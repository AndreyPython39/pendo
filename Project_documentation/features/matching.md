# Matching Feature

## Overview
Advanced matching system that connects users based on preferences, interests, and location.

## Components

### 1. Profile Matching
- Location-based matching
- Interest matching
- Preference matching
- Compatibility scoring
- Smart recommendations

### 2. Discovery Features
- Card swiping
- Super likes
- Boosts
- Rewind
- Match queue

### 3. Filter Options
- Distance
- Age range
- Interests
- Relationship goals
- Advanced filters (Premium)

## Database Schema

### Matches Table
```sql
CREATE TABLE matches (
    id UUID PRIMARY KEY,
    user1_id UUID REFERENCES users(id),
    user2_id UUID REFERENCES users(id),
    match_score FLOAT,
    status VARCHAR(50),
    matched_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user1_id, user2_id)
);
```

### Swipes Table
```sql
CREATE TABLE swipes (
    id UUID PRIMARY KEY,
    swiper_id UUID REFERENCES users(id),
    swiped_id UUID REFERENCES users(id),
    direction VARCHAR(10),
    is_super BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### User Preferences Table
```sql
CREATE TABLE user_preferences (
    user_id UUID PRIMARY KEY REFERENCES users(id),
    min_age INT,
    max_age INT,
    distance_radius INT,
    gender_preference VARCHAR(50)[],
    relationship_goals VARCHAR(50)[],
    deal_breakers JSONB,
    interests VARCHAR(255)[],
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## Matching Algorithm

### Score Components
1. Location Score (30%)
   - Distance between users
   - Activity areas overlap

2. Interest Score (25%)
   - Common interests
   - Interest categories
   - Activity preferences

3. Preference Score (25%)
   - Age compatibility
   - Gender preference
   - Relationship goals

4. Activity Score (20%)
   - Response rate
   - Profile completeness
   - Account activity

### Formula
```python
def calculate_match_score(user1, user2):
    location_score = calculate_location_score(user1, user2)
    interest_score = calculate_interest_score(user1, user2)
    preference_score = calculate_preference_score(user1, user2)
    activity_score = calculate_activity_score(user1, user2)
    
    total_score = (
        location_score * 0.3 +
        interest_score * 0.25 +
        preference_score * 0.25 +
        activity_score * 0.2
    )
    
    return total_score
```

## API Endpoints

### Discovery
```
GET /api/v1/matching/cards
POST /api/v1/matching/swipe
POST /api/v1/matching/superlike
POST /api/v1/matching/boost
POST /api/v1/matching/rewind
```

### Matches
```
GET /api/v1/matches
GET /api/v1/matches/{id}
DELETE /api/v1/matches/{id}
```

### Preferences
```
GET /api/v1/preferences
PUT /api/v1/preferences
PATCH /api/v1/preferences/location
```

## Mobile Implementation

### Models
- MatchModel
- SwipeModel
- PreferenceModel
- CardModel
- LocationModel

### BLoC Pattern
- MatchingBloc
- SwipeBloc
- PreferenceBloc

### UI Components
- DiscoveryPage
- SwipeCard
- MatchDialog
- PreferencePage
- FilterSheet

## Performance Optimization

### Caching
- Profile cards caching
- Match results caching
- Preference caching
- Location caching

### Background Processing
- Match calculation
- Score updates
- Location updates
- Recommendation updates

### Data Management
- Card preloading
- Image preloading
- Data pagination
- Cache invalidation

## Analytics

### Tracked Events
- Swipe actions
- Match creation
- Chat initiation
- Filter usage
- Feature engagement

### Metrics
- Match rate
- Response rate
- Engagement rate
- Feature usage
- User retention

## Error Handling

### Common Errors
- No cards available
- Location unavailable
- Invalid swipe
- Rate limiting
- Network issues

### Error Recovery
- Retry mechanisms
- Fallback options
- Cache usage
- User feedback

## Future Enhancements

1. Matching Features
   - AI-powered matching
   - Behavioral matching
   - Voice matching
   - Video matching

2. Discovery Features
   - Virtual dates
   - Ice breakers
   - Guided chat
   - Match suggestions

3. Premium Features
   - Global search
   - Advanced filters
   - Priority matching
   - Match insights
