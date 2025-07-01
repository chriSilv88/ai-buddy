from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from models.llama_model import LlamaModel

router = APIRouter(prefix="/chat", tags=["Chat"])

class ChatRequest(BaseModel):
    prompt: str
    max_tokens: int = 512

@router.post("/generate")
async def generate_response(request: ChatRequest):
    try:
        llama = LlamaModel()
        response = llama.generate_response(
            request.prompt, 
            request.max_tokens
        )
        return {"response": response}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))