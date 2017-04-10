# read_conll
#
# This function reads CoNNL files to R dataframe.
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

read_conll <- function(conll_file = '~/langdoc/universal_dependencies/ud-treebanks-conll2017/UD_Russian-SynTagRus/ru_syntagrus-ud-train.conllu'){

  `%>%` <- dplyr::`%>%`

  conll_lines <- readr::read_lines(conll_file)

  dplyr::data_frame(string = conll_lines) %>%
    dplyr::mutate(sentence = cumsum(stringr::str_detect(string, '^$'))) %>%
    dplyr::filter(! string == '') %>%
    dplyr::group_by(sentence) %>%
#    dplyr::mutate(id = dplyr::first(string)) %>%
    dplyr::mutate(id = stringr::str_extract(string, '(?<=# sent_id = )(.+)')) %>%
#    dplyr::slice(-1) %>%
#    dplyr::mutate(sentence_text = dplyr::first(string)) %>%
    dplyr::mutate(sentence_text = stringr::str_extract(string, '(?<=# text = )(.+)')) %>%
#    dplyr::slice(-1) %>%
    tidyr::fill(id) %>%
    tidyr::fill(sentence_text) %>%
    dplyr::filter(! stringr::str_detect(string, '^#')) %>% # if there are more annotations above the sentence, those are now disgarded
    dplyr::ungroup() %>%
    tidyr::separate(col = string,
                    into = c('id', 'form', 'lemma', 'upostag', 'xpostag', 'feats', 'head', 'deprel', 'deps', 'misc'),
                    sep = '\t')
}
