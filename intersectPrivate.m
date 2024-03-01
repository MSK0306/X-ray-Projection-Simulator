function intersectData = intersectPrivate(object, lineOrigin, lineNormal, energy)

    % Initialize output
    intersectData{1, 1} = NaN; % 1. Entry point of the ray
    intersectData{1, 2} = NaN; % 2. Exit point of the ray
    intersectData{1, 3} = object.name; % Name of the object tested
    intersectData{1, 4} = NaN; % Calculate attenuation coefficient
     
    % Obtain vertices and faces of the object
    vertices = [object.shape.vertices(:,1) + object.position(1), ...
        object.shape.vertices(:,2) + object.position(2),...
        object.shape.vertices(:,3) + object.position(3)];
    faces = object.shape.faces;

    % Calculate the position of the intersection
    posLine = intersectionRayObject(vertices,faces, lineOrigin, lineNormal);

    % If posLine is returned nonzero give the intersection location as
    % output
    if size(posLine, 1) > 0
        % Giving first and second intersection locations as first and
        % second cell of the intersection data
        intersectData{1, 1} = posLine(1);
        intersectData{1, 2} = posLine(2);
        % Getting attenuation coefficient for the object
        intersectData{1, 4} = getAttenuationCoefficient(object.material, energy);
    end

    % If the object has sub objects inside we iteratively obtain
    % intersection data for them also
    if size(object.subObjects, 2) > 0
        for subObjects = 1 : size(object.subObjects, 2)
             % This recursive function goes through an object and gets all ray hits
           intersectDataOfSubObjects = intersectPrivate(object.subObjects(1, subObjects), lineOrigin, lineNormal, energy); 
           
           % Merge all intersection data
           intersectData = [intersectData; intersectDataOfSubObjects];
           
        end

    end
    
end

