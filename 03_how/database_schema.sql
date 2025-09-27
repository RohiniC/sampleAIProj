-- HydraClean MVP Database Schema
-- Version: 1.0
-- Date: January 2025
-- Description: Complete database schema for HydraClean platform

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create custom types
CREATE TYPE user_type AS ENUM ('client', 'maid');
CREATE TYPE booking_status AS ENUM ('pending', 'accepted', 'rejected', 'completed', 'cancelled');
CREATE TYPE payment_status AS ENUM ('pending', 'completed', 'failed', 'refunded');
CREATE TYPE notification_type AS ENUM ('booking_request', 'booking_accepted', 'booking_rejected', 'message', 'payment', 'system');

-- Users table (core authentication)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    user_type user_type NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Client profiles
CREATE TABLE client_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    service_address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    preferred_contact_method VARCHAR(20) DEFAULT 'app',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Maid profiles
CREATE TABLE maid_profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    bio TEXT,
    hourly_rate DECIMAL(10, 2) NOT NULL,
    services TEXT[] NOT NULL, -- Array of services offered
    availability JSONB, -- Weekly availability schedule
    service_radius INTEGER DEFAULT 10, -- Miles from location
    is_available BOOLEAN DEFAULT TRUE,
    profile_photo_url VARCHAR(500),
    background_check_status VARCHAR(20) DEFAULT 'pending',
    years_experience INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Maid location for search optimization
CREATE TABLE maid_locations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    maid_id UUID NOT NULL REFERENCES maid_profiles(id) ON DELETE CASCADE,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    is_primary BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Bookings
CREATE TABLE bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    maid_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    service_type VARCHAR(100) NOT NULL,
    description TEXT,
    scheduled_date TIMESTAMP NOT NULL,
    duration_hours DECIMAL(4, 2) NOT NULL,
    hourly_rate DECIMAL(10, 2) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    platform_fee DECIMAL(10, 2) NOT NULL,
    maid_earnings DECIMAL(10, 2) NOT NULL,
    status booking_status DEFAULT 'pending',
    client_notes TEXT,
    maid_notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Messages between users
CREATE TABLE messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL REFERENCES bookings(id) ON DELETE CASCADE,
    sender_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    receiver_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Reviews and ratings
CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL REFERENCES bookings(id) ON DELETE CASCADE,
    reviewer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    reviewee_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Payment transactions
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL REFERENCES bookings(id) ON DELETE CASCADE,
    client_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    maid_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    amount DECIMAL(10, 2) NOT NULL,
    platform_fee DECIMAL(10, 2) NOT NULL,
    maid_payout DECIMAL(10, 2) NOT NULL,
    stripe_payment_intent_id VARCHAR(255),
    stripe_transfer_id VARCHAR(255),
    status payment_status DEFAULT 'pending',
    processed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Notifications
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type notification_type NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    data JSONB, -- Additional notification data
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- User sessions for device tracking
CREATE TABLE user_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    device_id VARCHAR(255) NOT NULL,
    device_type VARCHAR(50) NOT NULL,
    ip_address INET,
    user_agent TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    last_activity TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Audit log for security and compliance
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    action VARCHAR(100) NOT NULL,
    resource_type VARCHAR(50) NOT NULL,
    resource_id UUID,
    old_values JSONB,
    new_values JSONB,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes for performance optimization
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_type ON users(user_type);
CREATE INDEX idx_users_verified ON users(is_verified);

CREATE INDEX idx_client_profiles_user_id ON client_profiles(user_id);
CREATE INDEX idx_client_profiles_location ON client_profiles(city, state, zip_code);

CREATE INDEX idx_maid_profiles_user_id ON maid_profiles(user_id);
CREATE INDEX idx_maid_profiles_available ON maid_profiles(is_available);
CREATE INDEX idx_maid_profiles_rate ON maid_profiles(hourly_rate);

CREATE INDEX idx_maid_locations_maid_id ON maid_locations(maid_id);
CREATE INDEX idx_maid_locations_coordinates ON maid_locations(latitude, longitude);
CREATE INDEX idx_maid_locations_zip ON maid_locations(zip_code);

