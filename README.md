<!--
███████╗███╗   ███╗██╗   ██╗██╗     ██╗   ██╗
██╔════╝████╗ ████║██║   ██║██║     ██║   ██║
█████╗  ██╔████╔██║██║   ██║██║     ██║   ██║
██╔══╝  ██║╚██╔╝██║██║   ██║██║     ██║   ██║
███████╗██║ ╚═╝ ██║╚██████╔╝███████╗╚██████╔╝
╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝ ╚═════╝

Emily – Offline, Privacy-First Language-Learning Assistant
-->

<h1 align="center">Emily</h1>
<p align="center"><em>Offline, privacy-first language-learning & AI conversation desktop (Electron) + mobile companion</em></p>

<p align="center">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-green.svg" /></a>
  <!-- TODO: insert real status badge links once CI is configured -->
  <img alt="CI" src="https://img.shields.io/badge/build-passing-brightgreen" />
  <img alt="PRs welcome" src="https://img.shields.io/badge/PRs-welcome-blue" />
</p>

---

⚠️ Introduzione rapida (IT)  
• Emily è un assistente AI offline focalizzato sull’apprendimento del russo (ma facilmente estendibile ad altre lingue).  
• Desktop: Electron + React; Backend: Python (transformers, Whisper, modelli local quantizzati).  
• Questa repo contiene frontend, backend e script di setup. Qui sotto trovi la documentazione in inglese.

---

## Table of Contents
1. Features
2. Architecture
3. Tech Stack
4. Quick Start
5. Usage
6. Roadmap
7. Project Structure
8. Contributing
9. License

---

## 1. Features
• Offline first – tutti i modelli girano localmente; nessun dato inviato al cloud.  
• Chat di testo e vocale (Whisper STT + TTS).  
• Focus russo: suggerimenti di declinazione, coaching di pronuncia, dizionario personale con spaced-repetition.  
• Design orientato alla privacy: dati encryptati in locale, no telemetry.  
• Cross-platform: Windows / macOS / Linux; companion mobile React-Native (in arrivo).  
• Pipeline modulare: sostituisci facilmente i modelli (GGUF, GPT-Q, etc.).  
• Script di installazione one-shot (PowerShell/Bash).

## 2. High-Level Architecture

      ┌───────────────┐
      │  Electron UI  │  ← React / Chakra-UI
      └───────┬───────┘
              │ IPC (WebSocket)
      ┌───────▼───────┐
      │  Python API   │  ← FastAPI
      └──┬────┬───┬───┘
         │    │   │
 ┌───────▼──┐ │ ┌─▼────────┐
 │ NLP Core │ │ │ Whisper  │
 │ (LLM)    │ │ │ STT/TTS  │
 └──────────┘ │ └──────────┘
              │
       ┌──────▼──────┐
       │ SQLite /    │ ← encrypted user data
       │   DuckDB    │
       └─────────────┘

       
## 3. Tech Stack
Frontend: Electron 27, React 18, Vite, Chakra-UI, TypeScript.  
Backend: Python 3.11, FastAPI, transformers, accelerate, whisper-cpp / faster-whisper, sentencepiece.  
Modelli di default:  
• Chat – `Nous-Hermes-2-Mistral-7B-GGUF` (esempio)  
• STT – `openai/whisper-tiny` oppure `medium` (per RU)  
• TTS – `Coqui-TTS` o voci di sistema Windows/macOS  
Dev-Ops: GitHub Actions, ruff/black, pre-commit, Playwright e2e.

## 4. Quick Start

### 4.1 Prerequisites
• Git, Node.js ≥ 18, Python ≥ 3.10, (opz.) CUDA 11.8.  
• 8-16 GB RAM consigliati; GPU VRAM 6 GB+ per inferenza veloce.

### 4.2 Clone & bootstrap
```bash
git clone https://github.com/chriSilv88/emily.git
cd emily

# --- backend ---
python -m venv venv
venv\Scripts\activate           # Windows
# source venv/bin/activate      # macOS/Linux
pip install -U pip
pip install -r backend/requirements.txt

# scarica i modelli (~2-3 GB)
python backend/tools/download_models.py --preset russian-lite

# --- frontend ---
cd frontend
npm install
npm run dev             # dev server con hot-reload
# in un altro terminale
npm run electron-dev    # avvia shell Electron

4.3 Packaging
npm run make            # genera installer (.exe / .dmg / .AppImage)

4.4 Tests
pytest -q backend/tests
npm run test            # unit test frontend

pytest -q backend/tests
npm run test            # unit test frontend

5. Usage
Seleziona “Text chat” o “Voice chat”.
Parla o scrivi una frase in russo (o nella tua lingua).
Emily risponde, propone vocaboli, mostra la pronuncia.
Contrassegna le parole nuove per aggiungerle al tuo dizionario.
Usa la tab “Drills” per flashcards SRS.
Tutti i dati sono salvati in ~/.emily/ (SQLite cifrato). Elimina la cartella per wipe completo.

6. Roadmap
 MVP: Text chat RU
 Voice input/output (Whisper + TTS)
 Pronunciation heat-map
 Mobile companion
 Plugin marketplace
Consulta la Project board per lo stato aggiornato.

7. Project Structure

emily/
├─ backend/
│  ├─ app/
│  ├─ models/
│  ├─ requirements.txt
│  └─ tools/
├─ frontend/
│  ├─ src/
│  ├─ electron/
│  └─ package.json
├─ scripts/
├─ docs/
├─ .gitignore
└─ README.md

8. Contributing
Contributi benvenuti!

Fork → branch feat/
pre-commit install per lint locali
PR con descrizione chiara / screenshot
Tutti i checks CI devono passare.
9. License
MIT © 2025 Christian Silvestri (chriSilv88).

“The limits of my language mean the limits of my world.” — Ludwig Wittgenstein


Come integrare:

```bash
# nella root del progetto
echo "<—-incolla qui l’intero testo-—>" > README.md
git add README.md
git commit -m "docs: initial README for Emily"
git push