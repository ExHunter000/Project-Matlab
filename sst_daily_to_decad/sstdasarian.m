%% Created by Imron Ade

ifile=['E:/HTMK/OP_7/cdo/sst_indonesia_1891_2018.nc'];

dirout=['E:/project/data/sst_dasarian/'];
mkdir(dirout);

for tahun=1981:2018
    for bulan=1:12
        for das=1:3
                     
                blns=['0',num2str(bulan)]; blns=blns(:,end-1:end);
                
                ofile=['E:/project/data/sstdas_',num2str(tahun),blns,'0',num2str(das),'.nc'];
                                
            if das==1
                startdate='01'; enddate='10'; 
            elseif das==2 
                startdate='11'; enddate='20';
            elseif bulan==1 || bulan==3 || bulan==5 || bulan==7 || bulan==8 || bulan==10 || bulan==12
                enddate='31';startdate='21';
            elseif bulan==2 && mod(tahun,4)==0
                enddate='29';startdate='21';
            elseif bulan==2 && mod(tahun,4)~=0
                enddate='28';startdate='21';
            else
                enddate='30';startdate='21';
            end
            
            
            
            if das==1 || das==2           
                [~,out]=system(['cdo timselavg,10 -seldate,',num2str(tahun),'-',blns,'-',startdate,',',num2str(tahun),'-',blns,'-',enddate,' ' ifile ' ' ofile])
            elseif bulan==2 && mod(tahun,4)~=0
                [~,out]=system(['cdo timselavg,8 -seldate,',num2str(tahun),'-',blns,'-',startdate,',',num2str(tahun),'-',blns,'-',enddate,' ' ifile ' ' ofile])
            elseif bulan==2 && mod(tahun,4)==0
                [~,out]=system(['cdo timselavg,9 -seldate,',num2str(tahun),'-',blns,'-',startdate,',',num2str(tahun),'-',blns,'-',enddate,' ' ifile ' ' ofile])
            elseif bulan==1 || bulan==3 || bulan==5 || bulan==7 || bulan==8 || bulan==10 || bulan==12
                [~,out]=system(['cdo timselavg,11 -seldate,',num2str(tahun),'-',blns,'-',startdate,',',num2str(tahun),'-',blns,'-',enddate,' ' ifile ' ' ofile])
            else
                [~,out]=system(['cdo timselavg,10 -seldate,',num2str(tahun),'-',blns,'-',startdate,',',num2str(tahun),'-',blns,'-',enddate,' ' ifile ' ' ofile])
            end
            
            copyfile(ofile,dirout);
            delete(ofile);
            disp([num2str(tahun),blns,'0',num2str(das)]);
            
        end
    end
end

