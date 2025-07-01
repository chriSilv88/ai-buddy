<!--
███████╗███╗   ███╗██╗   ██╗██╗     ██╗   ██╗
██╔════╝████╗ ████║██║   ██║██║     ██║   ██║
█████╗  ██╔████╔██║██║   ██║██║     ██║   ██║
██╔══╝  ██║╚██╔╝██║██║   ██║██║     ██║   ██║
███████╗██║ ╚═╝ ██║╚██████╔╝███████╗╚██████╔╝
╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝ ╚═════╝

Emily – Offline, Privacy-First Language-Learning Assistant
-->
<p align="center">
  <img src="docs/Emily.webp" alt="Emily cyber-ninja key art" width="400">
</p>
<h1 align="center">Emily</h1>
<p align="center"><em>Offline, privacy-first assistant for learning language, powered by local LLMs.</em></p>

<p align="center">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-green.svg"></a>
  <img alt="CI" src="https://img.shields.io/badge/build-passing-brightgreen">
  <img alt="PRs welcome" src="https://img.shields.io/badge/PRs-welcome-blue">
</p>

---

⚠️ Introduzione rapida (IT)  
Emily gira interamente in locale: motore Python (`core/`) + interfaccia desktop Electron/React (`desktop/`). Nessun dato esce dal tuo PC.

---

## Indice
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
• Offline first – tutti i modelli girano localmente, zero cloud.  
• Chat di testo e vocale (Whisper STT + TTS).  
• Focus russo: suggerimenti grammaticali, dizionario personale SRS, coaching di pronuncia.  
• Dati cifrati in locale, nessuna telemetry.  
• Cross-platform: Windows, macOS, Linux.  
• Pipeline modulare: basta sostituire i file GGUF / GPT-Q per cambiare modello.  

## 2. Architecture (high-level)

┌───────────────┐
│ Desktop UI │ ← Electron + React
└───────┬───────┘
│ IPC (WebSocket)
┌───────▼───────┐
│ core API │ ← FastAPI
└──┬────┬──┬────┘
│ │ │
│ │ └─ Whisper (STT / TTS)
│ └──── LLM (GGUF)
└────────── Encrypted SQLite


## 3. Tech Stack
Desktop UI  : Electron 27, React 18, Vite, TypeScript, Chakra-UI  
Core/API  : Python 3.11, FastAPI, transformers, faster-whisper  
Modelli di default  
  • Chat `Nous-Hermes-2-Mistral-7B-GGUF`  
  • STT  `openai/whisper-tiny` (RU)  
  • TTS  `coqui-tts` o voci di sistema  
Dev-Ops  : GitHub Actions (workflow in `ci/`), pre-commit (ruff/black)

## 4. Quick Start

### 4.1 Prerequisiti
• Git, Node ≥ 18, Python ≥ 3.10, (opz.) CUDA 11.8  
• 8–16 GB RAM consigliati; GPU 6 GB+ se disponibile.

### 4.2 Clona e avvia
```bash
git clone https://github.com/chriSilv88/emily.git
cd emily

# --- core (Python) ---
python -m venv venv
venv\Scripts\activate            # Windows
# source venv/bin/activate       # macOS / Linux
pip install -U pip
pip install -r core/requirements.txt

# scarica i modelli (~2-3 GB)
python core/scripts/download_models.py --preset russian-lite

# avvia API
python -m core.app               # http://127.0.0.1:8000

# --- desktop (Electron) ---
cd desktop/electron
npm install
npm run dev           # Vite hot-reload
# in una nuova shell
npm run electron-dev  # lancia l’app desktop

cd desktop
npm run make          # produce .exe / .dmg / .AppImage in desktop/dist

pytest -q core/tests
npm test --prefix desktop/electron

5. Usage
Scegli “Text chat” o “Voice chat”.
Scrivi o pronuncia una frase in russo (o nella tua lingua).
Emily risponde, propone vocaboli, pronuncia e traslitterazione.
Salva le parole nuove nel tuo dizionario → “Drills” (flashcard SRS).
Tutti i dati utente sono salvati (cifrati) in ~/.emily/. Per cancellarli basta eliminare la cartella.

6. Roadmap
 MVP: chat di testo
 Input/output vocale
 Pronunciation heat-map
 Companion mobile
 Plugin marketplace

7. Project Structure

emily/
├─ ci/                    # GitHub Actions workflows
├─ core/                  # motore Python
│  ├─ buddy/              # asr, llm, tts, storage
│  ├─ data/
│  ├─ models/
│  └─ tests/
├─ desktop/               # interfaccia Electron
│  ├─ builder/
│  ├─ dist/
│  └─ electron/
│      ├─ public/
│      └─ src/
│          ├─ components/
│          └─ ipc/
├─ docs/                  # ADR, diagrammi, guide
├─ scripts/               # helper cross-platform
└─ README.md


8. Contributing
Fork → branch feat/<descrizione>
pre-commit install per lint e formatter locali
Apri una PR descrivendo motivazione e (se possibile) screenshot/GIF
Tutti i check CI devono passare.
9. License
MIT © 2025 Christian Silvestri (chriSilv88) — vedi file LICENSE.

“The limits of my language mean the limits of my world.”
— Ludwig Wittgenstein

