# statamet

`statamet` is an R package to search and download data from the Statistics Estonia [database](http://andmebaas.stat.ee/Index.aspx?lang=et).

## Installation

Use the `devtools` package to install the development version from Github:

```
devtools::install_github("tanelp/statamet", dependencies=TRUE)
```

## Examples

### search_data(phrase, language="et")

```R
> statamet::search_data("produktiivsus")

     code                                     description
370  PM12                Loomade ja lindude produktiivsus
371 PM121 Loomade ja lindude produktiivsus maakonna järgi
```

### get_data(id, language="et")

```R
> df = statamet::get_data("PM12")
> head(df, 3)

  DIM2                         DIM2_label.et TIME_FORMAT obsTime obsValue
1    1 Keskmine piimatoodang lehma kohta, kg         P1Y    1980     3658
2    1 Keskmine piimatoodang lehma kohta, kg         P1Y    1981     3594
3    1 Keskmine piimatoodang lehma kohta, kg         P1Y    1982     3515
```
