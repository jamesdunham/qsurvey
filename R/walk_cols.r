function(responses, design) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  key_from_file()
  id = "SV_2bDLL1k3csf1mlv"
  design = survey_design(id)
  plot_flow(design)
  edges(design)
  # r = responses(id, use_labels = FALSE)
  r = responses(id, use_labels = TRUE)
  r = keep_questions(r, design)
  r = r[Q1.2 == "No"]

  cols = names(r)
  y = lapply(cols, function(q) {
    # if variable q isn't missing, how often is (each other) variable p
    # non-missing?
    res = r[!is.na(get(q)) & get(q) != "", lapply(.SD, function(p)
      sum(!is.na(p) & p != "")), .SDcols = cols]
    res[, lapply(.SD, function(p) round(p / .SD[[q]], 2))]
    })
  y = setNames(y, cols)
  z = data.table::rbindlist(y, idcol = "var1")
  z = data.table::melt(z,
    id.vars = "var1",
    variable.name = "var2",
    value.name = "proportion",
    variable.factor = FALSE)
  z = z[var1 != var2]

  names(r)
  unique(r[, Q1.2]) # edited No / Yes
  unique(r[, Q1.3_2]) # edited a top general journal
  unique(r[, Q1.3_3]) # edited a top field journal
  unique(r[, Q1.3_4]) # edited another journal

  # saw intro blocks
  block_intros = c("Q1.1", "Q2.1", "Q3.1", "Q4.1", "Q5.1")
  props = z[var1 %in% block_intros & var2 %in% block_intros]
  blocks(design)
  recode_blocks = function(x) {
    switch(x,
      "Q1.1" = "1. Intro",
      "Q2.1" = "2. Reviewer",
      "Q3.1" = "3. Author",
      "Q4.1" = "4. Editor",
      "Q5.1" = "5. Career"
    )
  }
  props$var1 = sapply(props$var1, recode_blocks)
  props$var2 = sapply(props$var2, recode_blocks)
  prop_table = data.table::dcast(props, var1 ~ var2, fill = 1)
  knitr::kable(prop_table, format = "markdown")


}
