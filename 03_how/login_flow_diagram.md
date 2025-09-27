# HydraClean Login Flow Diagram

## Overview
This document outlines the complete login flow for the HydraClean house maid service platform, covering both client and maid user authentication processes.

## Login Flow Architecture

```mermaid
graph TD
    A[User Opens App] --> B{User Type?}
    B -->|New User| C[Registration Flow]
    B -->|Existing User| D[Login Screen]
    
    C --> C1[Select User Type]
    C1 --> C2{Client or Maid?}
    C2 -->|Client| C3[Client Registration]
    C2 -->|Maid| C4[Maid Registration]
    
    C3 --> C5[Basic Details<br/>Name, Email, Password, Location]
    C4 --> C6[Basic Details<br/>Name, Email, Password, Phone]
    C6 --> C7[Profile Creation<br/>Photo, Bio, Services, Availability, Rate]
    C7 --> C8[Identity Verification<br/>Email/Phone Confirmation]
    
    C5 --> E[Email Verification]
    C8 --> E
    E --> F[Login Successful]
    
    D --> D1[Enter Email & Password]
    D1 --> D2[Submit Credentials]
    D2 --> D3{Valid Credentials?}
    D3 -->|No| D4[Show Error Message]
    D4 --> D1
    D3 -->|Yes| D5{Account Verified?}
    D5 -->|No| D6[Resend Verification]
    D6 --> E
    D5 -->|Yes| F
    
    F --> G{User Type?}
    G -->|Client| H[Client Dashboard<br/>Search Maids, Bookings, Messages]
    G -->|Maid| I[Maid Dashboard<br/>Booking Requests, Schedule, Profile]
    
    H --> J[Client Features]
    I --> K[Maid Features]
    
    J --> J1[Search Maids by Location]
    J --> J2[View Maid Profiles]
    J --> J3[Request Service]
    J --> J4[Manage Bookings]
    J --> J5[In-App Messaging]
    
    K --> K1[View Booking Requests]
    K --> K2[Accept/Decline Requests]
    K --> K3[Manage Schedule]
    K --> K4[Update Profile]
    K --> K5[In-App Messaging]
    
    %% Error Handling
    D2 --> L{Forgot Password?}
    L -->|Yes| M[Password Reset Flow]
    M --> M1[Enter Email]
    M1 --> M2[Send Reset Link]
    M2 --> M3[Check Email]
    M3 --> M4[Click Reset Link]
    M4 --> M5[Enter New Password]
    M5 --> M6[Password Updated]
    M6 --> D1
```

## Detailed Login Flow Components

### 1. Initial App Entry
- User opens the HydraClean mobile app
- System checks for existing authentication tokens
- If authenticated, redirect to appropriate dashboard
- If not authenticated, show login/registration options

### 2. User Registration Flow
- **User Type Selection**: Client or Maid
- **Client Registration**:
  - Basic details: Name, Email, Password, Service Address
  - Email verification required
- **Maid Registration**:
  - Basic details: Name, Email, Password, Phone Number
  - Profile creation: Photo, Bio, Services offered, Availability, Hourly rate
  - Identity verification: Email/Phone confirmation
  - Initial vetting process

### 3. Login Authentication
- **Credential Entry**: Email and password input
- **Validation**: Server-side credential verification
- **Account Status Check**: Verify account is active and verified
- **Error Handling**: Clear error messages for invalid credentials

### 4. Post-Login Routing
- **Client Dashboard**: Search functionality, booking management, messaging
- **Maid Dashboard**: Request management, schedule, profile updates

### 5. Security Features
- **Password Reset**: Secure email-based password recovery
- **Account Verification**: Email confirmation required for account activation
- **Session Management**: Secure token-based authentication
- **Data Protection**: SSL encryption for all communications

## Technical Implementation Notes

### Frontend Components
- Login form with email/password fields
- Registration forms for both user types
- Password reset functionality
- Error message display
- Loading states during authentication

### Backend Services
- User authentication API endpoints
- Email verification service
- Password hashing and validation
- Session management
- User profile management

### Database Schema
- Users table with role differentiation
- Email verification tokens
- Password reset tokens
- User profiles (maid-specific fields)

## User Experience Considerations

### For Clients
- Simple, quick registration process
- Clear value proposition during onboarding
- Easy access to maid search functionality

### For Maids
- Comprehensive profile setup
- Verification process for trust building
- Clear dashboard for managing requests

### Security & Trust
- Transparent verification process
- Clear communication about platform fees
- Secure payment processing integration
- Privacy protection for personal information

## Success Metrics
- Registration completion rate
- Login success rate
- Time to first booking (clients)
- Time to first request acceptance (maids)
- User retention after first week
