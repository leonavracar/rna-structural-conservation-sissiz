## RNA Structural Conservation Analysis

This repository contains my completed assignment for the *Struktuvorhersagen in Biopolymeren* course (SS 2025, Tanja Gesell). The project explores conserved RNA structures using BLAST, alignment tools, consensus prediction, and SISSIz. It includes manual and automated analysis workflows for both original and realigned data.

### 🔧 Tools Used

- [SISSIz](https://github.com/ViennaRNA/SISSIz) – Tool for detecting conserved RNA secondary structure
- [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi) – Nucleotide/protein sequence similarity search
- [RNAalifold](http://rna.tbi.univie.ac.at/cgi-bin/RNAWebSuite/RNAalifold.cgi) – Consensus secondary structure prediction
- [Clustal Omega](https://www.ebi.ac.uk/jdispatcher/msa/clustalo) - Multiple sequence alignment


#### Task 1: BLAST

* Compared two provided "dinosaur" DNA sequences using **BLASTn** and **BLASTx**
* Interpreted results against the **nucleotide** and **protein** nr databases
* Assessed biological plausibility (and movie accuracy!)

#### Task 2: Alignment & Consensus Structure

* Created a **multiple sequence alignment** of an assigned RFAM family using **Clustalomega**
* Predicted consensus RNA secondary structure using **RNAalifold**
* Calculated **Structure Conservation Index (SCI)**
* Exported structure plots and graphical alignments

#### Task 3: SISSIz Analysis

* Installed and ran **SISSIz** on the Task 2 alignment using 4 parameter sets:
  `--mono`, `--mono -j`, `--di`, `--di -j`
* Extracted **z-scores** for structural conservation
* Analyzed and compared SCI and z-score outputs from **folders B and C** (predefined alignments)
* Identified which folder represented the **negative control group**

#### Task 4: Scripting and Batch Analysis

* Wrote two scripts:

  * One to **run SISSIz** on all alignments in folders B, C, D, and E
  * One to **parse and extract z-scores** into CSV files
* Compared z-scores across:

  * Original alignments (**B and C**)
  * MAFFT-realigned alignments (**D and E**)
* Confirmed that conserved structure signals were preserved in positives (D), but absent in negatives (E)

---

| **Path**                       | **Description**                                                                                 |
| ------------------------------ | ----------------------------------------------------------------------------------------------- |
| `workflow_results.ipynb`       | Main notebook documenting the full analysis workflow, including code, explanations, and results |
| `scripts/run_one.sh`           | Script to run SISSIz once with 4 parameter combinations across alignment files in folders B & C |
| `scripts/run_many.sh`          | Script to run SISSIz multiple times (e.g., 10, 100, 1000) and calculate average z-scores        |
| `scripts/csv_output.sh`        | Extracts final z-scores from raw SISSIz output into `.csv` format for downstream analysis       |
| `scripts/sissiz_runner.sh`     | Simplify calling SISSIz with desired options on a batch of files                                |
| `raw_data/A/`                  | Manually created alignment for my assigned RFAM family (Task 2)                                 |
| `raw_data/B/`                  | Provided alignments (positive examples) used for SCI and SISSIz analysis in Task 3              |
| `raw_data/C/`                  | Provided alignments (negative controls) used in Task 3                                          |
| `raw_data/B_all/`              | 88 alignments used in batch analysis of B (positives) for Task 4                                |
| `raw_data/C_all/`              | 88 alignments used in batch analysis of C (negatives) for Task 4                                |
| `raw_data/D_all/`              | MAFFT realignments of B\_all alignments (positive, realigned)                                   |
| `raw_data/E_all/`              | MAFFT realignments of C\_all alignments (negative, realigned)                                   |
| `csv_output/B_all_zscores.csv` | Extracted z-scores from SISSIz runs on B\_all (per parameter)                                   |
| `csv_output/C_all_zscores.csv` | Same as above, for C\_all                                                                       |
| `csv_output/D_all_zscores.csv` | Same as above, for D\_all                                                                       |
| `csv_output/E_all_zscores.csv` | Same as above, for E\_all                                                                       |

