clear all
% Skript til løsing av oppgave 1 i oblig 1 høst 2014 MAT1120

% Setter opp overgangsmatrisen P (bruker filen 'oslo.m')
oslo

% Sjekker at P er en stokastisk matrise ved å
% summere kolonnene og skrive de ut til skjerm.
% Ved inspeksjon ser vi at alle er lik 1.
sjekk  = sum(P);
% Transponerer for lettere avlesing
fprintf('Kolonnesummene er:\n')
disp(sjekk')        

% Høyeste eksponent av P vi sjekker:
eksp = 10;

for k=1:eksp;
    sjekk = 0;
    Pk    = P^k;
    for i=1:28;
        for j=1:28;
            if Pk(i,j) == 0;
                sjekk = 1;
            end
        end
    end
    if sjekk == 0;
        fprintf('Laveste potens av P, der P(i,j) > 0 for alle i,j er når k =')
        disp(k)
        break
    end
end

% Antar gjevn fordeling av biler som initialbetingelse for x0
x0        = 1/28 * ones(28,1);
presisjon = 1e-4;
xkf       = P*x0;

for k = 1:1000;
    xk  = P^k*x0;
    
    % Diff = 0 for k=1. Denne må ikke slå ut testen:
    diff_snitt = sum(abs(xk-xkf))/28;
    if k>1 && diff_snitt < presisjon; 
        fprintf('Likevektsvektor oppnådd etter antall tidssteg k =')
        disp(k)
        k_max = k; % Lagrer for fremtidig bruk
        break
    end
    xkf = xk; % Lagre denne vektoren til sammenligning 'neste runde'
end


% Veiarbeid fører til endringer i veisystemet i Oslo
Pny        = P(1:27,1:27);
Pny(25,22) = 0.7;
Pny(21,24) = 0.8;

x0_ny = 1/27 * ones(27,1);
xk_ny = Pny^k_max*x0_ny;

% Finner veien med størst trafikkøkning.
% Sort() sorterer vektoren fra størst til minst og endrer også 
% rekkefølgen på indeksene så vi vet hvor elementet opprinnelig var.
diff_trafikk   = xk_ny - xk(1:27);
[sort_diff, indeks] = sort(diff_trafikk,'descend');
vei1 = indeks(1);
fprintf('Størst trafikkøkning (I PROSENT) får vei nummer:')
disp(vei1)


% Finner nest og tredje største økning:
vei2 = indeks(2);
fprintf('Nest størst trafikkøkning (I PROSENT) opplever vei')
disp(vei2)
vei3 = indeks(3);
fprintf('\b\b og')
disp(vei3)

% Totalt antall biler etter 'lang' tid
N          = 50000;                 % Tot. ant. biler i Oslo på veiene
endr_biler = round(N*diff_trafikk);  % Endring i trafikk (rundet av)
fprintf('Økningen svarer til at ant. biler øker med hhv.: \n[veinummer antall]\n')
disp([vei1 endr_biler(vei1);
    vei2 endr_biler(vei2);
    vei3 endr_biler(vei3)])


