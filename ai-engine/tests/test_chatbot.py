"""
Tests for Chatbot Service
"""

import pytest
from services.chatbot import ChatbotService


@pytest.fixture
def chatbot():
    return ChatbotService()


@pytest.mark.asyncio
async def test_process_message(chatbot):
    """Test basic message processing"""
    response = await chatbot.process_message(
        message="What is concrete?",
        user_id="test-user-123"
    )
    
    assert "response" in response
    assert "confidence" in response
    assert "suggestions" in response
    assert isinstance(response["response"], str)
    assert len(response["response"]) > 0


@pytest.mark.asyncio
async def test_concrete_fallback(chatbot):
    """Test fallback response for concrete questions"""
    response = await chatbot.process_message(
        message="How to calculate concrete?",
        user_id="test-user-123"
    )
    
    assert "concrete" in response["response"].lower()


@pytest.mark.asyncio
async def test_suggestions_generation(chatbot):
    """Test that suggestions are generated"""
    response = await chatbot.process_message(
        message="I need help with concrete calculations",
        user_id="test-user-123"
    )
    
    assert isinstance(response["suggestions"], list)
    # Should have suggestions related to concrete
    assert any("concrete" in s.lower() for s in response["suggestions"])


def test_fallback_responses(chatbot):
    """Test fallback responses for different keywords"""
    test_cases = [
        ("concrete", "concrete"),
        ("brick", "brick"),
        ("cost", "cost"),
        ("soil", "soil"),
    ]
    
    for message, expected_keyword in test_cases:
        response = chatbot._get_fallback_response(message)
        assert expected_keyword in response.lower()


def test_generate_suggestions(chatbot):
    """Test suggestion generation"""
    suggestions = chatbot._generate_suggestions(
        "How much concrete do I need?",
        "You need to calculate the volume first..."
    )
    
    assert isinstance(suggestions, list)
    assert len(suggestions) <= 3  # Max 3 suggestions

