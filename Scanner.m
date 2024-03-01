classdef Scanner

    properties
        name
        sourcePosition
        sourceEnergy
        detectorPosition
        detectorPhysicalSize
        detectorMatrixSize
        phantom
    end

    methods

        function obj = Scanner(name, sourcePosition, sourceEnergy, ...
                detectorPosition, detectorPhysicalSize, ...
                detectorMatrixSize, phantom)

            obj.name = name;
            obj.sourcePosition = sourcePosition;
            obj.sourceEnergy = sourceEnergy;
            obj.detectorPosition = detectorPosition;
            obj.detectorPhysicalSize = detectorPhysicalSize;
            obj.detectorMatrixSize = detectorMatrixSize;
            obj.phantom = phantom;

        end

        function image = run(obj)

            % The image is initialized as NaN
            image = nan(obj.detectorMatrixSize(1), obj.detectorMatrixSize(2));

            % Finding real pixel size
            pixelSize = obj.detectorPhysicalSize(1)/obj.detectorMatrixSize(1); % cm

            % Determining the upper left corner of the first pixel
            detectorCornerUL = [obj.detectorPosition(2) - obj.detectorPhysicalSize(1)/2, ...
                obj.detectorPosition(3) + obj.detectorPhysicalSize(2)/2];

            % Center position of the first pixel
            centerOfFirstPixel(1) = detectorCornerUL(1) + 0.5 * pixelSize;
            centerOfFirstPixel(2) = detectorCornerUL(2) - 0.5 * pixelSize;

            % Calculating attenuation for all pixels of the detector
            for rowIndice = 1 : obj.detectorMatrixSize(1)
                for columnIndice = 1 : obj.detectorMatrixSize(2)

                    % Determine current pixel position
                    centerOfCurrentPixel = centerOfFirstPixel + [pixelSize*(columnIndice - 1), - pixelSize*(rowIndice - 1)];

                    % Determining the line between source and current pixel
                    % center
                    lineNotNormal = [obj.detectorPosition(1), centerOfCurrentPixel] - obj.sourcePosition;

                    % Normalizing the line
                    lineNormal = lineNotNormal ./ sqrt(sum(lineNotNormal.^2));

                    % Check all objects in phantom
                    intersectData = intersectPrivate(obj.phantom, obj.sourcePosition, lineNormal, obj.sourceEnergy);
                    intersectData(cellfun(@(x) isnan(x), intersectData(:,1)),:) = [];

                    if size(intersectData, 1) > 0
                        % Obtain attenuation coefficients for rays passing
                        % through objects
                        attenuationCoefficients = cell2mat(intersectData(:, 4));

                        % Obtain path data
                        numberOfPaths = numel(attenuationCoefficients);

                        % Initialize start point, end point, distance
                        % between them, attenuation intensity, and inital
                        % intensity levels
                        startPoint=nan(numberOfPaths,1);
                        endPoint=nan(numberOfPaths,1);
                        distance=nan(numberOfPaths,1);
                        attenuationIntensity=nan(numberOfPaths,1);
                        initialIntensityLevel=nan(numberOfPaths,1);

                        intersections = cell2mat(intersectData(:, 1:2));
                        % Sorting intersection points to find the start and
                        % end points
                        intersectionPointsSorted = sort([intersections(:,1); intersections(:,2)]);

                        % Initialize an intensity level
                        initialIntensityLevel(1)=obj.sourceEnergy;

                        % Calculating attenuation for each path passing
                        % through each sub object
                        for i = 1 : numberOfPaths

                            % Determine start, end and length of the path
                            startPoint(i) = intersectionPointsSorted(i);
                            endPoint(i) = intersectionPointsSorted(i + 1);

                            distance(i) = abs( startPoint(i) - endPoint(i) );

                            % Calculate intensity using Lambert-Beer Law
                            attenuationIntensity(i) = initialIntensityLevel(i) * ...
                                exp( - attenuationCoefficients(i) * distance(i) );

                            % If we have subobjects inside calculate
                            % attenuation for them also
                            if i < numberOfPaths
                                initialIntensityLevel(i+1) = attenuationIntensity(i);
                            end

                        end

                        % Assign final intensity value to the pixel
                        image(rowIndice, columnIndice) = attenuationIntensity(end);
                    else
                        image(rowIndice, columnIndice) = obj.sourceEnergy;
                    end
                end

            end

        end

    end

end
