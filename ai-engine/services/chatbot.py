"""
AI Chatbot Service for Construction Guidance
"""

import os
from typing import Optional, Dict, Any, List
from openai import AsyncOpenAI


class ChatbotService:
    def __init__(self):
        self.client = AsyncOpenAI(api_key=os.getenv("OPENAI_API_KEY", ""))
        self.model = os.getenv("OPENAI_MODEL", "gpt-4-turbo-preview")
        
        self.system_prompt = """You are an expert construction engineer AI assistant for CONSTRUCTIQ platform.
        
Your role is to help construction professionals with:
- Material calculations and recommendations
- Construction procedures and best practices
- Site analysis and soil assessment
- Safety guidelines and regulations
- Cost estimation and budgeting
- Equipment selection and usage
- Problem-solving and troubleshooting

Provide accurate, practical, and safety-focused advice. Always consider:
- Local building codes and standards
- Cost-effectiveness
- Safety requirements
- Environmental factors
- Project timelines

Be concise but thorough. Use technical terms when appropriate but explain them clearly.
"""

    async def process_message(
        self,
        message: str,
        user_id: str,
        project_id: Optional[str] = None,
        context: Optional[Dict[str, Any]] = None
    ) -> Dict[str, Any]:
        """
        Process user message and generate AI response
        """
        try:
            # Build conversation context
            messages = [
                {"role": "system", "content": self.system_prompt},
            ]
            
            # Add context if available
            if context:
                context_str = f"Project Context: {context}"
                messages.append({"role": "system", "content": context_str})
            
            # Add user message
            messages.append({"role": "user", "content": message})
            
            # Call OpenAI API
            response = await self.client.chat.completions.create(
                model=self.model,
                messages=messages,
                max_tokens=int(os.getenv("MAX_TOKENS", 1000)),
                temperature=float(os.getenv("TEMPERATURE", 0.7)),
            )
            
            ai_response = response.choices[0].message.content
            
            # Generate suggestions based on the conversation
            suggestions = self._generate_suggestions(message, ai_response)
            
            return {
                "response": ai_response,
                "confidence": 0.85,  # Could be calculated based on model response
                "suggestions": suggestions
            }
            
        except Exception as e:
            # Fallback response if API fails
            return {
                "response": self._get_fallback_response(message),
                "confidence": 0.5,
                "suggestions": []
            }
    
    def _generate_suggestions(self, user_message: str, ai_response: str) -> List[str]:
        """
        Generate follow-up suggestions based on the conversation
        """
        suggestions = []
        
        # Simple keyword-based suggestions
        keywords = {
            "concrete": ["Calculate concrete volume", "Concrete mix ratios", "Curing time"],
            "brick": ["Calculate brickwork", "Mortar requirements", "Wall thickness"],
            "cost": ["Estimate project cost", "Material prices", "Labor costs"],
            "soil": ["Analyze soil type", "Foundation recommendations", "Soil testing"],
            "safety": ["Safety guidelines", "PPE requirements", "Site safety checklist"],
        }
        
        message_lower = user_message.lower()
        for keyword, related_suggestions in keywords.items():
            if keyword in message_lower:
                suggestions.extend(related_suggestions[:2])
        
        return suggestions[:3]  # Return max 3 suggestions
    
    def _get_fallback_response(self, message: str) -> str:
        """
        Provide fallback response when AI service is unavailable
        """
        message_lower = message.lower()
        
        if "concrete" in message_lower:
            return "For concrete calculations, use our calculator with your dimensions. Standard mix ratio for C20 concrete is 1:2:3 (cement:sand:ballast)."
        elif "brick" in message_lower:
            return "For brickwork, you'll need approximately 120 bricks per square meter for a 9-inch wall. Use 1:4 cement:sand mortar ratio."
        elif "cost" in message_lower:
            return "Cost estimation depends on materials, labor, and location. Use our material calculator to get accurate quantities and costs."
        elif "soil" in message_lower:
            return "Soil analysis is crucial for foundation design. Upload a site photo for AI-powered soil analysis."
        else:
            return "I'm here to help with construction questions. Ask me about materials, calculations, procedures, or safety guidelines."

