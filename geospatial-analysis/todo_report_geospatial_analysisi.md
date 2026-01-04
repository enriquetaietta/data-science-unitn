# **Geospatial Data Analysis: Distribuzione e Analisi dei Flussi Migratori nel Mediterraneo**
**Autore:** Enrique Taietta
**Data:** 30/12/2025
**Corso:** Geospatial Data Analysis and Representation in Data Science

---

## **📌 Abstract**
*Da scrivere dopo la conclusione dell'analisi.*
**Obiettivo:** Analizzare la distribuzione spazio-temporale dei migranti nei centri di accoglienza italiani, la provenienza per nazionalità, e gli incidenti in mare nel Mediterraneo. Utilizzare modelli di autocorrelazione spaziale e regressione per identificare pattern e possibili associazioni con eventi socio-politici.

---

## **📂 Struttura del Report**
1. **Introduzione**
   - Contesto e motivazione
   - Domande di ricerca
   - Obiettivi
2. **Dataset e Metodologia**
   - Descrizione dataset
   - Preprocessing e pulizia
   - Strumenti utilizzati (QGIS, Python, GeoPandas, etc.)
3. **Analisi Dati**
   - Analisi esplorativa
   - Statistica descrittiva
4. **Visualizzazione e Mappe**
   - Distribuzione temporale nei centri di accoglienza
   - Distribuzione per nazionalità
   - Incidenti in mare e analisi di adiacenza
5. **Modelli Matematici**
   - Autocorrelazione spaziale
   - Regressione spaziale
   - Associazione con eventi specifici
6. **Risultati e Discussione**
   - Sintesi dei risultati
   - Confronto con letteratura
7. **Conclusioni e Lavori Futuri**
8. **Bibliografia**

---

## **📊 Tabella di Marcia**

### **1. Impostare la Struttura del Report (+ Abstract)**
- **Obiettivo:** Definire la struttura logica e scrivere l'abstract.
- **Output:** File `.md` con struttura dettagliata.
- **Note:** Lasciare l'abstract in bozza fino alla fine.

---

### **2. Analisi Dettagliata del Dataset**
- **Obiettivo:** Esplorare, pulire e preparare i dati per l'analisi spaziale.
- **Attività:**
  - Creare notebook `01-data_analysis.ipynb`:
    - Caricamento dataset
    - Pulizia e preprocessing
    - Statistica descrittiva
  - Creare **GeoPackage** e **GeoParquet** per l'archiviazione ottimizzata.
  - Scrivere la sezione **Data Analysis** nel report.
- **Output:**
  - Notebook Jupyter
  - File `.gpkg` e `.parquet`
  - Sezione "Dataset e Metodologia" completata.

---

### **3. Creazione Mappe**
- **Obiettivo:** Visualizzare i dati geospaziali con mappe interattive e statiche.

#### **3.1 Distribuzione Temporale nei Centri di Accoglienza**
- **Notebook:** `02_migrants_distribution_time.ipynb`
- **Output:** Mappa interattiva (Folium/Plotly) o statica (Matplotlib) con timeline.

#### **3.2 Distribuzione per Nazionalità**
- **Notebook:** `03_migrants_nationality_distribution_time.ipynb`
- **Output:** Mappa coropletica o a punti con distribuzione per paese di provenienza.

#### **3.3 Incidenti in Mare e Analisi di Adiacenza**
- **Notebook:** `04_missing_migrants_mediterranean.ipynb`
- **Output:**
  - Mappa con punti di incidenti e salvataggi.
  - Analisi di clustering spaziale (DBSCAN, K-Means).
  - Sezione "Visualizzazione e Mappe" completata.

---

### **4. Modelli Matematici**
- **Obiettivo:** Applicare modelli di autocorrelazione spaziale (Moran's I) e regressione spaziale (SLM/SEM).
- **Attività:**
  - Analizzare associazione con eventi socio-politici (es. guerre, crisi economiche).
  - Scrivere la sezione "Modelli Matematici".
- **Output:** Sezione "Modelli Matematici" completata.

---

### **5. Revisione Articoli e Scrittura Results/Conclusions**
- **Obiettivo:** Confrontare i risultati con la letteratura e trarre conclusioni.
- **Attività:**
  - Revisione di 3-5 articoli scientifici.
  - Scrivere sezioni "Risultati e Discussione" e "Conclusioni".
- **Output:** Report completo in `.md` e `.pdf`.

---

## **⏳ Gestione del Tempo**
| Fase | Durata Stimata | Data Inizio | Data Fine |
|------|----------------|-------------|-----------|
| 1. Struttura | 2 giorni | 02/01/2026 | 03/01/2026 |
| 2. Analisi Dati | 5 giorni | 04/01/2026 | 08/01/2026 |
| 3. Mappe | 7 giorni | 09/01/2026 | 15/01/2026 |
| 4. Modelli | 5 giorni | 16/01/2026 | 20/01/2026 |
| 5. Revisione | 3 giorni | 21/01/2026 | 23/01/2026 |

---

## **📌 Note Finali**
- **Strumenti consigliati:** QGIS, Python (GeoPandas, Folium, Plotly, Scikit-learn), Jupyter Notebook.
- **Formato output:** `.md` per il report, `.ipynb` per i notebook, `.gpkg`/`.parquet` per i dati.
- **Fonti dati:** OpenStreetMap, UNHCR, IOM, dati governativi italiani.

---
