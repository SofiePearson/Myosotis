## Create TruSeq2-PE.fa file
## Information from https://github.com/timflutre/trimmomatic/blob/master/adapters/TruSeq2-PE.fa

nano TruSeq2-PE.fa

>PrefixPE/1
AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT
>PrefixPE/2
CAAGCAGAAGACGGCATACGAGATCGGTCTCGGCATTCCTGCTGAACCGCTCTTCCGATCT
>PCR_Primer1
AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT
>PCR_Primer1_rc
AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT
>PCR_Primer2
CAAGCAGAAGACGGCATACGAGATCGGTCTCGGCATTCCTGCTGAACCGCTCTTCCGATCT
>PCR_Primer2_rc
AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG
>FlowCell1
TTTTTTTTTTAATGATACGGCGACCACCGAGATCTACAC
>FlowCell2
TTTTTTTTTTCAAGCAGAAGACGGCATACGA

## Trim raw data

#!/bin/bash -e
#SBATCH --job-name=Trimming  #job name (shows up in the queue)
#SBATCH --cpus-per-task=20   # number of CPUs per task (1 by default)
#SBATCH --time=00:30:00 #Walltime (HH:MM:SS)
#SBATCH --mem=30G  #Memory in GB

module purge
module load Trimmomatic/0.39-Java-1.8.0_144

for file in /nesi/nobackup/montpt03477/MGS00484/rawsequences/*_R1.fastq.gz ##specify end format of files
	do
	withpath="${file}"
	filename=${withpath##*/}
	base="${filename%*_*.fastq.gz}" ##specify end format of files
	echo "${base}"
	trimmomatic PE "${base}"*_R1.fastq.gz "${base}"*_R2.fastq.gz \
	"${base}"_1P.fq "${base}"_1UP.fq \
	"${base}"_2P.fq "${base}"_2UP.fq \
	ILLUMINACLIP:TruSeq2-PE.fa:2:20:10 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:50
	done
