function uncombineEnsembledDataForLine()
%
% UNCOMBINEENSEMBLEDDATAFORLINE() is used to uncombine lines which whave previously been 
% ensembled. 
% 
% Notes: 
% - The following 'objects' will be combined: average lines, variability clouds


figs = findobj('type','figure');
for i = 1:length(figs)
    figObj = findobj(get(figs(i), 'Children'), 'Type', 'uimenu');
    if ~isempty(figObj)
        mainObj = figs(i);
    end
end


ax = findensobj('axes',mainObj);

for i = 1:length(ax)
    tg = get(ax(i),'tag');
    
    axs = setdiff(findobj('type','axes','tag',tg),ax(i),'stable');
    
    ln = findobj(axs,'type','line');                           % all lines
    for j = 1:length(ln)                                       % find average lines
        userData = get(ln(j),'UserData');
        if ~strfind(userData,'average_line')
        ln(j) = [];
        end
    end

    pch   = findobj(axs,'type','patch');                       % variability clouds
    ebarh = findobj(axs,'LineWidth',1.1);                      % error bar vertical
    ebarv = findobj(axs,'LineWidth',1.12);                     % error bar horizontal
    evt   = findobj(axs,'type','text');                        % event mark
    
    copy(ln, ax(i));    
    copy(pch, ax(i));
    copy(ebarh, ax(i));
    copy(ebarv, ax(i));
    copy(evt, ax(i));
    
%     set(ln,'parent',ax(i),'Color',settings.regularLineColor);    
%     set(pch,'parent',ax(i),'FaceColor',settings.ensembledPatchColor);
%     set(ebarh,'parent',ax(i));
%     set(ebarv,'parent',ax(i));
%     set(evt,'parent',ax(i));
    bottomhnd(pch);
end

% Update figure names
%

combineData();