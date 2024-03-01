% Muhammed Saadeddin Kocak
% Lalith Boggaram Naveen
% Aleksandr Udalov

%% Initialize objects

% Generate the chest object with specified inputs at the origin
chestObject = Objects('Chest', [0, 0, 0], Cylinder('Cylinder', 'r', 0.1, 12, 35, 15), Material('water', 1));

% Generate the lung object with specified inputs at the origin
lungObject = Objects('Lung', [0, 0, 0], Ellipsoid('Ellipsoid', 'g', 0.3, 5, 5, 15), Material('air', 0.0012));  

% Generate the tumor objects with specified inputs at various locations
tumor1Object = Objects('Tumor1', [0, -2, 5], Sphere('tumorSphere', 'b', 1, 2.5, 15), Material('pet', 0.95));
tumor2Object = Objects('Tumor2', [2, 2, 0], Cube('tumorCube', 'b', 1, 2), Material('pet', 0.95));
tumor3Object = Objects('Tumor3', [0, 0, -5], Cone('tumorCone', 'b', 1, 2, 3.5, 15), Material('pet', 0.95));

% Inserting the tumors into the lung and the lung into the chest  
lungObject = addSubObject(lungObject, tumor1Object);
lungObject = addSubObject(lungObject, tumor2Object);
lungObject = addSubObject(lungObject, tumor3Object);
chestObject = addSubObject(chestObject, lungObject);  

% Generating the scanner object with the energy of 0.06 MeV
scannerObject = Scanner('Scanner', [20, 0, 0], 0.06, ...
                [-30, 0, 0], [60, 60], [128, 128], chestObject);
            
% Creating the 'projection rays' for better understanding, as well as the source point      
sourceShape = Sphere('sourceSphere', 'y', 1, 0.01, 15);
sourceViewShape = Shape('sourceView', 'w', .05);
sourceViewShape.vertices = [-30 -30 -30; -30 -30 30; -30 30 30; -30 30 -30; 20, 0, 0];
sourceViewShape.faces = [1, 2, 5; 2, 3, 5; 3, 4, 5; 4, 1, 5];


%% Generate the image

img = scannerObject.run();

% Generate 2D detector image
figure('Name', 'Image')
imshow(img, [])
colormap(gca, flip(gray)) % Flipping the gray scale to match real x-ray scenario
title('Image')

% Plot 3D configuration 

fig = figure('Name', '3D-Configuration');

chestShape=Cylinder('Cylinder', 'r', 0.1, 12, 35, 15);
tumor1Shape = Sphere('tumorSphere', 'b', 1, 2.5, 30);
tumor2Shape = Cube('tumorCube', 'b', 1, 2);
tumor3Shape = Cone('tumorCone', 'b', 1, 2, 3.5, 30);
lungShape = Ellipsoid('lungEllipsoid', 'g', 0.3, 5, 5, 15);

% Add source, objects, image and source view
chestShape.plotShape(chestObject.position);
lungShape.plotShape(lungObject.position);
tumor1Shape.plotShape(tumor1Object.position);
tumor2Shape.plotShape(tumor2Object.position);
tumor3Shape.plotShape(tumor3Object.position);
sourceShape.plotShape(scannerObject.sourcePosition);
sourceViewShape.plotShape([0, 0, 0]);
hold on
imgTransform = hgtransform('Matrix',makehgtform('translate', [-30, -30, 30], ...
    'xrotate', -pi/2, 'yrotate', -pi/2, 'scale', [60/128, 60/128, 60/128] ));
image(imgTransform, img, 'CDataMapping', 'scaled')   
colormap(gca, flip(gray))
xlim([-50 50]), ylim([-50 50]), zlim([-50 50])
grid on        
% Adjust view, add title and label            
view([50, 30])            
title('3D-Configuration')
xlabel('x [cm]'), ylabel('y [cm]'), zlabel('z [cm]')


