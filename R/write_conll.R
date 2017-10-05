# write_conll
#
# This function writes a CoNNL file from an R dataframe.

write_conll <- function(data, sentence_id = 'test_id', utterance = 'utterance', path = 'test.conllu', ID = 'token_range', FORM = 'token_norm', LEMMA = 'lemma', UPOSTAG = 'pos', XPOSTAG = 'xpostag', FEATS = 'feats', HEAD = 'head', DEPREL = 'deprel', DEPS = 'deps', MISC = 'misc') {
        readr::write_lines(x = paste0('# sent_id = ', sentence_id), path = path, append = T)
        readr::write_lines(x = paste0('# text = ', utterance), path = path, append = T)
        readr::write_delim(x = data %>% select_(ID, FORM, LEMMA, FORM, UPOSTAG) %>% mutate(XPOSTAG = '_', FEATS = '_', HEAD = '_', DEPREL = '_', DEPS = '_', MISC = '_'), path = path, na = '_', col_names = F, delim = '\t', append = T)
        readr::write_lines(x = '', path = path, append = T)
}

# yrk_tokens %>% left_join(yrk_glosses) %>% separate(glosses, c('lemma', 'morph'), '_') %>%
#         select(page, example, length, token_range, tokens, lemma, morph, orth, ft_rus, diacr, gloss, sentence_id) %>%
#         mutate(lemma = str_replace_all(lemma, '(\\[|\\])', '')) %>%
#         mutate(morph = str_replace_all(morph, '(\\[|\\])', '')) %>%
#         mutate(tokens = str_replace_all(tokens, '(\\[|\\])', '')) %>%
#         mutate(token_norm = transliterate(tokens, model = 'yrk_norm.csv')) %>%
#         mutate(pos = str_extract(morph, '^[A-Z]+')) %>%
#         split(.$sentence_id) %>%
#         map(., ~ write_conll(data = .x, sentence_id = .x$sentence_id[1], utterance = .x$orth[1], path = 'tn_corpus.conllu'))
