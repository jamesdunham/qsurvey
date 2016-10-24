function() {
id = "SV_bKQGl5WB66K9yFT"
r
sd = design(id)
head(sd)
tail(sd)
head(sq)

r = responses(id)
stopifnot(nrow(r))
sq = questions(id)
stopifnot(all(sq$export_label %in% names(r)))

x[1:5, 1:5]
x = cbind(as.matrix(names(r)), matrix(NA, ncol = length(names(r)),
  nrow = length(names(r)), dimnames = list(c(names(r)), names(r))))
names(x)
x[1:5, 1:5]

# there are 45 export labels
y = lapply(sq$export_label, function(q) {
  # if variable q isn't missing, how often is (each other) variable p
  # non-missing?
  res = r[!is.na(get(q)) & get(q) != "", lapply(.SD, function(p)
    sum(!is.na(p) & p != "")), .SDcols = sq$export_label]
  res[, varname := q][]
  })
z = data.table::rbindlist(y)
data.table::setcolorder(z, c("varname", setdiff(names(z), "varname")))
dim(z)
z[1:5, 1:5, with = F]

}
