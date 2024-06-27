setwd("C:/Users/7827x/OneDrive/Desktop/Myo_treeinfor/finalPlot/")

library(ggpattern)
library(ggtree)
library(treeio)
library(tidytree)
library(dplyr)
library(ggplot2)
library(aplot)
library(ggpubr)
library(ggbreak)
library(ggtreeExtra)
library(ggnewscale)
library(reshape2)
library(viridis)
library(tidyr)

########
library(phytools)


#MynrDNA <- read.nexus(file = "Myosotis_nrDNA_n259_JP_final.treefile")

MynrDNA2 <- read.tree(file = "Myosotis_nrDNA_n259_JP_reroot.treefile")


T0 = ggtree(MynrDNA2, branch.length = "none") +  
  geom_rootedge(rootedge = 0.3) +
  
  geom_nodelab(size = 2, nudge_x = -0.5, nudge_y = 0.65, color = 'black') +
  geom_tiplab(align=TRUE, linesize=0.5,  size = 2) +
  
  xlim(-3,60) +
  theme(legend.position = "none") 
T0



###################


mycha <- read.csv("Myosotis_characters_by_individuals2024NEW.csv", header = T,  na.strings=c("NA"," ")) %>% 
  filter(individual %in% MynrDNA$tip.label)

rownames(mycha) <- mycha$individual

mycha.melt <- melt(as.matrix(mycha[c(2:6)]))

#mycha.melt$Var1 <- gsub(" ","", mycha.melt$Var1)
#mycha.melt <- melt(mycha) %>% filter( Var1 %in% mytree[["tip.label"]][2:291]) 


mycha.melt.island <- mycha.melt[mycha.melt$Var2 == 'island',]  
colnames(mycha.melt.island)[3] <- "island"

mycha.melt.morph_group <- mycha.melt[mycha.melt$Var2 == 'morph_group',]
colnames(mycha.melt.morph_group)[3] <- "morph"


mycha.melt.X353_clade <- mycha.melt[mycha.melt$Var2 == 'X353_clade',] 
colnames(mycha.melt.X353_clade)[3] <- "A353_clade"


mycha.melt.nrDNA_clade <- mycha.melt[mycha.melt$Var2 == 'nrDNA_clade',] 
colnames(mycha.melt.nrDNA_clade)[3] <- "nrDNA_clade"


mycha.melt.plastome_clade <- mycha.melt[mycha.melt$Var2 == 'plastome_clade',] 
colnames(mycha.melt.plastome_clade)[3] <- "plastome_clade"

#############################################
T1 <- T0  +  new_scale_fill() + 
  geom_fruit(data= mycha.melt.island, geom=geom_tile,
             mapping= aes( y=Var1, x= Var2, fill = island, na.rm = F),
             axis.params=list( axis = "x", text  = "island",  text.size  = 3),
             offset = 0.1, pwidth = 1.5) +
  scale_fill_manual(values=c("A"= "#DDCC77",
                             "N"= "#CC6677",
                             "S" = "#88CCEE",
                             "sub" = "#AA4499",
                             "St" = "#44AA99")) +  
  theme(axis.title.x=element_blank(),
        axis.line.x=element_blank(),
        axis.ticks.x=element_blank()) 

T1

T2 <- T1  +  new_scale_fill() + 
  geom_fruit(data=mycha.melt.morph_group, geom=geom_tile,
             mapping= aes( y=Var1, x= Var2, fill = morph, na.rm = F),
             axis.params=list( axis = "x", text  = "morph",  text.size  = 3),
             offset = 0.05, pwidth = 1.5) +
  scale_fill_manual(values=c("bp"= "#88CCEE",
                             "ee"= "#CC6677",
                             "hyb" = "#DDCC77")) +  
  theme(axis.title.x=element_blank(),
        axis.line.x=element_blank(),
        axis.ticks.x=element_blank()) 

T2


safe_colorblind_palette <- c("#88CCEE", "#CC6677", "#DDCC77", "#DDCC77", "#332288", "#AA4499", 
                             "#44AA99", "#999933", "#882255", "#661100", "#6699CC", "#888888")

