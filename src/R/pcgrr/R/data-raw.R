cpsr_acmg <- list()
cpsr_acmg[["score2tier"]] <- data.frame()
cpsr_acmg[["evidence_codes"]] <-
  read.table(file = "data-raw/acmg_evidence.tsv",
             header = T, stringsAsFactors = F,
             comment.char = "", na.strings = c("NA"),
             sep = "\t")
cpsr_acmg[["pathogenic_range_gnomad"]] <- list()
cpsr_acmg[["pathogenic_range_gnomad"]][["af"]] <- 0.0005
cpsr_acmg[["pathogenic_range_gnomad"]][["min_an"]] <- 12000

cpsr_acmg[["score2tier"]] <-
  data.frame("CPSR_CLASSIFICATION" = "Pathogenic",
             "CPSR_PATHOGENICITY_SCORE" = "<b>[5, ]</b>")
cpsr_acmg[["score2tier"]] <-
  dplyr::bind_rows(
    cpsr_acmg[["score2tier"]],
    data.frame("CPSR_CLASSIFICATION" = "Likely Pathogenic",
               "CPSR_PATHOGENICITY_SCORE" = "<b>[2.5, 4.5]</b>"))
cpsr_acmg[["score2tier"]] <-
  dplyr::bind_rows(
    cpsr_acmg[["score2tier"]],
    data.frame("CPSR_CLASSIFICATION" = "VUS",
               "CPSR_PATHOGENICITY_SCORE" = "<b>[-1.0, 2.0]</b>"))
cpsr_acmg[["score2tier"]] <-
  dplyr::bind_rows(
    cpsr_acmg[["score2tier"]],
    data.frame("CPSR_CLASSIFICATION" = "Likely Benign",
               "CPSR_PATHOGENICITY_SCORE" = "<b>[-4.5, -1.5]</b>"))
cpsr_acmg[["score2tier"]] <-
  dplyr::bind_rows(
    cpsr_acmg[["score2tier"]],
    data.frame("CPSR_CLASSIFICATION" = "Benign",
               "CPSR_PATHOGENICITY_SCORE" = "<b>[, -5]</b>"))

color_palette <- list()
for (c in c("pathogenicity", "clinical_evidence", "tier",
           "report_color", "warning", "success", "none")) {
  color_palette[[c]] <- list()
  color_palette[[c]][["levels"]] <- c()
  color_palette[[c]][["values"]] <- c()

  if (c == "pathogenicity") {
    color_palette[[c]][["levels"]] <-
      c("Pathogenic", "Likely_Pathogenic", "VUS", "Likely_Benign", "Benign")
    color_palette[[c]][["values"]] <-
      c("#9E0142", "#D53E4F", "#000000", "#78C679", "#077009")
  }
  if (c == "clinical_evidence") {
    color_palette[[c]][["levels"]] <-
      c("A: Validated", "A: FDA/NCCN/ELN guidelines",
        "B: Clinical evidence", "B1: Clinical evidence: late trials",
        "B2: Clinical evidence: early trials", "C: Case study",
        "D: Preclinical evidence", "E: Indirect evidence")
    color_palette[[c]][["values"]] <-
      c("#009E73", "#009E73", "#56B4E9", "#56B4E9",
        "#56B4E9", "#0072B2", "#E69F00", "#F0E442")
  }
  if (c == "tier") {
    color_palette[[c]][["levels"]] <-
      c("TIER1", "TIER2", "TIER3", "TIER4", "NONCODING",
        "COL6", "COL7", "COL8", "COL9", "COL10", "COL11",
        "COL12", "COL13", "COL14", "COL15", "COL16",
        "COL17", "COL18")
    color_palette[[c]][["values"]] <-
      c("#0073C2", "#EFC000", "#CD534C", "#7AA6DC",
        "#8F7700", "#003C67", "#3B3B3B", "#868686",
        "#593196", "#1B9E77", "#276419", "#D95F02",
        "#000000", "#E31A1C", "#E7298A", "#009999",
        "#003366", "#660033")
  }
  if (c == "report_color") {
    color_palette[[c]][["levels"]] <- c("tumor_control", "tumor_only")
    color_palette[[c]][["values"]] <- c("#2780e3", "#593196")

  }
  if (c == "warning") {
    color_palette[[c]][["levels"]] <- c("warning")
    color_palette[[c]][["values"]] <- c("#ff7518")
  }
  if (c == "none") {
    color_palette[[c]][["levels"]] <- c("none")
    color_palette[[c]][["values"]] <- c("#868686")
  }
  if (c == "success") {
    color_palette[[c]][["levels"]] <- c("success")
    color_palette[[c]][["values"]] <- c("#00a65a")
  }

}

usethis::use_data(color_palette, overwrite = T)
usethis::use_data(cpsr_acmg, overwrite = T)

heterozygous_states <- c()
ref_allele_index <- 0
while (ref_allele_index < 20) {
  alt_allele_index <- ref_allele_index + 1
  while (alt_allele_index <= 20) {
    phased_gt_1 <- paste0(ref_allele_index, "|", alt_allele_index)
    phased_gt_2 <- paste0(alt_allele_index, "|", ref_allele_index)
    unphased_gt_1 <- paste0(ref_allele_index, "/", alt_allele_index)
    unphased_gt_2 <- paste0(alt_allele_index, "/", ref_allele_index)
    heterozygous_states <- c(heterozygous_states, phased_gt_1,
                             phased_gt_2, unphased_gt_1, unphased_gt_2)
    alt_allele_index <- alt_allele_index + 1
  }
  ref_allele_index <- ref_allele_index + 1
}
homozygous_states <- c()
hom_allele_index <- 1
while (hom_allele_index <= 10) {
  phased_gt <- paste0(hom_allele_index, "|", hom_allele_index)
  unphased_gt <- paste0(hom_allele_index, "/", hom_allele_index)
  homozygous_states <- c(homozygous_states, phased_gt, unphased_gt)
  hom_allele_index <- hom_allele_index + 1
}

