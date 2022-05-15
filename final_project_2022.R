---
title: "Final Project"
author: "Bahaa Noori"
date: "5/12/2022"
---


#Installing Packages
#Those packages are required to run a DESeq2 
#Download the package from Bioconductor
if (!requireNamespace('BiocManager', quietly = TRUE))
  install.packages('BiocManager')
BiocManager::install('EnhancedVolcano')

#To install development version:
devtools::install_github('kevinblighe/EnhancedVolcano')



#Libraries needed 
library(ggplot2)
library(EnhancedVolcano)
library(ggrepel)


#loading the data and asigning a name to it. 
DEAT <- read.delim("Differential_expression_analysis_table.csv", header = TRUE, row.names = 1, sep = ",")
DEAT


# Runnig a PCA anaylyasis on the data. 
#[,2:11] excluding the first 2 columns 
#scale = TRUE -> means that the data we supplied is centered and scaled 
My_Principle <- prcomp(DEAT[,2:11], scale = TRUE)
summary(My_Principle)



#Plotting The PCA output and getting a sense of what it look like
#l = stand for line 
plot(My_Principle, type = "l")
#Figure 1: Show the variance between he different PCs that. We see that more
#than 90% of the variance is explained by the 1st and 2nd PCs.





# First examine the structure of the principal component -> this will output 
#many varibles such as stdev, scale, center, and x. X give the values for PCs. 
#Then We extract PC Scores 
str(My_Principle)
My_Principle$x

#Combening first two PCA with the original data
DEAT2 <- cbind(DEAT, My_Principle$x[,1:2])
head(DEAT2)



#Flitering the data for any adjusted p-value less than 0.05
DEAT3 <- filter(DEAT2, padj < 0.05)
head(DEAT3)



#Volcano Plot and Customization 

#Plotting The Data with the most basic volcano plot
#The default cut-off for log2FC is >|2|; 
#the default cut-off for P value is 10e-6.
EnhancedVolcano(DEAT3,
                lab = rownames(DEAT3),
                x = 'log2FoldChange',
                y = 'pvalue')


#By default, EnhancedVolcano will only attempt to label genes that pass the
#thresholds that you set for statistical significance, i.e., ‘pCutoff’ and 
#‘FCcutoff’. Also, it will only label as many of these that can 
#reasonably fit in the plot space. The user can optionally supply a vector of 
#labels (as ‘selectLab’) that s/he wishes to label in the plot.

#Modify cut-offs for log2FC and P value; specify title; adjust point and label size

#increasing this threshold of P value cut-off by a few orders of magnitude. 
EnhancedVolcano(DEAT3,
                lab = rownames(DEAT3),
                x = 'log2FoldChange',
                y = 'pvalue',
                title = 'Differential Expression of Genes between the FA cell line and the complemented line',
                pCutoff = 10e-32,
                FCcutoff = 0.5,
                pointSize = 3.0,
                labSize = 6.0)


#Adjusting color and alpha for point shading
#Coloring only the variables that pass both the log2FC and P value thresholds 
#and are colored red, with everything else black. Also, adjusted the value for ‘alpha’,
#which controls the transparency of the plotted points: 1 = 100% opaque; 0 = 100% transparent.
EnhancedVolcano(DEAT3,
                lab = rownames(DEAT3),
                x = 'log2FoldChange',
                y = 'pvalue',
                title = 'Differential Expression of Genes between the FA cell line and the complemented line',
                pCutoff = 10e-32,
                FCcutoff = 0.5,
                pointSize = 3.0,
                labSize = 6.0,
                col=c('black', 'black', 'black', 'red3'),
                colAlpha = 1)




#Adjusting cut-off lines and adding extra threshold lines
#The lines that are drawn to indicate cut-off points can be modified. 
#The parameter ‘cutoffLineType’ accepts the following values: “blank”, “solid”,
#“dashed”, “dotted”, “dotdash”, “longdash”, and “twodash”. 
#The color and thickness of these can also be modified with ‘cutoffLineCol’ and ‘cutoffLineWidth’.
#To disable the lines, set either cutoffLineType=“blank” or cutoffLineWidth=0.