T3 <- T2  +  new_scale_fill() + 
  geom_fruit(data= na.omit(mycha.melt.X353_clade), geom=geom_tile,
             mapping= aes( y=Var1, x= Var2, fill = A353_clade, na.rm = F),
             axis.params=list( axis = "x", text  = "A353",  text.size  = 3),
             offset = 0.05, pwidth = 1.5) +
  scale_fill_manual(values=c(" 1"= "#661100",
                             " 2"= "#CC6677",
                             " 3" = "#DDCC77",
                             " 4" = "#6699CC",
                             " 5" = "#332288",
                             " 6" = "#AA4499",
                             " 7" = "#44AA99",
                             " 8" = "#882255",
                             " 9" = "#999933",
                             "10" = "#88CCEE")) +  
  theme(axis.title.x=element_blank(),
        axis.line.x=element_blank(),
        axis.ticks.x=element_blank()) 

T3

T4 <- T3  +  new_scale_fill() + 
  geom_fruit(data= na.omit(mycha.melt.nrDNA_clade), geom=geom_tile,
             mapping= aes( y=Var1, x= Var2, fill = nrDNA_clade, na.rm = F),
             axis.params=list( axis = "x", text  = "nrDNA",  text.size  = 3),
             offset = 0.05, pwidth = 1.5) +
  scale_fill_manual(values=c("1"= "#661100",
                             "2"= "#CC6677",
                             "3" = "#DDCC77",
                             "4" = "#AA4499",
                             "5" = "#999933",
                             "6" = "#88CCEE",
                             "7" = "#332288")) +
  theme(axis.title.x=element_blank(),
        axis.line.x=element_blank(),
        axis.ticks.x=element_blank()) 

T4


T5 <- T4  +  new_scale_fill() + 
  geom_fruit(data= na.omit(mycha.melt.plastome_clade) , geom=geom_tile,
             mapping= aes( y=Var1, x= Var2, fill = plastome_clade, na.rm = F),
             axis.params=list( axis = "x", text  = "plastome",  text.size  = 3),
             offset = 0.05, pwidth = 1.5) +
  scale_fill_manual(values=c(" 1"= "#661100",
                             " 2"= "#999933",
                             " 3" = "#DDCC77",
                             " 4" = "#44AA99",
                             " 5" = "#332288",
                             " 6" = "#AA4499",
                             " 7" = "#CC6677",
                             " 8" = "#882255",
                             " 9" = "#6699CC",
                             "10" = "#CC79A7",
                             "11" = "#88CCEE")) +
  theme(legend.position = c(0.8, 0.5),
        legend.key.size = unit(0.5, 'cm'),
        legend.title=element_text(size=10),
        legend.text=element_text(size= 10)) 

pdf("Myso_nrDNA_fivebars2_withname.pdf", width = 15, height = 22)
T5
dev.off()

T6 <- collapse(T5, 493, 'mixed', fill='grey70', alpha=.4) %>% 
  collapse(491, 'mixed', fill='grey70', alpha=.4) %>%
  collapse(481, 'mixed', fill='grey70', alpha=.4) %>%
  collapse(479, 'mixed', fill='grey70', alpha=.4) %>%
  collapse(424, 'mixed', fill='grey70', alpha=.4) %>%
  collapse(347, 'mixed', fill='grey70', alpha=.4) %>%
  collapse(267, 'mixed', fill='grey70', alpha=.4) 



pdf("Myso_nrDNA_fivebars2.pdf", width = 15, height = 22)

T6 + annotate("segment", x = 26, xend = 39.7, y = 5, yend = 5,colour = "black", linetype = "dashed")+ 
  annotate("segment", x = 26, xend = 39.7, y = 25, yend = 25,colour = "black", linetype = "dashed")+ 
  annotate("segment", x = 26, xend = 39.7, y = 28, yend = 28,colour = "black", linetype = "dashed")+ 
  annotate("segment", x = 26, xend = 39.7, y = 31, yend = 31,colour = "black", linetype = "dashed")+ 
  annotate("segment", x = 26, xend = 39.7, y = 34, yend = 34,colour = "black", linetype = "dashed")+ 
  annotate("segment", x = 26, xend = 39.7, y = 37, yend = 37,colour = "black", linetype = "dashed")+ 
  annotate("segment", x = 26, xend = 39.7, y = 40, yend = 40,colour = "black", linetype = "dashed")+ 
  annotate("segment", x = 26, xend = 39.7, y = 43, yend = 43,colour = "black", linetype = "dashed")+ 
  annotate("segment", x = 26, xend = 39.7, y = 46, yend = 46,colour = "black", linetype = "dashed")+ 
  annotate("segment", x = 26, xend = 39.7, y = 49, yend = 49,colour = "black", linetype = "dashed")+ 
  annotate("segment", x = 26, xend = 39.7, y = 52, yend = 52,colour = "black", linetype = "dashed")

dev.off()
