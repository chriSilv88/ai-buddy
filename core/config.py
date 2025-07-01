from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    # Configurazioni del progetto
    MODEL_PATH: str = "path/to/your/model.gguf"
    MAX_TOKENS: int = 512
    TEMPERATURE: float = 0.7

settings = Settings()