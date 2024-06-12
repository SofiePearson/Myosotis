#!/bin/bash -e
#SBATCH --account		montpt03477
#SBATCH --job-name=iqtree_353_tree_n200  #job name (shows up in the queue)
#SBATCH --cpus-per-task=70   # number of CPUs per task (1 by default)
#SBATCH --time=10:00:00 #Walltime (HH:MM:SS)
#SBATCH --mem=80G  #Memory in GB

java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i loci_gt07_n200_myoso_bs10.treefile -o loci_gt07_n200_myoso_bs10_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i loci_gt07_n200_myoso_bs20.treefile -o loci_gt07_n200_myoso_bs20_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i loci_gt07_n200_myoso_bs30.treefile -o loci_gt07_n200_myoso_bs30_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i loci_gt07_n200_myoso_bs50.treefile -o loci_gt07_n200_myoso_bs50_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i loci_gt07_n200_myoso_bs70.treefile -o loci_gt07_n200_myoso_bs70_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i loci_gt07_n200_myoso_bs90.treefile -o loci_gt07_n200_myoso_bs90_astral.treefile

###################################
## dataset subsets
###################################

#!/bin/bash -e
#SBATCH --account		montpt03477
#SBATCH --job-name=iqtree_353_tree_n200  #job name (shows up in the queue)
#SBATCH --cpus-per-task=30   # number of CPUs per task (1 by default)
#SBATCH --time=05:00:00 #Walltime (HH:MM:SS)
#SBATCH --mem=30G  #Memory in GB

java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n26.treefile -o  MyosotisTree_subsets_n26_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n26_bs10.treefile -o  MyosotisTree_subsets_n26_bs10_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n26_bs20.treefile -o  MyosotisTree_subsets_n26_bs20_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n26_bs30.treefile -o  MyosotisTree_subsets_n26_bs30_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n26_bs50.treefile -o  MyosotisTree_subsets_n26_bs50_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n26_bs70.treefile -o  MyosotisTree_subsets_n26_bs70_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n26_bs90.treefile -o  MyosotisTree_subsets_n26_bs90_astral.treefile


java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n57.treefile -o  MyosotisTree_subsets_n57_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n57_bs10.treefile -o  MyosotisTree_subsets_n57_bs10_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n57_bs20.treefile -o  MyosotisTree_subsets_n57_bs20_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n57_bs30.treefile -o  MyosotisTree_subsets_n57_bs30_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n57_bs50.treefile -o  MyosotisTree_subsets_n57_bs50_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n57_bs70.treefile -o  MyosotisTree_subsets_n57_bs70_astral.treefile
java -jar ASTRAL-5.7.1/Astral/astral.5.7.1.jar -i MyosotisTree_subsets_n57_bs90.treefile -o  MyosotisTree_subsets_n57_bs90_astral.treefile
