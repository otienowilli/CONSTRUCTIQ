-- CONSTRUCTIQ Database Schema
-- PostgreSQL 15+

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Create ENUM types
CREATE TYPE user_role AS ENUM ('admin', 'engineer', 'supervisor', 'worker');
CREATE TYPE project_type AS ENUM ('building', 'road', 'bridge', 'infrastructure');
CREATE TYPE project_status AS ENUM ('planning', 'active', 'paused', 'completed');
CREATE TYPE material_category AS ENUM ('civil', 'roads', 'finishing', 'plumbing', 'electrical', 'structural', 'bitumen', 'asphalt', 'geotextiles', 'prefabricated', 'admixtures', 'recycled');
CREATE TYPE machine_type AS ENUM ('excavator', 'mixer', 'crane', 'bulldozer', 'compactor', 'batching_plant', 'bitumen_plant', 'crusher', 'screener', 'roller', 'pump', 'weighbridge', 'other');
CREATE TYPE machine_status AS ENUM ('active', 'idle', 'maintenance', 'offline', 'running', 'paused', 'error');
CREATE TYPE machine_command AS ENUM ('start', 'stop', 'pause', 'resume', 'emergency_stop');
CREATE TYPE sensor_type AS ENUM ('gps', 'camera', 'accelerometer', 'gyroscope', 'soil_moisture', 'soil_ph', 'penetrometer', 'water_level', 'flow_meter', 'load_cell', 'temperature', 'vibration', 'pressure', 'humidity');
CREATE TYPE report_type AS ENUM ('daily', 'weekly', 'monthly', 'final');
CREATE TYPE report_status AS ENUM ('draft', 'submitted', 'approved');

-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role user_role DEFAULT 'worker',
    phone VARCHAR(20),
    company VARCHAR(255),
    avatar TEXT,
    email_verified_at TIMESTAMP,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);

-- Projects table
CREATE TABLE projects (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    type project_type NOT NULL,
    status project_status DEFAULT 'planning',
    location GEOGRAPHY(POINT, 4326),
    address TEXT,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(15,2),
    soil_type VARCHAR(100),
    slope_percentage DECIMAL(5,2),
    weather_conditions JSONB,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Materials table
CREATE TABLE materials (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    category material_category NOT NULL,
    unit VARCHAR(50) NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    description TEXT,
    specifications JSONB,
    image_url TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Material Calculations table
CREATE TABLE material_calculations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    calculation_type VARCHAR(100) NOT NULL,
    inputs JSONB NOT NULL,
    results JSONB NOT NULL,
    materials_used JSONB,
    total_cost DECIMAL(15,2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Site Analysis table
CREATE TABLE site_analysis (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    location GEOGRAPHY(POINT, 4326),
    photos JSONB,
    soil_analysis JSONB,
    ai_recommendations JSONB,
    slope_data JSONB,
    weather_data JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Machines table
CREATE TABLE machines (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    type machine_type NOT NULL,
    model VARCHAR(255),
    serial_number VARCHAR(255) UNIQUE,
    status machine_status DEFAULT 'idle',
    project_id UUID REFERENCES projects(id) ON DELETE SET NULL,
    location GEOGRAPHY(POINT, 4326),
    specifications JSONB,
    mqtt_topic VARCHAR(255),
    plc_address VARCHAR(255),
    can_remote_control BOOLEAN DEFAULT false,
    last_maintenance TIMESTAMP,
    next_maintenance TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Machine Commands table (for remote control)
CREATE TABLE machine_commands (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    machine_id UUID NOT NULL REFERENCES machines(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    command machine_command NOT NULL,
    parameters JSONB,
    status VARCHAR(50) DEFAULT 'pending',
    executed_at TIMESTAMP,
    response JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sensor Logs table
CREATE TABLE sensor_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    machine_id UUID REFERENCES machines(id) ON DELETE CASCADE,
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    sensor_type sensor_type NOT NULL,
    value DECIMAL(10,2) NOT NULL,
    unit VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    location GEOGRAPHY(POINT, 4326),
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reports table
CREATE TABLE reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    type report_type NOT NULL,
    content JSONB NOT NULL,
    pdf_url TEXT,
    status report_status DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Chat Messages table
CREATE TABLE chat_messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    project_id UUID REFERENCES projects(id) ON DELETE SET NULL,
    message TEXT NOT NULL,
    response TEXT,
    context JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Activity Logs table
CREATE TABLE activity_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    action VARCHAR(255) NOT NULL,
    entity_type VARCHAR(100),
    entity_id UUID,
    changes JSONB,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Indexes
CREATE INDEX idx_projects_user_id ON projects(user_id);
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_location ON projects USING GIST(location);
CREATE INDEX idx_materials_category ON materials(category);
CREATE INDEX idx_material_calculations_project_id ON material_calculations(project_id);
CREATE INDEX idx_site_analysis_project_id ON site_analysis(project_id);
CREATE INDEX idx_machines_project_id ON machines(project_id);
CREATE INDEX idx_machines_status ON machines(status);
CREATE INDEX idx_machine_commands_machine_id ON machine_commands(machine_id);
CREATE INDEX idx_machine_commands_status ON machine_commands(status);
CREATE INDEX idx_sensor_logs_machine_id ON sensor_logs(machine_id);
CREATE INDEX idx_sensor_logs_project_id ON sensor_logs(project_id);
CREATE INDEX idx_sensor_logs_sensor_type ON sensor_logs(sensor_type);
CREATE INDEX idx_sensor_logs_timestamp ON sensor_logs(timestamp);
CREATE INDEX idx_reports_project_id ON reports(project_id);
CREATE INDEX idx_chat_messages_user_id ON chat_messages(user_id);
CREATE INDEX idx_activity_logs_user_id ON activity_logs(user_id);
CREATE INDEX idx_activity_logs_created_at ON activity_logs(created_at);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at triggers
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_projects_updated_at BEFORE UPDATE ON projects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_materials_updated_at BEFORE UPDATE ON materials
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_material_calculations_updated_at BEFORE UPDATE ON material_calculations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_site_analysis_updated_at BEFORE UPDATE ON site_analysis
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_machines_updated_at BEFORE UPDATE ON machines
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_reports_updated_at BEFORE UPDATE ON reports
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

