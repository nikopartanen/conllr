# read_conll
#
# This function reads CoNNL files to R dataframe.
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

read_conll <- function(file = 'https://raw.githubusercontent.com/UniversalDependencies/UD_Russian/master/ru-ud-dev.conllu'){

  `%>%` <- dplyr::`%>%`

  conll_lines <- readr::read_lines(file)

  dplyr::data_frame(string = conll_lines) %>%
    dplyr::filter(! string == '') %>%
    dplyr::mutate(sentence = cumsum(stringr::str_detect(string, '^# sent_id'))) %>%
    dplyr::group_by(sentence) %>%
}
