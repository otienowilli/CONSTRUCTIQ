-- CONSTRUCTIQ Seed Data

-- Insert default admin user (password: admin123)
INSERT INTO users (name, email, password, role, is_active) VALUES
('Admin User', 'admin@constructiq.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', true),
('John Engineer', 'engineer@constructiq.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'engineer', true),
('Jane Supervisor', 'supervisor@constructiq.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'supervisor', true);

-- Insert Civil Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Cement (OPC 43 Grade)', 'civil', 'bag (50kg)', 350.00, 'Ordinary Portland Cement for general construction'),
('Cement (OPC 53 Grade)', 'civil', 'bag (50kg)', 400.00, 'High strength cement for structural work'),
('River Sand', 'civil', 'cubic meter', 1200.00, 'Fine aggregate for concrete and mortar'),
('Coarse Sand', 'civil', 'cubic meter', 1000.00, 'Medium aggregate for plastering'),
('Ballast (20mm)', 'civil', 'cubic meter', 1500.00, 'Coarse aggregate for concrete'),
('Ballast (40mm)', 'civil', 'cubic meter', 1400.00, 'Large aggregate for mass concrete'),
('Gravel', 'civil', 'cubic meter', 1300.00, 'Natural stone aggregate'),
('Concrete Blocks (6 inch)', 'civil', 'piece', 45.00, 'Hollow concrete blocks'),
('Concrete Blocks (9 inch)', 'civil', 'piece', 65.00, 'Heavy duty concrete blocks'),
('Clay Bricks', 'civil', 'piece', 15.00, 'Standard red clay bricks'),
('Machine Cut Stones', 'civil', 'cubic meter', 3500.00, 'Dressed stone for masonry'),
('Steel Bars (Y8)', 'civil', 'kg', 85.00, '8mm diameter reinforcement bars'),
('Steel Bars (Y10)', 'civil', 'kg', 85.00, '10mm diameter reinforcement bars'),
('Steel Bars (Y12)', 'civil', 'kg', 85.00, '12mm diameter reinforcement bars'),
('Steel Bars (Y16)', 'civil', 'kg', 85.00, '16mm diameter reinforcement bars'),
('Timber (Cypress)', 'civil', 'cubic foot', 120.00, 'Softwood for formwork'),
('Timber (Hardwood)', 'civil', 'cubic foot', 180.00, 'Hardwood for structural use');

-- Insert Road Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Subgrade Material', 'roads', 'cubic meter', 800.00, 'Natural soil for road foundation'),
('Murram (Sub-base)', 'roads', 'cubic meter', 1200.00, 'Laterite for sub-base layer'),
('Crushed Stone Base', 'roads', 'cubic meter', 1800.00, 'Aggregate base course'),
('Road Aggregates', 'roads', 'cubic meter', 1600.00, 'Graded aggregates for roads');

-- Insert Bitumen Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Bitumen (80/100)', 'bitumen', 'liter', 95.00, 'Penetration grade bitumen for road construction'),
('Bitumen (60/70)', 'bitumen', 'liter', 98.00, 'Medium penetration grade bitumen'),
('Bitumen (40/50)', 'bitumen', 'liter', 102.00, 'Hard penetration grade bitumen'),
('Cutback Bitumen MC-30', 'bitumen', 'liter', 105.00, 'Medium curing cutback bitumen'),
('Cutback Bitumen RC-70', 'bitumen', 'liter', 108.00, 'Rapid curing cutback bitumen'),
('Bitumen Emulsion (Cationic)', 'bitumen', 'liter', 85.00, 'Cationic bitumen emulsion'),
('Bitumen Emulsion (Anionic)', 'bitumen', 'liter', 82.00, 'Anionic bitumen emulsion'),
('Prime Coat', 'bitumen', 'liter', 85.00, 'Bitumen primer for road base'),
('Tack Coat', 'bitumen', 'liter', 90.00, 'Bitumen adhesive layer');

-- Insert Asphalt Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Asphalt Concrete (AC14)', 'asphalt', 'ton', 8500.00, 'Hot mix asphalt 14mm aggregate'),
('Asphalt Concrete (AC20)', 'asphalt', 'ton', 8200.00, 'Hot mix asphalt 20mm aggregate'),
('Dense Bitumen Macadam (DBM)', 'asphalt', 'ton', 7800.00, 'Dense graded bituminous mix'),
('Bituminous Concrete (BC)', 'asphalt', 'ton', 9000.00, 'Premium bituminous concrete'),
('Stone Mastic Asphalt (SMA)', 'asphalt', 'ton', 9500.00, 'High performance asphalt'),
('Porous Asphalt', 'asphalt', 'ton', 8800.00, 'Drainage asphalt mix'),
('Warm Mix Asphalt', 'asphalt', 'ton', 8600.00, 'Environmentally friendly asphalt'),
('Cold Mix Asphalt', 'asphalt', 'ton', 7500.00, 'Asphalt for patching and repairs');

-- Insert Finishing Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Emulsion Paint (Interior)', 'finishing', 'liter', 450.00, 'Water-based interior paint'),
('Emulsion Paint (Exterior)', 'finishing', 'liter', 550.00, 'Weather-resistant exterior paint'),
('Oil Paint', 'finishing', 'liter', 650.00, 'Gloss finish oil-based paint'),
('Ceramic Tiles (Floor)', 'finishing', 'square meter', 1200.00, 'Porcelain floor tiles'),
('Ceramic Tiles (Wall)', 'finishing', 'square meter', 900.00, 'Glazed wall tiles'),
('Granite Tiles', 'finishing', 'square meter', 3500.00, 'Natural stone tiles'),
('Glass (Clear 6mm)', 'finishing', 'square meter', 1800.00, 'Float glass'),
('Insulation (Fiberglass)', 'finishing', 'square meter', 450.00, 'Thermal insulation'),
('Gypsum Plaster', 'finishing', 'bag (25kg)', 380.00, 'Smooth finish plaster'),
('Ceiling Boards', 'finishing', 'square meter', 650.00, 'Gypsum ceiling boards');

-- Insert Plumbing Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('PVC Pipes (1/2 inch)', 'plumbing', 'meter', 85.00, 'Water supply pipes'),
('PVC Pipes (3/4 inch)', 'plumbing', 'meter', 120.00, 'Water supply pipes'),
('PVC Pipes (1 inch)', 'plumbing', 'meter', 165.00, 'Water supply pipes'),
('PVC Pipes (4 inch)', 'plumbing', 'meter', 450.00, 'Sewer pipes'),
('Pipe Fittings (Elbows)', 'plumbing', 'piece', 45.00, 'PVC elbow joints'),
('Pipe Fittings (Tees)', 'plumbing', 'piece', 55.00, 'PVC tee joints'),
('Water Tank (500L)', 'plumbing', 'piece', 8500.00, 'Plastic water storage tank'),
('Water Tank (1000L)', 'plumbing', 'piece', 15000.00, 'Large water storage tank'),
('Water Pump (0.5HP)', 'plumbing', 'piece', 12000.00, 'Centrifugal water pump');

-- Insert Electrical Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Electrical Cable (2.5mm)', 'electrical', 'meter', 85.00, 'Twin core cable'),
('Electrical Cable (4mm)', 'electrical', 'meter', 135.00, 'Heavy duty cable'),
('Conduit Pipes (20mm)', 'electrical', 'meter', 65.00, 'PVC conduit'),
('Switch Sockets', 'electrical', 'piece', 250.00, '13A socket outlets'),
('Light Switches', 'electrical', 'piece', 180.00, 'Single gang switches'),
('Distribution Board', 'electrical', 'piece', 4500.00, 'Consumer unit 8-way'),
('Circuit Breakers (MCB)', 'electrical', 'piece', 450.00, 'Miniature circuit breaker');

-- Insert Structural Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Steel Beams (I-Section)', 'structural', 'kg', 95.00, 'Structural steel beams'),
('Steel Trusses', 'structural', 'kg', 105.00, 'Prefabricated roof trusses'),
('Wire Mesh (BRC)', 'structural', 'square meter', 450.00, 'Reinforcement mesh'),
('Precast Concrete Slabs', 'structural', 'square meter', 2800.00, 'Hollow core slabs'),
('Structural Bolts', 'structural', 'piece', 25.00, 'High tensile bolts');

-- Insert Geotextiles Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Geotextile Fabric (Woven)', 'geotextiles', 'square meter', 180.00, 'High strength woven geotextile'),
('Geotextile Fabric (Non-woven)', 'geotextiles', 'square meter', 150.00, 'Filtration geotextile'),
('Geogrid (Biaxial)', 'geotextiles', 'square meter', 220.00, 'Soil reinforcement grid'),
('Geogrid (Uniaxial)', 'geotextiles', 'square meter', 200.00, 'Directional reinforcement'),
('Geomembrane (HDPE)', 'geotextiles', 'square meter', 350.00, 'Waterproof liner'),
('Geocell', 'geotextiles', 'square meter', 280.00, 'Cellular confinement system'),
('Erosion Control Mat', 'geotextiles', 'square meter', 120.00, 'Biodegradable erosion mat');

-- Insert Prefabricated Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Prefab Concrete Panels', 'prefabricated', 'square meter', 3200.00, 'Precast wall panels'),
('Prefab Steel Frames', 'prefabricated', 'kg', 110.00, 'Prefabricated steel structure'),
('Prefab Roof Trusses', 'prefabricated', 'piece', 8500.00, 'Ready-made roof trusses'),
('Prefab Stairs', 'prefabricated', 'piece', 25000.00, 'Precast concrete stairs'),
('Prefab Beams', 'prefabricated', 'piece', 15000.00, 'Prestressed concrete beams'),
('Modular Blocks', 'prefabricated', 'piece', 85.00, 'Interlocking concrete blocks');

-- Insert Admixtures Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Concrete Plasticizer', 'admixtures', 'liter', 180.00, 'Water reducing admixture'),
('Superplasticizer', 'admixtures', 'liter', 250.00, 'High range water reducer'),
('Retarder', 'admixtures', 'liter', 200.00, 'Setting time retarder'),
('Accelerator', 'admixtures', 'liter', 220.00, 'Hardening accelerator'),
('Air Entraining Agent', 'admixtures', 'liter', 190.00, 'Freeze-thaw protection'),
('Waterproofing Admixture', 'admixtures', 'liter', 280.00, 'Integral waterproofing'),
('Corrosion Inhibitor', 'admixtures', 'liter', 320.00, 'Steel protection admixture'),
('Shrinkage Reducer', 'admixtures', 'liter', 240.00, 'Crack prevention admixture');

-- Insert Recycled Materials
INSERT INTO materials (name, category, unit, base_price, description) VALUES
('Recycled Concrete Aggregate', 'recycled', 'cubic meter', 900.00, 'Crushed concrete aggregate'),
('Recycled Asphalt Pavement (RAP)', 'recycled', 'ton', 4500.00, 'Reclaimed asphalt'),
('Recycled Steel', 'recycled', 'kg', 70.00, 'Scrap steel reinforcement'),
('Recycled Plastic Lumber', 'recycled', 'cubic meter', 2800.00, 'Plastic composite lumber'),
('Fly Ash', 'recycled', 'kg', 8.00, 'Coal combustion byproduct'),
('Slag Cement', 'recycled', 'kg', 12.00, 'Ground granulated blast furnace slag'),
('Recycled Glass Aggregate', 'recycled', 'cubic meter', 1200.00, 'Crushed glass aggregate');

-- Insert sample machines with enhanced features
INSERT INTO machines (name, type, model, serial_number, status, mqtt_topic, can_remote_control) VALUES
('Concrete Mixer #1', 'mixer', 'CM-500', 'MX-2024-001', 'active', 'constructiq/machines/MX-2024-001', true),
('Excavator #1', 'excavator', 'CAT-320', 'EX-2024-001', 'active', 'constructiq/machines/EX-2024-001', false),
('Bulldozer #1', 'bulldozer', 'D6T', 'BD-2024-001', 'idle', 'constructiq/machines/BD-2024-001', false),
('Crane #1', 'crane', 'TC-5013', 'CR-2024-001', 'maintenance', 'constructiq/machines/CR-2024-001', false),
('Batching Plant #1', 'batching_plant', 'BP-3000', 'BP-2024-001', 'idle', 'constructiq/machines/BP-2024-001', true),
('Bitumen Plant #1', 'bitumen_plant', 'ABP-120', 'BTP-2024-001', 'idle', 'constructiq/machines/BTP-2024-001', true),
('Crusher #1', 'crusher', 'JAW-600', 'CR-2024-002', 'active', 'constructiq/machines/CR-2024-002', true),
('Roller #1', 'roller', 'VR-10', 'RL-2024-001', 'active', 'constructiq/machines/RL-2024-001', true),
('Water Pump #1', 'pump', 'WP-500', 'WP-2024-001', 'active', 'constructiq/machines/WP-2024-001', true);

