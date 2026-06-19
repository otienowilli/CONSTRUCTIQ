# CONSTRUCTIQ Web Dashboard

Modern web dashboard for CONSTRUCTIQ construction management platform built with Next.js 14.

## Features

- **Project Management** - Create, view, and manage construction projects
- **Material Calculator** - Calculate material requirements for various construction tasks
- **Site Analysis** - AI-powered site and soil analysis
- **Machine Monitoring** - Real-time IoT machine monitoring
- **Reports & Analytics** - Generate and view project reports
- **AI Chatbot** - Get construction guidance and assistance
- **Responsive Design** - Works on desktop, tablet, and mobile

## Tech Stack

- **Framework**: Next.js 14 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **State Management**: Zustand
- **Data Fetching**: TanStack Query (React Query)
- **Forms**: React Hook Form + Zod
- **Charts**: Recharts
- **Icons**: Lucide React

## Getting Started

### Prerequisites

- Node.js 18+ 
- npm or yarn

### Installation

1. Install dependencies:
```bash
npm install
```

2. Configure environment:
```bash
cp .env.example .env.local
# Edit .env.local with your API URLs
```

3. Run development server:
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

### Build for Production

```bash
npm run build
npm start
```

## Project Structure

```
web-dashboard/
├── app/                    # Next.js app directory
│   ├── layout.tsx         # Root layout
│   ├── page.tsx           # Dashboard home
│   ├── globals.css        # Global styles
│   ├── projects/          # Projects pages
│   ├── calculator/        # Calculator pages
│   ├── machines/          # Machine monitoring
│   └── reports/           # Reports pages
├── components/            # Reusable components
│   ├── ui/               # UI components
│   ├── forms/            # Form components
│   └── charts/           # Chart components
├── lib/                   # Utilities and helpers
│   ├── api.ts            # API client
│   └── utils.ts          # Helper functions
├── public/               # Static assets
└── package.json
```

## API Integration

The dashboard connects to:
- **Backend API** (Laravel): `http://localhost:8000/api`
- **AI Engine** (FastAPI): `http://localhost:8001`
- **IoT Gateway**: `http://localhost:8002`

Configure URLs in `.env.local`:
```env
NEXT_PUBLIC_API_URL=http://localhost:8000/api
NEXT_PUBLIC_AI_ENGINE_URL=http://localhost:8001
NEXT_PUBLIC_IOT_GATEWAY_URL=http://localhost:8002
```

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm run lint` - Run ESLint

## Docker

Build and run with Docker:
```bash
docker build -t constructiq-dashboard .
docker run -p 3000:3000 constructiq-dashboard
```

## Features Overview

### Dashboard Home
- Project statistics
- Quick actions
- Recent activity feed

### Material Calculator
- Concrete calculations
- Brickwork calculations
- Plastering calculations
- Painting calculations
- Excavation calculations
- Road construction calculations
- Roofing calculations

### Site Analysis
- Upload site images
- AI-powered soil analysis
- Site recommendations

### Machine Monitoring
- Real-time sensor data
- Machine status tracking
- Performance metrics

### Reports
- Generate project reports
- View historical reports
- Export to PDF

### AI Chatbot
- Construction guidance
- Material recommendations
- Cost estimation
- Risk analysis

## Development

### Adding New Pages

Create a new folder in `app/` directory:
```tsx
// app/new-page/page.tsx
export default function NewPage() {
  return <div>New Page</div>
}
```

### Adding Components

Create components in `components/` directory:
```tsx
// components/MyComponent.tsx
export function MyComponent() {
  return <div>My Component</div>
}
```

## License

MIT

