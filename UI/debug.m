 function debug(varargin)
   %MYFPRINTF Just a wrapper to FPRINTF.
    varargin{1} = [varargin{1} '\n'];
   
      fprintf(varargin{:});
   