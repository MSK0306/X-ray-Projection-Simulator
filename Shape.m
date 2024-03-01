classdef Shape

    % METHODS
    %  - Shape() to construct Shape object
    %  - plotShape() to plot the shape with the center at position
 
    properties
         name
         color
         opacity
         vertices
         faces
    end
    
    methods

        function obj = Shape(name, color, opacity)
            
            obj.name = name;
            obj.color = color;
            obj.opacity = opacity;
          
        end
    
        function disp = plotShape(obj, position)
            
            positionOfVertices = obj.vertices;
            positionOfVertices(:,1) = positionOfVertices(:,1) + position(1);
            positionOfVertices(:,2) = positionOfVertices(:,2) + position(2);
            positionOfVertices(:,3) = positionOfVertices(:,3) + position(3);
            
            disp = patch('Faces', obj.faces, 'Vertices', positionOfVertices, ...
                'FaceColor', obj.color, 'FaceAlpha', obj.opacity);
           
        end
    end
end
