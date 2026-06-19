# CONSTRUCTIQ Testing Guide

This guide covers testing strategies and procedures for the CONSTRUCTIQ platform.

## Overview

The project includes tests for:
- Backend API (PHPUnit)
- AI Engine (pytest)
- Web Dashboard (Jest - to be implemented)
- Integration tests
- End-to-end tests

## Backend API Tests (Laravel/PHPUnit)

### Running Tests

```bash
# Run all tests
docker-compose exec backend-api php artisan test

# Run specific test file
docker-compose exec backend-api php artisan test tests/Feature/CalculatorTest.php

# Run with coverage
docker-compose exec backend-api php artisan test --coverage
```

### Test Structure

```
backend-api/tests/
├── Feature/           # Feature tests
│   ├── CalculatorTest.php
│   ├── ProjectTest.php
│   ├── AuthTest.php
│   └── MaterialTest.php
└── Unit/             # Unit tests
    └── CalculatorServiceTest.php
```

### Writing Tests

Example test:

```php
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
        ]);
}
```

## AI Engine Tests (Python/pytest)

### Running Tests

```bash
# Run all tests
docker-compose exec ai-engine pytest

# Run with coverage
docker-compose exec ai-engine pytest --cov=. --cov-report=html

# Run specific test file
docker-compose exec ai-engine pytest tests/test_chatbot.py

# Run with verbose output
docker-compose exec ai-engine pytest -v
```

### Test Structure

```
ai-engine/tests/
├── test_chatbot.py
├── test_soil_analyzer.py
├── test_image_processor.py
└── test_recommendations.py
```

### Writing Tests

Example test:

```python
@pytest.mark.asyncio
async def test_process_message(chatbot):
    response = await chatbot.process_message(
        message="What is concrete?",
        user_id="test-user-123"
    )
    
    assert "response" in response
    assert isinstance(response["response"], str)
```

## Web Dashboard Tests (Jest/React Testing Library)

### Running Tests

```bash
# Run all tests
cd web-dashboard
npm test

# Run with coverage
npm test -- --coverage

# Run in watch mode
npm test -- --watch
```

### Test Structure

```
web-dashboard/__tests__/
├── components/
│   ├── Calculator.test.tsx
│   └── ProjectCard.test.tsx
└── pages/
    └── index.test.tsx
```

## Integration Tests

### API Integration Tests

Test complete workflows across services:

```bash
# Run integration tests
./scripts/test-integration.sh
```

Example integration test:

```python
def test_complete_calculation_workflow():
    # 1. Login
    auth_response = requests.post(f"{API_URL}/auth/login", json={
        "email": "test@example.com",
        "password": "password"
    })
    token = auth_response.json()["token"]
    
    # 2. Create project
    project_response = requests.post(
        f"{API_URL}/projects",
        headers={"Authorization": f"Bearer {token}"},
        json={"name": "Test Project", "type": "building"}
    )
    project_id = project_response.json()["id"]
    
    # 3. Calculate materials
    calc_response = requests.post(
        f"{API_URL}/calculator/concrete",
        headers={"Authorization": f"Bearer {token}"},
        json={
            "length": 10,
            "width": 10,
            "height": 0.15,
            "project_id": project_id
        }
    )
    
    assert calc_response.status_code == 200
```

## End-to-End Tests

### Using Playwright/Cypress

```bash
# Install dependencies
npm install -D @playwright/test

# Run E2E tests
npx playwright test
```

Example E2E test:

```javascript
test('complete project creation flow', async ({ page }) => {
  // Login
  await page.goto('http://localhost:3000/login');
  await page.fill('[name="email"]', 'test@example.com');
  await page.fill('[name="password"]', 'password');
  await page.click('button[type="submit"]');
  
  // Create project
  await page.click('text=New Project');
  await page.fill('[name="name"]', 'Test Building');
  await page.fill('[name="budget"]', '5000000');
  await page.click('button:has-text("Create")');
  
  // Verify project created
  await expect(page.locator('text=Test Building')).toBeVisible();
});
```

## Load Testing

### Using Apache Bench

```bash
# Test API endpoint
ab -n 1000 -c 10 http://localhost:8000/api/materials

# Test with authentication
ab -n 1000 -c 10 -H "Authorization: Bearer TOKEN" \
   http://localhost:8000/api/projects
```

### Using Locust

Create `locustfile.py`:

```python
from locust import HttpUser, task, between

class ConstructiqUser(HttpUser):
    wait_time = between(1, 3)
    
    def on_start(self):
        # Login
        response = self.client.post("/api/auth/login", json={
            "email": "test@example.com",
            "password": "password"
        })
        self.token = response.json()["token"]
    
    @task
    def get_projects(self):
        self.client.get("/api/projects", headers={
            "Authorization": f"Bearer {self.token}"
        })
    
    @task
    def calculate_concrete(self):
        self.client.post("/api/calculator/concrete", 
            headers={"Authorization": f"Bearer {self.token}"},
            json={
                "length": 10,
                "width": 10,
                "height": 0.15,
                "grade": "C20"
            }
        )
```

Run:
```bash
locust -f locustfile.py --host=http://localhost:8000
```

## Test Coverage

### Backend Coverage

```bash
docker-compose exec backend-api php artisan test --coverage-html coverage
```

View report: `backend-api/coverage/index.html`

### AI Engine Coverage

```bash
docker-compose exec ai-engine pytest --cov=. --cov-report=html
```

View report: `ai-engine/htmlcov/index.html`

## Continuous Integration

Tests run automatically on:
- Pull requests
- Pushes to main/develop branches

See `.github/workflows/ci-cd.yml` for CI configuration.

## Best Practices

### General

- Write tests before fixing bugs
- Aim for >80% code coverage
- Test edge cases and error conditions
- Use descriptive test names
- Keep tests independent

### Backend Tests

- Use database transactions for isolation
- Mock external services
- Test validation rules
- Test authorization

### AI Engine Tests

- Mock OpenAI API calls
- Test fallback responses
- Verify data structures
- Test async functions properly

### Frontend Tests

- Test user interactions
- Test component rendering
- Mock API calls
- Test error states

## Troubleshooting

### Tests Failing

1. Check database is running
2. Verify environment variables
3. Clear caches
4. Check test data

### Slow Tests

1. Use database transactions
2. Mock external services
3. Parallelize tests
4. Optimize test data

## Resources

- [PHPUnit Documentation](https://phpunit.de/)
- [pytest Documentation](https://docs.pytest.org/)
- [Jest Documentation](https://jestjs.io/)
- [Playwright Documentation](https://playwright.dev/)

