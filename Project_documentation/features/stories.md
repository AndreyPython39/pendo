# Stories Feature Documentation

## Overview
Stories feature allows users to share temporary content that expires after 24 hours, similar to Instagram Stories or WhatsApp Status.

## Database Schema

### Stories Table
```sql
CREATE TABLE stories (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    media_type VARCHAR NOT NULL,
    media_url VARCHAR NOT NULL,
    thumbnail_url VARCHAR,
    caption VARCHAR,
    views_count INTEGER DEFAULT 0,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Story Views Table
```sql
CREATE TABLE story_views (
    id INTEGER PRIMARY KEY,
    story_id INTEGER NOT NULL,
    viewer_id INTEGER NOT NULL,
    viewed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    FOREIGN KEY (story_id) REFERENCES stories(id),
    FOREIGN KEY (viewer_id) REFERENCES users(id)
);
```

## API Endpoints

### GET /stories
Get stories from followed users and tribes.

Response:
```json
{
    "stories": [
        {
            "id": 1,
            "userId": 123,
            "mediaType": "image",
            "mediaUrl": "https://...",
            "thumbnailUrl": "https://...",
            "caption": "At the beach!",
            "viewsCount": 42,
            "expiresAt": "2025-03-30T23:20:17Z",
            "createdAt": "2025-03-29T23:20:17Z",
            "isViewed": false
        }
    ]
}
```

### POST /stories
Create a new story.

Request:
```json
{
    "mediaType": "image",
    "mediaUrl": "https://...",
    "caption": "Optional caption"
}
```

### POST /stories/{id}/view
Mark a story as viewed.

### DELETE /stories/{id}
Delete a story.

## Mobile Implementation

### Models
- StoryModel: Represents a story with its metadata
- StoryViewerModel: Tracks story views

### BLoC Pattern
- StoriesBloc: Manages stories state and operations
- Events: Load, Create, View, Delete
- States: Initial, Loading, Loaded, Error

### UI Components
- StoriesPage: Main page showing all stories
- StoryViewer: Full-screen story viewer
- StoryCreationSheet: Bottom sheet for creating stories

### Features
- Story creation with image/video
- View count tracking
- Automatic expiry after 24 hours
- Story deletion
- View status tracking

## Performance Optimizations

### Database
- Indexes on user_id and expires_at
- Regular cleanup of expired stories
- Partitioning for large-scale deployments

### Storage
- Thumbnail generation for videos
- Image optimization
- CDN integration

### Caching
- Redis caching for active stories
- Local caching on mobile devices

## Security Considerations

- Media upload validation
- User authentication for story creation
- Privacy settings for story visibility
- Rate limiting for story creation
- Content moderation integration
