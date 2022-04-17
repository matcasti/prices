
# prices

<!-- badges: start -->
<!-- badges: end -->

El objetivo de `prices` es permitir un cálculo sencillo de los precios de los trabajos dependientes del tiempo para los independientes o cualquier otra forma de trabajo que requiera cobrar por hora/sesión.

## Instalación

Puedes instalar la versión de desarrollo así:

``` r
# install.packages("remotes")
remotes::install_github("matcasti/prices")
```

## Ejemplo

Este es un ejemplo básico de como usar el paquete:

```r
library(prices)

# valores por hora
(valores <- quantile(12:15)*1000)
#>    0%   25%   50%   75%  100% 
#> 12000 12750 13500 14250 15000

prices_matrix(
  valor_hora = valores,
  sesiones = c(mínimo = 8, 12, 24, 36, 48, máximo = 60)
 )
#>      mínimo                             máximo
#> 0%    96000 144000 288000 432000 576000 720000
#> 25%  102000 153000 306000 459000 612000 765000
#> 50%  108000 162000 324000 486000 648000 810000
#> 75%  114000 171000 342000 513000 684000 855000
#> 100% 120000 180000 360000 540000 720000 900000
```