usethis::use_data(heterozygous_states, overwrite = T)
usethis::use_data(homozygous_states, overwrite = T)

variant_db_url <-
  data.frame(
    name = "DBSNP",
    group_by_var = "VAR_ID",
    url_prefix = "https://www.ncbi.nlm.nih.gov/projects/SNP/snp_ref.cgi?rs=",
    link_key_var = "DBSNPRSID", link_display_var = "DBSNPRSID",
    stringsAsFactors = F)
variant_db_url <-
  dplyr::bind_rows(
    variant_db_url,
    data.frame(name = "CLINVAR", group_by_var = "VAR_ID",
               url_prefix = "http://www.ncbi.nlm.nih.gov/clinvar/variation/",
               link_key_var = "CLINVAR_MSID",
               link_display_var = "CLINVAR_TRAITS_ALL", stringsAsFactors = F),
    data.frame(name = "GENE_NAME", group_by_var = "VAR_ID",
               url_prefix = "https://www.ncbi.nlm.nih.gov/gene/",
               link_key_var = "ENTREZ_ID",
               link_display_var = "GENENAME", stringsAsFactors = F),
    data.frame(name = "PROTEIN_DOMAIN", group_by_var = "VAR_ID",
               url_prefix = "http://pfam.xfam.org/family/",
               link_key_var = "PFAM_DOMAIN",
               link_display_var = "PFAM_DOMAIN_NAME", stringsAsFactors = F),
    data.frame(name = "COSMIC", group_by_var = "VAR_ID",
               url_prefix = "https://cancer.sanger.ac.uk/cosmic/search?q=",
               link_key_var = "COSMIC_MUTATION_ID",
               link_display_var = "COSMIC_MUTATION_ID", stringsAsFactors = F),
    data.frame(name = "NCBI_REFSEQ", group_by_var = "VAR_ID",
               url_prefix = "https://www.ncbi.nlm.nih.gov/nuccore/",
               link_key_var = "REFSEQ_MRNA",
               link_display_var = "REFSEQ_MRNA", stringsAsFactors = F)
  )

usethis::use_data(variant_db_url, overwrite = T)

effect_prediction_algos <-
  read.table(file = "data-raw/effect_prediction_algorithms.tsv",
             header = T, sep = "\t", quote = "", stringsAsFactors = F)
usethis::use_data(effect_prediction_algos, overwrite = T)

cancer_phenotypes_regex <-
  "(cancer|carcinoma|tumor|neoplasm|gangliom|lymphom|leukem|meningiom"
cancer_phenotypes_regex <-
  paste0(cancer_phenotypes_regex,
         "|blastoma|melanom|chordom|adenoma|sarcom|mesotheli|ependymom|glioma")
cancer_phenotypes_regex <-
  paste0(cancer_phenotypes_regex,
         "|neurofibro|keratoacan|nevus|brca|polyposis|myelodysplastic|cowden")
cancer_phenotypes_regex <-
  paste0(
    cancer_phenotypes_regex,
    "|gardner|noonan|fanconi|carney|bullosa|schwanno|li-fraumeni|xeroderma")
cancer_phenotypes_regex <-
  paste0(cancer_phenotypes_regex,
         "|leiomyom|muir-|nijmegen|neoplasia|trichoepithelioma|brooke|turcot")
cancer_phenotypes_regex <-
  paste0(
    cancer_phenotypes_regex,
    "|exostoses|lynch|drash|wilm|perlman|fibrofolliculomas|hippel|hamartom")
cancer_phenotypes_regex <-
  paste0(cancer_phenotypes_regex,
         "|bloom|werner|peutz|legius|tuberous|exostosis|angiomyolipoma")
cancer_phenotypes_regex <-
  paste0(
    cancer_phenotypes_regex,
    "|lymphoproliferative|stat3|teratoma|thrombocytop|tp63|wiskott|weaver")
cancer_phenotypes_regex <-
  paste0(cancer_phenotypes_regex,
         "|pheochromo|gorlin|telangiectasia|hemangiom|osteochondro|response")
cancer_phenotypes_regex <-
  paste0(cancer_phenotypes_regex,
         "|polg-related|ras-associated|dyskeratosis")
cancer_phenotypes_regex <-
  paste0(
    cancer_phenotypes_regex,
    "|waardenburg|beckwidth|birt-hogg|costello|diamond|cardio-facio|frasier")
cancer_phenotypes_regex <-
  paste0(cancer_phenotypes_regex,
         "|hirschsprung|hydrocephalus|hyperparathyroidism|immunodeficiency")
cancer_phenotypes_regex <-
  paste0(
    cancer_phenotypes_regex,
    "|infantile myofibromatosis|leopard|proteus|rothmund|russel)")
usethis::use_data(cancer_phenotypes_regex, overwrite = T)

rm(cancer_phenotypes_regex)
rm(phased_gt)
rm(phased_gt_1)
rm(phased_gt_2)
rm(unphased_gt)
rm(unphased_gt_1)
rm(unphased_gt_2)
rm(ref_allele_index)
rm(homozygous_states)
rm(heterozygous_states)
rm(alt_allele_index)
rm(hom_allele_index)
rm(color_palette)
rm(cpsr_acmg)
rm(effect_prediction_algos)
rm(variant_db_url)
rm(c)
