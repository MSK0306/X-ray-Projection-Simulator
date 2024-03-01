classdef Ellipsoid < Shape

    properties
        semiAxesX
        semiAxesY
        semiAxesZ
    end
    
    

    methods
        
        % Method to construct the ellipsoid object in 3D space
        function obj = Ellipsoid(name, color, opacity, semiAxesX, semiAxesY, semiAxesZ)

            % Initialize object
            obj@Shape(name, color, opacity); 
            obj.semiAxesX = semiAxesX;   
            obj.semiAxesY = semiAxesY; 
            obj.semiAxesZ = semiAxesZ; 
            
            % Using the in-built ellipsoid function to create an ellipsoid
            % centered at the origin along with the given axes lengths
            [x, y, z] = ellipsoid(0, 0, 0, semiAxesX, semiAxesY, semiAxesZ);
            ellipsoidStruct = surf2patch(x, y, z, 'triangles');
            
            % Assign the values of vertices and faces back to the obj
            obj.vertices = ellipsoidStruct.vertices;      
            obj.faces = ellipsoidStruct.faces;

        end
        
    end
end
