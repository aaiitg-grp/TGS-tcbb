CreateLatexTableFromCsv <- function(csv.filename, text.filename = 'table.txt') {
  
  csv.data <- read.csv(csv.filename, header = FALSE, sep = ",")
  
  text.file.conn <- file(text.filename, open = "wt")
  # sink(text.file.conn)
  
  for (row.idx in 1:nrow(csv.data)) {
    
    line.to.write <- NULL
    
    for (col.idx in 1:ncol(csv.data)) {
      
      if (col.idx == 1) {
        ## row title
        line.to.write <- as.character(csv.data[row.idx, col.idx])
      } else {
        ## col value
        line.to.write <- paste(line.to.write, 
                               paste('$', as.character(csv.data[row.idx, col.idx]), '$', sep = ''), 
                               sep = ' & ')
      }
    }
    rm(col.idx)
    
    line.to.write <- paste(line.to.write, ' \\\\ \n \\hline \n', sep = '')
    
    cat(line.to.write, file = text.file.conn)
    
  }
  rm(row.idx)
  
  # sink()
  close(text.file.conn)
}