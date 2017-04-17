function cost = prison_transport(n,m, edges)

isVisited = false([1 n+1]);
cost = 0;
group = cell(1, n);
not_grouped = cell(1, 1);
i = 1;
total = length(edges);

%agrupa prisioneiros
while i <= n
        for idx = 1:total
            arr = cell2mat(edges(idx));
            result = ismember(i, arr);
            resultArray = ismember(group{i}, arr);
            if((result || sum(resultArray) > 0) && isVisited(idx) == false)
                group{i} = unique([group{i}, arr]);
                isVisited(idx) = true;
            end;
        end;
    i++;
end

i = 1;
%agrupa prisionaireios que estão sem ninguem acorrentados
while i <= n

    chained = false;

    for idx = 1:length(group)
        arr = group{idx};
        result = ismember(i, arr);
        if(result)
            chained = true;
            break;
        end;
    end;
        
    if(chained == false)
        not_grouped{1} = unique([not_grouped{1}, [i]]);
    end;
    
    i++;
end

i = 1;

%realiza o calculo 2^x = total de prisioneiros
while i <= n
        
        arr = cell2mat(group(i));
        if(sum(arr) > 0)
            cost += log10(length(arr))/log10(2);
        end;
        i++;
end

arr = cell2mat(not_grouped(1));

%realiza o calculo 2^x = total de prisioneiros não acorrentados
if(sum(arr) > 0)
    
    logTotalArray = log10(length(arr));
    
    if(logTotalArray <= 0)
        logTotalArray = log10(2);    
    end;
    
    cost += logTotalArray/log10(2);
end;

%arrendonda resultado para cima
cost = ceil(cost);

%disp(group);
%disp(not_grouped);

end


% exemplos de uso
% prison_transport(6, 3, {[1 2 1],[3 4 5]})
% prison_transport(4, 2, {[1 2,],[1 4]})
% prison_transport(6, 3, {[1 2 6],[3 4 5]})
