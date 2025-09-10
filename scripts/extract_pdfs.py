#!/usr/bin/env python3
"""
Simple PDF-to-text extractor for PDFs in the `PDF/` folder.
Writes one .txt file per PDF into `scripts/output_texts/`.
"""
from pathlib import Path
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[1]
PDF_DIR = ROOT / "PDF"
OUT_DIR = Path(__file__).resolve().parent / "output_texts"
OUT_DIR.mkdir(exist_ok=True)

def extract_text_from_pdf(pdf_path: Path) -> str:
    try:
        reader = PdfReader(str(pdf_path))
        texts = []
        for page in reader.pages:
            txt = page.extract_text()
            if txt:
                texts.append(txt)
        return "\n\n".join(texts)
    except Exception as e:
        return f"[ERROR] Failed to extract {pdf_path.name}: {e}\n"

if __name__ == '__main__':
    if not PDF_DIR.exists():
        print(f"PDF directory not found: {PDF_DIR}")
        raise SystemExit(1)

    pdfs = sorted(PDF_DIR.glob("*.pdf"))
    if not pdfs:
        print("No PDF files found in PDF/ folder.")
        raise SystemExit(1)

    for pdf in pdfs:
        print(f"Extracting: {pdf.name}")
        text = extract_text_from_pdf(pdf)
        out_file = OUT_DIR / (pdf.stem + ".txt")
        out_file.write_text(text, encoding='utf-8')
        print(f"Wrote: {out_file}")

    print("Done.")
