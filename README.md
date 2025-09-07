# BiodataBlueFlowersWikidata
Semantic integration of blue flower biodiversity data using Wikidata, GBIF, and POWO. Includes R scripts for data retrieval, cleaning, and visualization.

# Blue Flower Biodata
This repository contains the R script and resources used in the study *“Interconnected biodata from blue flowers”* (submitted to the *American Journal of Botany*).

# Overview
The project explores how floral color information (specifically blue flowers) can be curated, structured, and interconnected across major biodiversity data sources. Using semantic web technologies and open datasets, we demonstrate how phenotypic traits can be transformed into computable, interoperable formats.

# Data Sources
- **Wikidata**: Semantic annotations and species traits accessed via SPARQL queries.  
- **POWO (Plants of the World Online)**: Taxonomic backbone for species identification.  
- **GBIF**: Georeferenced occurrence records retrieved with the [`rgbif`](https://cran.r-project.org/package=rgbif) R package.  

# Contents
- `blue_flower_script.R` – Main R script for data retrieval, cleaning, and integration.  
- Example queries and code snippets for SPARQL and GBIF data access.  

# Links
- Curated dataset archived in Zenodo (DOI:https://doi.org/10.5281/zenodo.17073758).  
- Wikidata queries: [SPARQL examples](https://w.wiki/7ujk).  

# License
This repository is released under the MIT License for code and CC-BY 4.0 for data.
