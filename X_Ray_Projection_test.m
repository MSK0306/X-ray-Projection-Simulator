% Muhammed Saadeddin Kocak
% Lalith Boggaram Naveen
% Aleksandr Udalov

classdef X_Ray_Projection_test < matlab.uitest.TestCase
    methods (Test)
        
        %Testing the properties of class Cube
        function test_Cube(testCase)
            cube_shape = Cube('Cube', 'r', 1, 2);
            
            testCase.verifyEqual(cube_shape.name,'Cube');
            testCase.verifyEqual(cube_shape.color,'r');
            testCase.verifyEqual(cube_shape.opacity,1);
            testCase.verifyEqual(cube_shape.edgeSize,2) ;   
        end

        % Testing Cube shape     -  doesnt' work
        function test_Cube_Shape(testCase)
            
            % Create object Cube
            CubeObject = Cube('Cube', 'b', 1, 20);

            edgeSize = 20;

            x = [-1 1 1 -1 -1; -1 1 1 -1 -1] .*edgeSize/2;
            y = [-1 -1 1 1 -1; -1 -1 1 1 -1] .*edgeSize/2; 
            z = [-1 -1 -1 -1 -1; 1 1 1 1 1] .*edgeSize/2;                   
            cubeStruct = surf2patch(x, y, z, 'triangles');
            
            % Close the cube top and bottom faces
            lowerFace = [1, 3, 5; 1, 7, 5];
            upperFace = [2, 4, 6; 2, 8, 6];
            Example_Cube_Faces = [cubeStruct.faces; lowerFace; upperFace];
            Example_Cube_Vertices = cubeStruct.vertices;

            % Compare vertices and faces
            testCase.verifyEqual(CubeObject.faces,Example_Cube_Faces);
            testCase.verifyEqual(CubeObject.vertices,Example_Cube_Vertices);  
        end

        %Testing the properties of class Sphere
        function test_Sphere(testCase)         
            cube_shape = Sphere('Sphere', 'r', 1, 3, 40);
            
            testCase.verifyEqual(cube_shape.name,'Sphere');
            testCase.verifyEqual(cube_shape.color,'r');
            testCase.verifyEqual(cube_shape.opacity,1);
            testCase.verifyEqual(cube_shape.radius,3); 
            testCase.verifyEqual(cube_shape.numberOfFaces,40); 
        end

        % Testing Sphere shape
        function test_Sphere_Shape(testCase)

            % Creating object Sphere
            SphereObject = Sphere('Sphere', 'b', 1, 4, 50);
            
            % Create sphere manually            
            radius = 4;
            
            [X,Y,Z] = sphere(50);
            
            X = X*radius;
            Y = Y*radius;
            Z = Z*radius;
            
            [Example_Sphere_Faces, Example_Sphere_Vertices] = surf2patch(X, Y, Z, 'triangles');
            
            % Compare vertices and faces
            testCase.verifyEqual(SphereObject.faces,Example_Sphere_Faces);
            testCase.verifyEqual(SphereObject.vertices,Example_Sphere_Vertices); 
        end 

        %Testing the properties of class Ellipsoid
        function test_Ellipsoid(testCase)         
            cube_shape = Ellipsoid('Ellipsoid', 'r', 0.3, 6, 7, 13);
            
            testCase.verifyEqual(cube_shape.name,'Ellipsoid');
            testCase.verifyEqual(cube_shape.color,'r');
            testCase.verifyEqual(cube_shape.opacity,0.3);
            testCase.verifyEqual(cube_shape.semiAxesX,6);
            testCase.verifyEqual(cube_shape.semiAxesY,7); 
            testCase.verifyEqual(cube_shape.semiAxesZ,13);   
        end

        % Testing Ellipsoid shape
        function test_Ellipsoid_Shape(testCase)
            
            % Create object Ellipsoid
            EllipsoidObject = Ellipsoid('Ellipsoid', 'g', 0.3, 6, 7, 13);
            
            % Create Ellipsoid manually            
            semiAxesX = 6;
            semiAxesY = 7;
            semiAxesZ = 13;

            [X,Y,Z] = ellipsoid(0, 0, 0, semiAxesX, semiAxesY, semiAxesZ);
            
            [Example_Ellipsoid_Faces, Example_Ellipsoid_Vertices] = surf2patch(X, Y, Z, 'triangles');
            
            % Compare vertices and faces
            testCase.verifyEqual(EllipsoidObject.faces,Example_Ellipsoid_Faces);
            testCase.verifyEqual(EllipsoidObject.vertices,Example_Ellipsoid_Vertices); 
        end

        % Testing the properties of class Cylinder
        function test_Cylinder(testCase)
            cylinder_shape = Cylinder('Cylinder', 'r', 0.1, 9, 24, 32);
            
            testCase.verifyEqual(cylinder_shape.name,'Cylinder');
            testCase.verifyEqual(cylinder_shape.opacity,0.1);
            testCase.verifyEqual(cylinder_shape.radius,9);
            testCase.verifyEqual(cylinder_shape.height,24);
            testCase.verifyEqual(cylinder_shape.numberOfCurvePoints,32);

            testCase.verifyEqual(cylinder_shape.color,'r');       
        end

        % Testing Cylinder shape
        function test_Cylinder_Shape(testCase)
            
            % Create object Cylinder
            CylinderObject = Cylinder('chestCylinder', 'r', 0.1, 9, 24, 32);
            
            % Create Cylinder manually     
            radius = 9;
            height = 24;
            numberCurvePoints = 32;
            [X,Y,Z] = cylinder(radius,numberCurvePoints);
            Z = Z*height - height/2;
            
            [Faces, Vertices] = surf2patch(X, Y, Z, 'triangles');
            
            % Create a lower and upper face using circles (close the shape)      
            circle_faces = zeros(floor(size(Vertices,1)/2)-1, 3);
            circle_faces(:,1) = 1:2:size(Vertices,1)-2;
            circle_faces(:,2) = 3:2:size(Vertices,1)-1;
            
            % Adjust height coordinate of lower and upper face
            Upper_faces = circle_faces + 1;
            Upper_faces(:,3) = size(Vertices,1) + 2;          
            Lower_faces = circle_faces;
            Lower_faces(:,3) = size(Vertices, 1) + 1;
            
            % Positioning the created cylinder
            Example_Faces = [Faces; Lower_faces; Upper_faces];
            Example_Vertices = [Vertices; [0 0 -height/2]; [0 0 height/2]]; % center is [0 0 0]
            
            % Compare vertices and faces
            testCase.verifyEqual(CylinderObject.faces,Example_Faces);
            testCase.verifyEqual(CylinderObject.vertices,Example_Vertices);              
        end  

        %Testing the properties of class Cone
        function test_Cone(testCase)         
            cube_shape = Cone('Cone', 'r', 1, 3, 4, 30);
            
            testCase.verifyEqual(cube_shape.name,'Cone');
            testCase.verifyEqual(cube_shape.color,'r');
            testCase.verifyEqual(cube_shape.opacity,1);
            testCase.verifyEqual(cube_shape.radius,3) ;
            testCase.verifyEqual(cube_shape.height,4) ;
            testCase.verifyEqual(cube_shape.numberOfCurvePoints,30) ;
        end

        % Testing Cone shape  -   doesn't work
        function test_Cone_Shape(testCase)
            
            % Create object Ellipsoid
            ConeObject = Cone('tumorCone', 'b', 1, 3, 4, 30);
            
            % Create Cone manually             
            radius = 3;
            height = 4;
            numberOfCurvePoints = 30;
            
            % creating a cone
            [x, y, z] = cylinder(radius, numberOfCurvePoints);
            cylinderStruct = surf2patch(x, y, z.*height);  
            
            % Using the lower vertices of the cylinder to create a cone
            verticesCone = [cylinderStruct.vertices(1:2:end, :); [0, 0, 0]; [0, 0, height]];         
            
            % Create lower face and upper hat
            facesCircle = nan(size(cylinderStruct.vertices, 1)/2 - 1, 3);
            facesCircle(:,1) = 1 : size(verticesCone, 1) - 3;
            facesCircle(:,2) = 2 : size(verticesCone, 1) - 2;
                        
            % Adjust height coordinate of lower face and upper hat
            facesLowerCircle = facesCircle;
            facesLowerCircle(:,3) = size(verticesCone, 1) - 1;
            facesUpperHat = facesCircle;
            facesUpperHat(:,3) = size(verticesCone, 1);
            
            % Positioning the created cone onto the display
            facesCone = [facesLowerCircle; facesUpperHat];
            verticesCone(:,3) = verticesCone(:,3) - 0.5*height;
            
            % Assign the values of vertices and faces back to the obj
            Example_Cone_Vertices = verticesCone;      
            Example_Cone_Faces = facesCone;
            
            % Compare vertices and faces
            testCase.verifyEqual(ConeObject.faces,Example_Cone_Faces);
            testCase.verifyEqual(ConeObject.vertices,Example_Cone_Vertices);
        end
        
        % Testing the properties of class Material
        function test_Material(testCase)

            % PET
            pet_material = Material('pet', 0.95);
            testCase.verifyEqual(pet_material.name,'pet');
            testCase.verifyEqual(pet_material.density,0.95);
            
            % WATER
            water_material = Material('water', 1);
            testCase.verifyEqual(water_material.name,'water');
            testCase.verifyEqual(water_material.density,1);
            
            % AIR            
            air_material = Material('air', 0.0012);
            testCase.verifyEqual(air_material.name,'air')
            testCase.verifyEqual(air_material.density,0.0012); 
        end

        % Testing interpolation 
        function test_interpolation(testCase)

            % Calculated value for density = 1 and energy = 7 MeV
            test_material = Material('water', 1);
            actual_coeff = getAttenuationCoefficient(test_material, 7);
            
            % Load example data
            data = load('water.mat');
            energy = data.data(:,1);
            mass_att_coeff = data.data(:,2);
            energy_sample = 7;
            density = 1;

            % Calculate interpolation manually
            expected_coeff = interp1(energy, mass_att_coeff, energy_sample, 'linear', 'extrap')*density;
            
            % Compare automated and manual calculations
            testCase.verifyEqual(actual_coeff,expected_coeff);  
        end 

        % Testing class Objects (if it can contain many inputs (subobjects))
        function test_Object(testCase)
            % Creating main object
            MainObjectShape = Ellipsoid('lungEllipsoid', 'g', 0.35, 6, 4, 12);
            MainObjectMaterial = Material('air', 0.00012);
            MainObject = Objects('MainObject', [0, 0, 0], MainObjectShape, MainObjectMaterial);

            % Creating subobjects
            SubObject1_Shape = Sphere('Sphere', 'b', 0.9, 2.7, 31);
            SubObject2_Shape = Cube('Cube', 'b', 0.7, 3);
            SubObject_Material = Material('pet', 0.95);

            SubObject1 = Objects('SubObject1', [1, -1, -10], SubObject1_Shape, SubObject_Material);                        
            SubObject2 = Objects('SubObject2', [2.5, 0.24, -8.6], SubObject2_Shape, SubObject_Material);
            
            % Merging main- and subobjects
            MainObject = addSubObject(MainObject, SubObject1);
            MainObject = addSubObject(MainObject, SubObject2);

            % Check if subobjects is equal as they were defined
            testCase.verifyNotEqual(MainObject.subObjects,[]);
            testCase.verifyEqual(MainObject.subObjects(1),SubObject1);
            testCase.verifyEqual(MainObject.subObjects(2),SubObject2);   
        end

        % Testing the positions of created objects after merging       
        function test_Object_Position(testCase)
            
            % Create chest 
            chestShape = Cylinder('chestCylinder', 'r', 0.1, 12, 35, 30);
            chestMaterial = Material('water', 1);
            chestObject = Objects('Chest', [0, 0, 0], chestShape, chestMaterial);
            
            % Create lung 
            lungShape = Ellipsoid('lungEllipsoid', 'g', 0.35, 6, 4, 12);
            lungMaterial = Material('air', 0.00012);
            lungObject = Objects('Lung', [0, 0, 0], lungShape, lungMaterial);  
            
            % Create tumors
            tumorShape1 = Sphere('tumorSphere', 'b', 0.9, 2.7, 31);
            tumorShape2 = Cube('tumorCube', 'b', 0.7, 3);
            tumorShape3 = Cone('tumorCone', 'b', 1, 2, 3.5, 30);
            tumorMaterial = Material('pet', 0.95);
            tumorObject1 = Objects('Tumor1', [0, 0, -10], tumorShape1, tumorMaterial);
            tumorObject2 = Objects('Tumor2', [1, 1, 0], tumorShape2, tumorMaterial);
            tumorObject3 = Objects('Tumor3', [-1, -1, 10], tumorShape3, tumorMaterial);
            
            % Add subobjects: tumors to lung and lung to chest     
            lungObject = addSubObject(lungObject, tumorObject1);
            lungObject = addSubObject(lungObject, tumorObject2);
            lungObject = addSubObject(lungObject, tumorObject3);
            chestObject = addSubObject(chestObject, lungObject);  
                         
            % Test if objects are at the same position
            testCase.verifyEqual(lungObject.shape.vertices,chestObject.subObjects(1).shape.vertices);
            testCase.verifyEqual(tumorObject1.shape.vertices,chestObject.subObjects.subObjects(1).shape.vertices);
            testCase.verifyEqual(tumorObject2.shape.vertices,chestObject.subObjects.subObjects(2).shape.vertices);
            testCase.verifyEqual(tumorObject3.shape.vertices,chestObject.subObjects.subObjects(3).shape.vertices);                
        end

        % Testing class Scanner (properties and phantom object)
        function test_Scanner(testCase)
            
            % Creating object Chest
            chestShape = Cylinder('chestCylinder', 'r', 0.1, 12, 35, 30);
            chestMaterial = Material('water', 1);
            chestObject = Objects('Chest', [0, 0, 0], chestShape, chestMaterial);
            
            % Creating object Scanner
            ScannerObject = Scanner('X-Ray Scanner', [20, 10, -15], 0.06, ...
                [-30, 0, 0], [60, 60], [128, 128], chestObject);
            
            % Check the properties of Scanner
            testCase.verifyEqual(ScannerObject.sourcePosition, [20, 10, -15]);
            testCase.verifyEqual(ScannerObject.sourceEnergy, 0.06);
            testCase.verifyEqual(ScannerObject.detectorPosition, [-30, 0, 0]);
            testCase.verifyEqual(ScannerObject.detectorPhysicalSize, [60, 60]);
            testCase.verifyEqual(ScannerObject.detectorMatrixSize, [128, 128]);

            % Check if phantom is empty
            testCase.verifyNotEqual(ScannerObject.phantom,[]);
            testCase.verifyEqual(ScannerObject.phantom,chestObject); 
        end

        % Testing the attenuated image generation with 1 example
        function test_Atten_Image(testCase)

            % Creating object Chest
            chestShape = Cylinder('chestCylinder', 'r', 0.1, 12, 35, 30);
            chestMaterial = Material('water', 1);
            chestObject = Objects('Chest', [0, 0, 0], chestShape, chestMaterial);
           
            % Creating object Scanner
            ScannerObject = Scanner('X-Ray Scanner', [20, 10, -15], 0.06, ...
                [-30, 0, 0], [60, 60], [128, 128], chestObject);
            
            % Load actual data
            data = load('water.mat');
            
            % Apply Lambert Beer Law (values from data folder for water and energy = 0.06 MeV)
            Example_intensity = data.data(7,1)*exp(-data.data(7,2)*12);
            
            % Get image on detector
            attenuationImage = ScannerObject.run();

            % Compare calculated and actual values of Intensity with 5% inaccuracy 
            testCase.verifyEqual(mean(attenuationImage, 'all'),Example_intensity,'AbsTol',0.05);  
        end            
    end
end