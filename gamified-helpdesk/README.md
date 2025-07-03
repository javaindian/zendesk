# Gamified Multi-Client Helpdesk System

This project is a multi-tenant helpdesk system with a core focus on gamification to boost agent engagement, performance, and satisfaction.

## Project Overview

(A brief description of the project will be added here as it develops.)

## Features

(A list of key features will be populated based on the development phases.)

*   **Phase 1 (MVP):** Core helpdesk (multi-tenancy, user auth, ticket CRUD)
*   **Phase 2 (Gamification Core):** Points, basic leaderboards & badges
*   **Phase 3 (Advanced Helpdesk):** Email-to-ticket, SLA, custom fields, teams
*   **Phase 4 (Advanced Gamification & Client Portal):** Quests, client portal, enhanced reporting

## Tech Stack

*   **Frontend:** React, MUI v5, TypeScript, Vite
*   **Backend:** Node.js, Express.js, TypeScript (Modular Monolith)
*   **Database:** PostgreSQL
*   **Caching:** Redis
*   **Background Worker:** BullMQ (or similar)

## Getting Started

(Instructions for setup and running the project will be added here.)

### Prerequisites

*   Node.js (v18+)
*   Docker & Docker Compose
*   (Other dependencies)

### Installation & Running

1.  Clone the repository:
    ```bash
    git clone <repository-url>
    cd gamified-helpdesk
    ```
2.  Setup environment variables:
    *   Copy `.env.example` files in `backend/` and `frontend/` to `.env` and fill in the necessary values.
3.  Start services using Docker Compose:
    ```bash
    docker-compose up --build -d
    ```
    This will start PostgreSQL, Redis, the backend server, and the frontend development server.

*   Backend will be available at `http://localhost:5000`
*   Frontend will be available at `http://localhost:3000`

(More detailed instructions for development, testing, and deployment will be added.)

## Project Structure

```
gamified-helpdesk/
├── backend/        # Node.js/Express Modular Monolith
├── frontend/       # React (MUI v5) Client-Side Application
├── worker/         # Background Worker (Optional)
├── docker-compose.yml
├── Dockerfile.backend
├── Dockerfile.frontend
├── .gitignore
└── README.md
```

## Contributing

(Guidelines for contributing will be added if applicable.)

## License

(License information will be added here.)
