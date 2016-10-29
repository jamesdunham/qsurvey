function(responses, design) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  key_from_file()
  id = "SV_bKQGl5WB66K9yFT"
  design = survey_design(id)
  plot_flow(design)
  edges(design)
  r = responses(id, use_labels = FALSE)
  r = responses(id, use_labels = TRUE)

  ch = choices(id)
  en = export_names(id)
  sq = questions(id)
  sq[, id := as.numeric(sub("QID", "", question))]
  data.table::setkeyv(sq, "id")
  stopifnot(all(sq$export_label %in% names(r)))

  # there are 45 export labels
  names(r)
  cols = names(r)
  y = lapply(cols, function(q) {
    # if variable q isn't missing, how often is (each other) variable p
    # non-missing?
    res = r[!is.na(get(q)) & get(q) != "", lapply(.SD, function(p)
      sum(!is.na(p) & p != "")), .SDcols = cols]
    res[, lapply(.SD, function(p) round(p / .SD[[q]], 2))]
    })
  y = setNames(y, cols)
  z = data.table::rbindlist(y, idcol = "varname")
  dim(z)
  z[1:5, 1:5, with = F]
}
