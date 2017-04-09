# read_conll
#
# This function reads CoNNL files to R dataframe.
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

read_conll <- function(conll_file = 'https://raw.githubusercontent.com/UniversalDependencies/UD_Russian/master/ru-ud-dev.conllu'){

  `%>%` <- dplyr::`%>%`

  conll_lines <- readr::read_lines(conll_file)

  dplyr::data_frame(string = conll_lines) %>%
    dplyr::filter(! string == '') %>%
    dplyr::mutate(sentence = cumsum(stringr::str_detect(string, '^# sent_id'))) %>%
    dplyr::group_by(sentence) %>%
    dplyr::mutate(id = dplyr::first(string)) %>%
    dplyr::mutate(id = stringr::str_extract(id, '(?<=# sent_id = )(.+)')) %>%
    dplyr::slice(-1) %>%
    dplyr::mutate(sentence_text = dplyr::first(string)) %>%
    dplyr::mutate(sentence_text = stringr::str_extract(sentence_text, '(?<=# text = )(.+)')) %>%
    dplyr::slice(-1) %>%
    dplyr::ungroup() %>%
    tidyr::separate(col = string,
                    into = c('id', 'form', 'lemma', 'upostag', 'xpostag', 'feats', 'head', 'deprel', 'deps', 'misc'),
                    sep = '\t')
}
