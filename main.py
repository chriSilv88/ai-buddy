from fastapi import FastAPI
from core.config import Settings
from routes import chat_routes

app = FastAPI(
    title="AI Buddy",
    description="Assistente conversazionale con LLama-cpp-python"
)

# Includi i router
app.include_router(chat_routes.router)

# Evento di startup per caricare modelli
@app.on_event("startup")
async def startup_event():
    # Caricamento risorse iniziali
    pass