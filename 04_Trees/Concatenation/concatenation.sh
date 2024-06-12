###########################################
## Concatenation of full dataset
###########################################
#!/bin/bash -e
#SBATCH --account		montpt03477
#SBATCH --job-name=iqtree_353_tree_n200  #job name (shows up in the queue)
#SBATCH --cpus-per-task=30   # number of CPUs per task (1 by default)
#SBATCH --time=5-00:00:00 #Walltime (HH:MM:SS)
#SBATCH --mem=100G  #Memory in GB

module rest
module load IQ-TREE/2.2.2.2-gimpi-2022a

iqtree2 -p ../aln/ --prefix ./loci_gt07_n200_myoso_concat -T AUTO -B 1000 --undo

###########################################
## Concatenation of 56 dataset
###########################################

#!/bin/bash -e
#SBATCH --account		montpt03477
#SBATCH --job-name=iqtree_353_tree_n200  #job name (shows up in the queue)
#SBATCH --cpus-per-task=30   # number of CPUs per task (1 by default)
#SBATCH --time=3-00:00:00 #Walltime (HH:MM:SS)
#SBATCH --mem=100G  #Memory in GB

module rest
module load IQ-TREE/2.2.2.2-gimpi-2022a

iqtree2 -p ../aln_57/ --prefix ./loci_gt07_n200_myoso_concat57 -T AUTO -B 1000 --undo

###########################################
## Concatenation of 25 dataset
###########################################

#!/bin/bash -e
#SBATCH --account		montpt03477
#SBATCH --job-name=iqtree_353_tree_n200  #job name (shows up in the queue)
#SBATCH --cpus-per-task=30   # number of CPUs per task (1 by default)
#SBATCH --time=3-00:00:00 #Walltime (HH:MM:SS)
#SBATCH --mem=100G  #Memory in GB

module rest
module load IQ-TREE/2.2.2.2-gimpi-2022a

iqtree2 -p ../aln_26/ --prefix ./loci_gt07_n200_myoso_concat26 -T AUTO -B 1000 --undo
