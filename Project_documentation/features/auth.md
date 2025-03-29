# Authentication Feature

## Overview
Authentication system provides secure user registration, login, and account management functionality.

## Components

### 1. User Management
- Registration
- Login
- Password reset
- Account verification
- Profile management
- Session management

### 2. Social Authentication
- Google Sign-In
- Apple Sign-In
- Facebook Login
- Phone number verification

### 3. Security Features
- JWT tokens
- Refresh tokens
- Biometric authentication
- Two-factor authentication
- Device management

## Database Schema

### Users Table
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY,
    phone_number VARCHAR(15) UNIQUE,
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255),
    full_name VARCHAR(255),
    birth_date DATE,
    gender VARCHAR(50),
    bio TEXT,
    profile_photo_url VARCHAR(255),
    location_lat FLOAT,
    location_lon FLOAT,
    last_active TIMESTAMP WITH TIME ZONE,
    account_status VARCHAR(50),
    is_verified BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Sessions Table
```sql
CREATE TABLE sessions (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    refresh_token VARCHAR(255),
    device_id VARCHAR(255),
    device_type VARCHAR(50),
    ip_address VARCHAR(45),
    expires_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Verification Codes Table
```sql
CREATE TABLE verification_codes (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    code VARCHAR(6),
    type VARCHAR(50),
    expires_at TIMESTAMP WITH TIME ZONE,
    attempts INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## API Endpoints

### Authentication
```
POST /api/v1/auth/register
POST /api/v1/auth/login
POST /api/v1/auth/refresh
POST /api/v1/auth/logout
POST /api/v1/auth/verify
POST /api/v1/auth/resend-code
POST /api/v1/auth/reset-password
POST /api/v1/auth/change-password
```

### Social Authentication
```
POST /api/v1/auth/social/google
POST /api/v1/auth/social/apple
POST /api/v1/auth/social/facebook
```

### Profile Management
```
GET /api/v1/profile
PUT /api/v1/profile
PATCH /api/v1/profile/photo
DELETE /api/v1/profile
```

### Session Management
```
GET /api/v1/sessions
DELETE /api/v1/sessions/{id}
DELETE /api/v1/sessions/all
```

## Mobile Implementation

### Models
- UserModel
- SessionModel
- AuthCredentials
- VerificationCode
- SocialAuthData

### BLoC Pattern
- AuthBloc
- ProfileBloc
- SessionBloc

### UI Components
- LoginPage
- RegisterPage
- VerificationPage
- ProfilePage
- SettingsPage

## Security Measures

### Token Security
- Short-lived access tokens (1 hour)
- Secure token storage
- Token rotation
- Blacklisting

### Password Security
- Strong password requirements
- Bcrypt hashing
- Rate limiting
- Brute force protection

### Session Security
- Device fingerprinting
- Suspicious activity detection
- Automatic session termination
- Location validation

## Analytics

### Tracked Events
- Registration attempts
- Login success/failure
- Password resets
- Profile updates
- Session management
- Verification attempts

### Metrics
- Active users
- Registration success rate
- Login success rate
- Verification success rate
- Session duration
- Device distribution

## Error Handling

### Common Errors
- Invalid credentials
- Account not found
- Account locked
- Invalid verification code
- Session expired
- Rate limit exceeded

### Error Responses
```json
{
  "error": {
    "code": "AUTH001",
    "message": "Invalid credentials",
    "details": {
      "field": "password",
      "reason": "incorrect_password"
    }
  }
}
```

## Future Enhancements

1. Authentication Methods
   - Passwordless login
   - WebAuthn support
   - Hardware key support
   - Magic link authentication

2. Security Features
   - Risk-based authentication
   - Behavioral analysis
   - Fraud detection
   - IP reputation checking

3. Profile Features
   - Multiple photos
   - Video verification
   - Social links
   - Interests management
