
# Import the data -----------------------------------------------------------------------------

library(data.table)

finanzas = data.table::fread("data-raw/raw-data.csv",
                             key = "fecha_pago",
                             strip.white = TRUE,
                             blank.lines.skip = TRUE)

usethis::use_data(finanzas, overwrite = TRUE)
