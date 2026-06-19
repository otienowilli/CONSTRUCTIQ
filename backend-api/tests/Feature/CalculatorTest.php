<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

class CalculatorTest extends TestCase
{
    use RefreshDatabase;

    protected $user;

    protected function setUp(): void
    {
        parent::setUp();
        $this->user = User::factory()->create();
    }

    public function test_concrete_calculation()
    {
        $response = $this->actingAs($this->user)
            ->postJson('/api/calculator/concrete', [
                'length' => 10,
                'width' => 10,
                'height' => 0.15,
                'grade' => 'C20',
            ]);

        $response->assertStatus(200)
            ->assertJsonStructure([
                'volume',
                'materials',
                'total_cost',
                'mix_ratio',
            ]);

        $this->assertGreaterThan(0, $response->json('volume'));
    }

    public function test_brickwork_calculation()
    {
        $response = $this->actingAs($this->user)
            ->postJson('/api/calculator/brickwork', [
                'length' => 10,
                'height' => 3,
                'thickness' => 0.23,
                'mortar_ratio' => '1:4',
            ]);

        $response->assertStatus(200)
            ->assertJsonStructure([
                'area',
                'bricks_required',
                'materials',
                'total_cost',
            ]);
    }

    public function test_plastering_calculation()
    {
        $response = $this->actingAs($this->user)
            ->postJson('/api/calculator/plastering', [
                'area' => 100,
                'thickness' => 0.015,
                'mix_ratio' => '1:4',
            ]);

        $response->assertStatus(200)
            ->assertJsonStructure([
                'volume',
                'materials',
                'total_cost',
            ]);
    }

    public function test_calculation_validation()
    {
        $response = $this->actingAs($this->user)
            ->postJson('/api/calculator/concrete', [
                'length' => -10, // Invalid negative value
                'width' => 10,
                'height' => 0.15,
            ]);

        $response->assertStatus(422);
    }

    public function test_unauthorized_access()
    {
        $response = $this->postJson('/api/calculator/concrete', [
            'length' => 10,
            'width' => 10,
            'height' => 0.15,
        ]);

        $response->assertStatus(401);
    }
}

