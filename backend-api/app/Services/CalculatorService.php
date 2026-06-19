<?php

namespace App\Services;

use App\Models\Material;

class CalculatorService
{
    /**
     * Calculate concrete requirements
     * 
     * @param array $data [length, width, height, concrete_grade]
     * @return array
     */
    public function calculateConcrete(array $data): array
    {
        $length = $data['length']; // meters
        $width = $data['width']; // meters
        $height = $data['height']; // meters
        $grade = $data['concrete_grade'] ?? 'C20'; // C15, C20, C25, C30
        
        // Calculate volume
        $volume = $length * $width * $height; // cubic meters
        
        // Mix ratios (cement:sand:ballast)
        $mixRatios = [
            'C15' => ['cement' => 1, 'sand' => 2, 'ballast' => 4],
            'C20' => ['cement' => 1, 'sand' => 2, 'ballast' => 3],
            'C25' => ['cement' => 1, 'sand' => 1.5, 'ballast' => 3],
            'C30' => ['cement' => 1, 'sand' => 1, 'ballast' => 2],
        ];
        
        $ratio = $mixRatios[$grade];
        $totalParts = $ratio['cement'] + $ratio['sand'] + $ratio['ballast'];
        
        // Calculate material quantities
        // 1 bag of cement = 0.035 cubic meters
        $cementBags = ($volume * $ratio['cement'] / $totalParts) / 0.035;
        $sand = ($volume * $ratio['sand'] / $totalParts) * 1.54; // 54% wastage
        $ballast = ($volume * $ratio['ballast'] / $totalParts) * 1.54;
        
        // Get material prices
        $cementPrice = Material::where('name', 'LIKE', '%Cement%')->first()->base_price ?? 350;
        $sandPrice = Material::where('name', 'LIKE', '%Sand%')->first()->base_price ?? 1200;
        $ballastPrice = Material::where('name', 'LIKE', '%Ballast%')->first()->base_price ?? 1500;
        
        $totalCost = ($cementBags * $cementPrice) + ($sand * $sandPrice) + ($ballast * $ballastPrice);
        
        return [
            'volume' => round($volume, 2),
            'concrete_grade' => $grade,
            'materials' => [
                'cement' => [
                    'quantity' => round($cementBags, 2),
                    'unit' => 'bags (50kg)',
                    'unit_price' => $cementPrice,
                    'total' => round($cementBags * $cementPrice, 2),
                ],
                'sand' => [
                    'quantity' => round($sand, 2),
                    'unit' => 'cubic meters',
                    'unit_price' => $sandPrice,
                    'total' => round($sand * $sandPrice, 2),
                ],
                'ballast' => [
                    'quantity' => round($ballast, 2),
                    'unit' => 'cubic meters',
                    'unit_price' => $ballastPrice,
                    'total' => round($ballast * $ballastPrice, 2),
                ],
            ],
            'total_cost' => round($totalCost, 2),
            'mix_ratio' => "{$ratio['cement']}:{$ratio['sand']}:{$ratio['ballast']}",
        ];
    }

    /**
     * Calculate brickwork requirements
     */
    public function calculateBrickwork(array $data): array
    {
        $length = $data['length']; // meters
        $height = $data['height']; // meters
        $thickness = $data['thickness'] ?? 0.225; // meters (9 inch default)
        $brickType = $data['brick_type'] ?? 'clay'; // clay or concrete
        
        $area = $length * $height;
        $volume = $area * $thickness;
        
        // Bricks per square meter (accounting for mortar)
        $bricksPerSqm = $thickness == 0.225 ? 120 : 60; // 9 inch or 4.5 inch
        $totalBricks = $area * $bricksPerSqm;
        
        // Mortar calculation (30% of volume)
        $mortarVolume = $volume * 0.30;
        $cementBags = ($mortarVolume / 0.035) * 0.25; // 1:4 ratio
        $sand = $mortarVolume * 1.25;
        
        $brickPrice = $brickType === 'clay' ? 15 : 45;
        $cementPrice = 350;
        $sandPrice = 1200;
        
        $totalCost = ($totalBricks * $brickPrice) + ($cementBags * $cementPrice) + ($sand * $sandPrice);
        
        return [
            'area' => round($area, 2),
            'volume' => round($volume, 2),
            'materials' => [
                'bricks' => [
                    'quantity' => round($totalBricks),
                    'unit' => 'pieces',
                    'unit_price' => $brickPrice,
                    'total' => round($totalBricks * $brickPrice, 2),
                ],
                'cement' => [
                    'quantity' => round($cementBags, 2),
                    'unit' => 'bags (50kg)',
                    'unit_price' => $cementPrice,
                    'total' => round($cementBags * $cementPrice, 2),
                ],
                'sand' => [
                    'quantity' => round($sand, 2),
                    'unit' => 'cubic meters',
                    'unit_price' => $sandPrice,
                    'total' => round($sand * $sandPrice, 2),
                ],
            ],
            'total_cost' => round($totalCost, 2),
        ];
    }

