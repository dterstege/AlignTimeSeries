function aligned = aligntimeseries(x1,t1,x2,t2)
%
%   ~~~~~~~~~~~~~~~~~~ Align Time Series ~~~~~~~~~~~~~~~~~~~~~~
%
%   Align two time-series datasets recorded at different framerates
%
%   Find the closest timestamps across datasets and then gap-fill without
%   interpolation
%
%   [alignedt, alignedx] = aligntimeseries(t1,x1,t2,x2)
%
%   INPUT:
%       x1 = input matrix 1
%       t1 = column of the timestamps in input matrix x1
%       x2 = input matrix 2
%       t2 = column of the timestamps in input matrix x1
%
%   OUTPUT:
%       aligned = matrix containing the data from matrix 1 aligned to
%       matrix 2
%
%   aligntimeseries.m is a function for the alignment of timeseries data
%   collected at different framerates.
%   Copyright (C) 2021 Dylan Terstege
%
%   This program is free software; you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License , or (at your
%   option) any later version.
%
%   This program is distributed in the hope that it will be useful, but
%   WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%   General Public License for more details.
%
%   You should have received a copy of the GNU General Public License along
%   with this program.  If not, see <https://www.gnu.org/licenses/>.
%
%Created 06/10/2021 Dylan Terstege
%Epp Lab, University of Calgary
%Contact: dylan.terstege@ucalgary.ca

%check inputs
if nargin<4
    error('Insufficient number of inputs');
end

%identify the dataset to be stretched
if size(x1,1)>size(x2,1) %align x2 to x1
    shorter=x2;
    longer=x1;
    longtime=x1(:,t1);
    shorttime=x2(:,t2);
    shorter(:,t2)=[];
elseif size(x1,1)<size(x2,1) %align x1 to x2
    shorter=x1;
    longer=x2;
    longtime=x2(:,t2);
    shorttime=x1(:,t1);
    shorter(:,t1)=[];
elseif size(x1,1)==size(x2,1) %error; matrices are the same length
    error('Input matrices are already the same size'); 
end

%stretch and align datasets
%sets arrays to the same length and gap fills
aligned=zeros(size(longer,1),((size(longer,2)+size(shorter,2)))); %make output dataset
aligned(1:size(longer,1),1:size(longer,2))=longer; %input data which does not need alignment

%batch through timestamps
for ii=1:size(longtime,1) %batch one row at a time
    temp_time=longtime(ii); %moving down time column
    [~,ix]=min(abs(shorttime-temp_time)); %find index to align closest timestamps
    aligned(ii,(size(longer,2)+1):(size(longer,2)+size(shorter,2)))=shorter(ix,:); %apply index to shorter dataset
end
