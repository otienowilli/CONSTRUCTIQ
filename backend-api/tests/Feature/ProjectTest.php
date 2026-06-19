<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use App\Models\Project;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ProjectTest extends TestCase
{
    use RefreshDatabase;

    protected $user;

    protected function setUp(): void
    {
        parent::setUp();
        $this->user = User::factory()->create();
    }

    public function test_can_create_project()
    {
        $response = $this->actingAs($this->user)
            ->postJson('/api/projects', [
                'name' => 'Test Building',
                'description' => 'A test building project',
                'type' => 'building',
                'location' => ['latitude' => -1.2921, 'longitude' => 36.8219],
                'budget' => 5000000,
                'start_date' => '2024-03-01',
                'end_date' => '2024-12-31',
            ]);

        $response->assertStatus(201)
            ->assertJsonStructure([
                'id',
                'name',
                'description',
                'type',
                'status',
            ]);
    }

    public function test_can_list_projects()
    {
        Project::factory()->count(3)->create(['user_id' => $this->user->id]);

        $response = $this->actingAs($this->user)
            ->getJson('/api/projects');

        $response->assertStatus(200)
            ->assertJsonCount(3, 'data');
    }

    public function test_can_view_project()
    {
        $project = Project::factory()->create(['user_id' => $this->user->id]);

        $response = $this->actingAs($this->user)
            ->getJson("/api/projects/{$project->id}");

        $response->assertStatus(200)
            ->assertJson([
                'id' => $project->id,
                'name' => $project->name,
            ]);
    }

    public function test_can_update_project()
    {
        $project = Project::factory()->create(['user_id' => $this->user->id]);

        $response = $this->actingAs($this->user)
            ->putJson("/api/projects/{$project->id}", [
                'status' => 'in_progress',
            ]);

        $response->assertStatus(200)
            ->assertJson([
                'status' => 'in_progress',
            ]);
    }

    public function test_can_delete_project()
    {
        $project = Project::factory()->create(['user_id' => $this->user->id]);

        $response = $this->actingAs($this->user)
            ->deleteJson("/api/projects/{$project->id}");

        $response->assertStatus(204);
        $this->assertDatabaseMissing('projects', ['id' => $project->id]);
    }
}

