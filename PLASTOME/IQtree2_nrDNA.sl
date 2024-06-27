#!/bin/bash -e
#SBATCH --account		montpt03477
#SBATCH --job-name=iqtree_nrdna  #job name (shows up in the queue)
#SBATCH --cpus-per-task=10   # number of CPUs per task (1 by default)
#SBATCH --time=00:20:00 #Walltime (HH:MM:SS)
#SBATCH --mem=10G  #Memory in GB

module load IQ-TREE/2.2.2.2-gimpi-2022a

iqtree2 -s sorted_changed_CHL_geneiousoriented_fixedn259_aln_trim_extratrim.fasta --prefix ./Myosotis_nrDNA_n259_JP -T 10 -B 1000 --undo

## plastome tree:
iqtree2 -s All_samples259_aln_trim.fasta a --prefix ./All_My_n259_plastome.treefile -T 10 -B 1000 --undo
