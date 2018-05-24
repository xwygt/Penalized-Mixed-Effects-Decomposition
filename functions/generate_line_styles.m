function [linestyles,MarkerEdgeColors,Markers]= generate_line_styles(n)
% generate the space of linestyles, MarkerEdgeColors,Markers
% basic_linestyles = cellstr(char('-',':','-.','--'));
% basic_Markers    = cellstr(char('o','x','+','*','s','d','v','^','<','>','p','h','.'));
% 
% MarkerEdgeColors = jet(n);
% linestyles       = repmat(basic_linestyles,ceil(n/4),1);
% Markers          = repmat(basic_Markers,ceil(n/13),1);

MarkerEdgeColors = [1 0 0;   %green
                    1 0 1;   % magenta
                    0 0 1;   %blue
                    0 1 1;   %cyan
                    0 1 0;   %green
                    1 0 1;   %magenta
                    0 1 0;   %green
                    1 1 0;   %yellow
                    0 1 1;   %cyan                  
                    1 0 0];  % red




linestyles       = cellstr(char('-',':','--','-.',':','-','-.','--',':','-.'));
Markers          = cellstr(char(' ',' ',' ',' ',' ',' ',' ',' ',' ',' '));

end
