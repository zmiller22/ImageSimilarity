
# Path to the reference image
ref.img.path <- '/mnt/c/Users/TracingPC1/Desktop/ANTSruns/volumes/zbrain3ch.nrrd'
# Path to folder containing the registered images
reg.img.parent.path <- '/mnt/c/Users/TracingPC1/Desktop/ANTSruns/runs'

setwd(reg.img.parent.path)

subfolders <- list.dirs(full.names=FALSE, recursive=FALSE)
file.name <- 'outputWarped.nii.gz'

row.names <- c("MI", "CC", "Mattes", "GC", "MeanSquares")
col.names <- as.character(a:length(subfolders))
metric.values <- matrix(data=NA, nrow=5, ncol=length(subfolders), dimnames=list(row.names, col.names))

for(i in 1:length(subfolders)) {
  file.path = paste(reg.img.parent.path,subfolders[i],file.name, sep="/"); print(file.path)
  print(sprintf("Metrics for %s", subfolders[i]))
  
  command <- 'MeasureImageSimilarity'
  
  file.args <- paste(ref.img.path, file.path, sep=", ")
  
  MI.sys.args.1 <- '-d 3 -m MI['
  MI.sys.args.2 <- ', 1, 32]'
  
  CC.sys.args.1 <- '-d 3 -m CC['
  CC.sys.args.2 <- ', 1, 5]'
  
  Mattes.sys.args.1 <- '-d 3 -m Mattes['
  Mattes.sys.args.2 <- ', 1, 32]'
  
  GC.sys.args.1 <- '-d 3 -m GC['
  GC.sys.args.2 <- ', 1]'
  
  MeanSquares.sys.args.1 <- '-d 3 -m MeanSquares['
  MeanSquares.sys.args.2 <- ', 1]'
  
  MI.output <- system2(command, args=paste(MI.sys.args.1, file.args, MI.sys.args.2, sep=""), stdout=TRUE)
  CC.output <- system2(command, args=paste(CC.sys.args.1, file.args, CC.sys.args.2, sep=""), stdout=TRUE)
  Mattes.output <- system2(command, args=paste(Mattes.sys.args.1, file.args, Mattes.sys.args.2, sep=""), stdout=TRUE)
  GC.output <- system2(command, args=paste(GC.sys.args.1, file.args, GC.sys.args.2, sep=""), stdout=TRUE)
  MeanSquares.output <- system2(command, args=paste(MeanSquares.sys.args.1, file.args, MeanSquares.sys.args.2, sep=""), stdout=TRUE)

  metric.values[1,i] <- as.numeric(MI.output)
  metric.values[2,i] <- as.numeric(CC.output)
  metric.values[3,i] <- as.numeric(Mattes.output)
  metric.values[4,i] <- as.numeric(GC.output)
  metric.values[5,i] <- as.numeric(MeanSquares.output)
  
  print(metric.values)
}
