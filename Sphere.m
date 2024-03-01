classdef Sphere < Shape
    
    properties
        radius
        numberOfFaces
    end
    
    methods
        
        function obj = Sphere(name, color, opacity, radius, numberOfFaces)

            obj@Shape(name, color, opacity); 
            obj.radius = radius;   
            obj.numberOfFaces = numberOfFaces;
            % Using the in-built sphere function to create a sphere with the
            % specified number of faces as input
            [x, y, z] = sphere(numberOfFaces);
            sphereStruct = surf2patch(x, y, z, 'triangles');
            
            % Assign the values of vertices and faces back to the obj
            obj.vertices = sphereStruct.vertices .*radius;      
            obj.faces = sphereStruct.faces;

        end
        
    end
end