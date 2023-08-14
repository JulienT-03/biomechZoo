function ch = makevalidfield(ch)

% ch = makevalidfield(ch) fixes common invalid field names for structed
% arrays
% 
% ARGUMENTS
%   ch    ...   name of channel as string
%   
% RETURNS
%   ch    ...   new name of channel as string with invalid fieldnames removed
% 
%
% Created by JJ Loh
% 
% Updated by Phil Dixon Nov 2008
%   - This function now uses recursion to fix channel names with multiple
%     problems
%
% Updated by Phil Dixon Nov 2011
% - subcase ':' can handle invalid characters at the end of the field
% 
% updated by Phil Dixon March 2013
% - added new cases
%
% Updated by Philippe C. Dixon May 2014
% - added new cases
% - use of 'strrep' to clean code
%
% Updated by Philippe C. Dixon Oct 2016
% - Removed '_' as invalid field
% - Added '^,=' as invalid fields
% - Truncates any field that exceeds MATLAB's maximum name length
% - Converts numeric channel names x to nx
%
% Updated by Oussama Jlassi and Philippe C. Dixon Aug 2023
% - Improved code execution speed
% -------------------------------------------

if isempty(ch)
    ch = 'empty';
else

%     if isnumeric(ch)
%         ch = ['n',num2str(ch)];
%     end


    characters_to_replace = {'-', '[', ']', '^', '=', '(', ')', '+', '.', '\', '?', ',', ':', ''''};

    for i = 1:length(characters_to_replace)
        ch = strrep(ch, characters_to_replace{i}, '');
    end

    replacements = {
        ' ', '_';
        '#', 'numbersign';
        '%', 'percent';
        '$', 'dollarsign'
    };

    for i = 1:size(replacements, 1)
        ch = strrep(ch, replacements{i, 1}, replacements{i, 2});
    end


    % ch = strrep(ch,' ','_');
    % ch = strrep(ch,'#','numbersign');
    % ch = strrep(ch,'%','percent');
    % ch = strrep(ch,'$','dollarsign');
    % ch = strrep(ch,filesep,'per');
    
    % if ~isempty(strfind(ch,'*'))
    if contains(ch,'*')
        ch = 'star';
    end
    if ~isempty(ch) && isnumeric(ch(1)) && length(ch) == 1
        ch = ['marker', ch];
    end

    if ~isempty(ch) && isnumeric(ch(1)) && length(ch) ~= 1
        ch = ch(2:end);
    end

    % if strfind(ch(1),'_')
    if strcmp(ch(1), '_')
        ch = ch(2:end);
    end

    if length(ch)>namelengthmax
        ch = ch(1:namelengthmax);
    end
    % % if anything is still bad deal with it
    % a = struct;
    % try
    %    a.(ch) = 3;
    % catch 
    %     disp(['invalid field name ', ch, ' ...ignoring'])
    %     ch = 'invalid_field_name';
    % end
    % if anything is still bad deal with it
    % Check if the string starts with a letter (A-Z or a-z)
    isValid = isletter(ch(1));

    if isValid
        % Check if the string contains only ASCII letters, digits, and underscores
        isValid = all(isletter(ch) | ismember(ch, '0123456789_'));
    end

    if ~isValid
        disp(['invalid field name ', ch, ' ...ignoring'])
        ch = 'invalid_field_name';
    end
end