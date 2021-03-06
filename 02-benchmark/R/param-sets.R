param_sets_plan <- drake_plan(
  param_set_svm1 = target(
    ParamSet$new(params = list(
      ParamFct$new("type", "C-classification"),
      ParamFct$new("kernel", "radial"),
      ParamDbl$new("cost", lower = 0, upper = 100),
      ParamDbl$new("gamma", lower = 0, upper = 100)
    ))
  ),

  param_set_svm2 = target({
    foo <- ParamSet$new(params = list(
      ParamFct$new("type", "C-classification"),
      ParamFct$new("kernel", "radial"),
      ParamDbl$new("cost", lower = -5, upper = 5),
      ParamDbl$new("gamma", lower = -5, upper = 3)
    ))

    foo$trafo <- function(x, param_set) {
      x$cost <- 2^x$cost
      x$gamma <- 2^x$gamma
      return(x)
    }
    return(foo)
  }),

  param_set_knn1 = target({
    ParamSet$new(params = list(
      ParamInt$new("k", lower = 1, upper = 50),
      ParamDbl$new("distance", lower = 1, upper = 50)
    ))
  }),
  param_set_knn2 = target({
    ParamSet$new(params = list(
      ParamInt$new("k", lower = 1, upper = 30)
    ))
  }),

  param_set_list = list(
    param_set_svm1,
    param_set_svm2,
    param_set_knn1,
    param_set_knn2
  )
)
