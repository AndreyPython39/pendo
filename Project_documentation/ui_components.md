# Pendo Mobile UI Components

## 1. Matching Components

### SwipeCard
A customizable card widget for displaying user profiles with African-styled animations:
- Profile photo with cultural gradient overlay
- User name, age, and premium status
- Distance information
- Bio preview with cultural prompts
- Top 3 interests
- Smooth animations with African motifs
- Cultural compatibility indicators

### SwipeButtons
A set of action buttons with African design elements:
- Like (heart icon with cultural pattern)
- Pass (X icon)
- Super Like (star icon with tribal motif)
- Rewind (premium only)
- Boost (premium only)

## 2. Chat Components

### ChatBubble
A message bubble widget with cultural theming:
- Different styles for sent and received messages
- Support for text, images, and cultural icebreakers
- African-themed stickers and reactions
- Timestamp display
- Read status indicator

### ChatInput
An input widget for rich messaging:
- Text input with emoji and cultural expressions
- Image/video attachment
- Voice messages
- Quick replies with cultural context
- African-themed sticker picker
- Typing indicator
- Send button animation

## 3. Tribes Components

### TribeCard
A card widget for displaying tribe information:
- Cover image with cultural overlay
- Tribal badge and status
- Name and member count
- Cultural description
- Activity stats
- Join/Leave button

### TribeEventCard
A card for cultural and social events:
- Date and time with local timezone
- Location with map preview
- Event type (cultural, social, etc.)
- Attendee list with avatars
- RSVP options
- Share button

### StoriesWidget
A widget for sharing and viewing stories:
- Story creation with cultural filters
- View count and reactions
- Cultural stickers and effects
- Duration indicator
- Reply options

### LiveStreamCard
A card for live streaming features:
- Live indicator
- Viewer count
- Stream preview
- Cultural tags
- Interaction buttons

## 4. Cultural Components

### CulturalPrompt
A widget for cultural questions and prompts:
- Rotating cultural questions
- Answer input
- Cultural context
- Share options

### VirtualGift
An African-themed virtual gift component:
- Gift animation
- Cultural significance
- Sender/receiver info
- Gift history

### CulturalEvent
A component for traditional events:
- Event details
- Cultural significance
- Participation options
- Share functionality

## 5. Design System

### Colors
```dart
class AppColors {
  // Brand colors with African inspiration
  static const primary = Color(0xFF6200EE);    // Royal Purple
  static const secondary = Color(0xFFE4A01B);   // African Gold
  static const accent = Color(0xFFD35400);      // Terracotta
  static const tribal = Color(0xFF27AE60);      // Savanna Green
  
  // Cultural palette
  static const earthRed = Color(0xFFC0392B);    // Earth Red
  static const sandYellow = Color(0xFFF1C40F);  // Sand Yellow
  static const oceanBlue = Color(0xFF2980B9);   // Ocean Blue
  static const forestGreen = Color(0xFF27AE60); // Forest Green
}
```

### Typography
```dart
class AppTextStyles {
  // Headers with African font family
  static const headline1 = TextStyle(
    fontFamily: 'AfricanSpirit',
    fontSize: 96,
    fontWeight: FontWeight.light,
  );
  
  // Body text optimized for multiple languages
  static const bodyText = TextStyle(
    fontFamily: 'NotoSans',
    fontSize: 16,
    height: 1.5,
  );
}
```

### Cultural Patterns
```dart
class CulturalPatterns {
  static const tribalPattern = BoxDecoration(
    // African-inspired patterns
  );
  
  static const traditionalBorder = BorderRadius.all(
    Radius.circular(16)
  );
}
```

## 6. Animations

### Cultural Animations
- Traditional dance-inspired movements
- Tribal pattern transitions
- Cultural celebration effects
- Traditional music integration

### Micro-interactions
- African-themed loading indicators
- Cultural success/error states
- Traditional gesture feedback
- Local sound effects

## 7. Accessibility

### Features
- Multi-language support (en, sw, zu, ru)
- Cultural context help
- Voice guidance
- High contrast themes

### Implementation
```dart
class AccessibilityConfig {
  static const culturalHints = true;
  static const voiceGuidance = true;
  static const localizedHelp = true;
}
```

## 8. Responsive Design

### Cultural Adaptations
- Right-to-left support
- Local date/time formats
- Cultural measurement units
- Regional adaptations
