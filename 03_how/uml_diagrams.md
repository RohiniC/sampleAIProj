# HydraClean MVP - UML Diagrams

**Version:** 1.0  
**Date:** January 2025  
**Description:** UML diagrams for HydraClean platform architecture

---

## 1. Entity Relationship Diagram (ERD)

```mermaid
erDiagram
    USERS {
        uuid id PK
        varchar email UK
        varchar password_hash
        enum user_type
        boolean is_verified
        boolean is_active
        timestamp last_login
        timestamp created_at
        timestamp updated_at
    }
    
    CLIENT_PROFILES {
        uuid id PK
        uuid user_id FK
        varchar first_name
        varchar last_name
        varchar phone
        text service_address
        varchar city
        varchar state
        varchar zip_code
        decimal latitude
        decimal longitude
        varchar preferred_contact_method
        timestamp created_at
        timestamp updated_at
    }
    
    MAID_PROFILES {
        uuid id PK
        uuid user_id FK
        varchar first_name
        varchar last_name
        varchar phone
        text bio
        decimal hourly_rate
        text_array services
        jsonb availability
        integer service_radius
        boolean is_available
        varchar profile_photo_url
        varchar background_check_status
        integer years_experience
        timestamp created_at
        timestamp updated_at
    }
    
    MAID_LOCATIONS {
        uuid id PK
        uuid maid_id FK
        varchar city
        varchar state
        varchar zip_code
        decimal latitude
        decimal longitude
        boolean is_primary
        timestamp created_at
    }
    
    BOOKINGS {
        uuid id PK
        uuid client_id FK
        uuid maid_id FK
        varchar service_type
        text description
        timestamp scheduled_date
        decimal duration_hours
        decimal hourly_rate
        decimal total_amount
        decimal platform_fee
        decimal maid_earnings
        enum status
        text client_notes
        text maid_notes
        timestamp created_at
        timestamp updated_at
    }
    
    MESSAGES {
        uuid id PK
        uuid booking_id FK
        uuid sender_id FK
        uuid receiver_id FK
        text message
        boolean is_read
        timestamp created_at
    }
    
    REVIEWS {
        uuid id PK
        uuid booking_id FK
        uuid reviewer_id FK
        uuid reviewee_id FK
        integer rating
        text comment
        timestamp created_at
    }
    
    PAYMENTS {
        uuid id PK
        uuid booking_id FK
        uuid client_id FK
        uuid maid_id FK
        decimal amount
        decimal platform_fee
        decimal maid_payout
        varchar stripe_payment_intent_id
        varchar stripe_transfer_id
        enum status
        timestamp processed_at
        timestamp created_at
    }
    
    NOTIFICATIONS {
        uuid id PK
        uuid user_id FK
        enum type
        varchar title
        text message
        jsonb data
        boolean is_read
        timestamp created_at
    }
    
    USER_SESSIONS {
        uuid id PK
        uuid user_id FK
        varchar device_id
        varchar device_type
        inet ip_address
        text user_agent
        boolean is_active
        timestamp last_activity
        timestamp created_at
    }
    
    AUDIT_LOGS {
        uuid id PK
        uuid user_id FK
        varchar action
        varchar resource_type
        uuid resource_id
        jsonb old_values
        jsonb new_values
        inet ip_address
        text user_agent
        timestamp created_at
    }

    USERS ||--o{ CLIENT_PROFILES : "has"
    USERS ||--o{ MAID_PROFILES : "has"
    USERS ||--o{ BOOKINGS : "creates"
    USERS ||--o{ BOOKINGS : "receives"
    USERS ||--o{ MESSAGES : "sends"
    USERS ||--o{ MESSAGES : "receives"
    USERS ||--o{ REVIEWS : "writes"
    USERS ||--o{ REVIEWS : "receives"
    USERS ||--o{ PAYMENTS : "makes"
    USERS ||--o{ PAYMENTS : "receives"
    USERS ||--o{ NOTIFICATIONS : "receives"
    USERS ||--o{ USER_SESSIONS : "has"
    USERS ||--o{ AUDIT_LOGS : "generates"
    
    MAID_PROFILES ||--o{ MAID_LOCATIONS : "serves"
    BOOKINGS ||--o{ MESSAGES : "contains"
    BOOKINGS ||--o{ REVIEWS : "generates"
    BOOKINGS ||--o{ PAYMENTS : "requires"
```

---

## 2. System Architecture Diagram