CREATE INDEX idx_bookings_client_id ON bookings(client_id);
CREATE INDEX idx_bookings_maid_id ON bookings(maid_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_date ON bookings(scheduled_date);

CREATE INDEX idx_messages_booking_id ON messages(booking_id);
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_receiver ON messages(receiver_id);
CREATE INDEX idx_messages_created ON messages(created_at);

CREATE INDEX idx_reviews_booking_id ON reviews(booking_id);
CREATE INDEX idx_reviews_reviewee ON reviews(reviewee_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);

CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_payments_client_id ON payments(client_id);
CREATE INDEX idx_payments_maid_id ON payments(maid_id);
CREATE INDEX idx_payments_status ON payments(status);

CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_type ON notifications(type);
CREATE INDEX idx_notifications_read ON notifications(is_read);

CREATE INDEX idx_user_sessions_user_id ON user_sessions(user_id);
CREATE INDEX idx_user_sessions_device ON user_sessions(device_id);
CREATE INDEX idx_user_sessions_active ON user_sessions(is_active);

CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_action ON audit_logs(action);
CREATE INDEX idx_audit_logs_created ON audit_logs(created_at);

-- Triggers for updated_at timestamps
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_client_profiles_updated_at BEFORE UPDATE ON client_profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_maid_profiles_updated_at BEFORE UPDATE ON maid_profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON bookings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Views for common queries
CREATE VIEW active_maids AS
SELECT 
    u.id as user_id,
    mp.id as profile_id,
    mp.first_name,
    mp.last_name,
    mp.hourly_rate,
    mp.services,
    mp.availability,
    mp.profile_photo_url,
    ml.city,
    ml.state,
    ml.latitude,
    ml.longitude,
    AVG(r.rating) as average_rating,
    COUNT(r.id) as review_count
FROM users u
JOIN maid_profiles mp ON u.id = mp.user_id
LEFT JOIN maid_locations ml ON mp.id = ml.maid_id
LEFT JOIN reviews r ON u.id = r.reviewee_id
WHERE u.is_active = TRUE 
  AND u.is_verified = TRUE 
  AND mp.is_available = TRUE
GROUP BY u.id, mp.id, ml.city, ml.state, ml.latitude, ml.longitude;

CREATE VIEW booking_summary AS
SELECT 
    b.id,
    b.client_id,
    b.maid_id,
    cp.first_name as client_name,
    mp.first_name as maid_name,
    b.service_type,
    b.scheduled_date,
    b.duration_hours,
    b.total_amount,
    b.status,
    b.created_at
FROM bookings b
JOIN client_profiles cp ON b.client_id = cp.user_id
JOIN maid_profiles mp ON b.maid_id = mp.user_id;

-- Sample data for testing
INSERT INTO users (email, password_hash, user_type, is_verified) VALUES
('client1@example.com', '$2b$10$example_hash', 'client', true),
('maid1@example.com', '$2b$10$example_hash', 'maid', true),
('maid2@example.com', '$2b$10$example_hash', 'maid', true);

INSERT INTO client_profiles (user_id, first_name, last_name, service_address, city, state, zip_code) VALUES
((SELECT id FROM users WHERE email = 'client1@example.com'), 'John', 'Smith', '123 Main St', 'San Francisco', 'CA', '94102');

INSERT INTO maid_profiles (user_id, first_name, last_name, phone, bio, hourly_rate, services) VALUES
((SELECT id FROM users WHERE email = 'maid1@example.com'), 'Maria', 'Garcia', '555-0123', 'Professional cleaner with 10+ years experience', 35.00, ARRAY['Basic Cleaning', 'Deep Cleaning']),
((SELECT id FROM users WHERE email = 'maid2@example.com'), 'Sarah', 'Johnson', '555-0124', 'Eco-friendly cleaning specialist', 28.00, ARRAY['Eco-Friendly', 'Pet-Friendly']);

-- Comments for documentation
COMMENT ON TABLE users IS 'Core user authentication and basic information';
COMMENT ON TABLE client_profiles IS 'Extended profile information for clients';
COMMENT ON TABLE maid_profiles IS 'Extended profile information for maids including services and rates';
COMMENT ON TABLE maid_locations IS 'Maid service locations for geographic search';
COMMENT ON TABLE bookings IS 'Service booking requests and confirmations';
COMMENT ON TABLE messages IS 'In-app messaging between clients and maids';
COMMENT ON TABLE reviews IS 'Mutual ratings and reviews between users';
COMMENT ON TABLE payments IS 'Payment transactions and payouts';
COMMENT ON TABLE notifications IS 'User notifications and alerts';
COMMENT ON TABLE user_sessions IS 'Active user sessions for device tracking';
COMMENT ON TABLE audit_logs IS 'Security and compliance audit trail';
