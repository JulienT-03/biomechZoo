function Mdl=model_train(ml_data, Model_name)

% Mdl=model_train(ml_data, Model_name) trains a classification model
%
% ARGUMENTS
%   ml_data        ...   struct, struct returned with train_test_split
%   Model_name     ...   string,'BDT'     --> Binary Classification Tree
%                          'NBayes'  --> Naive bayes
%                          'knn'     --> k-Nearest Neighbor Classifier
%                          'Bsvm'    --> Binary support vector machines
%                          'Blinear' --> Binary Linear Classification
%                          'Bkernel' --> Binary Kernel Classification
%                          'Msvm'    --> Multiclass support vector machines
%                          'FF'      --> Forward Feed Neural network
%                          'LSTM'    --> Long short-term memory
%                          'BiLS'  --> Bidirectional Long short-term memory
%                          'CNN'     --> Convolutional neural network
% RETURNS
%   Mdl         ...   Trained model


if contains(Model_name,'BDT')
    disp('Training Binary Classification Tree')
    Mdl=fitctree(ml_data.x_train,ml_data.y_train,...
        'PredictorNames',ml_data.VariableName,...
        'AlgorithmForCategorical',ml_data.BDT.AlgorithmForCategorical,...
        'MaxNumCategories',ml_data.BDT.MaxNumCategories,...
        'MaxNumSplits',ml_data.BDT.MaxNumSplits,...
        'MergeLeaves',ml_data.BDT.MergeLeaves,...
        'MinLeafSize',ml_data.BDT.MinLeafSize,...
        'MinParentSize',ml_data.BDT.MinParentSize,...
        'Prior',ml_data.Prior);
elseif contains(Model_name,'NBayes')
    disp('Training naive bayes')
    Mdl = fitcnb(ml_data.x_train,ml_data.y_train,...
        'DistributionNames',ml_data.NBayes.DistributionNames,...
        'Kernel',ml_data.NBayes.Kernel,...
        'Support',ml_data.NBayes.Support,...
        'Prior',ml_data.Prior);
elseif contains(Model_name,'knn')
    disp('Training k-Nearest Neighbor Classifier')
    Mdl = fitcknn(ml_data.x_train,ml_data.y_train,...
        'BucketSize',ml_data.knn.BucketSize,...
        'Distance',ml_data.knn.Distance,...
        'Exponent',ml_data.knn.Exponent,...
        'NSMethod',ml_data.knn.NSMethod,...
        'NumNeighbors',ml_data.knn.NumNeighbors,...
        'Prior',ml_data.Prior);
elseif contains(Model_name,'Bsvm')
    disp('Training Binary SVM');
    Mdl = fitcsvm(ml_data.x_train,ml_data.y_train,...
        'BoxConstraint',ml_data.Bsvm.BoxConstraint,...
        'KernelFunction',ml_data.Bsvm.KernelFunction,...
        'KernelScale',ml_data.Bsvm.KernelScale,...
        'KernelOffset',ml_data.Bsvm.KernelOffset,...
        'Solver',ml_data.Bsvm.Solver,...
        'Nu',ml_data.Bsvm.Nu,...
        'KernelScale','auto',...
        'Prior',ml_data.Prior);
elseif contains(Model_name,'Blinear')
    disp('Binary Linear Classification')
    Mdl = fitckernel(ml_data.x_train,ml_data.y_train,...
        'Lambda',ml_data.Blinear.Lambda,...
        'Learner',ml_data.Blinear.Learner,...
        'Prior',ml_data.Prior);

elseif contains(Model_name,'Bkernel')
    disp('Training Binary Kernel Classification')
    Mdl = fitckernel(ml_data.x_train,ml_data.y_train,...
        'Learner',ml_data.Bkernel.Learner,...
        'NumExpansionDimensions',ml_data.Bkernel.NumExpansionDimensions,...
        'KernelScale',ml_data.Bkernel.KernelScale,...
        'Lambda',ml_data.Bkernel.Lambda,...
        'Prior',ml_data.Prior);

elseif contains(Model_name,'Msvm')
    disp('Training multiclass support vector machines')
    Mdl = fitcecoc(ml_data.x_train,ml_data.y_train,...
        'Learners',ml_data.Msvm.Learners,...
        'NumConcurrent',ml_data.Msvm.NumConcurrent,...
        'Prior',ml_data.Prior);
elseif contains(Model_name,'FF')
    disp('Training forward feed neural network')
    Mdl = trainNetwork(ml_data.x_train,ml_data.y_train,ml_data.FF.layers,ml_data.deeplearning.options);
elseif contains(Model_name,'LSTM')
    disp('Training Long shot-term memory neural network')
    Mdl = trainNetwork(ml_data.x_train,ml_data.y_train,ml_data.LSTM.layers,ml_data.deeplearning.options);
elseif contains(Model_name,'BiLS')
    disp('Training Bidirectional Long shot-term memory neural network')
    Mdl = trainNetwork(ml_data.x_train,ml_data.y_train,ml_data.BiLSTM.layers,ml_data.deeplearning.options);
elseif contains(Model_name,'CNN')
    disp('Training Convolutional neural network')
    Mdl = trainNetwork(ml_data.x_train,ml_data.y_train,ml_data.CNN.layers,ml_data.deeplearning.options);
    %elseif contains(Model_name,'FFNN')
    %        net = feedforwardnet(hiddenSizes,trainFcn); % still working
else
    error([Model_name,' model name does not exist check available models'])
end
