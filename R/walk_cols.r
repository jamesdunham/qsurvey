function() {
  key_from_file()
  id = "SV_bKQGl5WB66K9yFT"

  sd = design(id)
  plot_flow(sd)
  edges(sd)
  r = responses(id, use_labels = FALSE)
  r[, grepl('fraud', names(r)), with = FALSE]
  r[, grepl('confidence', names(r)), with = FALSE]
  r = responses(id, use_labels = TRUE)
  r[, grepl('fraud', names(r)), with = FALSE]
  r[, grepl('confidence', names(r)), with = FALSE]
  r[, grepl('husted', names(r)), with = FALSE]

  prop.table(table(r[, fraud_statement_attribution], useNA = 'always'))
  prop.table(table(r[, husted_intro], useNA = 'always'))
  names(r)
  stopifnot(nrow(r) > 0)
  qu = questions(id)
  str(qu)
  ch = choices(id)
  en = export_names(id)
  en[grepl('fraud', export_name)]
  ch[question %in% c("QID20", "QID21")]

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
