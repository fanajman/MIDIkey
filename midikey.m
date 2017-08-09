function read = midikey(xx)
read = readmidi(xx);
notmat = midiInfo(read);
notmat = notmat(:, [3, 6]);

conv = nan(12, 10);
for a = 0:11;
    for b = 1:10;
        conv(a+1, b) = (a+ (12*(b-1)));
    end
end
conv = conv';


resposta = {'C Maior', 'C# Maior', 'D Maior', 'Eb Maior', 'E Maior', 'F Maior', 'F# Maior', 'G Maior', 'G# Maior', 'A Maior', 'Bb Maior', 'B Maior', 'C Menor', 'C# Menor', 'D Menor', 'Eb Menor', 'E Menor', 'F Menor', 'F# Menor', 'G Menor', 'G# Menor', 'A Menor', 'Bb Menor', 'B Menor'};
soluc = nan(1, 24);
vezes = [1:12 1:12];
isso = nan(12, 12);
for o = 1:12
    isso(o, :) = vezes((o+(14-(2*o))):o+(25-(2*o)));
end
major = [0.748, 0.06, 0.488, 0.082, 0.67, 0.46, 0.096, 0.715, 0.104, 0.366, 0.057, 0.4];
minor = [0.712, 0.084, 0.474, 0.618, 0.049, 0.46, 0.105, 0.747, 0.404, 0.067, 0.133, 0.330];
t = 2.5;
seg = notmat(notmat(:, 2) < t);
for p = 1:24
    prob = 1/24;
        for v = 1:length(seg);
            for mj = 1:12; 
                soma = 0;
                for k = 1:10;
                    veja = find(conv(k, mj) == seg(v));                
                    if  veja > 0;
                        soma = soma + 1;
                    end    
                end
                
                if p <= 12                
                    if soma > 0;
                        prob = prob * major(isso(p, mj));
                    else
                     prob = prob * (1 - (major(isso(p, mj))));
                    end
                else
                    if soma > 0;
                        prob = prob * minor(isso(p-12, mj));
                    else
                     prob = prob * (1 - (minor(isso(p-12, mj))));
                    end                    
                end
            end
        end
    soluc(1, p) = prob;    
end
resposta(find(soluc == max(soluc)))
end