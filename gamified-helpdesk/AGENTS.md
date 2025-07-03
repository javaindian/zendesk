# AGENTS.md - Guidelines for AI Agent Development

This document provides guidelines and conventions for AI agents working on the Gamified Multi-Client Helpdesk System.

## 1. General Principles

*   **Understand the Plan:** Always refer to the overall project plan and the current phase of development. Ensure your work aligns with the active goals.
*   **Modular Design:** Strive for modular and well-encapsulated code in both backend and frontend.
*   **Readability & Maintainability:** Write clean, well-commented, and maintainable code.
*   **Test Coverage:** While not explicitly developing tests in this initial automated run, keep in mind that future development will require robust testing. Design code to be testable.
*   **Security:** Be mindful of security best practices, especially regarding authentication, authorization, data validation, and handling sensitive information.
*   **User Experience (UX):** For frontend tasks, prioritize a clear, intuitive, and responsive user experience, adhering to the MUI v5 component guidelines.
*   **Commit Messages:** (If applicable in the future) Use clear and descriptive commit messages following conventional formats (e.g., `feat: Add user login functionality`).

## 2. Backend Development (Node.js, Express.js, TypeScript)

*   **Technology Stack:** Node.js, Express.js, TypeScript.
*   **Architecture:** Modular Monolith. Each business domain (e.g., tickets, users, gamification) should reside in its own directory under `backend/src/modules/`.
*   **File Structure within Modules:**
    *   `*.controller.ts`: Handles HTTP requests, data validation, and responses. Calls services for business logic.
    *   `*.service.ts`: Contains core business logic, interacts with models/database.
    *   `*.routes.ts`: Defines API endpoints for the module and links them to controller methods.
    *   `*.model.ts`: (If not using a full ORM immediately) Defines TypeScript interfaces/types for data structures. Database interaction logic might be here or in services.
    *   `*.types.ts` or `types.ts`: For module-specific types.
*   **Database:** PostgreSQL. Use `node-postgres` (pg) library for database interactions. SQL queries should be parameterized to prevent SQL injection. Migrations will be handled (conceptually for now) in `backend/src/database/migrations/`.
*   **Error Handling:** Implement consistent error handling. Use a centralized error handling middleware in Express.
*   **Async/Await:** Use `async/await` for all asynchronous operations.
*   **Environment Variables:** Access configuration through `process.env`. Do not hardcode sensitive information. Use `backend/.env.example` as a template.
*   **Logging:** Implement basic logging for important events and errors. (A more robust logger can be added later).
*   **API Design:** Follow RESTful principles outlined in the API design document. Ensure proper use of HTTP methods and status codes.
*   **Multi-tenancy:** `client_id` is crucial for data isolation. Ensure it's correctly applied in database queries and business logic. It will typically be derived from the authenticated user's JWT.

## 3. Frontend Development (React, MUI v5, TypeScript, Vite)

*   **Technology Stack:** React, MUI v5, TypeScript, Vite.
*   **Component Library:** Exclusively use MUI v5 components for the UI, following the designs and component mappings specified in the plan.
*   **File Structure:**
    *   `src/components/`: Shared, reusable components.
        *   `layout/`: Page structure components (Navbar, Sidebar).
        *   `common/`: Generic components (Buttons, Modals not tied to a feature).
    *   `src/features/`: Feature-specific modules (e.g., `auth`, `tickets`, `dashboard`). Each feature folder can contain its own `components/`, `hooks/`, `services/`, `pages/` (if page is specific to feature).
    *   `src/pages/`: Top-level page components that compose features.
    *   `src/hooks/`: Global custom React hooks.
    *   `src/services/`: API interaction logic (e.g., using Axios).
    *   `src/store/`: State management (e.g., Redux Toolkit, Zustand - to be decided and implemented).
    *   `src/theme/`: MUI theme configuration (`theme.ts`).
    *   `src/types/`: Global frontend TypeScript types and interfaces.
*   **State Management:** For now, use React's built-in state management (`useState`, `useContext`). A global state management solution (like Redux Toolkit or Zustand) will be integrated as complexity grows, particularly for shared state like user authentication and ticket lists.
*   **Styling:** Primarily use MUI's styling solutions (`sx` prop, `styled` API). Avoid plain CSS files where possible, unless for very global styles.
*   **API Calls:** Use a centralized API client (e.g., an Axios instance) configured in `src/services/`.
*   **Forms:** Use controlled components for forms. Implement form validation.
*   **Routing:** Use `react-router-dom` for client-side routing.
*   **Environment Variables:** Access frontend configuration via `import.meta.env` (Vite). Use `frontend/.env.example` as a template.
*   **Accessibility (A11y):** Keep accessibility in mind. Use semantic HTML where appropriate and leverage MUI's accessibility features.

## 4. Communication & Workflow

*   **Plan Adherence:** Follow the established plan. If deviations are necessary, they should be justified and, if possible, discussed (though in this automated run, make the best logical choice).
*   **Tool Usage:** Utilize the provided tools correctly. Ensure code blocks for tools are valid.
*   **Idempotency (for file creation/modification):** Be mindful that operations might be retried. Design file modifications to be safe if applied multiple times, or use tools that handle this (like `replace_with_git_merge_diff`).

## 5. Code Implementation - Phase 1 (MVP) Specifics

*   **Focus on Core Functionality:** Prioritize the features outlined for Phase 1 in the development roadmap.
*   **Backend - MVP:**
    *   Implement basic CRUD operations for `Clients` (manual setup for now), `Users` (Admin, Agent roles), and `Tickets`.
    *   Setup JWT-based authentication.
    *   Ensure `client_id` is used for data queries to enforce multi-tenancy.
*   **Frontend - MVP:**
    *   Create login page.
    *   Create views for ticket listing, ticket detail, and manual ticket creation.
    *   Implement basic navigation.
    *   Connect to backend APIs for user authentication and ticket management.
    *   Use MUI components as per the UI/UX breakdown.

This document will be updated as the project evolves.```