```mermaid
graph TB
    subgraph "Client Layer"
        A[Mobile App - iOS]
        B[Mobile App - Android]
        C[Web App]
    end
    
    subgraph "API Gateway"
        D[Load Balancer]
        E[Rate Limiter]
        F[Authentication]
    end
    
    subgraph "Application Layer"
        G[Auth Service]
        H[Profile Service]
        I[Booking Service]
        J[Payment Service]
        K[Notification Service]
        L[Search Service]
    end
    
    subgraph "Data Layer"
        M[(PostgreSQL)]
        N[(Redis Cache)]
        O[(File Storage)]
    end
    
    subgraph "External Services"
        P[Stripe API]
        Q[SendGrid]
        R[Twilio]
        S[Google Maps]
    end
    
    A --> D
    B --> D
    C --> D
    D --> E
    E --> F
    F --> G
    F --> H
    F --> I
    F --> J
    F --> K
    F --> L
    
    G --> M
    H --> M
    I --> M
    J --> M
    K --> M
    L --> M
    
    G --> N
    H --> N
    I --> N
    J --> N
    K --> N
    L --> N
    
    H --> O
    
    J --> P
    K --> Q
    K --> R
    L --> S
```

---

## 3. User Journey Flow Diagram

```mermaid
flowchart TD
    A[User Opens App] --> B{User Type?}
    B -->|New User| C[Registration Flow]
    B -->|Existing User| D[Login Flow]
    
    C --> C1[Select User Type]
    C1 --> C2{Client or Maid?}
    C2 -->|Client| C3[Client Registration]
    C2 -->|Maid| C4[Maid Registration]
    
    C3 --> C5[Basic Details + Location]
    C4 --> C6[Basic Details + Profile Creation]
    C6 --> C7[Identity Verification]
    
    C5 --> E[Email Verification]
    C7 --> E
    E --> F[Login Successful]
    
    D --> D1[Enter Credentials]
    D1 --> D2[Authentication]
    D2 --> F
    
    F --> G{User Type?}
    G -->|Client| H[Client Dashboard]
    G -->|Maid| I[Maid Dashboard]
    
    H --> H1[Search Maids]
    H --> H2[View Bookings]
    H --> H3[Messages]
    H --> H4[Profile]
    
    I --> I1[Manage Profile]
    I --> I2[View Requests]
    I --> I3[Schedule]
    I --> I4[Messages]
    
    H1 --> J[Select Maid]
    J --> K[Request Service]
    K --> L[Booking Created]
    
    I2 --> M[Review Request]
    M --> N{Accept or Reject?}
    N -->|Accept| O[Booking Confirmed]
    N -->|Reject| P[Booking Rejected]
    
    O --> Q[Service Communication]
    Q --> R[Service Completed]
    R --> S[Payment Processing]
    S --> T[Reviews & Ratings]
```

---

## 4. Authentication Flow Diagram

```mermaid
sequenceDiagram
    participant U as User
    participant A as Mobile App
    participant API as API Gateway
    participant Auth as Auth Service
    participant DB as Database
    participant Email as Email Service
    
    U->>A: Enter credentials
    A->>API: POST /auth/login
    API->>Auth: Validate credentials
    Auth->>DB: Check user credentials
    DB-->>Auth: User data
    Auth->>Auth: Generate JWT tokens
    Auth-->>API: Access + Refresh tokens
    API-->>A: Authentication response
    A->>A: Store tokens securely
    A-->>U: Login successful
    
    Note over A,API: Subsequent requests
    A->>API: Request with JWT token
    API->>Auth: Validate JWT token
    Auth-->>API: Token valid
    API-->>A: Protected resource
    
    Note over A,Auth: Token refresh
    A->>API: POST /auth/refresh
    API->>Auth: Validate refresh token
    Auth->>Auth: Generate new tokens
    Auth-->>API: New tokens
    API-->>A: Updated tokens
```

---

## 5. Booking Process Flow Diagram

```mermaid
sequenceDiagram
    participant C as Client
    participant CA as Client App
    participant API as API Gateway
    participant BS as Booking Service
    participant NS as Notification Service
    participant M as Maid
    participant MA as Maid App
    
    C->>CA: Search for maids
    CA->>API: GET /maids/search
    API-->>CA: Maid listings
    CA-->>C: Display results
    
    C->>CA: Select maid and request service
    CA->>API: POST /bookings
    API->>BS: Create booking
    BS->>BS: Validate availability
    BS->>BS: Calculate pricing
    BS-->>API: Booking created
    API->>NS: Send notification
    NS->>MA: Push notification
    API-->>CA: Booking pending
    
    M->>MA: Review booking request
    MA->>API: GET /bookings/pending
    API-->>MA: Booking details
    
    M->>MA: Accept/Reject booking
    MA->>API: PUT /bookings/{id}/accept
    API->>BS: Update booking status
    BS->>NS: Send confirmation
    NS->>CA: Push notification
    API-->>MA: Booking accepted
    
    Note over C,M: Service communication
    C->>CA: Send message
    CA->>API: POST /messages
    API->>BS: Store message
    API->>NS: Send notification
    NS->>MA: Message notification
```

---

## 6. Payment Processing Flow Diagram

