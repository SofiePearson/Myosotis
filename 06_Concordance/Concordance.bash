## TO DO: remove unrelevant information
######################################################################################################################
## Reroot the species tree for small dataset:
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

source $(conda info --base)/etc/profile.d/conda.sh
conda activate /scale_wlg_persistent/filesets/project/montpt03477/biopython

# pwd
# /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phypartspiecharts

cd /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor

## reroot the species tree:
python /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phypartspiecharts/reroot_trees.py MyosotisTree_subset_n26_outgroup_reroot_bs20_astral.treefile outgroup.list > MyosotisTree_subset_n26_outgroup_reroot_bs20_astral_root.treefile

conda deactivate

######################################################################################################################

## install phyparts

cd /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor
cd /nesi/nobackup/montpt03477/baits_332/HybPiper2/finaldatasets/323_samples
git clone https://bitbucket.org/blackrim/phyparts.git
cd phyparts/

module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
./mvn_cmdline.sh
## took a couple minutes to build
java -jar target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -help
#usage: phyparts
# -a,--analysis <arg>   what kind of analysis (0 - concon, 1 - fullconcon,
#                       2 - duplications)
# -d,--dtree <arg>      directory of trees (for deconstruct)
# -h,--help             show help
# -i,--ignore <arg>     comma separated list of things to ignore
# -m,--mtree <arg>      mapping tree (for mapping)
# -o,--outpr <arg>      prepend output files with this
# -s,--support <arg>    support cutoff (only keep things with greater
#                       support than the one specified)
# -v,--verbose          include verbose output
# -x,--secret <arg>
# -y,--secret2

## will need to call it from:
/nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phyparts/target

## copy input files to new directory
mkdir concordance

pwd
/nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/concordance

## copy the gene tree file and species tree to the new "concordance" folder

## can test analysis using the new AMD nodes (milan partition) if we want to but hugemem might be okay

nano concordance_26loci_291ind.sl

#!/bin/bash -e 
#SBATCH --account montpt03477 
#SBATCH --job-name concordance_26loci_291ind 
#SBATCH --cpus-per-task 4 
#SBATCH --time 02:00:00 
#SBATCH --mem 256G 
#SBATCH --output concordance_26loci_291ind-%j.out 
#SBATCH --error concordance_26loci_291ind-%j.err 
#SBATCH --mail-type ALL 
#SBATCH --mail-user sofie.pearson@uq.edu.au

module purge
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

TMPDIR=/nesi/nobackup/montpt03477/tmp
[[ -d $TMPDIR ]]  || mkdir $TMPDIR

java -jar -Xmx230g -Djava.io.tmpdir=$TMPDIR /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -v -d MyosotisTree_subset_n26_outgroup_reroot_bs20.treefile -m MyosotisTree_subset_n26_outgroup_reroot_bs20_astral_root.treefile -o concord_out_26_291

sbatch concordance_26loci_291ind.sl 

Submitted batch job 41838644

## started with two hours, see how it goes and if we need to extend the time

squeue -u spea1
#JOBID         USER     ACCOUNT   NAME        CPUS MIN_MEM PARTITI START_TIME     TIME_LEFT STATE    NODELIST(REASON)    
#41838627      spea1    montpt034 spawner-jupy   2      4G interac 2023-12-11T1       53:37 RUNNING  wbn001              
#41838644      spea1    montpt034 concordance_   4    256G hugemem 2023-12-11T1     1:57:32 RUNNING  wbh001 

## if this runs well then we can try the 57 genes, then the 291 genes


#############################################################
## Root the 56 and 318 species trees and copy them (and their gene trees) to the concordance folder

module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

source $(conda info --base)/etc/profile.d/conda.sh
conda activate /scale_wlg_persistent/filesets/project/montpt03477/biopython

# pwd
# /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phypartspiecharts

cd /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor

## reroot the species tree:
python /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phypartspiecharts/reroot_trees.py MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20_astral.treefile outgroup.list > MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20_astral_root.treefile
python /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phypartspiecharts/reroot_trees.py MyosotisTree_subset_n57_outgroup_reroot_bs20_astral.treefile outgroup.list > MyosotisTree_subset_n57_outgroup_reroot_bs20_astral_root.treefile
conda deactivate

#############################################################
## copy the rooted species treefiles and rooted gene treefiles to concordance folder

cp MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20_astral_root.treefile concordance/
cp MyosotisTree_subset_n57_outgroup_reroot_bs20_astral_root.treefile concordance/
cp MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20.treefile concordance/
cp MyosotisTree_subset_n57_outgroup_reroot_bs20.treefile concordance/

