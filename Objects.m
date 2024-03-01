classdef Objects

    properties
        name
        position
        shape
        material
        subObjects
    end
    
    
    methods
        
        function obj = Objects(name, position, shape, material)
            
            obj.name = name;
            obj.position = position;
            obj.shape = shape;
            obj.material = material;
            
        end
        % When we have subobjects
        function obj = addSubObject(obj, subObject)
            % Move to the next index
            objectNum = size(obj.subObjects, 2) + 1;
            % Check if there are more than one subobjects
            if objectNum == 1
                obj.subObjects = subObject;
            else
                obj.subObjects(objectNum) = subObject;
            end
        end
        
    end
end
