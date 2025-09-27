## MaidConnect Portal

A simple portal to connect house maids with users who need household services. Users can discover, book, and review maids; maids can list services, availability, and pricing.

### Key Features (MVP)
- **User onboarding**: Register/login for users and maids
- **Service listings**: Browse/search maids by location, skills, and price
- **Booking requests**: Request, accept/decline, and schedule jobs
- **Ratings & reviews**: Post-job feedback to build trust
- **Messaging (optional MVP+)**: In-app chat between users and maids

### Tech Stack (proposed)
- **Frontend**: React or Next.js
- **Backend**: Node.js (Express/Nest) or Python (FastAPI)
- **Database**: PostgreSQL (primary), Redis (caching/sessions)
- **Auth**: JWT-based sessions or OAuth provider
- **Deployment**: Docker + a cloud provider (Render/Fly/Heroku/AWS)

### Getting Started
1. Clone the repo
2. Install dependencies (to be added after scaffolding)
3. Create a `.env` file (sample to be provided)
4. Run the development servers (details to follow)

### Project Structure (planned)
```
sampleAIProj/
  backend/
  frontend/
  infra/
```

### Roadmap
- Phase 1: Auth, listings, basic booking
- Phase 2: Reviews, notifications, calendar availability
- Phase 3: Payments, dispute resolution, advanced search/filters

### Contributing
Open an issue to discuss features or bugs. Create a PR with a clear description and tests.

### License
MIT


