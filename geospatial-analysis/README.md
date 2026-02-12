This report was produced for the exam in Geospatial Analysis and Data Representation.

The topic of the report is about migration, and specifically, about migration governance in Italy.

To do so, 3 main questions were developed to guide the creation of the report: 
1. How and Where are dislocated the migrants in the dedicated infrastructure in Italy.
2. What are the nationalities of the migrants and How it changes over time, and Which context are involved.
3. How different governments and laws changed the phenomena over time, focusing on incidents and standoffs


### Datasets

- **Liberiamoli tutti - Sbarchi Migranti** -> https://github.com/ondata/liberiamoli-tutti/tree/main/sbarchi-migranti/dati

-  **International Organization for Migration - Missing Migrants Project** -> https://missingmigrants.iom.int/downloads

- **ISPI - Standoffs** -> https://docs.google.com/spreadsheets/d/1ahgkPp6NqMh3Dg63YHj8LVyaeW6-qHn2QQcRrKasJyM/edit?gid=0#gid=0

- **https://www.naturalearthdata.com/**

- **https://www.marineregions.org/eez.php**

- **ACLED** - https://acleddata.com

Most datasets required to reproduce the analyses are included directly within the project.
The only exception concerns the **marine regions data**, which must be downloaded manually.

Download the following files:

* [https://www.marineregions.org/download_file.php?name=World_EEZ_v12_20231025_gpkg.zip](https://www.marineregions.org/download_file.php?name=World_EEZ_v12_20231025_gpkg.zip)
* [https://www.marineregions.org/download_file.php?name=World_24NM_v4_20231025_gpkg.zip](https://www.marineregions.org/download_file.php?name=World_24NM_v4_20231025_gpkg.zip)
* [https://www.marineregions.org/download_file.php?name=World_12NM_v4_20231025_gpkg.zip](https://www.marineregions.org/download_file.php?name=World_12NM_v4_20231025_gpkg.zip)
* [https://www.marineregions.org/download_file.php?name=World_Internal_Waters_v4_20231025_gpkg.zip](https://www.marineregions.org/download_file.php?name=World_Internal_Waters_v4_20231025_gpkg.zip)

After downloading:

1. Extract the files.
2. Place the extracted contents inside the `data/` directory.

This step is required for the correct execution of the notebooks that integrate maritime jurisdiction layers.

### Project Structure

The repository includes four main Jupyter notebooks:

* **Three notebooks**, each dedicated to one research question (RQ1, RQ2, RQ3)
* **One notebook** specifically for preprocessing and preparing the standoff dataset

- R -> Directory with code, data and images produced with statistical analysis
- Maps -> Directory with the maps generated
- Data -> Directory with the part of the datasets used
- Report -> Directory with the pdf of the report

### Exported Maps

For Research Questions 1 and 3, the resulting interactive maps were exported as HTML files:

* `map_liberiamoli_tutti_accoglienza.html`
  Interactive map based on the *accoglienza* dataset from the Liberiamoli Tutti project.

* `bubble_map_mediterranean_FULL.html`
  Map showing all recorded maritime incidents in the Mediterranean based on IOM data.

* `RQ3_bubble_map_and_marine_boundaries_ispi_with_folium_w_description.html`
  Map integrating:

  * maritime jurisdiction boundaries
  * maritime incidents within Italian areas
  * standoff events based on ISPI data

Maps related to migrants’ nationalities (RQ2) were not exported. They can be explored directly within the notebook:

```
01B_data_analysis_liberiamoli-tutti_nazionalita.ipynb
```

### Statistical Analysis (R)

All statistical analyses and spatial tests performed in R are available in the dedicated directory:

```
/R
```

This includes:

* Moran’s I
* Geary’s C
* Getis-Ord Gi*

### Requirements

Each main notebook includes its own `requirements` file.
A general `requirements.txt` is also provided, listing the primary Python libraries used across the project.

### Software Versions

* **Python:** v3.12.7
* **R:** v4.3.1