EnhancedVolcano(DEAT3,
                lab = rownames(DEAT3),
                x = 'log2FoldChange',
                y = 'pvalue',
                xlim = c(-6, 6),
                title = 'Differential Expression of Genes between the FA cell line and the complemented line',
                pCutoff = 10e-12,
                FCcutoff = 1.5,
                pointSize = 3.0,
                labSize = 6.0,
                colAlpha = 1,
                cutoffLineType = 'blank',
                cutoffLineCol = 'black',
                cutoffLineWidth = 0.8,
                hline = c(10e-20,
                          10e-20 * 10e-30,
                          10e-20 * 10e-60,
                          10e-20 * 10e-90),
                hlineCol = c('pink', 'hotpink', 'purple', 'black'),
                hlineType = c('solid', 'longdash', 'dotdash', 'dotted'),
                hlineWidth = c(1.0, 1.5, 2.0, 2.5),
                gridlines.major = FALSE,
                gridlines.minor = FALSE)


#Adjust legend position, size, and text
#The position of the legend can also be changed to “left” or “right” 
#(and stacked vertically), or ‘top’ or “bottom” (stacked horizontally). 
#The legend text, label size, and icon size can also be modified.
#Note: to make the legend completely invisible, specify:
#legendPosition = 'none'

EnhancedVolcano(DEAT3,
                lab = rownames(DEAT3),
                x = 'log2FoldChange',
                y = 'pvalue',
                title = 'Differential Expression of Genes between the FA cell line and the complemented line',
                pCutoff = 10e-12,
                FCcutoff = 1.5,
                cutoffLineType = 'twodash',
                cutoffLineWidth = 0.8,
                pointSize = 4.0,
                labSize = 6.0,
                colAlpha = 1,
                legendLabels=c('Not sig.','Log (base 2) FC','p-value',
                               'p-value & Log (base 2) FC'),
                legendPosition = 'right',
                legendLabSize = 16,
                legendIconSize = 5.0)


  
#Fit more labels by adding connectors
#In order to maximize free space in the plot window by adding connectors from
#labels to points, where appropriate. The width and color of these connectors 
#can also be modified with ‘widthConnectors’ and  ‘colConnectors’, respectively.

EnhancedVolcano(DEAT3,
                lab = rownames(DEAT3),
                x = 'log2FoldChange',
                y = 'pvalue',
                title = 'Differential Expression of Genes between the FA cell line and the complemented line',
                xlab = bquote(~Log[2]~ 'fold change'),
                pCutoff = 10e-32,
                FCcutoff = 2.0,
                pointSize = 4.0,
                labSize = 6.0,
                colAlpha = 1,
                legendPosition = 'right',
                legendLabSize = 12,
                legendIconSize = 4.0,
                drawConnectors = TRUE,
                widthConnectors = 0.75)

#Only label key variables
#We can use  ‘selectLab’parameter, the contents of which have to also be present
#in the vector passed to ‘lab’.

EnhancedVolcano(DEAT3,
                lab = rownames(DEAT3),
                x = 'log2FoldChange',
                y = 'pvalue',
                title = 'Differential Expression of Genes between the FA cell line and the complemented line',
                selectLab = c('TMEM176B','ADH1A'),
                xlab = bquote(~Log[2]~ 'fold change'),
                pCutoff = 10e-14,
                FCcutoff = 2.0,
                pointSize = 4.0,
                labSize = 6.0,
                shape = c(4, 35, 17, 18),
                colAlpha = 1,
                legendPosition = 'right',
                legendLabSize = 14,
                legendIconSize = 5.0)

#Draw labels in boxes
#To improve label clarity, we can draw simple boxes around the plot’s labels via 
#boxedLabels. This works much better when drawConnectors is also TRUE.

EnhancedVolcano(DEAT3,
                lab = rownames(DEAT3),
                title = 'Differential Expression of Genes between the FA cell line and the complemented line',
                x = 'log2FoldChange',
                y = 'pvalue',
                xlab = bquote(~Log[2]~ 'fold change'),
                pCutoff = 10e-14,
                FCcutoff = 2.0,
                pointSize = 4.0,
                labSize = 6.0,
                labCol = 'black',
                labFace = 'bold',
                boxedLabels = TRUE,
                colAlpha = 4/5,
                legendPosition = 'right',
                legendLabSize = 14,
                legendIconSize = 4.0,
                drawConnectors = TRUE,
                widthConnectors = 1.0,
                colConnectors = 'black')


#Figure 2: This graph shows the differential expression of genes between the two 
#cell lines. The Black dots correspond to no significance variance. The green 
#correspond to long2 fold change and doesn't show much of varince. The blue are
#the p-value and doesn't show much of vaiance as well. The red dots are the 
#p-value and log2foldchange and show all the varicnce bertween the two cell lines. 



