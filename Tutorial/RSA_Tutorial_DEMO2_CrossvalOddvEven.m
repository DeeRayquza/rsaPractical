%% RSA on cross-validated data (using an odd-even split)

% Step 1: load data and compute representational similarity

%Clear workspace
clear
close

%load data
load('Tutorialdata_withCV');
d_odd  = (patterns.data(:,:,1) + patterns.data(:,:,3) + patterns.data(:,:,5))/3;
d_even = (patterns.data(:,:,2) + patterns.data(:,:,4) + patterns.data(:,:,6))/3;


%de-mean patterns for each voxels
for icol = 1:length(d_odd)
    dn_odd(:,icol)  = d_odd(:,icol)  - mean(d_odd(:,icol));
    dn_even(:,icol) = d_even(:,icol) - mean(d_even(:,icol));
end


dn_comb = [dn_odd;dn_even];

rsm_comb = 1 - squareform(pdist(dn_comb,'correlation'));
rsm_cv   = rsm_comb(1:6,7:12);

rdm_comb = squareform(pdist(dn_comb,'correlation'));
rdm_cv   = rdm_comb(1:6,7:12);

figure(1)
imagesc(rsm_cv);
xticklabels({'Face Left','Face Center','Face Right','Hand Left','Hand Left','Hand Center','Hand Right'});
yticklabels({'Face Left','Face Center','Face Right','Hand Left','Hand Left','Hand Center','Hand Right'});
colorbar;
title('Data RSM','FontSize',24);



%% Step 2: create and plot model-RDMs
mrsm_diag =       [1 0 0 0 0 0;...
                   0 1 0 0 0 0;...
                   0 0 1 0 0 0;...
                   0 0 0 1 0 0;
                   0 0 0 0 1 0;
                   0 0 0 0 0 1];

mrsm_facevshand = [1 1 1 0 0 0;...
                   1 1 1 0 0 0;...
                   1 1 1 0 0 0;...
                   0 0 0 1 1 1;
                   0 0 0 1 1 1;
                   0 0 0 1 1 1];
               
% mrdm_facevshand = [repmat([ones(1,3),zeros(1,3)],3,1);repmat([zeros(1,3),ones(1,3)],3,1)];

                          
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

figure(4)
imagesc(mrsm_diag);
xticklabels({'Face Left','Face Center','Face Right','Hand Left','Hand Left','Hand Center','Hand Right'});
yticklabels({'Face Left','Face Center','Face Right','Hand Left','Hand Left','Hand Center','Hand Right'});
colorbar;
title('Model RSM - Diagonal','FontSize',24);
              


%% Step 3: Run statistical test
glm = fitglm([mrsm_diag(:),mrsm_direction(:),mrsm_facevshand(:)],rsm_cv(:));
beta_diag      = glm.Coefficients.Estimate(2);
beta_direction = glm.Coefficients.Estimate(3);
beta_facevhand = glm.Coefficients.Estimate(4);

%% Step 4: visualisation via MDS
r = flipandfold(rdm_cv);
MDSPlot(r)
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);
xlabel('MDS  DIMENSION 1')
ylabel('MDS  DIMENSION 2')
zlabel('MDS  DIMENSION 3')