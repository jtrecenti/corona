library(magrittr)

dados <- "http://plataforma.saude.gov.br/novocoronavirus/resources/scripts/database.js" %>%
  readr::read_file() %>%
  stringr::str_remove("var database=") %>%
  jsonlite::fromJSON() %>%
  purrr::pluck("brazil") %>%
  dplyr::mutate(values = purrr::map(values, dplyr::mutate_all, as.character)) %>%
  tidyr::unnest(values) %>%
  dplyr::mutate(date = lubridate::dmy(date))

readr::write_csv(dados, "corona-ms.csv")
