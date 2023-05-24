%% Cross-validated RSA with visualisation and competitive regression

%Clear workspace and close figures
clear
close

%Load data from selected region of interest (ROI)
ROI = 'Parietal';%Visual or Parietal
load(['HomeworkData_',ROI,'.mat'])

%Loop analyses over subjects 
for isub = 1:length(patterns)
    
    %Display number of current subject
    disp(['Processing subject ',num2str(isub),''])
    
    
    %load data of current subject
    data   = patterns{isub};
    
    %%%Fill in code%%%
    %Create independent data splits (e.g., odd vs even runs)
    d_odd  = (data(:,:,1) + data(:,:,3) + data(:,:,5))/3;d_odd  = d_odd';
    d_even = (data(:,:,2) + data(:,:,4) + data(:,:,6))/3;d_even = d_even';
    
    %%%Fill in code%%%
    %De-mean patterns for each voxels
    dn_odd  = zeros(size(d_odd));
    dn_even = zeros(size(d_even));

    for icol = 1:length(d_odd)
        dn_odd(:,icol)  = d_odd(:,icol)  - mean(d_odd(:,icol));
        dn_even(:,icol) = d_even(:,icol) - mean(d_even(:,icol));
    end
    
    %%%Fill in code%%%
    % Compute cross-validated pattern (dis)similarity matrices
    dn_comb = [dn_odd;dn_even];

    rdm_comb = squareform(pdist(dn_comb,'correlation'));%compute dissimilarity matrix
    
    %%%Fill in code%%%
    %Create model RDMs for room identity, map, and context
    
    mrdm_room =  [];
            
    mrdm_map = [];
            
    mrdm_context = [];
    
    %%%Fill in code%%%
    %Regress model RDMs competitively againsts data RDM and save
    %coefficients for each subject and regressor
    
    
    
    
end

%Compute average rdm across subjects
avg_rdm_cv = cell2mat({mean(cat(3,rdms_cv{:}),3)});

%Flip and fold average matrix for multidimensional scaling
r = flipandfold(avg_rdm_cv);

%%%Fill in code (create the plotmds function)%%%
%Visualise data via MDS (separate function)
homework_plotmds(r);
xlim([-0.5 0.5]);
ylim([-0.5 0.5]);
zlim([-0.5 0.5]);
xlabel('MDS  DIMENSION 1')
ylabel('MDS  DIMENSION 2')
zlabel('MDS  DIMENSION 3')


%test beta coefficients from each model RDM for significance
[h,p,ci,stats] = ttest(cell2mat(beta_context));
[h,p,ci,stats] = ttest(cell2mat(beta_map));
[h,p,ci,stats] = ttest(cell2mat(beta_room));

%Display that analysis has finished
disp("Done")


%% Estimate dimensionality via singular value decomposition (just for illustration)

%Loop analysis over subjects
for isub = 1:length(patterns)
    
    %Calculate cross-validated RDMs for splits from odd and from even runs
    data   = patterns{isub};%load data of current subject
    
    %Create independent data splits by concatenating the respective three runs
    data_odd  = [data(:,:,1),data(:,:,3),data(:,:,5)];
    data_even = [data(:,:,2),data(:,:,4),data(:,:,6)];
    
    rdm_odd  = squareform(pdist(data_odd','correlation'));
    rdm_even = squareform(pdist(data_even','correlation'));
    
    rdm_odd_cv  = (rdm_odd(1:8,9:16)  + rdm_odd(1:8,17:24)  + rdm_odd(9:16,17:24))/3;
    rdm_even_cv = (rdm_even(1:8,9:16) + rdm_even(1:8,17:24) + rdm_even(9:16,17:24))/3;
    
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%SVD Low rank Approximation%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Number of dimensions to be considered (arbitrary)
    Ncomp = [1:8];
    
    %Fit partition 1 of single-subject data (odd runs) to partition 2 of
    %single-subject data (even runs)
    [U,S,V] = svd(rdm_odd_cv);
    
    % Perform SVD on the single-subject RDM with 1:N components
    %Loop over components
    for icomp = 1:length(Ncomp)
                Sr = S;
                Sr(icomp+1:end,icomp+1:end) = 0;
                Ur = U;
                Ur(icomp+1:end,icomp+1:end) = 0;
                Vr = V;
                Vr(icomp+1:end,icomp+1:end) = 0;
                Br{isub,icomp}     = Ur * Sr * Vr';%Reconstructed RDM with Ncomp
                %Test on held out data from same subject
                err{isub,icomp}       = (rdm_even_cv - Br{isub,icomp}).^2;%squared error between reconstructed subject and test RDM
                err_index{isub,icomp} = sum(sum(err{isub,icomp}));
    end
            
  
    end            
    ei = cell2mat(err_index);
    
    %Plot Mean squared error (MSE) Loss as a function of the number of included SVD components
    %Calculate within-subject error bars
    for i = 1:27
        ei_sub_avg(i) = mean(ei(i,:));%average error for each subject (across Ncomps): one value per subject
    end
    ei_sub_avg = ei_sub_avg';
    grand_avg  = mean(ei_sub_avg);%average error across the whole sample (across NComps): one value
    ei_demean  = ei - ei_sub_avg;%subtract subject average from error matrix: nsubject x ncomponents 
    ei_final   = ei_demean + grand_avg;%add grand average to error matrix: nsubjects x ncomponents
    
    %Create Plot
    figure
    a = errorbar(mean(ei_final),std(ei_final)/sqrt(27));
    xlim([0.5 8.5]);
    ylim([min(mean(ei_final)) - 0.001 max(mean(ei_final)) + 0.001]);
    xlabel('Included Components');
    ylabel('Average MSE');
    a.LineWidth = 2;
    a.Color = [0 0 0];
    title(ROI);
    set(gca,'FontSize',14);
