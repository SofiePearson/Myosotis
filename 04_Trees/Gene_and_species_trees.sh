#!/bin/bash -e
#SBATCH --account montpt03477
#SBATCH --job-name treebuilding_323_300
#SBATCH --cpus-per-task 72
#SBATCH --time 40:00:00
#SBATCH --mem 72G
#SBATCH --output treebuilding_323_300-%j.out
#SBATCH --error treebuilding_323_300-%j.err
#SBATCH --mail-type ALL
 
module purge
module load IQ-TREE/2.1.3-gimpi-2020a
module load Java/15.0.2
 
iqtree2 -S /nesi/nobackup/montpt03477/baits_332/HybPiper2/finaldatasets/323_samples/low_paralogs_300_genes/ -T AUTO -B 1000 --undo

./nw_ed low_paralogs_300_genes.treefile 'i & b<=10' o > genetrees_323_samples_300_genes_bs30.treefile

java -jar /nesi/nobackup/montpt03477/Astral/astral.5.7.8.jar -i genetrees_323_samples_300_genes_bs10.treefile -o species_tree_from_323_samples_300_genes.treefile --outgroup disc_AT_Vall

#####################################
## reroot trees at: after subsetting gene trees with outgroup present, after collapsing nodes, and after constructing the species tree.
## an example of re-rooting the trees after collapsing nodes:
python reroot_trees.py genetrees_323_samples_300_genes_bs30.treefile > genetrees_323_samples_300_genes_bs30_rerooted.treefile
