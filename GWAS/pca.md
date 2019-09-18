#qc
plink --tfile <file> --allow-extra-chr --chr-set 33 --geno 0.1 --hwe 0.0000001 --maf 0.01  --mind 0.1 --make-bed --out <file>_qc

plink --bfile <file>_qc --chr-set 33 --allow-extra-chr --indep-pairwise 100 25 0.25
plink --bfile <file>_qc --chr-set 33 --allow-extra-chr --extract plink.prune.in --make-bed --out <file>_qc.prune

##gcta PCA
gcta64 --bfile <file>_qc.prune --autosome --autosome-num 33 --make-grm --out <file>_qc
gcta64 --grm <file>_qc --pca 20 --out <file>_qc

##Plink MDS
plink --bfile <file>_qc.prune --chr-set 38 --allow-extra-chr --genome
plink --bfile <file>_qc --chr-set 38 --allow-extra-chr --read-genome plink.genome --cluster --mds-plot 10 

##smartPCA
smartpca -i <file>.ped -a <file>.pedsnp -b <file>.pedind -o <file>.pca -k 10 -p <file>.plot -e <file>.eval -l <file>.log

#Visualization in R
plot(pca[,1],pca[,2],xlab = "eigenvector1",ylab = "eigenvector2")