#############################################################
nn_seff 41838644
#Cluster: mahuika
#Job ID: 41838644
#State: COMPLETED
#Cores: 2
#Tasks: 1
#Nodes: 1
#Job Wall-time:   45.8%  00:54:58 of 02:00:00 time limit
#CPU Efficiency:  50.1%  00:55:06 of 01:49:56 core-walltime
#Mem Efficiency:   2.8%  7.11 GB of 256.00 GB

## reduce the memory for the 57 genes

nano concordance_26loci_291ind.sl

#!/bin/bash -e 
#SBATCH --account montpt03477 
#SBATCH --job-name concordance_57loci_291ind 
#SBATCH --cpus-per-task 4 
#SBATCH --time 05:00:00 
#SBATCH --mem 16G 
#SBATCH --output concordance_57loci_291ind-%j.out 
#SBATCH --error concordance_57loci_291ind-%j.err 
#SBATCH --mail-type ALL 
#SBATCH --mail-user sofie.pearson@uq.edu.au

module purge
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

TMPDIR=/nesi/nobackup/montpt03477/tmp
[[ -d $TMPDIR ]]  || mkdir $TMPDIR

java -jar -Xmx230g -Djava.io.tmpdir=$TMPDIR /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -v -d MyosotisTree_subset_n57_outgroup_reroot_bs20.treefile -m MyosotisTree_subset_n57_outgroup_reroot_bs20_astral_root.treefile -o concord_out_57_291

sbatch concordance_57loci_291ind.sl 
Submitted batch job 41838895


## Once concordance factor analysis has completed for all three, check the output and create piecharts using phyparts

nn_seff 41838895
#Cluster: mahuika
#Job ID: 41838895
#State: COMPLETED
#Cores: 2
#Tasks: 1
#Nodes: 1
#Job Wall-time:   47.5%  02:22:29 of 05:00:00 time limit
#CPU Efficiency:  50.3%  02:23:14 of 04:44:58 core-walltime
#Mem Efficiency:  26.6%  4.25 GB of 16.00 GB

nano concordance_318loci_291ind.sl

#!/bin/bash -e 
#SBATCH --account montpt03477 
#SBATCH --job-name concordance_318loci_291ind 
#SBATCH --cpus-per-task 4 
#SBATCH --time 20:00:00 
#SBATCH --mem 32G 
#SBATCH --output concordance_318loci_291ind-%j.out 
#SBATCH --error concordance_318loci_291ind-%j.err 
#SBATCH --mail-type ALL 
#SBATCH --mail-user sofie.pearson@uq.edu.au

module purge
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

TMPDIR=/nesi/nobackup/montpt03477/tmp
[[ -d $TMPDIR ]]  || mkdir $TMPDIR

java -jar -Xmx230g -Djava.io.tmpdir=$TMPDIR /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -v -d MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20.treefile -m MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20_astral_root.treefile -o concord_out_318_291

sbatch concordance_318loci_291ind.sl 

Submitted batch job 41842986

##################################
## create piechart output

module load Miniconda3/4.12.0
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Python/3.8.2-gimkl-2020a

source $(conda info --base)/etc/profile.d/conda.sh
conda activate /scale_wlg_persistent/filesets/project/montpt03477/biopython
pip install matplotlib
pip install ete3

module load Miniconda3/4.12.0
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Python/3.8.2-gimkl-2020a

cd /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/concordance

export DISPLAY=:0.0
export QT_QPA_PLATFORM=offscreen
python /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phypartspiecharts/phypartspiecharts.py MyosotisTree_subset_n26_outgroup_reroot_bs20_astral_root.treefile concord_out_26_291 25 --to_csv
#QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/dev/shm/jobs/41843763/runtime-spea1'

mkdir n26_loci
mv pies* n26_loci/
mv phyparts* n26_loci/

python /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phypartspiecharts/phypartspiecharts.py MyosotisTree_subset_n57_outgroup_reroot_bs20_astral_root.treefile concord_out_57_291 56 --to_csv

mkdir n57_loci
mv pies* n57_loci/
mv phyparts* n57_loci/

## wait for the 318 dataset to complete before running this final one

python /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phypartspiecharts/phypartspiecharts.py MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20_astral_root.treefile concord_out_318_291 318 --to_csv


