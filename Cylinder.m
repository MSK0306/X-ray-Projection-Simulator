classdef Cylinder < Shape
 
    properties
        radius
        height
        numberOfCurvePoints
    end
    
    methods
        
        function obj = Cylinder(name, color, opacity, radius, height, numberCurvePoints)
        
            obj@Shape(name, color, opacity); 
            obj.radius = radius;
            obj.height = height;
            obj.numberOfCurvePoints = numberCurvePoints;
            
            % Using the in-built cylinder function
            [x, y, z] = cylinder(radius, numberCurvePoints);
            cylinderStruct = surf2patch(x, y, z*height, 'triangles');
            
            % Create a lower and upper face using circles
            facesCircle = nan(floor(size(cylinderStruct.vertices, 1)/2) - 1, 3);
            facesCircle(:,1) = 1  : 2 : size(cylinderStruct.vertices, 1) -2;
            facesCircle(:,2) = 3  : 2 : size(cylinderStruct.vertices, 1) -1;

            
            % Adjust height coordinate of lower and upper face
            facesLowerCircle = facesCircle;
            facesLowerCircle(:,3) = size(cylinderStruct.vertices, 1) + 1;
            facesUpperCircle = facesCircle + 1;
            facesUpperCircle(:,3) = size(cylinderStruct.vertices, 1) + 2;
            
            % Positioning the created cylinder onto the display
            facesCylinder = [cylinderStruct.faces; facesLowerCircle; facesUpperCircle];
            verticesCylinder = [cylinderStruct.vertices; [0,0,0]; [0,0,height]];
            verticesCylinder(:,3) = verticesCylinder(:,3) - 0.5*height;
            
            % Assign the values of vertices and faces back to the obj
            obj.vertices = verticesCylinder;       
            obj.faces = facesCylinder;
    
            
        end
        
    end
end

