#####
## Install HybPiper
#####

## In rawsequences folder run:
git clone https://github.com/mossmatters/HybPiper.git
cd HybPiper

module purge
module load Python/3.8.1-gimkl-2018b
module load SAMtools/1.8-gimkl-2018b
module load BWA/0.7.17-gimkl-2017a
module load BLAST/2.9.0-gimkl-2018b
module load exonerate/2.2.0-gimkl-2017a
module load SPAdes/3.13.1-gimkl-2018b
module load Parallel/20200522

## Test to make sure HybPiper will run:

cd /nesi/nobackup/montpt03477/MGS00484/rawsequences/HybPiper/test_dataset
bash run_tests.sh



#####
## Download the file with target sequences containing 6 genera in the Boraginaceae
#####
## In the New Targets fasta file there are Boraginaceae samples:
# Ehretia acuminata (EMAL)
# Heliotropium calcicola (XVRU)
# Lennoa madreporoides (SMUR)
# Mertensia paniculata (DKFZ)
# Phacelia campanularia (YQIJ)
# Pholisma arenarium (HANM)
## These are in the mega353.fasta file. Look at the filtering_options.csv for other species included:
## https://github.com/chrisjackson-pellicle/NewTargets/blob/master/filtering_options.csv

## In /nesi/nobackup/montpt03477/MGS00484/rawsequences/
## Clone the repository into the rawsequences folder:
git clone https://github.com/chrisjackson-pellicle/NewTargets.git

cd /nesi/nobackup/montpt03477/MGS00484/rawsequences/NewTargets

## unzip the mega353.fasta.zip file
unzip mega.fasta.zip

## use mega353 fasta file


#!/bin/bash -e

#SBATCH --account               montpt03477
#SBATCH --job-name              HybPiper
#SBATCH --cpus-per-task         32
#SBATCH --time                  06:00:00
#SBATCH --mem                   8G
#SBATCH --output                HybPiperMiSeq-%j.out
#SBATCH --error                 HybPiperMiSeq-%j.err
#SBATCH --mail-type             ALL
#SBATCH --mail-user             sofie.pearson@hotmail.com

module purge
module load Python/3.8.1-gimkl-2018b
module load Miniconda3/4.9.2
module load Parallel/20200522
module load SPAdes/3.13.1-gimkl-2018b
module load exonerate/2.2.0-gimkl-2017a
module load BLAST/2.9.0-gimkl-2018b
module load BWA/0.7.17-gimkl-2017a
module load SAMtools/1.8-gimkl-2018b

# Run HybPiper script
while read i
do
../reads_first.py -r $i*.fq -b mega353.fasta --prefix $i --bwa
done < namelist.txt

# Get the sequence lengths file
python ../get_seq_lengths.py mega353.fasta namelist.txt dna > test_seq_lengths.txt

# Get summary statistics
python ../hybpiper_stats.py test_seq_lengths.txt namelist.txt > test_stats.txt

# Test for paralogs
while read i
do
python ../paralog_investigator.py $i
done < namelist.txt

# Run intronerate
while read i
do
python ../intronerate.py --prefix $i
done < namelist.txt

#6. run the first 14 samples

sbatch test_myo.sl
Submitted batch job 23780349

#7. when this has finished, run the cleanup script before going ahead with the remaining 14 samples
## will need to run the summary and stats scripts after both have finished to get info for all 28 samples (especially for the heatmap)

