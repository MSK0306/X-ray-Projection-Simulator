classdef Cube < Shape
    
    properties
        edgeSize
    end

    methods
        
        function obj = Cube(name, color, opacity, edgeSize)

            obj@Shape(name, color, opacity); 
            obj.edgeSize = edgeSize;   
                                                     
            x = [-1 1 1 -1 -1; -1 1 1 -1 -1] .*edgeSize/2;
            y = [-1 -1 1 1 -1; -1 -1 1 1 -1] .*edgeSize/2; 
            z = [-1 -1 -1 -1 -1; 1 1 1 1 1] .*edgeSize/2;                   
            cubeStruct = surf2patch(x, y, z, 'triangles');
            
            % Close the cube top and bottom faces
            lowerFace = [1, 3, 5; 1, 7, 5];
            upperFace = [2, 4, 6; 2, 8, 6];
            faces = [cubeStruct.faces; lowerFace; upperFace];
            
            % Assign the values of vertices and faces back to the obj
            obj.vertices = cubeStruct.vertices;
            obj.faces = faces;
            
        end
        
    end
end

