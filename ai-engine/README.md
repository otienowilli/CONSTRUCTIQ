# CONSTRUCTIQ AI Engine

Python FastAPI-based AI services for construction intelligence.

## Features

- **AI Chatbot**: Construction guidance and assistance using GPT-4
- **Soil Analysis**: Computer vision-based soil type detection
- **Image Processing**: Construction site image analysis
- **Material Recommendations**: AI-powered material suggestions
- **Cost Estimation**: Intelligent project cost prediction
- **Risk Analysis**: Project risk assessment and mitigation

## Installation

### Prerequisites

- Python 3.11+
- OpenAI API key (for chatbot)

### Setup

1. Create virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Configure environment:
```bash
cp .env.example .env
# Edit .env and add your OPENAI_API_KEY
```

4. Run the server:
```bash
uvicorn main:app --reload --port 8001
```

The AI Engine will be available at `http://localhost:8001`

## API Endpoints

### Health Check
- `GET /health` - Service health status

### Chatbot
- `POST /chat` - Send message to AI chatbot
  ```json
  {
    "message": "How much concrete do I need for a 10x10x0.15m slab?",
    "user_id": "user-123",
    "project_id": "project-456"
  }
  ```

### Soil Analysis
- `POST /analyze/soil` - Analyze soil from image URL
  ```json
  {
    "image_url": "https://example.com/soil-image.jpg"
  }
  ```

### Image Analysis
- `POST /analyze/image` - Upload and analyze construction site image
  - Multipart form data with image file

### Material Recommendations
- `POST /recommendations/materials` - Get material recommendations
  ```json
  {
    "project_type": "building",
    "budget": 1000000,
    "requirements": {}
  }
  ```

### Cost Estimation
- `POST /estimate/cost` - Estimate project cost
  ```json
  {
    "project_type": "building",
    "size": 100,
    "quality": "standard"
  }
  ```

### Risk Analysis
- `POST /analyze/risk` - Analyze project risks
  ```json
  {
    "project_type": "building",
    "budget": 1000000,
    "timeline_months": 6
  }
  ```

## API Documentation

Interactive API documentation available at:
- Swagger UI: `http://localhost:8001/docs`
- ReDoc: `http://localhost:8001/redoc`

## Docker

Build and run with Docker:
```bash
docker build -t constructiq-ai .
docker run -p 8001:8001 -e OPENAI_API_KEY=your-key constructiq-ai
```

## Services

### ChatbotService
Provides intelligent construction guidance using OpenAI GPT-4.

### SoilAnalyzer
Analyzes soil images to determine type, composition, and recommendations.

### ImageProcessor
Processes construction site images for quality and content analysis.

### RecommendationEngine
Generates material recommendations, cost estimates, and risk assessments.

## Development

Run tests:
```bash
pytest
```

Format code:
```bash
black .
```

## License

MIT

