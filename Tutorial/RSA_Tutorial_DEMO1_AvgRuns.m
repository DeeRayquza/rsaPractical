%% RSA on the average patterns across runs (generally not recommended)

% Step 1: Load data and calculate representational similarity matrix (RSM)

%clear workspace
clear
close

%load data
load('Tutorialdata_withCV');

%average patterns across runs (yields a 6 (conditions) x 193 (voxels) matrix
d = (patterns.data(:,:,1) + patterns.data(:,:,2) + patterns.data(:,:,3) + patterns.data(:,:,4) + patterns.data(:,:,5) + patterns.data(:,:,6))/6;

%de-mean patterns for each voxel
for icol = 1:length(d)
    dn(:,icol) = d(:,icol) - mean(d(:,icol));
end

% calculate pattern similarity and dissimilarity matrices
rsm = 1- squareform(pdist(dn,'correlation'));
rdm = squareform(pdist(dn,'correlation'));

%Plot similarity matrix of the data (averaged across runs)
figure(1)
imagesc(rsm);
xticklabels({'Face Left','Face Center','Face Right','Hand Left','Hand Left','Hand Center','Hand Right'});
yticklabels({'Face Left','Face Center','Face Right','Hand Left','Hand Left','Hand Center','Hand Right'});
colorbar;
title('Data RSM','FontSize',24);


%%
% Step 2: create and plot model-RSMs for stimulus category (face vs hand) and direction

mrsm_facevshand = [1 1 1 0 0 0;...
                   1 1 1 0 0 0;...
                   1 1 1 0 0 0;...
                   0 0 0 1 1 1;
                   0 0 0 1 1 1;
                   0 0 0 1 1 1];
               
% mrsm_facevshand = [repmat([ones(1,3),zeros(1,3)],3,1);repmat([zeros(1,3),ones(1,3)],3,1)];

                          
mrsm_direction = [1 0 0 1 0 0;...
                  0 1 0 0 1 0;...
                  0 0 1 0 0 1;...
                  1 0 0 1 0 0;...
                  0 1 0 0 1 0;...
                  0 0 1 0 0 1];
              
              

figure(2)
imagesc(mrsm_facevshand);
xticklabels({'Face Left','Face Center','Face Right','Hand Left','Hand Left','Hand Center','Hand Right'});
yticklabels({'Face Left','Face Center','Face Right','Hand Left','Hand Left','Hand Center','Hand Right'});
colorbar;
title('Model RSM - Stimulus Category','FontSize',24);

figure(3)
imagesc(mrsm_direction);
xticklabels({'Face Left','Face Center','Face Right','Hand Left','Hand Left','Hand Center','Hand Right'});
yticklabels({'Face Left','Face Center','Face Right','Hand Left','Hand Left','Hand Center','Hand Right'});
colorbar;
title('Model RSM - Direction','FontSize',24);
              
 
%%

%Step 3: Regress model RDMs competitively against data RDM 

glm = fitglm([mrsm_facevshand(:),mrsm_direction(:)],rsm(:));
beta_diag      = glm.Coefficients.Estimate(2);
beta_direction = glm.Coefficients.Estimate(3);
beta_facevhand = glm.Coefficients.Estimate(4);
