as_conllu_div <- function(data){

  data <- data %>%
    group_by(sentence) %>%
    mutate(numbering = 1:n()) %>%
    ungroup()

  by_row(data, ~ paste0(.x$numbering, '\t', .x$form, '\t', .x$lemma, '\t', .x$upostag, '\t', .x$xpostag, '\t', .x$feats, '\t', .x$head, '\t', .x$deprel, sep = '\n')) %>% .$.out %>% unlist %>% paste0(collapse = '') %>%
    shiny::div(class="conllu-parse", tabs="yes", .)

}
