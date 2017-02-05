#' See Terms in Context
#'
#' Examine regex term selections in the context of n rows before and after.
#'
#' @param x A data.frame with a text column.
#' @param regex A regular expression that will be highlighted.
#' @param file A file to output the .html output to.
#' @param n.before The number of rows before an occurrence to show.
#' @param n.after The number of rows after an occurrence to show.
#' @param color The highlight color.
#' @param open logical.  If \code{TRUE} the created .html file will attempt to be opened.
#' @param text.var The name of the text variable. If TRUE split_word tries to detect the text column with words.
#' @param ignore.case logical.  If \code{TRUE} case sensitivity is ignored.
#' @param \ldots ignored.
#' @return Generates an .html file with highlighted terms in context.
#' @export
#' @examples
#' \dontrun{
#' context(presidential_debates_2012, '\\b[Oo][Hh]\\b')
#' context(presidential_debates_2012, '\\b[Oo][Hh]\\b', n.before = 3, n.after = 2)
#' context(presidential_debates_2012, '\\b([Bb]ut|[Oo][Hh])\\b')
#' context(presidential_debates_2012, '^[Bb]ut\\b')
#' context(presidential_debates_2012, 'mister', ignore.case = TRUE)
#' context(presidential_debates_2012, 'please', ignore.case = TRUE)
#' context(presidential_debates_2012, '\\b[Bb]ut\\b', color = 'yellow')
#' context(presidential_debates_2012, 'I(\'[a-z]+)*\\b(?=\\slike)', color = 'orange')
#' context(presidential_debates_2012, 'health care', ignore.case = TRUE)
#' context(presidential_debates_2012, '((I\\b.*\\bto\\b)|(\\bto\\b.*I\\b))')
#' }
context <- function(x, regex, file = "out.html", n.before = 1, n.after = n.before,
    color = "lightgreen", open = TRUE, text.var = TRUE, ignore.case = FALSE, ...){

    if (isTRUE(text.var)) {
        text.var <- names(which.max(sapply(as.data.frame(x), function(y) {
                if (!is.character(y) && !is.factor(y)) return(0)
                mean(nchar(as.character(y)), na.rm = TRUE)
        }))[1])
        if (length(text.var) == 0) stop("Could not detect ` text.var`.  Please supply `text.var` explicitly.")
    }


    locs <- which(termco::search_term_which(x[[text.var]], regex, ignore.case = ignore.case))
    len <- nrow(x)

    tables <- lapply(locs, function(i){
        j <- i
        i <- c(i - rev(seq_len(n.before)), i, i + seq_len(n.after))
        i <- i[i > 0 & i < len]

        txt <- data.frame(rows = as.character(i), x[i, ], stringsAsFactors = FALSE)
        txt[] <- lapply(txt, as.character)
        loc <- which(txt[['rows']] %in% as.character(j))
        txt[[text.var]][loc] <- gsub(
            paste0('(', regex, ')'),
            "templeftanglemark class=\"pos\"temprightangle\\1templeftangle/marktemprightangle",
            unlist(txt[[text.var]])[loc],
            ignore.case = ignore.case,
            perl = TRUE
        )

        blank <- txt[1:2, ]
        blank[] <- ''
        rbind.data.frame(txt, blank, stringsAsFactors = FALSE)
    })


    tables[[length(tables)]] <- tables[[length(tables)]][1:(nrow(tables[[length(tables)]]) - 2),]
    html_out <- capture.output(xtable::print.xtable(xtable::xtable(do.call(rbind, tables)), 'html', include.rownames = FALSE))
    body <- paste(paste(textclean::mgsub(html_out, c("templeftangle", "temprightangle"), c("<", ">"))[-c(1:2)], collapse = "\n"), collapse ="<br><br>")

    marks <- c(pos = color)
    hilight::template2html(hilight::insert_body(hilight::highlight_template(marks), body), file = file)
    if (isTRUE(open)) hilight::open_html(x = file)

}
