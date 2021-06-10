## AlignTimeSeries

AlignTimeSeries.m is a MATLAB function for the alignment of pairs of time-series datasets collected at different framerates over the same period of time.

The function indexes through the longer dataset.  For each timestamp in the longer dataset, the closest timestamp from the shorter dataset will be identified and its associated data will be aligned to the longer dataset.  This effectively stretches the shorter timeseries without interpolation - which is beneficial when working with binary data.

## Function

```MATLAB
aligned = aligntimeseries(x1,t1,x2,t2
```

INPUT:

* x1 = input matrix 1
* t1 = column containing the timestamps in input matrix 1
* x2 = input matrix 2
* t2 = column containing the timestamps in input matrix 2

OUTPUT:

* aligned = output matrix containing the longer timestamp in the first column, followed by the longer dataset and then the aligned dataset

