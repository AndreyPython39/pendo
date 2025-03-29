# Tribes Feature Documentation

## Overview
Tribes are communities within Pendo that allow users to form groups based on shared interests, cultures, or locations. Each tribe has its own hierarchy, events, and voting system.

## Database Schema

### Tribes Table
```sql
CREATE TABLE tribes (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    avatar VARCHAR(255),
    cover_image VARCHAR(255),
    chief_id UUID REFERENCES users(id),
    status VARCHAR(50) DEFAULT 'active',
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Tribe Members Table
```sql
CREATE TABLE tribe_members (
    id UUID PRIMARY KEY,
    tribe_id UUID REFERENCES tribes(id),
    user_id UUID REFERENCES users(id),
    role VARCHAR(50) DEFAULT 'member',
    joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(tribe_id, user_id)
);
```

### Tribe Events Table
```sql
CREATE TABLE tribe_events (
    id UUID PRIMARY KEY,
    tribe_id UUID REFERENCES tribes(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    start_time TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE NOT NULL,
    location VARCHAR(255),
    coordinates POINT,
    max_attendees INTEGER,
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Tribe Votes Table
```sql
CREATE TABLE tribe_votes (
    id UUID PRIMARY KEY,
    tribe_id UUID REFERENCES tribes(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    options JSONB NOT NULL,
    start_time TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    end_time TIMESTAMP WITH TIME ZONE NOT NULL,
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## API Endpoints

### Tribes
- GET /tribes - List tribes
- POST /tribes - Create tribe
- GET /tribes/{id} - Get tribe details
- PUT /tribes/{id} - Update tribe
- DELETE /tribes/{id} - Delete tribe
- POST /tribes/{id}/join - Join tribe
- POST /tribes/{id}/leave - Leave tribe
- GET /tribes/{id}/members - List tribe members
- POST /tribes/{id}/moderators - Add moderator
- DELETE /tribes/{id}/moderators/{userId} - Remove moderator
- POST /tribes/{id}/kick/{userId} - Kick member

### Events
- GET /tribes/{id}/events - List tribe events
- POST /tribes/{id}/events - Create event
- GET /tribes/{id}/events/{eventId} - Get event details
- PUT /tribes/{id}/events/{eventId} - Update event
- DELETE /tribes/{id}/events/{eventId} - Delete event
- POST /tribes/{id}/events/{eventId}/join - Join event
- POST /tribes/{id}/events/{eventId}/leave - Leave event

### Votes
- GET /tribes/{id}/votes - List tribe votes
- POST /tribes/{id}/votes - Create vote
- GET /tribes/{id}/votes/{voteId} - Get vote details
- POST /tribes/{id}/votes/{voteId}/cast - Cast vote
- GET /tribes/{id}/votes/active - Get active votes

## Mobile Implementation

### Models
- TribeModel: Basic tribe information
- TribeEventModel: Event details and attendees
- TribeVoteModel: Vote information and results
- TribeMemberModel: Member details with role

### BLoC Pattern
- TribesBloc: Manages tribes state and operations
- Events: Load, Create, Update, Delete, Join, Leave
- States: Initial, Loading, Loaded, Error

### UI Components
- TribesPage: Main tribes listing
- TribeDetailsPage: Individual tribe view
- TribeStatsCard: Statistics visualization
- TribeActivityFeed: Recent activities
- CreateVoteSheet: Vote creation interface
- VoteResultsDialog: Vote results visualization

### Features
- Tribe creation and management
- Member roles and permissions
- Events organization
- Democratic voting system
- Activity feed
- Statistics and analytics

## Performance Optimizations

### Database
- Indexes on frequently queried columns
- Partitioning for large tribes
- Materialized views for statistics

### Caching
- Redis caching for active tribes
- Local caching on mobile devices
- Cached tribe statistics

### Real-time Updates
- WebSocket for live updates
- Event sourcing for activity feed
- Optimistic UI updates

## Security Considerations

- Role-based access control
- Vote manipulation prevention
- Content moderation
- Rate limiting
- Audit logging

## Analytics

### Tracked Metrics
- Active members
- Event participation
- Voting engagement
- Member retention
- Growth rate

### Reports
- Daily active members
- Event attendance
- Vote participation
- Member demographics
- Activity patterns

## Future Enhancements

1. Tribe Categories
   - Interest-based grouping
   - Discovery improvements
   - Recommended tribes

2. Enhanced Events
   - Virtual events support
   - Ticket system
   - Event series

3. Advanced Voting
   - Multiple choice voting
   - Weighted voting
   - Polls with media

4. Gamification
   - Tribe achievements
   - Member rankings
   - Contribution rewards