```mermaid
sequenceDiagram
    participant C as Client
    participant CA as Client App
    participant API as API Gateway
    participant PS as Payment Service
    participant Stripe as Stripe API
    participant M as Maid
    participant MA as Maid App
    
    C->>CA: Complete service
    CA->>API: POST /payments/process
    API->>PS: Process payment
    
    PS->>Stripe: Create payment intent
    Stripe-->>PS: Payment intent created
    PS->>Stripe: Confirm payment
    Stripe-->>PS: Payment confirmed
    
    PS->>PS: Calculate platform fee
    PS->>PS: Calculate maid payout
    
    PS->>Stripe: Create transfer to maid
    Stripe-->>PS: Transfer created
    
    PS->>PS: Update payment status
    PS-->>API: Payment processed
    API-->>CA: Payment successful
    
    Note over PS,MA: Payout notification
    PS->>MA: Send payout notification
    MA-->>M: Payout received
```

---

## 7. Database Index Strategy

```mermaid
graph TD
    A[Database Performance] --> B[Primary Indexes]
    A --> C[Composite Indexes]
    A --> D[Partial Indexes]
    
    B --> B1[Primary Keys]
    B --> B2[Foreign Keys]
    B --> B3[Unique Constraints]
    
    C --> C1[Search Optimization]
    C --> C2[Geographic Queries]
    C --> C3[Time-based Queries]
    
    D --> D1[Active Users Only]
    D --> D2[Verified Users Only]
    D --> D3[Recent Data Only]
    
    C1 --> C1A[maid_locations: lat, lng]
    C1 --> C1B[bookings: client_id, status]
    C1 --> C1C[messages: booking_id, created_at]
    
    C2 --> C2A[Geographic search radius]
    C2 --> C2B[Location-based filtering]
    
    C3 --> C3A[Recent bookings]
    C3 --> C3B[Active sessions]
    C3 --> C3C[Recent messages]
```

---

## 8. Security Architecture Diagram

```mermaid
graph TB
    subgraph "Security Layers"
        A[Application Security]
        B[Network Security]
        C[Data Security]
        D[Infrastructure Security]
    end
    
    subgraph "Authentication & Authorization"
        E[JWT Tokens]
        F[Role-Based Access]
        G[Multi-Factor Auth]
        H[Session Management]
    end
    
    subgraph "Data Protection"
        I[Encryption at Rest]
        J[Encryption in Transit]
        K[Data Masking]
        L[Audit Logging]
    end
    
    subgraph "Threat Protection"
        M[Rate Limiting]
        N[Input Validation]
        O[SQL Injection Prevention]
        P[XSS Protection]
    end
    
    A --> E
    A --> F
    A --> G
    A --> H
    
    B --> I
    B --> J
    B --> K
    B --> L
    
    C --> M
    C --> N
    C --> O
    C --> P
    
    D --> A
    D --> B
    D --> C
```

---

## 9. Microservices Communication Diagram

```mermaid
graph LR
    subgraph "API Gateway"
        A[Load Balancer]
        B[Rate Limiter]
        C[Auth Middleware]
    end
    
    subgraph "Core Services"
        D[Auth Service]
        E[Profile Service]
        F[Booking Service]
        G[Payment Service]
        H[Notification Service]
        I[Search Service]
    end
    
    subgraph "Data Services"
        J[User Database]
        K[Booking Database]
        L[Payment Database]
        M[Cache Layer]
    end
    
    subgraph "External APIs"
        N[Stripe]
        O[SendGrid]
        P[Twilio]
        Q[Google Maps]
    end
    
    A --> D
    A --> E
    A --> F
    A --> G
    A --> H
    A --> I
    
    D --> J
    E --> J
    F --> K
    G --> L
    H --> M
    I --> M
    
    G --> N
    H --> O
    H --> P
    I --> Q
```

---

## 10. Deployment Architecture Diagram

```mermaid
graph TB
    subgraph "Production Environment"
        A[Load Balancer]
        B[API Gateway]
        C[Application Servers]
        D[Database Cluster]
        E[Cache Cluster]
        F[File Storage]
    end
    
    subgraph "Monitoring & Logging"
        G[Application Monitoring]
        H[Database Monitoring]
        I[Log Aggregation]
        J[Alerting System]
    end
    
    subgraph "Security & Backup"
        K[SSL/TLS Termination]
        L[Firewall]
        M[Backup System]
        N[Disaster Recovery]
    end
    
    A --> B
    B --> C
    C --> D
    C --> E
    C --> F
    
    C --> G
    D --> H
    C --> I
    G --> J
    H --> J
    I --> J
    
    A --> K
    K --> L
    D --> M
    M --> N
```

---

**Document Owner:** Technical Architecture Team  
**Review Date:** Weekly  
**Next Review:** End of Week 1
