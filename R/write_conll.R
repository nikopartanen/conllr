# write_conll
#
# This function writes a CoNNL file from an R dataframe.

write_conll <- function(data, sentence_id = 'test_id', utterance = 'utterance', path = 'test.conllu', ID = 'token_range', FORM = 'token_norm', LEMMA = 'lemma', UPOSTAG = 'pos', XPOSTAG = 'xpostag', FEATS = 'feats', HEAD = 'head', DEPREL = 'deprel', DEPS = 'deps', MISC = 'misc') {
        readr::write_lines(x = paste0('# sent_id = ', sentence_id), path = path, append = T)
        readr::write_lines(x = paste0('# text = ', utterance), path = path, append = T)
        readr::write_delim(x = data %>% select_(ID, FORM, LEMMA, FORM, UPOSTAG) %>% mutate(XPOSTAG = '_', FEATS = '_', HEAD = '_', DEPREL = '_', DEPS = '_', MISC = '_'), path = path, na = '_', col_names = F, delim = '\t', append = T)
        readr::write_lines(x = '', path = path, append = T)
}
