
#############################
## trim reads
#############################

#!/bin/bash -e
#SBATCH --job-name=trim_cpdna  #job name (shows up in the queue)
#SBATCH --account=montpt03477
#SBATCH --cpus-per-task=10   # number of CPUs per task (1 by default)
#SBATCH --time=10:00:00 #Walltime (HH:MM:SS)
#SBATCH --mem=20G  #Memory in GB 

module load Trimmomatic/0.39-Java-1.8.0_144

for file in /nesi/nobackup/montpt03477/Weixuan/plastome/CHL_P3_7*_1.fq.gz
	do
	withpath="${file}"
	filename=${withpath##*/}
	base="${filename%**_1.fq.gz}"
	echo "${base}"
	trimmomatic PE -threads 50 "${base}"_1.fq.gz "${base}"_2.fq.gz \
	"${base}"_1P.fq.gz "${base}"_1UP.fq.gz \
	"${base}"_2P.fq.gz "${base}"_2UP.fq.gz \
	ILLUMINACLIP:TruSeq3-PE.fa:2:20:10 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:50
	done

for file in /nesi/nobackup/montpt03477/Weixuan/plastome/CHL_P3_8*_1.fq.gz
	do
	withpath="${file}"
	filename=${withpath##*/}
	base="${filename%**_1.fq.gz}"
	echo "${base}"
	trimmomatic PE -threads 50 "${base}"_1.fq.gz "${base}"_2.fq.gz \
	"${base}"_1P.fq.gz "${base}"_1UP.fq.gz \
	"${base}"_2P.fq.gz "${base}"_2UP.fq.gz \
	ILLUMINACLIP:TruSeq3-PE.fa:2:20:10 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:50
	done
	
for file in /nesi/nobackup/montpt03477/Weixuan/plastome/CHL_P2_8*_1.fq.gz
	do
	withpath="${file}"
	filename=${withpath##*/}
	base="${filename%**_1.fq.gz}"
	echo "${base}"
	trimmomatic PE -threads 50 "${base}"_1.fq.gz "${base}"_2.fq.gz \
	"${base}"_1P.fq.gz "${base}"_1UP.fq.gz \
	"${base}"_2P.fq.gz "${base}"_2UP.fq.gz \
	ILLUMINACLIP:TruSeq3-PE.fa:2:20:10 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:50
	done
	
for file in /nesi/nobackup/montpt03477/Weixuan/plastome/CHL_P2_9*_1.fq.gz
	do
	withpath="${file}"
	filename=${withpath##*/}
	base="${filename%**_1.fq.gz}"
	echo "${base}"
	trimmomatic PE -threads 50 "${base}"_1.fq.gz "${base}"_2.fq.gz \
	"${base}"_1P.fq.gz "${base}"_1UP.fq.gz \
	"${base}"_2P.fq.gz "${base}"_2UP.fq.gz \
	ILLUMINACLIP:TruSeq3-PE.fa:2:20:10 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:50
	done
 ###############################
 ## plastome assembly
 ###############################
# load Miniconda3 module:

module load Miniconda3/4.12.0

## create a biopython environment:
source $(conda info --base)/etc/profile.d/conda.sh
conda create -p biopython python=3.8 biopython

#To activate this environment, use
#
#     $ conda activate /scale_wlg_persistent/filesets/project/montpt03477/biopython
#
# To deactivate an active environment, use
#
#     $ conda deactivate

source $(conda info --base)/etc/profile.d/conda.sh
conda activate ./biopython

## install get organelle
conda install -c bioconda getorganelle

get_organelle_from_reads.py -h
conda deactivate




###################################
## De novo assembly 
###################################

## get the embplant_pt and embplant_mt from internet

## the following code wasn't working so had to do it a different way
get_organelle_config.py --add embplant_pt,embplant_mt

## needed to get the embplant_pt properly installed first:
git clone https://github.com/Kinggerm/GetOrganelleDB
get_organelle_config.py -a embplant_pt,embplant_mt --use-local ./GetOrganelleDB/0.0.1
(do this from the biopython folder)

## then needed to create the plastome_output folder:
mkdir /nesi/nobackup/montpt03477/plastome/plastome_output

########
#!/bin/bash -e
#SBATCH --account               montpt03477
#SBATCH --job-name              getorganelle
#SBATCH --cpus-per-task         6
#SBATCH --time                  06:00:00
#SBATCH --mem                   32G
#SBATCH --output                getorganelle_last_8-%j.out
#SBATCH --error                 getorganelle_last_8-%j.err
#SBATCH --mail-type             ALL
#SBATCH --mail-user             sofie.pearson@hotmail.com

module purge
module load Miniconda3/4.12.0

cd /nesi/nobackup/montpt03477/plastome
source $(conda info --base)/etc/profile.d/conda.sh
conda activate /scale_wlg_persistent/filesets/project/montpt03477/biopython

cd /nesi/nobackup/montpt03477/plastome/

for file in /nesi/nobackup/montpt03477/plastome/*_1P.fq
        do
        withpath="${file}"
        filename=${withpath##*/}
        base="${filename%*_1P.fq}"
        echo "${base}"

        get_organelle_from_reads.py -1 "${base}"_1P.fq -2 "${base}"_2P.fq -o plastome_output/"${base}" -R 15 -k 21,45,65,85,105 -F embplant_pt

        done



###################################################
## De novo assembly of additional samples
###################################################
## run variantcall.sh script in loop using example code bellow:
bash variantcall.sh prefix.supercontigs.fasta samplelist.txt

