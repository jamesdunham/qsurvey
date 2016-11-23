# rename_questions = function() {
# library(qsurvey)
# id = "SV_cuxfjYWRTB30ouh"
# key_from_file()
# d = survey_design(id)
#
# r_id = responses(id, use_labels = FALSE)
# r_labels = responses(id, use_labels = TRUE) # default
#
# # At least four header formats can be found in response tables exported from the
# # Qualtrics Control Panel.
#
# #
#
# modern = read.csv("~/Downloads/table.csv", header = FALSE)
# modern = setNames(as.data.frame(t(modern[1:2, ])), c("h1", "h2"))
# modern
#
# # modern, but "not all fields" just omits everything but question responses,
# # like _recordId and finished
#
# modern_not_all_fields = read.csv("~/Downloads/table_not_all_fields.csv", header = FALSE)
# modern_not_all_fields = setNames(as.data.frame(t(modern_not_all_fields[1:2, ])), c("h1", "h2"))
# modern_not_all_fields
#
# all(modern_not_all_fields$h1 %in% modern$h1)
# all(modern_not_all_fields$h2 %in% modern$h2)
#
# # Legacy with defaults (use question numbers ticked)
#
# legacy_q_nums = read.csv("~/Downloads/legacy_question_numbers.csv", header = FALSE)
# legacy_q_nums = setNames(as.data.frame(t(legacy_q_nums[1:2, ])), c("h1", "h2"))
# legacy_q_nums
# # h1 here (V1, V2, ...) for first 10 vars matches those in legacy without
# # question numbers
# # h2 here matches other legacy h2
#
# # Legacy (use question numbers unticked)
#
# legacy = read.csv("~/Downloads/legacy.csv", header= FALSE)
# legacy = setNames(as.data.frame(t(legacy[1:2, ])), c("h1", "h2"))
# legacy
# # h2 here matches other legacy h2
#
# # Select legacy, then untick use legacy format
#
# legacy_not_legacy = read.csv("~/Downloads/legacy_not_legacy.csv", header = FALSE)
# legacy_not_legacy = setNames(as.data.frame(t(legacy_not_legacy[1:3, ])), c("h1", "h2", "h3"))
# legacy_not_legacy
# # h1 here matches h1 in legacy without question numbers
# # h2 here matches other legacy h2
# # h3 here matches h1 from modern
#
# head(r_id)
# # h1 here matches: legacy_not_legacy and legacy w/o question numbers
#
# qu = questions(d)
# head(qu)
#
# rename(tbl, design, from = )
#
# # datatable 1, id: ipAddress, QID2
# # datatable 2, name_label: IP Address, mc_sa_2 - question label for mc-sa-2
#
# # legacy 1, name: IPAddress, mc_sa_2
# # legacy 1 number: V6, V12, ...
# # legacy 2, label: IPAddress, question label for mc-sa-2
# # legacy 3, legacy_id: (legacy-not-legacy): {'ImportId': 'ipAddress'},  {'ImportId': 'QID1'}
#
# col_map = function(id) {
#   modern = responses(id, format = "json", limit = 1)
#   names(modern)
#   csv = responses(id, format = "csv", limit = 1)
#   names(csv)
#   csv[1:2, ]
#   csv2013 = responses(id, format = "csv2013", limit = 1)
#   names(csv2013)
#   csv2013[1, ]
#   map = data.frame(
#     id = names(modern),
#     name = names(csv),
#     number = names(csv2013),
#     label = unlist(csv[1, ]),
#     legacy_id = unlist(csv[2, ]),
#     number = unlist(csv2013[1, ]),
#     stringsAsFactors = FALSE)
#   head(modern)
#   head(csv)  # +2 rows
#   head(csv2013)  # +1 row
# }

#' Rename response table columns
#'
#' \code{ids_to_names} takes a table of responses and renames the columns with
#' question identifier names (e.g. \code{QID2}) using question names (e.g.,
#' \code{approval}). \code{names_to_ids} does the reverse.
#'
#' @inheritParams drop_sensitive
#' @inheritParams choices
#'
#' @return The data.frame with renamed columns.
#' @aliases names_to_ids
#' @export
ids_to_names = function(tbl, design) {
  en = export_names(design)
  data.table::setDT(tbl)
  data.tabel::setnames(tbl, en$id, en$export_name)
  return(tbl[])
}

#' @rdname ids_to_names
#' @export
names_to_ids = function(tbl, design) {
  en = export_names(design)
  data.table::setDT(tbl)
  data.tabel::setnames(tbl, en$export_name, en$id)
  return(tbl[])
}
