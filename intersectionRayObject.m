function [posLine] = intersectionRayObject(vertices,faces,lineOrigin,lineNormal)
            % ======================================================================
            %> @brief calculates the length of a ray within an object
            %>
            %> calculates the position where the ray intersects the
            %> faces of the object
            %>
            %> @param vertices      vertices of object of interest
            %> @param faces         faces of object of interest must be
            %triangular - in oder to ensure that use
            %surf2patch(...,'triangles') when you generate the faces
            %> @param lineOrigin    origin of ray (e.g. source) in [x,y,z] format
            %> @param lineNormal    normal vector along ray (source to
            %> detector pixel), must be a unity vector in [x,y,z] format
            %>
            %> @retval posLine      entry and exit point of the ray into 
            %> the object, coordinate axis along the ray in [u,v] format 
            % ======================================================================
            
            
            V0  = vertices(faces(:,1),:);
            V1  = vertices(faces(:,2),:);
            V2  = vertices(faces(:,3),:);
            E1  = V1-V0;
            E2  = V2-V0;
            
            %
            P    = cross(ones(size(faces,1),1)*lineNormal,E2,2);
            T    = ones(size(faces,1),1)*lineOrigin-V0;
            iPE1 = 1./dot(P,E1,2);
            
            
            %calculation of u
            u    = iPE1.*dot(P,T,2);
            indU = find(0<=u & u<=1);
            
            
            %calcultion of v
            Q    = cross(T(indU,:),E1(indU,:),2);
            D    = ones(length(indU),1)*lineNormal;
            v    = iPE1(indU).*dot(Q,D,2);
            indV = find(0<=v & v<=1);
            
            
            %checking which u and v obey u+v<=1
            indOK = find(v(indV)+u(indU(indV))<=1);
            iFaces = indU(indV(indOK));
            
            %calculation of t
            if ~isempty(iFaces)
                
                t = iPE1(iFaces).*dot(Q(indV(indOK),:),E2(iFaces,:),2);
                t  = unique(t);
                
                
                if length(t)>1
                    posLine = t;
                else
                    posLine = [];
                end
                
            else
                posLine = [];
            end
        end