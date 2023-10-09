function h = centered_colorbar

% creates a colorbar with zero in the middle and a colormap that differentiates positive from negative values.
% There are 101 different colors ... the middle three are 'gray'
%
% Usage:
% imagesc(peaks(32));
% h = centered_colorbar;
%
% this does change the colormap. 
% I may want to extend this for situations ... green to brown ... dryness?
% positive == green (good), negative == red (bad) ... that sort of thing.

% take the jet colormap to get the 'red' end. In the RGB world,
% the equivalent 'blue' numbers are easy to get.

bob     = jet(128);
redend  = bob(80:128,:);  % actually yellow-to-red.
bluend  = fliplr(flipud(redend));
gray    = ones(3,3) * 0.8;
bluered = [bluend; gray; redend];

colormap(bluered);

clim = get(gca,'Clim');
dmin = clim(1);
dmax = clim(2);

if (abs(dmin) > dmax) 
   dmax = abs(dmin);
else
   dmin = dmax * -1.0;
end

set(gca,'Clim',[dmin dmax])

h = colorbar;
