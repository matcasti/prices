#' @title Generador de matrices de precios
#' @name prices_matrix
#'
#' @description
#'
#'   Genera una matriz de valores para una combinación de precios por hora
#'   y una cantidad de sesiones en formato vectores, pudiendo ser (idealmente),
#'   de longitud > 1 (devolviendo así una matriz).
#'
#' @param valor_hora Numérico. Vector con los valores por hora.
#' @param sesiones Numérico. Vector con número de sesiones.
#'
#'
#' @return Matriz si alguno de los vectores es de longitud > 1, de lo contrario
#' devuelve un vector de longitud 1 equivalente a el producto de `valor_hora` y `sesiones`
#'
#' @examples
#'
#'   prices_matrix(
#'     valor_hora = 10:15,
#'     sesiones = c(8, 12, 24, 36, 48, 60)
#'    )
#'
#' @export

prices_matrix <- function(valor_hora, sesiones) {
  stopifnot(
    "valor_hora must be numeric" = is.numeric(valor_hora),
    "sesiones must be numeric" = is.numeric(sesiones)
  )

  check_name <- function(value) {
    if (is.null(names(value))) {
      names(value) <- value
    }
    return(value)
  }

  valor_hora <- check_name(valor_hora)
  sesiones   <- check_name(sesiones)

  check_length <- function(value) {
    if (length(value) > 1) {
      value <- as.matrix(value)
    }
    return(value)
  }

  valor_hora <- check_length(valor_hora)
  sesiones   <- check_length(sesiones)

  if ((length(valor_hora) + length(sesiones)) > 2) {
    out <- valor_hora %*% t(sesiones)
  } else {
    out <- valor_hora * sesiones
  }

  return(out)
}

