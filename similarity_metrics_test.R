# WSL path "/mnt/c/Users/TracingPC1/Desktop/R_scripts/similarity_metrics.R"

# USAGE: ref.img.path should be the full path to the reference image. reg.img.folder should be the 
# path to the folder containing the registered images you wish to evaluate

# Load in ANTsR library
# library(ANTsR)
# library(ANTsRCore)

# Path to the reference image
ref.img.path <- '/mnt/c/Users/TracingPC1/Desktop/ANTSruns/volumes/zbrain3ch.nrrd'
# Path to folder containing the registered images
reg.img.parent.path <- '/mnt/c/Users/TracingPC1/Desktop/ANTSruns/runs'

setwd(reg.img.parent.path)

subfolders <- list.dirs(full.names=FALSE, recursive=FALSE)
file.name <- 'outputWarped.nii.gz'
MI.vector <- 1:length(subfolders)

for(i in 1:length(subfolders)) {
  file.path = paste(reg.img.parent.path,subfolders[i],file.name, sep="/"); print(file.path)
  print(sprintf("Metrics for %s", subfolders[i]))
  
  command <- 'MeasureImageSimilarity'
  sys.args.1 <- '-d 3 -m MI['
  sys.args.2 <- paste(ref.img.path, file.path, sep=", ")
  sys.args.3 <- ', 1, 32] -v 1'
  
  system2(command, args=paste(sys.args.1, sys.args.2, sys.args.3, sep=""), stdout=TRUE)
  MI.vector[i] <- as.numeric(output)
  print(MI.vector[i])
}

print(MI.vector)

# # ref.img <- antsImageRead(ref.img.path)
# # files <- list.files(path = reg.img.folder.path, full.names = TRUE)
# # reg.img.list <- lapply(files, antsImageRead)
# # MI.list <- c()
# #
# # # Calculate the MI between the reference img and each registered img
# # # (unitless quantity, lower is better)
# # for(i in reg.img.list) {
# #   MI <- antsImageMutualInformation(i, ref.img, 0.75, 32)
# #   MI.list <- c(MI.list, MI)
# # }
# 
# # Print the file names and MI metric values
# files
# MI.list