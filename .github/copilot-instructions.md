# AI Coding Agent Instructions for RWD Training Repository

## Project Overview
This repository provides training materials for Real World Data (RWD) processing, focusing on converting flat files to structured databases and performing statistical analysis. The codebase demonstrates practical data engineering workflows using command-line tools, Python, MySQL, and LaTeX documentation.

## Architecture & Data Flow

### Core Components
- **Command-line Processing** (`lec01_commandline/`): Data deduplication and quality checks using Unix tools
- **Database Operations** (`lecDBMS_mysql80/`, `lecDBMS_SQL/`): MySQL 8.0 setup and SQL transformations
- **Python Analysis** (`examples/`): Statistical analysis and change point detection
- **Documentation** (`lec02_AI/`): LaTeX-based technical documentation
- **Text Processing** (`scripts/`): Perl and Python utilities for data cleaning

### Data Processing Pipeline
1. **Input**: CSV/TSV flat files with potential duplicates and encoding issues
2. **Processing**: Command-line deduplication → Database import → SQL transformations → Analysis
3. **Output**: Clean datasets, statistical reports, and LaTeX documentation

## Critical Developer Workflows

### Data Deduplication (Essential Pattern)
```bash
# Always sort before uniq - this is NOT optional in this codebase
sort file.csv | uniq > deduplicated.csv

# For awk-based deduplication (handles non-contiguous duplicates)
awk '!seen[$0]++' input.csv > output.csv
```
**Key Convention**: Never use `uniq` without `sort` first. The codebase demonstrates this with multiple examples showing why sorted deduplication is crucial.

### Database Setup
```sql
-- Always set these MySQL configurations for RWD processing
SET GLOBAL innodb_file_per_table=ON;
SET GLOBAL secure_file_priv="";  -- For bulk imports
```
````markdown
# AI coding agent notes — RWD_Training (condensed)

Short summary
- Purpose: training materials for Real World Data (RWD) workflows: flat-file cleaning → MySQL import → SQL transforms → Python analysis and LaTeX docs.

Key directories (quick lookups)
- `lec01_commandline/` — Unix tools & dedup examples (`DUP.awk`, `checkDUP.sh`)
- `lecDBMS_mysql80/`, `lecDBMS_SQL/` — MySQL init and import SQLs (`initDB_Training.sql`)
- `examples/` — Python analysis demos (`change_point_demo.py`, `requirements.txt`)
- `lec02_AI/` — LaTeX sources and `Makefile` (build with `make`)
- `scripts/` — small text-processing tools (`clean_text.pl`, `detex.pl`)

Essential rules & examples
- Deduplication: always sort before using `uniq`. Example: `sort file.csv | uniq > dedup.csv`. For non-contiguous duplicates use `awk '!seen[$0]++' input.csv > out.csv` (see `lec01_commandline/DUP.awk`).
- Encoding: expect Japanese input. Convert to UTF-8 (example in `scripts/` and `lec01_commandline/`): `iconv -f SHIFT_JIS -t UTF-8 input.csv > utf8.csv`.
- MySQL: repository assumes MySQL 8.0 with `innodb_file_per_table=ON` and `secure_file_priv` cleared for bulk imports (see `lecDBMS_mysql80/README.md`). Example SQL: `SET GLOBAL innodb_file_per_table=ON; SET GLOBAL secure_file_priv="";`.
- LaTeX: always use `lec02_AI/Makefile` (uses `latexmk`) rather than calling `pdflatex` directly.
- Python scripts: use relative paths via `HERE = os.path.dirname(__file__)` and keep data under `data/` (see `examples/change_point_demo.py`).

Developer workflows (how to run)
- Build PDF docs: `cd lec02_AI && make` (task present in workspace tasks).
- Install Python deps: create a venv and `pip install -r examples/requirements.txt` or root `requirements.txt`.
- Validate dedup: `wc -l input.csv output.csv` and `diff <(sort input.csv) <(sort output.csv)`.

Conventions & gotchas
- Prefer small, well-documented SQL files (see `lecDBMS_mysql80/*.sql`). Use UTF8MB4 for Japanese text.
- Avoid absolute paths; scripts expect relative `data/` folders.
- Do not run `uniq` without `sort` first — it's a recurring teaching point in exercises.
- When editing LaTeX, use `Makefile` targets to regenerate `.pdf` and bibliography.

Important reference files (examples to inspect)
- `lec01_commandline/DUP.awk`, `lec01_commandline/checkDUP.sh`
- `examples/change_point_demo.py`, `examples/requirements.txt`
- `lecDBMS_mysql80/initDB_Training.sql`, `lecDBMS_mysql80/README.md`
- `lec02_AI/Makefile`, `lec02_AI/aboutAI.tex`
- `scripts/clean_text.pl`, `scripts/extract_pdfs.py`

When you're uncertain
- Search for `HERE = os.path.dirname(__file__)` to find scripts that load local `data/` files.
- Inspect `lecDBMS_mysql80/README.md` before running imports — it documents necessary MySQL settings.

Scope notes for agents
- Produce small, well-scoped edits (change one script or notebook at a time). Add tests or a README entry when behaviour changes.
- Avoid touching MySQL server configuration files directly; suggest changes and point to `lecDBMS_mysql80/README.md`.

If anything here is unclear or you'd like more examples (unit tests, CI, or a short contributor guide), tell me which area to expand.
````