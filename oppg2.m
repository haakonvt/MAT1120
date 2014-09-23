clear all
% Skript til løsing av oppgave 2 i oblig 1 høst 2014 MAT1120
% Skriver en litt mer generell løser enn for akkurat n=3

% Matrisen størrelse n x n:
n = 3;
e = zeros(n,1);

P  = eye(n);
% Skriver permutasjonene som kolonnevektorer i en matrise
perm = perms(1:n)';

fprintf('Permutasjonene av identitetsmatrisen "n x n" der n =')
disp(n)
for j=1:factorial(n);
    pj = perm(:,j);
    
    % Setter opp permutasjonsmatrisen. Antall ledd må endres om n =! 3
    Pj = [P(:,pj(1)) P(:,pj(2)) P(:,pj(3))]; 
    disp(Pj)
end
