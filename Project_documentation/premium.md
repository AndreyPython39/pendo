# Premium Features Documentation

## Overview
Premium features provide additional functionality and benefits to paying users, enhancing their experience with advanced matching, communication, and visibility options.

## Database Schema

### Subscriptions Table
```sql
CREATE TABLE subscriptions (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    period VARCHAR(50) NOT NULL,
    features JSONB NOT NULL,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Purchases Table
```sql
CREATE TABLE purchases (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    subscription_id UUID REFERENCES subscriptions(id),
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    status VARCHAR(50) NOT NULL,
    platform_transaction_id VARCHAR(255),
    receipt TEXT,
    purchase_date TIMESTAMP WITH TIME ZONE NOT NULL,
    expiry_date TIMESTAMP WITH TIME ZONE,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Feature Access Table
```sql
CREATE TABLE feature_access (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    feature_id VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    is_enabled BOOLEAN DEFAULT false,
    limit_count INTEGER DEFAULT 0,
    used_count INTEGER DEFAULT 0,
    expiry_date TIMESTAMP WITH TIME ZONE,
    metadata JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## Premium Features

### Advanced Matching
- See who liked you
- Advanced filters (age, location, interests)
- Extended search radius
- Unlimited likes
- Super likes
- Rewind last swipe
- Passport (change location)

### Enhanced Communication
- Priority messages
- Read receipts
- Voice messages
- Video calls
- Send gifts
- Custom message themes

### Profile Enhancements
- Profile boost
- Verified badge
- Custom profile themes
- Additional photos
- Profile statistics
- Hide ads

### Tribe Features
- Create unlimited tribes
- Premium tribe badges
- Advanced tribe analytics
- Custom tribe themes
- Extended event management

## API Endpoints

### Subscriptions
- GET /subscriptions - List available subscriptions
- GET /subscriptions/active - Get active subscription
- POST /subscriptions/{id}/purchase - Purchase subscription
- POST /subscriptions/cancel - Cancel subscription
- POST /subscriptions/restore - Restore purchases

### Features
- GET /premium/features - List feature access
- GET /premium/features/{id}/access - Check feature access
- POST /premium/features/{id}/consume - Consume feature usage

## Mobile Implementation

### Models
- SubscriptionModel: Subscription details
- PurchaseModel: Purchase information
- FeatureAccessModel: Feature access status

### BLoC Pattern
- PremiumBloc: Manages premium state
- Events: Load, Purchase, Cancel, Restore
- States: Initial, Loading, Loaded, Error

### UI Components
- PremiumPage: Main premium features page
- SubscriptionCard: Subscription option display
- FeatureList: Available features list
- PurchaseDialog: Purchase confirmation

## Payment Integration

### Platforms
- Apple App Store
- Google Play Store
- Stripe (Web)

### Features
- Secure payment processing
- Receipt validation
- Subscription management
- Purchase restoration
- Refund handling

## Analytics

### Tracked Metrics
- Conversion rate
- Revenue per user
- Churn rate
- Feature usage
- Subscription length
- Popular features

### Reports
- Revenue analytics
- User engagement
- Feature popularity
- Churn analysis
- A/B test results

## Security

### Payment Security
- PCI compliance
- Secure token storage
- Receipt validation
- Fraud prevention

### Access Control
- Feature access validation
- Subscription verification
- Usage monitoring
- Rate limiting

## Future Enhancements

1. Subscription Tiers
   - Basic Premium
   - Premium Plus
   - Premium Elite

2. Feature Bundles
   - Communication Bundle
   - Matching Bundle
   - Tribe Bundle

3. Promotional Features
   - Free trials
   - Referral rewards
   - Special offers
   - Holiday promotions

4. Advanced Analytics
   - Predictive analytics
   - Personalized recommendations
   - Usage patterns
   - Revenue optimization
