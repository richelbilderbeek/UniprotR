#' Connect and parse stringdb information.
#'
#' This function is connecting to stringdb and retrieve all possible interactions
#' for the searched protein/s.
#'
#' @usage GetproteinNetwork(ProteinAccList , directorypath = NULL)
#'
#' @param ProteinAccList input a vector of UniProt Accession/s
#'
#' @param directorypath path to save excel file containing results returened by the function.
#'
#' @usage GetproteinNetwork(ProteinAccList , directorypath = NULL)
#'
#' @author Mohmed Soudy \email{Mohamed.soudy@57357.com} and Ali Mostafa \email{ali.mo.anwar@std.agr.cu.edu.eg}
#'
#' @export
GetproteinNetwork <- function(ProteinAccList , directorypath = NULL)
{
  pdf(paste0(directorypath , "/","Protin Network.pdf"))
  baseUrl <- "https://string-db.org/api/image/network?identifiers="
  Accessions <- NULL
  for (identifier in ProteinAccList)
  {
    ProteinString <- paste0(baseUrl , identifier)
    Request <- GET(ProteinString)
    if (Request$status_code == 200)
    {
      Network <- image_read(ProteinString)
      ProteinFrame <- read.csv(URLencode(paste0("https://www.uniprot.org/uniprot/?query=accession:" ,identifier ,"&format=tab&columns=protein names")))
      ProteinName <- as.character(ProteinFrame$Protein.names)
      plot(Network)
      title(list(paste0(identifier ,":" ,  ProteinName),cex = 0.4, font = 1))
      Accessions <- c(Accessions , identifier);
    }else{
      print(paste0(identifier , " Not Found on Stringdb"))
    }
  }
  ProteinList <- paste0(Accessions , collapse = "%0d")
  ProteinList <- paste0(baseUrl,ProteinList)
  ProteinList <- paste0(ProteinList , "&network_flavor=actions&block_structure_pics_in_bubbles=1")
  WholeNetwork <- image_read(ProteinList)
  plot(WholeNetwork)
  title(list("Whole Protein Network", cex = 1,
             col = "black", font = 1))
  dev.off()
}
