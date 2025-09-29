# HydraClean MVP Architecture

Here is a high-level architecture diagram for the HydraClean MVP, based on the project specifications and architecture decisions.

```
     ┌────────────────────────────────────────────────────────────────┐
     │                        Presentation Layer                     │
     │              (HydraClean Mobile App - React Native)          │
     └─────────────────────┬──────────────────────────────────────────┘
                           │ (HTTPS - REST API Calls)
     ┌─────────────────────▼──────────────────────────────────────────┐
     │                     Backend Service Layer (Node.js)            │
     │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
     │  │ User Mgmt   │  │ Booking Mgmt│  │   Notification Svc  │  │
     │  │             │  │             │  │                     │  │
     │  │• Profiles   │  │• Scheduling │  │• Push Notifications │  │
     │  │• Auth       │  │• Reviews    │  │• In-App Messaging   │  │
     │  │• Vetting    │  │• Payments   │  │• Email / SMS        │  │
     │  └─────────────┘  └─────────────┘  └─────────────────────┘  │
     └─────────────────────┬──────────────────────────────────────────┘
                           │
     ┌─────────────────────▼──────────────────────────────────────────┐
     │                   Infrastructure Layer                      │
     │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
     │  │  Database   │  │ Ext. APIs   │  │  Cloud Services     │  │
     │  │(PostgreSQL) │  │             │  │      (AWS/GCP)      │  │
     │  │             │  │• Stripe     │  │• Object Storage (S3)│  │
     │  │• Users      │  │• APNS / FCM │  │• Hosting (EC2/Bean) │  │
     │  │• Bookings   │  │             │  │• Logging/Monitoring │  │
     │  │• Reviews    │  └─────────────┘  └─────────────────────┘  │
     └────────────────────────────────────────────────────────────────┘
```
