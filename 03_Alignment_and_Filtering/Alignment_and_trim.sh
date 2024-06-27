#!/bin/bash -e
#SBATCH --account montpt03477
#SBATCH --job-name Align_Trim_supercontigs
#SBATCH --cpus-per-task 8
#SBATCH --time 08:00:00
#SBATCH --mem 8G
#SBATCH --output align_trim-%j.out
#SBATCH --error align_trim-%j.err
#SBATCH --mail-type ALL
 
module purge
module load MAFFT/7.429-gimkl-2020a
module load trimAl/1.4.1-GCC-9.2.0
 
for i in *_supercontig.fasta; do mafft --auto ${i} > ${i%.*}_aln.fasta; done
 
for file in *_aln.fasta; do trimal -in $file -out ${file%%.fasta}_trim.fasta -gt 0.7 -htmlout ${file%%.fasta}_trim.html; done

######################
## run AMAS.py
######################

## install AMAS from:
https://github.com/marekborowiec/AMAS/

## run AMAS
python3 AMAS.py summary -f fasta -d dna -i *.fasta

