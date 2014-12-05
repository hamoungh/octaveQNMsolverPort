%%Copyright (C) 2012, 2013 Moreno Marzolla
%%
%%This file is part of the queueing toolbox.
%%
%%The queueing toolbox is free software: you can redistribute it and/or
%%modify it under the terms of the GNU General Public License as
%%published by the Free Software Foundation, either version 3 of the
%%License, or (at your option) any later version.
%%
%%The queueing toolbox is distributed in the hope that it will be
%%useful, but WITHOUT ANY WARRANTY; without even the implied warranty
%%of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%%General Public License for more details.
%%
%%You should have received a copy of the GNU General Public License
%%along with the queueing toolbox. If not, see <http://www.gnu.org/licenses/>.

%%-*- texinfo -*-
%%
%%@deftypefn {Function File} {[@var{err} @var{Nout} @var{Sout} @var{Vout} @var{mout} @var{Zout}] = } qncmchkparam( N, S )
%%@deftypefnx {Function File} {[@var{err} @var{Nout} @var{Sout} @var{Vout} @var{mout} @var{Zout}] = } qncmchkparam( N, S, V )
%%@deftypefnx {Function File} {[@var{err} @var{Nout} @var{Sout} @var{Vout} @var{mout} @var{Zout}] = } qncmchkparam( N, S, V, m )
%%@deftypefnx {Function File} {[@var{err} @var{Nout} @var{Sout} @var{Vout} @var{mout} @var{Zout}] = } qncmchkparam( N, S, V, m, Z )
%%
%%Validate input parameters for closed, multiclass network.
%%@var{err} is the empty string on success, or a suitable error message
%%string on failure.
%%
%%@end deftypefn

%%Author: Moreno Marzolla <marzolla(at)cs.unibo.it>
%%Web: http://www.moreno.marzolla.name/

function [err Nout Sout Vout mout Zout] = qncmchkparam( N, S, V, m, Z )
  
  err = '';
  [Nout Sout Vout mout Zout] = deal(0);

  if ( nargin < 2 || nargin > 5 )
    err = 'Wrong number of parameters (min 2, max 5)';
    return;
  end

  if (not(isvector(N)) || length(N)==0 )
    err = 'N must be a nonempty vector';
    return;
  end

  if ( any(N<0) || any( fix(N) ~= N ) )
    err = 'N must contain nonnegative integers';
    return;
  end

  Nout = N(:)';

  C = length(Nout); %%Number of classes

  if ( not(ismatrix(S)) || size(S,1) ~= C )
    err = sprintf('S must be a matrix with %d rows',C);
    return;
  end

  if ( any(S(:)<0) )
    err = 'S must contain nonnegative values';
    return;
  end

  Sout = S;

  K = size(Sout,2);

  if ( nargin < 3 )
    Vout = ones(size(Sout));
  else
    if ( not(ismatrix(V)) || size(V,1) ~= C || size(V,2) ~= K )
      err = sprintf('V must be a %d x %d matrix', C, K );
      return;
    end

    if ( any(V(:)<0) )
      err = 'V must contain nonnegative values';
      return;
    end

    Vout = V;
  end

  if ( nargin < 4 ) 
    mout = ones(1,K);
  else
    if (not(isvector(m)) || length(m) ~= K ) 
      err = sprintf('m must be a vector with %d elements', K );
      return;
    end
    mout = m(:)';
  end

  if ( nargin < 5 )
    Zout = zeros(1,C);
  else
    if (not(isvector(Z)) || length(Z) ~= C)
      err = sprintf('Z must be a vector with %d elements', C);
      return;
    end
    if ( any(Z<0) )
      err = 'Z must contain nonnegative values';
      return;
    end
    Zout = Z(:)';
  end
end % function