    /**
     * Calculate plastering requirements
     */
    public function calculatePlastering(array $data): array
    {
        $area = $data['area']; // square meters
        $thickness = $data['thickness'] ?? 0.012; // meters (12mm default)
        $ratio = $data['ratio'] ?? '1:4'; // cement:sand ratio
        
        $volume = $area * $thickness;
        
        // Calculate materials based on ratio
        $parts = explode(':', $ratio);
        $cementPart = (int)$parts[0];
        $sandPart = (int)$parts[1];
        $totalParts = $cementPart + $sandPart;
        
        $cementBags = ($volume * $cementPart / $totalParts) / 0.035 * 1.25;
        $sand = ($volume * $sandPart / $totalParts) * 1.25;
        
        $cementPrice = 350;
        $sandPrice = 1200;
        
        $totalCost = ($cementBags * $cementPrice) + ($sand * $sandPrice);
        
        return [
            'area' => round($area, 2),
            'thickness' => $thickness * 1000 . 'mm',
            'materials' => [
                'cement' => [
                    'quantity' => round($cementBags, 2),
                    'unit' => 'bags (50kg)',
                    'unit_price' => $cementPrice,
                    'total' => round($cementBags * $cementPrice, 2),
                ],
                'sand' => [
                    'quantity' => round($sand, 2),
                    'unit' => 'cubic meters',
                    'unit_price' => $sandPrice,
                    'total' => round($sand * $sandPrice, 2),
                ],
            ],
            'total_cost' => round($totalCost, 2),
            'mix_ratio' => $ratio,
        ];
    }

    /**
     * Calculate painting requirements
     */
    public function calculatePainting(array $data): array
    {
        $area = $data['area']; // square meters
        $coats = $data['coats'] ?? 2;
        $paintType = $data['paint_type'] ?? 'emulsion'; // emulsion, oil, etc.

        // Coverage: 1 liter covers ~10-12 sqm per coat
        $coverage = 11; // sqm per liter
        $liters = ($area * $coats) / $coverage;

        $paintPrice = $paintType === 'emulsion' ? 450 : 650;
        $totalCost = $liters * $paintPrice;

        return [
            'area' => round($area, 2),
            'coats' => $coats,
            'materials' => [
                'paint' => [
                    'quantity' => round($liters, 2),
                    'unit' => 'liters',
                    'unit_price' => $paintPrice,
                    'total' => round($totalCost, 2),
                ],
            ],
            'total_cost' => round($totalCost, 2),
        ];
    }

    /**
     * Calculate excavation requirements
     */
    public function calculateExcavation(array $data): array
    {
        $length = $data['length']; // meters
        $width = $data['width']; // meters
        $depth = $data['depth']; // meters

        $volume = $length * $width * $depth;

        // Estimate labor and machine hours
        $machineHours = $volume / 20; // 20 cubic meters per hour average
        $laborDays = $volume / 5; // 5 cubic meters per person per day

        return [
            'volume' => round($volume, 2),
            'dimensions' => [
                'length' => $length,
                'width' => $width,
                'depth' => $depth,
            ],
            'estimates' => [
                'machine_hours' => round($machineHours, 2),
                'labor_days' => round($laborDays, 2),
            ],
        ];
    }

    /**
     * Calculate road construction requirements
     */
    public function calculateRoad(array $data): array
    {
        $length = $data['length']; // meters
        $width = $data['width']; // meters
        $layers = $data['layers'] ?? [
            'subgrade' => 0.15,
            'subbase' => 0.15,
            'base' => 0.15,
            'asphalt' => 0.05,
        ];

        $area = $length * $width;
        $materials = [];
        $totalCost = 0;

        foreach ($layers as $layer => $thickness) {
            $volume = $area * $thickness;

            $prices = [
                'subgrade' => 800,
                'subbase' => 1200,
                'base' => 1800,
                'asphalt' => 8500,
            ];

            $price = $prices[$layer] ?? 1000;
            $cost = $volume * $price;
            $totalCost += $cost;

            $materials[$layer] = [
                'volume' => round($volume, 2),
                'thickness' => $thickness,
                'unit_price' => $price,
                'total' => round($cost, 2),
            ];
        }

        return [
            'area' => round($area, 2),
            'length' => $length,
            'width' => $width,
            'materials' => $materials,
            'total_cost' => round($totalCost, 2),
        ];
    }

