"""
CONSTRUCTIQ AI Engine
FastAPI-based AI services for construction intelligence
"""

from fastapi import FastAPI, HTTPException, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional, List, Dict, Any
import os
from datetime import datetime

# Import services
from services.chatbot import ChatbotService
from services.soil_analyzer import SoilAnalyzer
from services.image_processor import ImageProcessor
from services.recommendations import RecommendationEngine

app = FastAPI(
    title="CONSTRUCTIQ AI Engine",
    description="AI-powered construction intelligence services",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize services
chatbot = ChatbotService()
soil_analyzer = SoilAnalyzer()
image_processor = ImageProcessor()
recommendation_engine = RecommendationEngine()


# Request/Response Models
class ChatRequest(BaseModel):
    message: str
    user_id: str
    project_id: Optional[str] = None
    context: Optional[Dict[str, Any]] = None


class ChatResponse(BaseModel):
    response: str
    confidence: float
    suggestions: Optional[List[str]] = None


class SoilAnalysisRequest(BaseModel):
    image_url: str


class SoilAnalysisResponse(BaseModel):
    soil_type: str
    moisture_level: str
    composition: Dict[str, float]
    recommendations: List[str]
    confidence: float


class RecommendationRequest(BaseModel):
    project_type: str
    budget: Optional[float] = None
    location: Optional[Dict[str, float]] = None
    requirements: Optional[Dict[str, Any]] = None


# Health check
@app.get("/")
@app.get("/health")
async def health_check():
    return {
        "status": "ok",
        "service": "CONSTRUCTIQ AI Engine",
        "version": "1.0.0",
        "timestamp": datetime.now().isoformat()
    }


# Chatbot endpoint
@app.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest):
    """
    AI chatbot for construction guidance and assistance
    """
    try:
        response = await chatbot.process_message(
            message=request.message,
            user_id=request.user_id,
            project_id=request.project_id,
            context=request.context
        )
        return response
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# Soil analysis endpoint
@app.post("/analyze/soil", response_model=SoilAnalysisResponse)
async def analyze_soil(request: SoilAnalysisRequest):
    """
    Analyze soil from image using computer vision and ML
    """
    try:
        analysis = await soil_analyzer.analyze(request.image_url)
        return analysis
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# Image upload and analysis
@app.post("/analyze/image")
async def analyze_image(file: UploadFile = File(...)):
    """
    Upload and analyze construction site image
    """
    try:
        # Save uploaded file
        file_path = await image_processor.save_upload(file)
        
        # Analyze image
        analysis = await image_processor.analyze(file_path)
        
        return {
            "file_path": file_path,
            "analysis": analysis
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# Material recommendations
@app.post("/recommendations/materials")
async def get_material_recommendations(request: RecommendationRequest):
    """
    Get AI-powered material recommendations based on project requirements
    """
    try:
        recommendations = await recommendation_engine.get_material_recommendations(
            project_type=request.project_type,
            budget=request.budget,
            location=request.location,
            requirements=request.requirements
        )
        return recommendations
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# Cost estimation
@app.post("/estimate/cost")
async def estimate_cost(data: Dict[str, Any]):
    """
    AI-powered cost estimation
    """
    try:
        estimation = await recommendation_engine.estimate_cost(data)
        return estimation
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# Project risk analysis
@app.post("/analyze/risk")
async def analyze_risk(data: Dict[str, Any]):
    """
    Analyze project risks using AI
    """
    try:
        risk_analysis = await recommendation_engine.analyze_risks(data)
        return risk_analysis
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8001)

