.create_dataset_list = function(language="et"){
  base_url = "http://andmebaas.stat.ee/Index.aspx"
  url = paste0(base_url, "?lang=", language)
  html = xml2::read_html(url)
  nodes = rvest::html_nodes(html, ".ds")
  descriptions = rvest::html_text(nodes)
  items = stringr::str_split_fixed(descriptions, ": ", 2)
  df = data.frame(items)
  colnames(df) = c("code", "description")
  return(df)
}

.get_dataset_list = function(language="et"){
  obj_name = paste0("dataset_list_", language)
  if(!exists(obj_name, envir=pkg_env)){
    assign(obj_name, .create_dataset_list(language), envir=pkg_env)
  }
  df = get(obj_name, envir=pkg_env)
}

#' Search data sets from Statistics Estonia database.
#'
#' The function greps the phrase from the data sets' descriptions.
#'
#' @param phrase Search phrase.
#' @param language Language of the search phrase and returned descriptions.
#' Either \code{et} or \code{en}.
#'
#' @examples
#' search_data("produktiivsus")
#' search_data("alcohol", language="en")
#' @export
search_data = function(phrase, language="et"){
  df = .get_dataset_list(language)
  ix = grepl(phrase, df$description, ignore.case = TRUE)
  return(df[ix, ])
}