##################################
## 03/01/2024
nn_seff 41842986
#Cluster: mahuika
#Job ID: 41842986
#State: FAILED
#Cores: 2
#Tasks: 1
#Nodes: 1
#Job Wall-time:    9.3%  2-14:14:03 of 28-00:00:00 time limit
#CPU Efficiency:  50.2%  2-14:28:39 of 5-04:28:06 core-walltime
#Mem Efficiency:  98.8%  31.63 GB of 32.00 GB

## Increase memory and time and re-run
cd /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/concordance

nano concordance_318loci_291ind.sl

#!/bin/bash -e
#SBATCH --account montpt03477
#SBATCH --job-name concordance_318loci_291ind
#SBATCH --cpus-per-task 4
#SBATCH --time 150:00:00
#SBATCH --mem 256G
#SBATCH --output concordance_318loci_291ind-%j.out
#SBATCH --error concordance_318loci_291ind-%j.err
#SBATCH --mail-type ALL
#SBATCH --mail-user sofie.pearson@uq.edu.au

module purge
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

TMPDIR=/nesi/nobackup/montpt03477/tmp
[[ -d $TMPDIR ]]  || mkdir $TMPDIR

java -jar -Xmx230g -Djava.io.tmpdir=$TMPDIR /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phyparts/target/phy$

sbatch concordance_318loci_291ind.sl 
#Submitted batch job 42511089


##############################################
##16/02/2024

## re-run concordance factor analysis for 25 (not 26 loci)

## copy the two new files Weixuan created into the concordance folder and rename to reflect 25 loci

pwd /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor

cp MyosotisTree_subset_n26_outgroup_reroot_bs20_astral_root2_reroot.treefile concordance/MyosotisTree_subset_n25_outgroup_reroot_bs20_astral_root2_reroot.treefile

cp MyosotisTree_subset_n26_outgroup_reroot_bs20_reroot.treefile concordance/MyosotisTree_subset_n25_outgroup_reroot_bs20_reroot.treefile

cd concordance

nano concordance_25_loci_291_ind.sl

#!/bin/bash -e 
#SBATCH --account montpt03477 
#SBATCH --job-name concordance_25loci_291ind 
#SBATCH --cpus-per-task 4 
#SBATCH --time 02:00:00 
#SBATCH --mem 256G 
#SBATCH --output concordance_25loci_291ind-%j.out 
#SBATCH --error concordance_25loci_291ind-%j.err 
#SBATCH --mail-type ALL 
#SBATCH --mail-user sofie.pearson@uq.edu.au

module purge
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

TMPDIR=/nesi/nobackup/montpt03477/tmp
[[ -d $TMPDIR ]]  || mkdir $TMPDIR

java -jar -Xmx230g -Djava.io.tmpdir=$TMPDIR /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -v -d MyosotisTree_subset_n25_outgroup_reroot_bs20_reroot.treefile -m MyosotisTree_subset_n25_outgroup_reroot_bs20_astral_root2_reroot.treefile -o concord_out_25_291

sbatch concordance_25_loci_291_ind.sl
#Submitted batch job 43813512

############################
## create piechart output

module load Miniconda3/4.12.0
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Python/3.8.2-gimkl-2020a

source $(conda info --base)/etc/profile.d/conda.sh
conda activate /scale_wlg_persistent/filesets/project/montpt03477/biopython
pip install matplotlib
pip install ete3

module load Miniconda3/4.12.0
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Python/3.8.2-gimkl-2020a

cd /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/concordance

export DISPLAY=:0.0
export QT_QPA_PLATFORM=offscreen
python /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phypartspiecharts/phypartspiecharts.py MyosotisTree_subset_n25_outgroup_reroot_bs20_astral_root2_reroot.treefile concord_out_25_291 25 --to_csv
#QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/dev/shm/jobs/41843763/runtime-spea1'

mkdir n25_loci
mv pies* n25_loci/
mv phyparts* n25_loci/

###########################

## 19/02/2024

## get 56 loci dataset running

## copy the two new files Weixuan created into the concordance folder and rename to reflect 56 loci

MyosotisTree_subset_n57_outgroup_reroot_bs20.treefile
MyosotisTree_subset_n57_outgroup_reroot_bs20_astral_root.treefile
pwd /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor

cp MyosotisTree_subset_n57_outgroup_reroot_bs20_root.treefile concordance/MyosotisTree_subset_n56_outgroup_reroot_bs20_root.treefile

cp MyosotisTree_subset_n57_outgroup_reroot_bs20_root_astral_root.treefile concordance/MyosotisTree_subset_n56_outgroup_reroot_bs20_root_astral_root.treefile

cd concordance

nano concordance_56_loci_291_ind.sl

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

sbatch concordance_56_loci_291_ind.sl
#Submitted batch job 43868279

