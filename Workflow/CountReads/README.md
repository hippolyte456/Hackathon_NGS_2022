# To install Rsubread

```R terminal
$ if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

$ BiocManager::install("Rsubread")
```

Installs a shit ton of librairies :

path: C:/Program Files/R/R-4.1.1/library
  packages:
    class, cluster, foreign, lattice, MASS, Matrix, mgcv, nlme, nnet, rpart, spatial, survival

  Old packages: 'backports', 'BiocManager', 'blob', 'brew', 'broom', 'callr', 'car', 'caret', 'cli',
    'clipr', 'collections', 'colorspace', 'commonmark', 'conquer', 'cpp11', 'crayon', 'curl',
    'data.table', 'DBI', 'dbplyr', 'dendextend', 'DEoptimR', 'desc', 'digest', 'dplyr', 'DT', 'dtplyr',
    'e1071', 'ellipse', 'emmeans', 'estimability', 'evaluate', 'FactoMineR', 'fansi', 'farver',
    'forcats', 'foreach', 'formatR', 'fs', 'future', 'future.apply', 'gargle', 'generics',
    'GenomeInfoDb', 'ggplot2', 'ggsignif', 'glmnet', 'globals', 'googlesheets4', 'gower', 'gplots',
    'gtable', 'gtools', 'haven', 'hms', 'htmltools', 'HTSCluster', 'httr', 'ipred', 'isoband',
    'iterators', 'jsonlite', 'knitr', 'languageserver', 'lava', 'lifecycle', 'limma', 'lintr', 'lme4',
    'locfit', 'magrittr', 'maptools', 'markdown', 'MatrixModels', 'matrixStats', 'minqa', 'modelr',
    'multcomp', 'MultiVarSel', 'nloptr', 'openssl', 'openxlsx', 'parallelly', 'pillar', 'pkgload',
    'plyr', 'polynom', 'processx', 'progressr', 'proxy', 'ps', 'purrr', 'quantreg', 'R.cache',
    'R.methodsS3', 'R.oo', 'R.utils', 'RColorBrewer', 'Rcpp', 'RcppArmadillo', 'RcppEigen', 'RCurl',
    'readr', 'readxl', 'recipes', 'reprex', 'rio', 'rlang', 'rmarkdown', 'Rmixmod', 'robustbase',
    'roxygen2', 'RSQLite', 'rstudioapi', 'rvest', 'S4Vectors', 'sandwich', 'scales', 'scatterplot3d',
    'sp', 'stringi', 'stringr', 'styler', 'sys', 'testthat', 'TH.data', 'tibble', 'tidyr', 'tidyselect',
    'tidyverse', 'timeDate', 'tinytex', 'tzdb', 'uuid', 'vctrs', 'viridis', 'viridisLite', 'vroom',
    'xfun', 'XML', 'yaml', 'zip', 'zoo'

# Exploit the file CountReads.counts

Actually can't load it in R so far ...

```R terminal
Error in load("C:/Users/ ... /CountReads.counts") : 
  bad restore file magic number (file may be corrupted) -- no data loaded
In addition: Warning message:
file ‘CountReads.counts’ has magic number '# Pro'
  Use of save versions prior to 2 is deprecated 
```

And changing the file extension to tsv (same error) :

```R terminal
Error in load("C:/Users/ ... /CountReads_counts.tsv") : 
  bad restore file magic number (file may be corrupted) -- no data loaded
In addition: Warning message:
file ‘CountReads_counts.tsv’ has magic number '# Pro'
  Use of save versions prior to 2 is deprecated 
```

Maybe the exploitation is soft locked somewhere ... 
Tsv files are normaly correctly exploited by R.