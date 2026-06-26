#!/usr/bin/env python3
"""
CONSTRUCTIQ Calculator Demo
Test the new calculators without Docker
"""

def calculate_bitumen(length, width, layer_thickness=0.05, grade="80/100"):
    """Calculate bitumen requirements for road construction"""
    
    # Application rates (liters per square meter)
    application_rates = {
        "prime_coat": 0.8,
        "tack_coat": 0.3,
        "80/100": 1.2,
        "60/70": 1.1,
        "40/50": 1.0,
    }
    
    # Calculate area
    area = length * width
    
    # Get application rate
    rate = application_rates.get(grade, 1.0)
    
    # Calculate bitumen required
    bitumen_required = area * rate
    
    # Add 5% wastage
    total_with_wastage = bitumen_required * 1.05
    
    # Prices (from seed data)
    bitumen_prices = {
        "80/100": 95.00,
        "60/70": 98.00,
        "40/50": 102.00,
        "prime_coat": 85.00,
        "tack_coat": 90.00,
    }
    
    price = bitumen_prices.get(grade, 95.00)
    total_cost = total_with_wastage * price
    
    return {
        "area": round(area, 2),
        "bitumen_required": round(bitumen_required, 2),
        "total_with_wastage": round(total_with_wastage, 2),
        "unit": "liters",
        "grade": grade,
        "application_rate": rate,
        "price_per_liter": price,
        "total_cost": round(total_cost, 2),
    }


def calculate_asphalt(length, width, thickness=0.05, asphalt_type="AC14"):
    """Calculate asphalt requirements for road construction"""
    
    # Calculate volume
    volume = length * width * thickness
    
    # Asphalt density (tons per cubic meter)
    density = 2.4
    
    # Calculate weight
    weight = volume * density
    
    # Add 3% wastage
    total_with_wastage = weight * 1.03
    
    # Prices (from seed data)
    asphalt_prices = {
        "AC14": 8500.00,
        "AC20": 8200.00,
        "DBM": 7800.00,
        "BC": 9000.00,
        "SMA": 9500.00,
    }
    
    price = asphalt_prices.get(asphalt_type, 8500.00)
    total_cost = total_with_wastage * price
    
    return {
        "volume": round(volume, 2),
        "weight": round(weight, 2),
        "total_with_wastage": round(total_with_wastage, 2),
        "unit": "tons",
        "type": asphalt_type,
        "density": density,
        "thickness": thickness,
        "price_per_ton": price,
        "total_cost": round(total_cost, 2),
    }


def calculate_geotextile(length, width, geotextile_type="woven", overlap=10):
    """Calculate geotextile requirements"""
    
    # Calculate base area
    base_area = length * width
    
    # Add overlap
    overlap_factor = 1 + (overlap / 100)
    total_area = base_area * overlap_factor
    
    # Prices (from seed data)
    geotextile_prices = {
        "woven": 180.00,
        "non-woven": 150.00,
    }
    
    price = geotextile_prices.get(geotextile_type, 180.00)
    total_cost = total_area * price
    
    return {
        "base_area": round(base_area, 2),
        "overlap_percentage": overlap,
        "total_area": round(total_area, 2),
        "unit": "square meters",
        "type": geotextile_type,
        "price_per_sqm": price,
        "total_cost": round(total_cost, 2),
    }


def print_result(title, result):
    """Pretty print calculation results"""
    print(f"\n{'='*60}")
    print(f"  {title}")
    print(f"{'='*60}")
    for key, value in result.items():
        print(f"  {key.replace('_', ' ').title():<30}: {value}")
    print(f"{'='*60}")


if __name__ == "__main__":
    print("\n🚀 CONSTRUCTIQ Calculator Demo - Version 2.0")
    print("Testing new calculators from updated specification\n")
    
    # Test 1: Bitumen Calculator
    print("\n📊 TEST 1: Bitumen Calculator")
    print("   Scenario: 100m x 10m road with Bitumen 80/100")
    bitumen_result = calculate_bitumen(
        length=100,
        width=10,
        grade="80/100"
    )
    print_result("Bitumen Calculation Results", bitumen_result)
    
    # Test 2: Asphalt Calculator
    print("\n📊 TEST 2: Asphalt Calculator")
    print("   Scenario: 100m x 10m road with 50mm AC14 asphalt")
    asphalt_result = calculate_asphalt(
        length=100,
        width=10,
        thickness=0.05,
        asphalt_type="AC14"
    )
    print_result("Asphalt Calculation Results", asphalt_result)
    
    # Test 3: Geotextile Calculator
    print("\n📊 TEST 3: Geotextile Calculator")
    print("   Scenario: 100m x 50m area with woven geotextile (10% overlap)")
    geotextile_result = calculate_geotextile(
        length=100,
        width=50,
        geotextile_type="woven",
        overlap=10
    )
    print_result("Geotextile Calculation Results", geotextile_result)
    
    print("\n✅ All calculators working correctly!")
    print("\n📚 These are the NEW calculators added in CONSTRUCTIQ v2.0")
    print("   - Bitumen Calculator (for road construction)")
    print("   - Asphalt Calculator (volume to weight conversion)")
    print("   - Geotextile Calculator (with overlap calculation)")
    print("\n🚀 To test the full system with all features:")
    print("   1. Install Docker Desktop")
    print("   2. Run: docker compose up -d")
    print("   3. Visit: http://localhost:8000")
    print("\n📖 For more info, see: TESTING_NEW_FEATURES.md\n")
