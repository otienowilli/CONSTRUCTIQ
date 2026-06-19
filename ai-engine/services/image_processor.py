"""
Image Processing Service for Construction Site Analysis
"""

import os
import uuid
from typing import Dict, Any
from fastapi import UploadFile
from PIL import Image
import numpy as np


class ImageProcessor:
    def __init__(self):
        self.upload_dir = os.getenv("UPLOAD_DIR", "/app/uploads")
        os.makedirs(self.upload_dir, exist_ok=True)
    
    async def save_upload(self, file: UploadFile) -> str:
        """
        Save uploaded file and return path
        """
        # Generate unique filename
        file_ext = file.filename.split('.')[-1] if '.' in file.filename else 'jpg'
        filename = f"{uuid.uuid4()}.{file_ext}"
        file_path = os.path.join(self.upload_dir, filename)
        
        # Save file
        contents = await file.read()
        with open(file_path, 'wb') as f:
            f.write(contents)
        
        return file_path
    
    async def analyze(self, file_path: str) -> Dict[str, Any]:
        """
        Analyze construction site image
        """
        try:
            # Open image
            image = Image.open(file_path)
            
            # Get image properties
            width, height = image.size
            mode = image.mode
            
            # Convert to RGB if needed
            if mode != 'RGB':
                image = image.convert('RGB')
            
            # Analyze image content
            analysis = {
                "dimensions": {"width": width, "height": height},
                "format": image.format,
                "mode": mode,
                "detected_objects": self._detect_objects(image),
                "quality_score": self._assess_quality(image),
                "recommendations": []
            }
            
            # Add recommendations based on analysis
            if analysis["quality_score"] < 0.5:
                analysis["recommendations"].append("Image quality is low. Consider retaking with better lighting.")
            
            return analysis
            
        except Exception as e:
            return {
                "error": str(e),
                "recommendations": ["Failed to process image. Please try again with a different image."]
            }
    
    def _detect_objects(self, image: Image.Image) -> list:
        """
        Simple object detection (placeholder for actual ML model)
        """
        # This would use a trained model in production
        # For now, return placeholder data
        return [
            {"type": "construction_site", "confidence": 0.75},
            {"type": "equipment", "confidence": 0.60}
        ]
    
    def _assess_quality(self, image: Image.Image) -> float:
        """
        Assess image quality
        """
        # Convert to grayscale
        gray = image.convert('L')
        img_array = np.array(gray)
        
        # Calculate sharpness (using Laplacian variance)
        laplacian_var = img_array.std()
        
        # Normalize to 0-1 range
        quality_score = min(laplacian_var / 100, 1.0)
        
        return round(quality_score, 2)