    /**
     * Calculate roofing requirements
     */
    public function calculateRoofing(array $data): array
    {
        $area = $data['area']; // square meters
        $roofType = $data['roof_type'] ?? 'iron_sheets';
        $pitch = $data['pitch'] ?? 30; // degrees

        // Adjust area for pitch
        $pitchFactor = 1 / cos(deg2rad($pitch));
        $actualArea = $area * $pitchFactor;

        // Add 10% wastage
        $totalArea = $actualArea * 1.10;

        return [
            'plan_area' => round($area, 2),
            'actual_area' => round($actualArea, 2),
            'total_with_wastage' => round($totalArea, 2),
            'pitch' => $pitch . '°',
            'roof_type' => $roofType,
        ];
    }

    /**
     * Calculate bitumen requirements for road construction
     *
     * @param array $data [length, width, layer_thickness, bitumen_grade]
     * @return array
     */
    public function calculateBitumen(array $data): array
    {
        $length = $data['length']; // meters
        $width = $data['width']; // meters
        $thickness = $data['layer_thickness'] ?? 0.05; // meters (default 50mm)
        $grade = $data['bitumen_grade'] ?? '80/100';

        // Calculate area
        $area = $length * $width; // square meters

        // Bitumen application rates (liters per square meter)
        $applicationRates = [
            'prime_coat' => 0.8,
            'tack_coat' => 0.3,
            '80/100' => 1.2,
            '60/70' => 1.1,
            '40/50' => 1.0,
        ];

        $rate = $applicationRates[$grade] ?? 1.0;
        $bitumenRequired = $area * $rate; // liters

        // Add 5% wastage
        $totalBitumen = $bitumenRequired * 1.05;

        // Get price
        $bitumenPrice = Material::where('name', 'LIKE', "%Bitumen%$grade%")->first()->base_price ?? 95;
        $totalCost = $totalBitumen * $bitumenPrice;

        return [
            'area' => round($area, 2),
            'bitumen_required' => round($bitumenRequired, 2),
            'total_with_wastage' => round($totalBitumen, 2),
            'unit' => 'liters',
            'grade' => $grade,
            'application_rate' => $rate,
            'total_cost' => round($totalCost, 2),
        ];
    }

    /**
     * Calculate asphalt requirements for road construction
     *
     * @param array $data [length, width, thickness, asphalt_type]
     * @return array
     */
    public function calculateAsphalt(array $data): array
    {
        $length = $data['length']; // meters
        $width = $data['width']; // meters
        $thickness = $data['thickness'] ?? 0.05; // meters (default 50mm)
        $type = $data['asphalt_type'] ?? 'AC14';

        // Calculate volume
        $volume = $length * $width * $thickness; // cubic meters

        // Asphalt density (tons per cubic meter)
        $density = 2.4;

        // Calculate weight
        $weight = $volume * $density; // tons

        // Add 3% wastage
        $totalWeight = $weight * 1.03;

        // Get price
        $asphaltPrice = Material::where('name', 'LIKE', "%$type%")->first()->base_price ?? 8500;
        $totalCost = $totalWeight * $asphaltPrice;

        return [
            'volume' => round($volume, 2),
            'weight' => round($weight, 2),
            'total_with_wastage' => round($totalWeight, 2),
            'unit' => 'tons',
            'type' => $type,
            'density' => $density,
            'thickness' => $thickness,
            'total_cost' => round($totalCost, 2),
        ];
    }

    /**
     * Calculate geotextile requirements
     *
     * @param array $data [length, width, geotextile_type, overlap_percentage]
     * @return array
     */
    public function calculateGeotextile(array $data): array
    {
        $length = $data['length']; // meters
        $width = $data['width']; // meters
        $type = $data['geotextile_type'] ?? 'woven';
        $overlap = $data['overlap_percentage'] ?? 10; // percentage

        // Calculate base area
        $baseArea = $length * $width;

        // Add overlap
        $overlapFactor = 1 + ($overlap / 100);
        $totalArea = $baseArea * $overlapFactor;

        // Get price
        $searchTerm = $type === 'woven' ? 'Woven' : 'Non-woven';
        $geotextilePrice = Material::where('name', 'LIKE', "%$searchTerm%")->first()->base_price ?? 180;
        $totalCost = $totalArea * $geotextilePrice;

        return [
            'base_area' => round($baseArea, 2),
            'overlap_percentage' => $overlap,
            'total_area' => round($totalArea, 2),
            'unit' => 'square meters',
            'type' => $type,
            'total_cost' => round($totalCost, 2),
        ];
    }
}


