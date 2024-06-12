#!/bin/bash -e
#SBATCH --job-name=MyoExon #job name (shows up in the queue)
#SBATCH --account=massey02696
#SBATCH --cpus-per-task=6   # number of CPUs per task (1 by default)
#SBATCH --time=10:00:00 #Walltime (HH:MM:SS)
#SBATCH --mem=30G  #Memory in GB

module load BWA/0.7.17-gimkl-2017a
module load SAMtools/1.9-GCC-7.4.0
module load BCFtools/1.9-GCC-7.4.0
module load BBMap/38.81-gimkl-2020a
module load R/4.0.1-gimkl-2020a
module load File-Rename/1.13-GCC-9.2.0

bash ./HybPhaser/1_generate_consensus_sequences.sh -n ../02_hybpiper/namelist3_n291.txt -p ../02_hybpiper/ -o ./hybphaseroutput_exon -t 6
