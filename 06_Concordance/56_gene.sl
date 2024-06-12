#!/bin/bash -e 
#SBATCH --account montpt03477 
#SBATCH --job-name concordance_56loci_291ind 
#SBATCH --cpus-per-task 4 
#SBATCH --time 05:00:00 
#SBATCH --mem 256G 
#SBATCH --output concordance_56loci_291ind-%j.out 
#SBATCH --error concordance_56loci_291ind-%j.err 
#SBATCH --mail-type ALL 
#SBATCH --mail-user sofie.pearson@uq.edu.au

module purge
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

TMPDIR=/nesi/nobackup/montpt03477/tmp
[[ -d $TMPDIR ]]  || mkdir $TMPDIR

java -jar -Xmx230g -Djava.io.tmpdir=$TMPDIR /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -v -d MyosotisTree_subset_n56_outgroup_reroot_bs20_root.treefile -m MyosotisTree_subset_n56_outgroup_reroot_bs20_root_astral_root.treefile -o concord_out_56_291

