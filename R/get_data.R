.get_generic_data = function(id){
  base_url = "http://andmebaas.stat.ee/restsdmx/sdmx.ashx/GetData/"
  url = paste0(base_url, id)
  sdmx = rsdmx::readSDMX(url)
  sdmx
}

.get_dsd = function(id){
  base_url = "http://andmebaas.stat.ee/restsdmx/sdmx.ashx/GetDataStructure/"
  url = paste0(base_url, id)
  sdmx = rsdmx::readSDMX(url)
  sdmx
}

#' Retrieve data sets from the Statistics Estonia database.
#'
#' The function downloads the data set from the SDMX XML API.
#'
#' @param id Data set code.
#' @param language Language of the returned labels.
#' Either \code{et} or \code{en}.
#'
#' @examples
#' get_data("EH001")
#' get_data("EH001", language="en")
#' @export
get_data = function(id, language="et"){
  sdmx = .get_generic_data(id)
  dsd = .get_dsd(id)
  sdmx = rsdmx::setDSD(sdmx, dsd)
  df = as.data.frame(sdmx, labels = TRUE)

  # keep columns in one language
  cols = colnames(df)
  if(language == "et"){
    cols = cols[!grepl("label.en", cols)]
  }
  else if(language == "en"){
    cols = cols[!grepl("label.et", cols)]
  }
  else{
    stop(paste0("No such language: ", language))
  }

  df[cols]
}
