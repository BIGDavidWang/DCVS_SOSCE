function Phi = OrthGauss(M,N,init_state)

 randn('state',init_state);
 dirpath = what('ProjectionsLAB');
 if ~isempty(dirpath)
     dirpath = dirpath.path;
     filename = [dirpath,'\','Projections.',...
         num2str(N),'.',num2str(init_state),'.mat'];
     if exist(filename,'file')
         load(filename); % Phi is from The Directory "ProjectionsLAB"                       
     else                % This Phi from LAB is a full Orthonomal Matirx!
         Theta = randn(N,N);
         Theta = orth(Theta)';
         save(filename,'Theta');% Phi has been saved in the Directory "ProjectionsLAB"                         
     end                        % This saved Phi is a full Orthonomal Matirx
 else
     Theta = randn(N,N);
     Theta = orth(Theta)'; % The Directory "ProjectionsLAB" is not on the    
 end                       % Search Path and the Current Directory
                           % Directly Reconstruct Matrix! Do Not Save It
    
 Phi = Theta(1:M,:);% sub-extract
 
end