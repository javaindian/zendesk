-- Migration: 001_initial_schema.sql

-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Client Organizations
CREATE TABLE clients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    domain VARCHAR(255) UNIQUE,
    configuration JSONB,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- User Roles Enum and Table
CREATE TYPE user_role_enum AS ENUM ('agent', 'supervisor', 'admin', 'client_user');

CREATE TABLE user_roles (
    id SERIAL PRIMARY KEY,
    name user_role_enum UNIQUE NOT NULL,
    description TEXT
);

-- Users Table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    role_id INTEGER NOT NULL REFERENCES user_roles(id),
    is_active BOOLEAN DEFAULT TRUE,
    last_login_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE (client_id, email)
);
CREATE INDEX idx_users_client_id_email ON users(client_id, email);
CREATE INDEX idx_users_role_id ON users(role_id);

-- Ticket Enums
CREATE TYPE ticket_status_enum AS ENUM ('Open', 'In Progress', 'Pending', 'Resolved', 'Closed');
CREATE TYPE ticket_priority_enum AS ENUM ('Low', 'Medium', 'High', 'Urgent');
CREATE TYPE ticket_type_enum AS ENUM ('Incident', 'Question', 'Problem', 'Feature Request');

-- Tickets Table
CREATE TABLE tickets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
    subject VARCHAR(255) NOT NULL,
    description TEXT,
    status ticket_status_enum DEFAULT 'Open',
    priority ticket_priority_enum DEFAULT 'Medium',
    type ticket_type_enum DEFAULT 'Incident',
    created_by_user_id UUID REFERENCES users(id) ON DELETE SET NULL, -- User who created the ticket
    requester_email VARCHAR(255), -- For tickets from unregistered users or direct email
    requester_name VARCHAR(255),
    assigned_to_agent_id UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    resolved_at TIMESTAMPTZ,
    closed_at TIMESTAMPTZ
    -- No tags, due_date, assigned_to_team_id in MVP
);
CREATE INDEX idx_tickets_client_id ON tickets(client_id);
CREATE INDEX idx_tickets_status ON tickets(status);
CREATE INDEX idx_tickets_assigned_to_agent_id ON tickets(assigned_to_agent_id);
CREATE INDEX idx_tickets_created_by_user_id ON tickets(created_by_user_id);

-- Ticket Replies Enum and Table
CREATE TYPE reply_type_enum AS ENUM ('public', 'internal');

CREATE TABLE ticket_replies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ticket_id UUID NOT NULL REFERENCES tickets(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE, -- User who made the reply
    body TEXT NOT NULL,
    type reply_type_enum DEFAULT 'public',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX idx_ticket_replies_ticket_id ON ticket_replies(ticket_id);
CREATE INDEX idx_ticket_replies_user_id ON ticket_replies(user_id);

-- Function to update 'updated_at' timestamp
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply the trigger to tables
CREATE TRIGGER set_timestamp_clients
BEFORE UPDATE ON clients
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

CREATE TRIGGER set_timestamp_users
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

CREATE TRIGGER set_timestamp_tickets
BEFORE UPDATE ON tickets
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

CREATE TRIGGER set_timestamp_ticket_replies
BEFORE UPDATE ON ticket_replies
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();