############################

## create piechart output

module load Miniconda3/4.12.0
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Python/3.8.2-gimkl-2020a

source $(conda info --base)/etc/profile.d/conda.sh
conda activate /scale_wlg_persistent/filesets/project/montpt03477/biopython
pip install matplotlib
pip install ete3

module load Miniconda3/4.12.0
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Python/3.8.2-gimkl-2020a

cd /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/concordance

export DISPLAY=:0.0
export QT_QPA_PLATFORM=offscreen
python /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phypartspiecharts/phypartspiecharts.py MyosotisTree_subset_n56_outgroup_reroot_bs20_root_astral_root.treefile concord_out_56_291 56 --to_csv
#QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/dev/shm/jobs/41843763/runtime-spea1'

mkdir n56_loci
mv pies* n56_loci/
mv phyparts* n56_loci/

############################
## talk to NeSI staff about 318 dataset on the milan nodes then run through

## files are:

/nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20_root_astral_root.treefile
/nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20_root.treefile

## copy to concordance folder

cd /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor

cp MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20_root_astral_root.treefile concordance/MyosotisTree_subset_n318_loci_gt07_n200_outgroup_reroot_bs20_root_astral_root.treefile

cp MyosotisTree_subset_n291_loci_gt07_n200_outgroup_reroot_bs20_root.treefile concordance/MyosotisTree_subset_n318_loci_gt07_n200_outgroup_reroot_bs20_root.treefile

cd concordance

nano concordance_318loci_291ind.sl

#!/bin/bash -e
#SBATCH --account montpt03477
#SBATCH --job-name concordance_318loci_291ind
#SBATCH --cpus-per-task 16
#SBATCH --time 150:00:00
#SBATCH --mem 256G
#SBATCH --output concordance_318loci_291ind-%j.out
#SBATCH --error concordance_318loci_291ind-%j.err
#SBATCH --mail-type ALL
#SBATCH --mail-user sofie.pearson@uq.edu.au
#SBATCH --partition milan

module purge
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

TMPDIR=/nesi/nobackup/montpt03477/tmp
[[ -d $TMPDIR ]]  || mkdir $TMPDIR

java -jar -Xmx230g -Djava.io.tmpdir=$TMPDIR /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -v -d MyosotisTree_subset_n318_loci_gt07_n200_outgroup_reroot_bs20_root.treefile -m MyosotisTree_subset_n318_loci_gt07_n200_outgroup_reroot_bs20_root_astral_root.treefile -o concord_out_318_291

sbatch concordance_318loci_291ind.sl 
#sbatch: "milan" is not the most appropriate partition for this job, which would otherwise default to "hugemem". If you believe this is incorrect then please contact support@nesi.org.nz and quote the Job ID number.
#Submitted batch job 43946889

## also couldn't find the java file

## test the file but request small time and mem
nano concordance_318loci_291ind_test.sl

#!/bin/bash -e
#SBATCH --account montpt03477
#SBATCH --job-name concordance_318loci_291ind
#SBATCH --cpus-per-task 4
#SBATCH --time 00:05:00
#SBATCH --mem 8G
#SBATCH --output concordance_318loci_291ind-%j.out
#SBATCH --error concordance_318loci_291ind-%j.err
#SBATCH --mail-type ALL
#SBATCH --mail-user sofie.pearson@uq.edu.au
#SBATCH --partition milan

module purge
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

TMPDIR=/nesi/nobackup/montpt03477/tmp
[[ -d $TMPDIR ]]  || mkdir $TMPDIR

java -jar -Xmx230g -Djava.io.tmpdir=$TMPDIR /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/phylogeney/gene_concordant_factor/phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -v -d MyosotisTree_subset_n318_loci_gt07_n200_outgroup_reroot_bs20_root.treefile -m MyosotisTree_subset_n318_loci_gt07_n200_outgroup_reroot_bs20_root_astral_root.treefile -o concord_out_318_291

sbatch concordance_318loci_291ind_test.sl 
#Submitted batch job 43947729

##  looked okay. change the test script by increasing the cpus, time and mem
#!/bin/bash -e
#SBATCH --account montpt03477
#SBATCH --job-name concordance_318loci_291ind
#SBATCH --cpus-per-task 16
#SBATCH --time 10:00:00
#SBATCH --mem 256G
#SBATCH --output concordance_318loci_291ind-%j.out
#SBATCH --error concordance_318loci_291ind-%j.err
#SBATCH --mail-type ALL
#SBATCH --mail-user sofie.pearson@uq.edu.au
#SBATCH --partition milan

