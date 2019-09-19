#!bin/bash

#QC
plink --tfile sheep_new --chr-set 30 --allow-extra-chr --make-bed --out  sheep
plink --bfile sheep --allow-extra-chr --chr-set 30 --geno 0.1 --hwe 0.0000001 --maf 0.05  --mind 0.1 --make-bed --out sheep_qc

#Prune SNP，extract SNPs on autosome
plink --bfile sheep_qc --allow-extra-chr --chr-set 30 --chr 1-27 --make-bed --out sheep_auto 
plink --bfile sheep_auto --chr-set 30 --allow-extra-chr --indep-pairwise 25 5 0.2
plink --bfile sheep_auto --chr-set 30 --allow-extra-chr --extract plink.prune.in --make-bed --out sheep_auto.prune

#PCA
plink --bfile sheep_auto.prune --chr-set 30 --allow-extra-chr --pca

##Gemma Plink
gemma -bfile sheep_auto -gk 1 -o sheep
gemma -bfile sheep_qc -k output/sheep.cXX.txt -lmm 4 -n 1 -o sheep_gemma


