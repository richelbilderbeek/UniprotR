#' Connect and DOWNLOAD Proteome info.
#'
#'The function is work to retrieve proteome information based on proteome id.
#'
#' @usage GetProteomeInfo(ProteomeID , directorypath = NULL)
#'
#' @param ProteomeID Proteome ID from UniProt
#'
#' @param directorypath path to save CSV file containing results returened by the function.
#'
#' @note The function Download csv Info of proteome.
#'
#' @export
#'
#' @author Mohmed Soudy \email{Mohamed.soudy@57357.com} and Ali Mostafa \email{ali.mo.anwar@std.agr.cu.edu.eg}
GetProteomeInfo <- function(ProteomeID , directorypath = NULL)
{
  baseUrl <- "https://www.uniprot.org/uniprot/?query=proteome:"
  Request <- GET(paste0(baseUrl , ProteomeID,"&format=tab"))
  ProteinInfoParsed <- data.frame()
  if (Request$status_code == 200)
    {
    # parse the information in DataFrame
    ProteinDataTable <- tryCatch(read.table(Request$url, header = TRUE, sep = '\t'), error=function(e) NULL)
    if (!is.null(ProteinDataTable))
    {
      ProteinInfoParsed <- as.data.frame(ProteinDataTable)
    }
    
  }
  else {
    HandleBadRequests(Request$status_code)
  }
  if(!is.null(directorypath))
    {
    write.csv(ProteinInfoParsed , paste0(directorypath ,"/" , "Proteome Info.csv"))
    }
return(ProteinInfoParsed)
}
  
  
  
