classdef Material
       
    properties
        name
        density
    end
    
    properties (Access = private)
        energy
        massAttenuationCoefficientPerDensity
    end
    
    methods
        
        function obj = Material(MaterialName, density)
            
            materialFile = load([MaterialName, '.mat']);
            
            obj.name = MaterialName;
            obj.density = density;
            obj.energy = materialFile.data(:,1);
            obj.massAttenuationCoefficientPerDensity = materialFile.data(:,2);
            
        end
        
        
        
        function AttenuationCoefficient = getAttenuationCoefficient(obj, energy)
            % getAttenuationCoefficient() to calculate the mass attenuation
            % coefficient for a given energy and density
         
            if any(ismember(obj.energy, energy))
                AttenuationCoefficientPerDensity = obj.massAttenuationCoefficientPerDensity(obj.energy == energy);       
            else   
                % If the corresponding energy is not present then we
                % interpolate the mass attenuation coefficient per density
                AttenuationCoefficientPerDensity = interp1(obj.energy, obj.massAttenuationCoefficientPerDensity, energy);   
            end
            
            % Compute attenuation coefficient using attenuation coefficient
            % per density and the density
            AttenuationCoefficient = AttenuationCoefficientPerDensity * obj.density;
            
        end
      
    end
end

