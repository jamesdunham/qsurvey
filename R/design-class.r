print.qualtrics_design = function(x) {
    message('name:\t\t', x$name)
    message('id:\t\t', x$id)
    message("created:\t", lubridate::date(x$creationDate))
    message("modified:\t", lubridate::date(x$lastModifiedDate))
    message("responses:\t", x$responseCounts$auditable,
     ifelse(x[["isActive"]], " (active)", " (closed)"))
    message("questions:\t", length(x$questions))
    message("blocks:\t\t", length(x$blocks))
}
