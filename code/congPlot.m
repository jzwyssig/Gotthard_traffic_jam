function [] = congPlot(dataset)
switch dataset 
    case 1
        time = {'18.07.2014 07:40' '18.07.2014 08:20' '18.07.2014 09:20' '18.07.2014 09:50' '18.07.2014 10:45' '18.07.2014 12:30' '18.07.2014 13:55' '18.07.2014 15:36' '18.07.2014 15:41' '18.07.2014 16:14' '18.07.2014 18:57' '18.07.2014 19:30' '18.07.2014 19:52' '18.07.2014 21:37' '18.07.2014 22:00' '19.07.2014 00:00' '19.07.2014 01:08' '19.07.2014 03:39' '19.07.2014 03:50' '19.07.2014 04:02' '19.07.2014 04:11' '19.07.2014 04:55' '19.07.2014 05:20' '19.07.2014 06:15' '19.07.2014 07:15' '19.07.2014 08:20' '19.07.2014 09:25' '19.07.2014 10:15' '19.07.2014 10:50' '19.07.2014 11:10' '19.07.2014 11:25' '19.07.2014 12:40' '19.07.2014 13:20' '19.07.2014 13:35' '19.07.2014 14:10' '19.07.2014 14:25' '19.07.2014 15:40' '19.07.2014 16:55' '19.07.2014 17:40' '19.07.2014 18:00'};
        congestion = [0 1 2 2 3 4 5 6 7 8 7 6 5 4 3 3 4 5 6 8 9 11 13 15 13 12 11 10 9 8 9 8 6 5 4 3 2 2 1 0];
    case 2
        time = {'01.08.2014 06:26' '01.08.2014 10:05' '01.08.2014 11:05' '01.08.2014 11:20' '01.08.2014 11:35' '01.08.2014 13:24' '01.08.2014 14:03' '01.08.2014 16:15' '01.08.2014 17:00' '01.08.2014 17:22'};
        congestion = [0 2 3 3 4 4 3 2 1 0];          
    case 3
        time = {'25.07.2014 09:55' '25.07.2014 10:10' '25.07.2014 11:45' '25.07.2014 11:55' '25.07.2014 12:00' '25.07.2014 12:40' '25.07.2014 13:35' '25.07.2014 16:45' '25.07.2014 17:10' '25.07.2014 18:30' '25.07.2014 19:14' '25.07.2014 20:48' '25.07.2014 21:50' '25.07.2014 23:44' '26.07.2014 00:00' '26.07.2014 01:57' '26.07.2014 02:38' '26.07.2014 03:45' '26.07.2014 04:20' '26.07.2014 04:36' '26.07.2014 04:55' '26.07.2014 05:30' '26.07.2014 05:40' '26.07.2014 07:50' '26.07.2014 09:00' '26.07.2014 10:15' '26.07.2014 12:00' '26.07.2014 13:00' '26.07.2014 13:45' '26.07.2014 14:30' '26.07.2014 14:55' '26.07.2014 15:10' '26.07.2014 16:33' '26.07.2014 16:47' '26.07.2014 17:01'};
        congestion = [0 1 3 4 5 6 7 6 5 4 3 4 3 4 4 4 4 4 5 6 7 8 9 11 13 15 13 10 8 6 4 3 2 1 0];
    case 4
        time = {'02.08.2014 05:10' '02.08.2014 05:30' '02.08.2014 06:11' '02.08.2014 06:40' '02.08.2014 07:25' '02.08.2014 07:50' '02.08.2014 08:05' '02.08.2014 08:45' '02.08.2014 08:56' '02.08.2014 10:48' '02.08.2014 10:53' '02.08.2014 11:30' '02.08.2014 12:08' '02.08.2014 12:51' '02.08.2014 13:42' '02.08.2014 14:05' '02.08.2014 14:15' '02.08.2014 14:30' '02.08.2014 14:45' '02.08.2014 15:03' '02.08.2014 16:00' '02.08.2014 16:17'};
        congestion = [ 0 2 3 4 5 6 7 8 9 11 13 11 10 9 8 7 6 5 4 3 2 0];
    otherwise 
        disp (['dataset ' num2str(dataset) ' does not exist. Available datasets: training(1, 2); evaluation(3,4)'])
        return
end

% generate date vector
data = datevec(time, 'dd.mm.yyyy HH:MM');
    
% compute seconds since 00:00 of first day
seconds = zeros(1, length(time));
first_date = datenum(data(1,1:3));
for i = 1:length(time)
    curr_date = datenum(data(i,1:3));
    if curr_date == first_date
       seconds(1,i) = data(i,4)*3600 + data(i,5)*60;
    else
       seconds(1,i) = data(i,4)*3600 + data(i,5)*60 + 24*3600;
    end
end

% hold value
counter_s = seconds(1,1);
counter_c = 1;
if mod(dataset,2)
   X = 4:96:48*3600;
   Y = zeros(1,48*3600/96);
else
   X = 4:96:24*3600;
   Y = zeros(1,24*3600/96);
end

while counter_s < seconds(1,end)
    if seconds(1,counter_c) == counter_s
       counter_c = counter_c + 1;
    end
    Y(1,round(counter_s/96)) = congestion(1,counter_c - 1);
    counter_s = counter_s + 1;
end

% diagram of congestion
figure()
hold on;
bar(X/3600,Y, .01, 'EdgeColor',[.8,.85,.9])
bar(seconds/3600,congestion, 'k')
title('Congestion')
if mod(dataset,2)
   xlabel([datestr(data(1,:),'dd.mm.yyyy') ' - ' datestr(data(end,:),'dd.mm.yyyy')]);
else
   xlabel(datestr(data(1,:),'dd.mm.yyyy'));
end
ylabel('Kilometer');
if mod(dataset,2)
   xlim([0 48]);
else
   xlim([0 24]);
end
grid on;
%plot(Y);

end