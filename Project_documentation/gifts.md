# Gifts Feature

## Overview
Virtual gift system that enables users to send and receive virtual gifts using in-app currency.

## Components

### 1. Gift Management
- Gift catalog
- Gift sending
- Gift receiving
- Gift history
- Gift animations

### 2. Currency System
- Coin purchases
- Coin balance
- Transaction history
- Refund system
- Premium packages

### 3. Gift Features
- Animated gifts
- Special effects
- Custom messages
- Anonymous giving
- Gift collections

## Database Schema

### Gifts Table
```sql
CREATE TABLE gifts (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image_url VARCHAR(255) NOT NULL,
    animation_url VARCHAR(255),
    coins INT NOT NULL,
    is_animated BOOLEAN DEFAULT false,
    is_premium BOOLEAN DEFAULT false,
    is_limited BOOLEAN DEFAULT false,
    available_until TIMESTAMP WITH TIME ZONE,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Gift Transactions Table
```sql
CREATE TABLE gift_transactions (
    id UUID PRIMARY KEY,
    sender_id UUID REFERENCES users(id),
    receiver_id UUID REFERENCES users(id),
    gift_id UUID REFERENCES gifts(id),
    coins INT NOT NULL,
    message TEXT,
    is_anonymous BOOLEAN DEFAULT false,
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Coin Packages Table
```sql
CREATE TABLE coin_packages (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    coins INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    is_popular BOOLEAN DEFAULT false,
    is_limited BOOLEAN DEFAULT false,
    discount_percent INT,
    available_until TIMESTAMP WITH TIME ZONE,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## API Endpoints

### Gift Management
```
GET /api/v1/gifts
GET /api/v1/gifts/{id}
POST /api/v1/gifts/send
GET /api/v1/gifts/received
GET /api/v1/gifts/sent
```

### Coin Management
```
GET /api/v1/coins/balance
GET /api/v1/coins/packages
POST /api/v1/coins/purchase
GET /api/v1/coins/transactions
```

### Gift Features
```
GET /api/v1/gifts/popular
GET /api/v1/gifts/new
GET /api/v1/gifts/limited
GET /api/v1/gifts/collections
```

## Mobile Implementation

### Models
- GiftModel
- GiftTransactionModel
- CoinPackageModel
- GiftAnimationModel

### BLoC Pattern
- GiftBloc
- CoinBloc
- TransactionBloc
- AnimationBloc

### UI Components
- GiftCatalogPage
- GiftDetailPage
- SendGiftSheet
- CoinShopPage
- TransactionHistoryPage

## Features

### Gift System
- Gift categories
- Gift preview
- Gift animations
- Gift messages
- Gift history

### Coin System
- Coin packages
- Purchase flow
- Balance tracking
- Transaction history
- Refund process

### Social Features
- Gift notifications
- Gift reactions
- Gift leaderboard
- Gift collections
- Gift achievements

## Analytics

### Tracked Events
- Gift sends
- Gift views
- Coin purchases
- Feature usage
- User engagement

### Metrics
- Popular gifts
- Purchase rate
- Gift economy
- User spending
- Feature adoption

## Error Handling

### Common Errors
- Insufficient coins
- Purchase failure
- Network issues
- Animation loading
- Invalid gift

### Error Recovery
- Purchase retry
- Coin refund
- Offline cache
- Fallback images
- Error messages

## Future Enhancements

1. Gift Features
   - Custom gifts
   - Gift combos
   - Gift challenges
   - Gift stories
   - Gift rooms

2. Coin Features
   - Subscription model
   - Reward system
   - VIP tiers
   - Coin sharing
   - Coin games

3. Social Features
   - Gift streaming
   - Gift battles
   - Gift events
   - Gift missions
   - Gift communities
