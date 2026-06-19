"""
AI-Powered Recommendation Engine
"""

from typing import Dict, Any, List, Optional
import random


class RecommendationEngine:
    def __init__(self):
        self.material_database = {
            "building": {
                "foundation": ["cement", "sand", "ballast", "steel_bars", "water", "admixtures"],
                "walls": ["bricks", "blocks", "cement", "sand", "prefab_panels"],
                "roofing": ["iron_sheets", "timber", "nails", "prefab_trusses"],
                "finishing": ["paint", "tiles", "plaster", "geotextiles"]
            },
            "road": {
                "base": ["murram", "crushed_stone", "gravel", "recycled_aggregate", "geotextiles"],
                "surface": ["asphalt", "bitumen", "aggregates", "recycled_asphalt"],
                "drainage": ["pipes", "culverts", "geotextiles"],
                "stabilization": ["admixtures", "geogrid", "geocell"]
            },
            "bridge": {
                "foundation": ["concrete", "steel", "reinforcement", "admixtures"],
                "structure": ["steel_beams", "concrete", "cables", "prefab_beams"],
                "deck": ["concrete_slabs", "asphalt", "waterproofing"],
                "protection": ["geotextiles", "corrosion_inhibitors"]
            },
            "infrastructure": {
                "earthwork": ["geotextiles", "geogrids", "recycled_materials"],
                "pavement": ["bitumen", "asphalt", "recycled_asphalt", "admixtures"],
                "drainage": ["geotextiles", "pipes", "recycled_materials"],
                "stabilization": ["admixtures", "geosynthetics", "recycled_aggregate"]
            }
        }
    
    async def get_material_recommendations(
        self,
        project_type: str,
        budget: Optional[float] = None,
        location: Optional[Dict[str, float]] = None,
        requirements: Optional[Dict[str, Any]] = None
    ) -> Dict[str, Any]:
        """
        Get AI-powered material recommendations
        """
        # Get base materials for project type
        base_materials = self.material_database.get(project_type, {})
        
        recommendations = []
        
        for category, materials in base_materials.items():
            for material in materials:
                rec = {
                    "material": material,
                    "category": category,
                    "priority": random.choice(["high", "medium", "low"]),
                    "reason": f"Essential for {category} in {project_type} projects"
                }
                
                # Adjust based on budget
                if budget:
                    if budget < 100000:
                        rec["alternative"] = f"Budget-friendly {material}"
                    elif budget > 1000000:
                        rec["alternative"] = f"Premium {material}"
                
                recommendations.append(rec)
        
        return {
            "project_type": project_type,
            "recommendations": recommendations,
            "total_items": len(recommendations),
            "budget_category": self._categorize_budget(budget) if budget else "not_specified"
        }
    
    async def estimate_cost(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """
        AI-powered cost estimation
        """
        project_type = data.get("project_type", "building")
        size = data.get("size", 100)  # square meters
        quality = data.get("quality", "standard")  # budget, standard, premium
        
        # Base cost per square meter
        base_costs = {
            "building": {"budget": 15000, "standard": 25000, "premium": 45000},
            "road": {"budget": 8000, "standard": 12000, "premium": 20000},
            "bridge": {"budget": 50000, "standard": 80000, "premium": 150000}
        }
        
        cost_per_unit = base_costs.get(project_type, {}).get(quality, 25000)
        total_cost = size * cost_per_unit
        
        # Add contingency (10-20%)
        contingency = total_cost * 0.15
        
        # Breakdown
        breakdown = {
            "materials": total_cost * 0.60,
            "labor": total_cost * 0.30,
            "equipment": total_cost * 0.10,
            "contingency": contingency
        }
        
        return {
            "estimated_cost": total_cost,
            "total_with_contingency": total_cost + contingency,
            "breakdown": breakdown,
            "currency": "KES",
            "confidence": 0.75,
            "notes": [
                "Estimate based on current market rates",
                "Actual costs may vary based on location and availability",
                "Includes 15% contingency for unforeseen expenses"
            ]
        }
    
    async def analyze_risks(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Analyze project risks using AI
        """
        project_type = data.get("project_type", "building")
        location = data.get("location", {})
        timeline = data.get("timeline_months", 6)
        budget = data.get("budget", 0)
        
        risks = []
        
        # Budget risk
        if budget < 500000:
            risks.append({
                "type": "financial",
                "level": "high",
                "description": "Budget may be insufficient for project scope",
                "mitigation": "Review project scope or increase budget allocation"
            })
        
        # Timeline risk
        if timeline < 3:
            risks.append({
                "type": "schedule",
                "level": "medium",
                "description": "Tight timeline may lead to quality compromises",
                "mitigation": "Ensure adequate resources and parallel work streams"
            })
        
        # Weather risk (placeholder)
        risks.append({
            "type": "environmental",
            "level": "medium",
            "description": "Weather conditions may affect construction schedule",
            "mitigation": "Plan for weather delays and have contingency schedule"
        })
        
        # Soil/Foundation risk
        if project_type in ["building", "bridge"]:
            risks.append({
                "type": "technical",
                "level": "medium",
                "description": "Soil conditions may require special foundation design",
                "mitigation": "Conduct thorough soil testing before foundation work"
            })
        
        # Calculate overall risk score
        risk_levels = {"low": 1, "medium": 2, "high": 3}
        avg_risk = sum(risk_levels[r["level"]] for r in risks) / len(risks) if risks else 0
        
        overall_risk = "low" if avg_risk < 1.5 else "medium" if avg_risk < 2.5 else "high"
        
        return {
            "overall_risk": overall_risk,
            "risk_score": round(avg_risk, 2),
            "identified_risks": risks,
            "total_risks": len(risks),
            "recommendations": [
                "Conduct regular risk assessments throughout project",
                "Maintain contingency reserves for identified risks",
                "Implement risk mitigation strategies proactively"
            ]
        }
    
    def _categorize_budget(self, budget: float) -> str:
        """
        Categorize budget level
        """
        if budget < 500000:
            return "small"
        elif budget < 2000000:
            return "medium"
        elif budget < 10000000:
            return "large"
        else:
            return "mega"

