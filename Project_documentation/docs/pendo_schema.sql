-- Основные таблицы для MVP Pendo
CREATE TABLE users (
    id UUID PRIMARY KEY,
    email TEXT UNIQUE,
    phone TEXT,
    password_hash TEXT,
    is_verified BOOLEAN DEFAULT FALSE,
    role TEXT DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_profiles (
    user_id UUID PRIMARY KEY REFERENCES users(id),
    birthdate DATE,
    gender TEXT,
    looking_for TEXT,
    bio TEXT,
    interests TEXT[],
    temperament TEXT,
    extra_data JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE photos (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    url TEXT,
    status TEXT DEFAULT 'pending',
    moderated_by UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE likes (
    id UUID PRIMARY KEY,
    from_user UUID REFERENCES users(id),
    to_user UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE matches (
    id UUID PRIMARY KEY,
    user1 UUID REFERENCES users(id),
    user2 UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE messages (
    id UUID PRIMARY KEY,
    chat_id UUID,
    sender_id UUID REFERENCES users(id),
    content TEXT,
    message_type TEXT DEFAULT 'text',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tribes (
    id UUID PRIMARY KEY,
    name TEXT,
    description TEXT,
    status TEXT DEFAULT 'pending',
    created_by UUID REFERENCES users(id),
    moderated_by UUID,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tribe_members (
    tribe_id UUID REFERENCES tribes(id),
    user_id UUID REFERENCES users(id),
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (tribe_id, user_id)
);

CREATE TABLE tribe_votes (
    tribe_id UUID REFERENCES tribes(id),
    voter_id UUID REFERENCES users(id),
    candidate_id UUID REFERENCES users(id),
    voted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (tribe_id, voter_id)
);

CREATE TABLE reports (
    id UUID PRIMARY KEY,
    reporter_id UUID REFERENCES users(id),
    target_type TEXT,
    target_id UUID,
    reason TEXT,
    status TEXT DEFAULT 'new',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_scores (
    user_id UUID PRIMARY KEY REFERENCES users(id),
    score INTEGER DEFAULT 0,
    level TEXT DEFAULT 'novice',
    last_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE
);

CREATE TABLE moderation_logs (
    id UUID PRIMARY KEY,
    moderator_id UUID REFERENCES users(id),
    target_type TEXT,
    target_id UUID,
    action TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE subscriptions (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    type TEXT,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);