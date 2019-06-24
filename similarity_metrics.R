# USAGE: ref.img.path should be the full path to the reference image. reg.img.folder should be the 
# path to the folder containing the registered images you wish to evaluate

# Load in ANTsR library
library(ANTsR)
library(ANTsRCore)

# Path to the reference image
ref.img.path <- "/home/zack/Desktop/Lab Work/Data/Zbrain/zbrain3ch-1.nrrd" 
# Path to folder containing the registered images
reg.img.folder.path <- "/home/zack/Desktop/Lab Work/Data/Alligned Images"


ref.img <- antsImageRead(ref.img.path)
files <- list.files(path = reg.img.folder.path, full.names = TRUE)
reg.img.list <- lapply(files, antsImageRead)
MI.list <- c()

# Calculate the MI between the reference img and each registered img
# (unitless quantity, lower is better)
for(i in reg.img.list) {
  MI <- antsImageMutualInformation(i, ref.img, 0.75, 32)
  MI.list <- c(MI.list, MI)
}

# Print the file names and MI metric values
files
MI.list
 
