"""
Soil Analysis Service using Computer Vision and ML
"""

import os
import httpx
from typing import Dict, Any, List
from PIL import Image
import numpy as np
import io


class SoilAnalyzer:
    def __init__(self):
        self.soil_types = {
            "clay": {
                "color_range": [(100, 50, 30), (180, 120, 80)],
                "characteristics": "High plasticity, poor drainage",
                "bearing_capacity": "Medium (100-200 kN/m²)"
            },
            "sand": {
                "color_range": [(200, 180, 140), (255, 240, 200)],
                "characteristics": "Good drainage, low cohesion",
                "bearing_capacity": "Low to Medium (50-150 kN/m²)"
            },
            "loam": {
                "color_range": [(120, 80, 50), (160, 120, 90)],
                "characteristics": "Balanced properties, good for construction",
                "bearing_capacity": "Good (150-300 kN/m²)"
            },
            "gravel": {
                "color_range": [(150, 140, 130), (200, 190, 180)],
                "characteristics": "Excellent drainage, high stability",
                "bearing_capacity": "High (300-500 kN/m²)"
            },
            "silt": {
                "color_range": [(140, 120, 100), (180, 160, 140)],
                "characteristics": "Moderate drainage, compressible",
                "bearing_capacity": "Low (50-100 kN/m²)"
            }
        }
    
    async def analyze(self, image_url: str) -> Dict[str, Any]:
        """
        Analyze soil from image URL
        """
        try:
            # Download image
            async with httpx.AsyncClient() as client:
                response = await client.get(image_url, timeout=30.0)
                image_data = response.content
            
            # Open image
            image = Image.open(io.BytesIO(image_data))
            
            # Analyze image
            soil_type, confidence = self._analyze_image(image)
            
            # Get soil properties
            properties = self.soil_types.get(soil_type, {})
            
            # Generate recommendations
            recommendations = self._generate_recommendations(soil_type)
            
            # Estimate composition
            composition = self._estimate_composition(soil_type)
            
            return {
                "soil_type": soil_type,
                "moisture_level": self._estimate_moisture(image),
                "composition": composition,
                "recommendations": recommendations,
                "confidence": confidence,
                "properties": properties
            }
            
        except Exception as e:
            # Return default analysis if processing fails
            return {
                "soil_type": "unknown",
                "moisture_level": "medium",
                "composition": {"clay": 0.33, "sand": 0.33, "silt": 0.34},
                "recommendations": [
                    "Conduct professional soil testing",
                    "Consult with a geotechnical engineer",
                    "Perform bearing capacity tests"
                ],
                "confidence": 0.3,
                "error": str(e)
            }
    
    def _analyze_image(self, image: Image.Image) -> tuple:
        """
        Analyze image to determine soil type
        """
        # Convert to RGB if needed
        if image.mode != 'RGB':
            image = image.convert('RGB')
        
        # Resize for processing
        image = image.resize((300, 300))
        
        # Convert to numpy array
        img_array = np.array(image)
        
        # Calculate average color
        avg_color = img_array.mean(axis=(0, 1))
        
        # Find closest soil type based on color
        best_match = "loam"
        best_score = 0
        
        for soil_type, properties in self.soil_types.items():
            color_range = properties["color_range"]
            lower = np.array(color_range[0])
            upper = np.array(color_range[1])
            
            # Calculate similarity score
            if np.all(avg_color >= lower) and np.all(avg_color <= upper):
                score = 1.0 - np.linalg.norm(avg_color - (lower + upper) / 2) / 255
                if score > best_score:
                    best_score = score
                    best_match = soil_type
        
        confidence = min(0.5 + best_score * 0.4, 0.9)  # 0.5 to 0.9 range
        
        return best_match, confidence
    
    def _estimate_moisture(self, image: Image.Image) -> str:
        """
        Estimate moisture level from image
        """
        # Simple estimation based on image brightness
        img_array = np.array(image.convert('L'))
        avg_brightness = img_array.mean()
        
        if avg_brightness < 80:
            return "high"
        elif avg_brightness < 140:
            return "medium"
        else:
            return "low"
    
    def _estimate_composition(self, soil_type: str) -> Dict[str, float]:
        """
        Estimate soil composition percentages
        """
        compositions = {
            "clay": {"clay": 0.60, "sand": 0.20, "silt": 0.20},
            "sand": {"clay": 0.10, "sand": 0.75, "silt": 0.15},
            "loam": {"clay": 0.30, "sand": 0.40, "silt": 0.30},
            "gravel": {"clay": 0.05, "sand": 0.70, "silt": 0.25},
            "silt": {"clay": 0.20, "sand": 0.20, "silt": 0.60},
        }
        return compositions.get(soil_type, {"clay": 0.33, "sand": 0.33, "silt": 0.34})
    
    def _generate_recommendations(self, soil_type: str) -> List[str]:
        """
        Generate construction recommendations based on soil type
        """
        recommendations_map = {
            "clay": [
                "Use deep foundations due to expansive nature",
                "Ensure proper drainage to prevent swelling",
                "Consider pile foundations for heavy structures",
                "Allow for soil stabilization before construction"
            ],
            "sand": [
                "Use shallow foundations with wider footings",
                "Compact soil thoroughly before construction",
                "Consider ground improvement techniques",
                "Ensure adequate foundation depth below frost line"
            ],
            "loam": [
                "Suitable for most foundation types",
                "Standard foundation design applicable",
                "Ensure proper compaction",
                "Good bearing capacity for typical structures"
            ],
            "gravel": [
                "Excellent for foundation support",
                "Minimal settlement expected",
                "Good drainage characteristics",
                "Suitable for heavy loads"
            ],
            "silt": [
                "Avoid construction during wet conditions",
                "Use soil stabilization techniques",
                "Consider deep foundations",
                "Implement proper drainage systems"
            ]
        }
        return recommendations_map.get(soil_type, [
            "Conduct professional soil testing",
            "Consult with geotechnical engineer"
        ])

