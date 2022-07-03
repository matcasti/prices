#' @title Calcula balances financieros ordenados por fecha
#' @name prices_balance
#'
#' @description
#'
#'  Calcula el balance secuencial ordenado por fecha. Ideal para estimar el balance de un conjunto
#'  de egresos/ingresos.
#'
#' @param data Datos. Deben contener como mínimo la fecha (en el cual se asigna el concepto) o número
#' (que sirva para ordenar la secuencia del balance), así como el valor o monto asociado al egreso/ingreso.
#' Adicionalmente puede tener una columna con los conceptos (un descriptor), el cual no se verá modificado.
#' @param fecha Nombre de la columna con las fechas o número que sirva para ordenar los valores/montos.
#' @param valor Nombre de la columna con los valores. Los valores/montos deben ser mayor a cero (> 0)
#' si son ingresos, y menores a cero (< 0) si son egresos/gastos.
#' @param balance_inicial Número indicando el balance inicial al cual se le aplican los conceptos.
#' @param alcanza Lógico indicando si el se desea una columna indicando si el balance se mantiene positivo.
#'
#' @examples prices_balance(finanzas, fecha_pago, valor)
#'
#' @export

prices_balance <- function(data,
                           fecha,
                           valor,
                           balance_inicial = 0,
                           alcanza = TRUE) {


  # Check if data inherits a data.table class ---------------------------------------------------

  if (!inherits(data, "data.table")) {
    data <- data.table::as.data.table(data)
  }

  # Deal with user inputs -----------------------------------------------------------------------

  fecha <- substitute(fecha)
  if (is.character(fecha)) {
    fecha <- as.name(fecha)
  }

  valor <- substitute(valor)
  if (is.character(valor)) {
    valor <- as.name(valor)
  }

  # Calculate financial data --------------------------------------------------------------------

  output = data.table::copy(data)

  j_list = substitute(expr = {
    valor[1] = valor[1] + balance_inicial
    cumsum(valor)
  })

  output[, ("balance") := eval(j_list)][]

  if (isTRUE(alcanza)) {
    output[, ("alcanza") := eval(j_list) >= 0][]
  }

  j_list = substitute(expr = data.table::month(fecha))

  output[, ("mes") := eval(j_list)][]

  return(output)
}
