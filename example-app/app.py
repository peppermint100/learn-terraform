from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return { "message": "Hello World"}

@app.get("/api/health")
async def health_check_api():
    return { "message": "Checking Health..OK!"}