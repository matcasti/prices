#' @title Generador de rangos de precios
#' @name prices_ranges
#'
#' @description
#'
#'   Dado un precio mínimo y máximo (en un vector de longitud 2), genera
#'   un rango de precios tomando los intervalos regulares desde el
#'   mínimo hasta el máximo dividido en el número total de sesiones dadas.
#'
#' @param valor_hora Númerico de largo 2. Vector con los valores a interpolar.
#' @param sesiones Numérico. Vector con número de sesiones.
#' @param k Numérico. Número de valores decimales (por defecto 3).
#'
#' @return data.frame con tres columnas: `sesiones`, indicando el número
#' de sesiones, `valor_hora`, indicando el valor de la sesión y `valor_plan`,
#' indicando el valor final del plan.
#'
#' @examples
#'
#'   list(
#'     online_individual     = prices_ranges(valor_hora = c(15, 10)),
#'     presencial_individual = prices_ranges(valor_hora = c(20, 15)),
#'     presencial_duo        = prices_ranges(valor_hora = c(30, 20)),
#'     presencial_trio       = prices_ranges(valor_hora = c(40, 30)),
#'     presencial_domicilio  = prices_ranges(valor_hora = c(25, 17.5))
#'   )
#'
#' @export

prices_ranges <- function(valor_hora,
                          sesiones = c(4, 8, 12, 24, 36),
                          k = 3) {
  stopifnot(
    "valor_hora must be a vector of length 2" = length(valor_hora) == 2,
    "valor_hora must be a numeric vector" = is.numeric(valor_hora),
    "sesiones must be a numeric vector" = is.numeric(sesiones)
  )

  lowest <- valor_hora[[1]]
  highest <- valor_hora[[2]]

  valores <- seq.int(lowest, highest, length.out = length(sesiones))
  valor_plan <- sesiones*valores

  out <- data.frame(
    sesiones = sesiones,
    valor_hora = format(valores, nsmall = k, digits = k),
    valor_plan = format(valor_plan, nsmall = k, digits = k)
  )

  return(out)
}
