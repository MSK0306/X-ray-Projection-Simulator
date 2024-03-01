classdef Cone < Shape

    properties
        radius
        height
        numberOfCurvePoints
    end
    
    methods
        
        function obj = Cone(name, color, opacity, radius, height, numberOfCurvePoints)

            obj@Shape(name, color, opacity); 
            obj.radius = radius;
            obj.height = height;
            obj.numberOfCurvePoints = numberOfCurvePoints;
            
            % Using the in-built cylinder function to utilize while
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
            obj.vertices = verticesCone;      
            obj.faces = facesCone;
    
        end
        
    end
end
