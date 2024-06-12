##############################################################
## Download the mega file with target sequences
##############################################################
## In the New Targets fasta file there are Boraginaceae samples:
# Ehretia acuminata (EMAL)
# Heliotropium calcicola (XVRU)
# Lennoa madreporoides (SMUR)
# Mertensia paniculata (DKFZ)
# Phacelia campanularia (YQIJ)
# Pholisma arenarium (HANM)
## These are in the mega353.fasta file

## Clone the repository into the working folder:
git clone https://github.com/chrisjackson-pellicle/NewTargets.git

cd /nesi/nobackup/montpt03477/MGS00484/rawsequences/NewTargets

## unzip the mega353.fasta.zip file
unzip mega.fasta.zip

## use mega353 fasta file

##############################################################
## hybpiper_06.sh
##############################################################
#!/bin/bash -e
#SBATCH --job-name=hybpiper8  #job name (shows up in the queue)
#SBATCH --account=montpt03477
#SBATCH --cpus-per-task=20   # number of CPUs per task (1 by default)
#SBATCH --time=60:00:00 #Walltime (HH:MM:SS)
#SBATCH --mem=60G  #Memory in GB 

module load Python/3.9.9-gimkl-2020a
module load HybPiper/2.0.1rc-Miniconda3
module load Parallel/20200522

for file in /nesi/nobackup/montpt03477/Weixuan/angiosperm353/01_trimmedreads/l*_1P.fq
	do
	withpath="${file}"
	filename=${withpath##*/}
	base="${filename%*_1P.fq}"
	echo "${base}"

	hybpiper assemble --run_intronerate \
	--readfiles /nesi/nobackup/montpt03477/Weixuan/angiosperm353/01_trimmedreads/"${base}"*P.fq \
	--targetfile_dna mega353.fasta --bwa \
	--prefix "${base}"_nomerge  --no_padding_supercontigs \
	--timeout_assemble 600 --paralog_min_length_percentage 0.5
	done

##############################################################
## hybpiper_exonerator.sh
##############################################################
#!/bin/bash -e
#SBATCH --job-name=hybpiper7  #job name (shows up in the queue)
#SBATCH --account=montpt03477
#SBATCH --cpus-per-task=30   # number of CPUs per task (1 by default)
#SBATCH --time=20:00:00 #Walltime (HH:MM:SS)
#SBATCH --mem=60G  #Memory in GB

module load Python/3.9.9-gimkl-2020a
module load HybPiper/2.0.1rc-Miniconda3
module load Parallel/20200522


for file in /nesi/nobackup/montpt03477/Weixuan/angiosperm353/01_trimmedreads/*_1P.fq; do         withpath="${file}";         filename=${withpath##*/};         base="${filename%*_1P.fq}";         echo "${base}";          hybpiper assemble --run_intronerate         --readfiles /nesi/nobackup/montpt03477/Weixuan/angiosperm353/01_trimmedreads/"${base}"*P.fq         --targetfile_dna mega353.fasta --bwa         --prefix "${base}"_nomerge  --no_padding_supercontigs         --timeout_assemble 600 --paralog_min_length_percentage 0.5 --start_from exonerate_contigs ; done

##############################################################
## Run hybpiper stats 
##############################################################

module load HybPiper/2.0.1rc-Miniconda3
hybpiper stats -t_dna mega353.fasta gene namelist.txt --stats_filename hybpiper_stats --seq_lengths_filename seq_lengths

##############################################################
## Create heatmap
##############################################################

module load HybPiper/2.0.1rc-Miniconda3
hybpiper recovery_heatmap seq_lengths.tsv

##############################################################
## Run paralog retriever
##############################################################

module load HybPiper/2.0.1rc-Miniconda3
hybpiper paralog_retriever #**ADD IN**
