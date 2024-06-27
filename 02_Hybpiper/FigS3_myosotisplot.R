setwd("C:/Users/7827x/OneDrive/Desktop/Myosotis/myosotis_plot")
library(ggplot2)

hybstat <- read.csv("hybpiper_stats_rename.csv", header = T)

options(scipen=999)

hybstat$group <- paste(hybstat$Group, hybstat$SeqPlatform, sep="_")
unique(hybstat$group)

hyb_supercontigs <- ggplot(hybstat, aes(y=hybstat$GenesAt150pct, x=hybstat$ReadsMapped, fill=group, shape = group, size = group)) +
  geom_point( stroke = 1) +
  scale_fill_manual(values=c ("black", "white", "grey", "white")) +
  scale_shape_manual(values=c(21, 21, 22, 22)) +
  scale_size_manual(values=c(3,3,5,5)) +
  geom_hline(yintercept=300, linetype="dashed", color = "red") + 
  xlab("Number of mapped reads") +
  ylab("Number of genes with assmbled supercontigs") +
  theme_bw() +
  theme(legend.position = c(0.9, 0.15),
        legend.background = element_rect(size=0.5, linetype="dashed",  colour ="black"),
        axis.title=element_text(size=15),
        axis.text  = element_text(size = 15, colour = 'black'))

hyb_supercontigs

hyb_stitch <- ggplot(hybstat, aes(y=hybstat$GenesWithStitchedContigs, x=hybstat$ReadsMapped, fill=group, shape = group, size = group)) +
  geom_point( stroke = 1) +
  scale_fill_manual(values=c ("black", "white", "grey", "white")) +
  scale_shape_manual(values=c(21, 21, 22, 22)) +
  scale_size_manual(values=c(3,3,5,5)) +
  geom_hline(yintercept=200, linetype="dashed", color = "red") + 
  xlab("Number of mapped reads") +
  ylab("Number of genes with stitched contigs") +
  theme_bw() +
  theme(legend.position = c(0.9, 0.15),
        legend.background = element_rect(size=0.5, linetype="dashed",  colour ="black"),
        axis.title=element_text(size=15),
        axis.text  = element_text(size = 15, colour = 'black'))

hyb_stitch





hyb_paralogslong <- ggplot(hybstat, aes(y=hybstat$ParalogWarningsLong, x=hybstat$ReadsMapped, fill=group, shape = group, size = group)) +
  geom_point( stroke = 1) +
  scale_fill_manual(values=c ("black", "white", "grey", "white")) +
  scale_shape_manual(values=c(21, 21, 22, 22)) +
  scale_size_manual(values=c(3,3,5,5)) +
  ylab("Number of genes with paralogs") +
  xlab("Number of mapped reads") +
  theme_bw() +
  theme(legend.position = c(0.9, 0.15),
        legend.background = element_rect(size=0.5, linetype="dashed",  colour ="black"),
        axis.title=element_text(size=15),
        axis.text  = element_text(size = 15, colour = 'black'))

hyb_paralogslong


hybsnp <- read.csv("0_Table_SNPs.csv")
hybsnp$snpmean <- rowMeans(hybsnp[-1], na.rm=TRUE)
colnames(hybsnp)[1] <- 'Name'
colnames(hybstat)[1] <- "Name"

hybstat3 <- merge(hybstat, hybsnp[,c(1,355)], by = "Name")

unique(hybstat3$group)

hyb_snp <- ggplot(hybstat3, aes(y=hybstat3$snpmean, x=ReadsMapped, fill=group, shape = group, size = group)) + 
  geom_point( stroke = 1) +
  scale_fill_manual(values=c ("black", "white", "grey", "white")) +
  scale_shape_manual(values=c(21, 21, 22, 22)) +
  scale_size_manual(values=c(3,3,5,5)) +
  xlab("Number of mapped reads") +
  ylab("SNP percentage (average) ") +
  theme_bw() +
  theme(legend.position = c(0.9, 0.17),
        legend.background = element_rect(size=0.5, linetype="dashed",  colour ="black"),
        axis.title=element_text(size=15),
        axis.text  = element_text(size = 15, colour = 'black'))
hyb_snp



library(ggpubr)
library(grid)
library(gridExtra)
library("cowplot")

grid.arrange(hyb_supercontigs, hyb_stitch, hyb_paralogslong, hyb_snp, ncol=2, nrow =2)

gt <- arrangeGrob(hyb_supercontigs, hyb_stitch, hyb_paralogslong, hyb_snp, ncol=2, nrow =2)

p <- as_ggplot(gt)  +
  draw_plot_label(label = c("A", "B", "C", "D"), size = 20,
                  x = c(0, 0.495, 0, 0.495), y = c(1, 1, 0.5, 0.5 )) # Add labels


write.csv(hybsnp, file = "hybsnp.csv", quote = F)

pdf("FigS3_hybstat_three2.pdf", width = 25, height = 17)
p
dev.off()

png("FigS3_hybstat_three2.png",  width = 8888, height = 6000, res =300)
p
dev.off()


