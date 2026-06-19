"""
Tests for Soil Analyzer Service
"""

import pytest
from services.soil_analyzer import SoilAnalyzer


@pytest.fixture
def analyzer():
    return SoilAnalyzer()


def test_soil_types_defined(analyzer):
    """Test that soil types are properly defined"""
    assert "clay" in analyzer.soil_types
    assert "sand" in analyzer.soil_types
    assert "loam" in analyzer.soil_types
    assert "gravel" in analyzer.soil_types
    assert "silt" in analyzer.soil_types


def test_estimate_composition(analyzer):
    """Test soil composition estimation"""
    composition = analyzer._estimate_composition("clay")
    
    assert isinstance(composition, dict)
    assert "clay" in composition
    assert "sand" in composition
    assert "silt" in composition
    
    # Total should be approximately 1.0
    total = sum(composition.values())
    assert 0.99 <= total <= 1.01


def test_generate_recommendations(analyzer):
    """Test recommendation generation"""
    recommendations = analyzer._generate_recommendations("clay")
    
    assert isinstance(recommendations, list)
    assert len(recommendations) > 0
    assert all(isinstance(r, str) for r in recommendations)


def test_all_soil_types_have_recommendations(analyzer):
    """Test that all soil types have recommendations"""
    for soil_type in analyzer.soil_types.keys():
        recommendations = analyzer._generate_recommendations(soil_type)
        assert len(recommendations) > 0


def test_soil_properties(analyzer):
    """Test that soil properties are defined"""
    for soil_type, properties in analyzer.soil_types.items():
        assert "color_range" in properties
        assert "characteristics" in properties
        assert "bearing_capacity" in properties
        assert len(properties["color_range"]) == 2

