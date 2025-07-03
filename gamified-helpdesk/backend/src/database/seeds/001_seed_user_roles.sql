-- Seed initial user roles
INSERT INTO user_roles (name, description) VALUES
('agent', 'Can manage assigned tickets and create tickets.'),
('supervisor', 'Can manage team tickets, agents, and has agent capabilities. (Full functionality in later phase)'),
('admin', 'Full access to client organization settings, users, and tickets.'),
('client_user', 'Can create tickets and view their own tickets. (Portal functionality in later phase)')
ON CONFLICT (name) DO NOTHING; -- Avoid errors if run multiple times