module purge
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

TMPDIR=/nesi/nobackup/montpt03477/tmp
[[ -d $TMPDIR ]]  || mkdir $TMPDIR

java -jar -Xmx230g -Djava.io.tmpdir=$TMPDIR /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/
phylogeney/gene_concordant_factor/phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -v -d 
MyosotisTree_subset_n318_loci_gt07_n200_outgroup_reroot_bs20_root.treefile -m 
MyosotisTree_subset_n318_loci_gt07_n200_outgroup_reroot_bs20_root_astral_root.treefile -o concord_out_318_291

sbatch concordance_318loci_291ind_test.sl
#sbatch: "milan" is not the most appropriate partition for this job, which would otherwise default to "hugemem". If you believe this is incorrect then please contact support@nesi.org.nz and quote the Job ID number.
#Submitted batch job 43948167

seff 43948167
#Job ID: 43948167
#Cluster: mahuika
#User/Group: spea1/spea1
#State: FAILED (exit code 0)
#Nodes: 1
#Cores per node: 16
#CPU Utilized: 13-12:36:26
#CPU Efficiency: 10.07% of 134-07:08:48 core-walltime
#Job Wall-clock time: 8-09:26:48
#Memory Utilized: 141.38 GB
#Memory Efficiency: 55.23% of 256.00 GB


## increase memory to 512















sbatch concordance_318loci_291ind_test2.sl 

#!/bin/bash -e
#SBATCH --account montpt03477
#SBATCH --job-name concordance_318loci_291ind
#SBATCH --cpus-per-task 16
#SBATCH --time 10:00:00
#SBATCH --mem 512G
#SBATCH --output concordance_318loci_291ind-%j.out
#SBATCH --error concordance_318loci_291ind-%j.err
#SBATCH --mail-type ALL
#SBATCH --mail-user sofie.pearson@uq.edu.au
#SBATCH --partition milan

module purge
module load ETE/3.1.1-gimkl-2020a-Python-3.8.2
module load Java/15.0.2
module load Maven/3.6.0
module load Miniconda3/4.12.0

TMPDIR=/nesi/nobackup/montpt03477/tmp
[[ -d $TMPDIR ]]  || mkdir $TMPDIR

java -jar -Xmx512g -Djava.io.tmpdir=$TMPDIR /nesi/nobackup/montpt03477/Weixuan/angiosperm353/03_aln/07_SupercontigsOutput_n291/
phylogeney/gene_concordant_factor/phyparts/target/phyparts-0.0.1-SNAPSHOT-jar-with-dependencies.jar -a 1 -v -d 
MyosotisTree_subset_n318_loci_gt07_n200_outgroup_reroot_bs20_root.treefile -m 
MyosotisTree_subset_n318_loci_gt07_n200_outgroup_reroot_bs20_root_astral_root.treefile -o concord_out_318_291

sbatch concordance_318loci_291ind_test2.sl
#sbatch: "milan" is not the most appropriate partition for this job, which would otherwise default to "hugemem". If you believe this is incorrect then please contact support@nesi.org.nz and quote the Job ID number.
#Submitted batch job 43948167

########################################################################

## concordance analysis using IQ-TREE2



You can make the concat tree like this - iqtree2 -p ALN_DIR --prefix concat -B 1000 -T AUTO
And then gene trees using the same folder - iqtree2 -S ALN_DIR --prefix loci -T AUTO

The gene trees can then go into ASTRAL. You might want to run TreeShrink on the gene trees before running ASTRAL to remove weird branches etc. - https://github.com/uym2/TreeShrink




## run iqtree over these 147 gene supercontigs:

nano gene_trees_IQ-TREE2_147_genes.sl

#!/bin/bash -e

#SBATCH --account               montpt03477
#SBATCH --job-name              Build_147_gene_trees
#SBATCH --cpus-per-task         72
#SBATCH --time                  25:00:00
#SBATCH --mem                   72G
#SBATCH --output                gene_trees-147-%j.out
#SBATCH --error                 gene_trees-147-%j.err
#SBATCH --mail-type             ALL
#SBATCH --mail-user             sofie.pearson@hotmail.com

module purge
module load IQ-TREE/2.1.3-gimpi-2020a

iqtree2 -S /nesi/nobackup/montpt03477/baits_332/HybPiper2/328_samples_315_genes_no_paralogs_153_total/genetrees_147_Trig_outgroup/ -T AUTO -B 1000 --undo

sbatch gene_trees_IQ-TREE2_147_genes.sl
#Submitted batch job 27305571






