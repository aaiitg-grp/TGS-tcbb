AdjMxToSif <- function(adj.mx) {
  
  ## Open an output file connection in write mode
  output.sif <- file('net.sif', 'w')
  
  ## separator for SIF
  sep.sif <- ' '
  
  for (src.node.idx in 1:nrow(adj.mx)) {
    line.to.write <- rownames(adj.mx)[src.node.idx]
    
    ## if the source node is not an isolated node
    if ((sum(adj.mx[src.node.idx, ]) != 0) | (sum(adj.mx[, src.node.idx]) != 0)) {
      ## if the source node has at least one target node
      
      if (sum(adj.mx[src.node.idx, ]) >=  1) {
        ## 'pd' stands for Protein-DNA interaction type in Cytoscape.
        line.to.write <- paste(line.to.write, 'pd', sep = sep.sif)
        
        for (tgt.node.idx in 1:ncol(adj.mx)) {
          if (adj.mx[src.node.idx, tgt.node.idx] == 1) {
            line.to.write <- paste(line.to.write, colnames(adj.mx)[tgt.node.idx], sep = sep.sif)
          }
        }
        rm(tgt.node.idx)
      }
    }
    
    cat(line.to.write, file = output.sif, '\n')
  }
  rm(src.node.idx)
  
  ## Close the output file connection
  close(output.sif)
}