using Random, LinearAlgebra, Distributions, StatsBase, DiscreteMarkovChains

function checkregularity(P)
Pn = P
        for i in 1:100
                Pn *= P
        end
        if(isempty(findall(<=(0), Pn)))
                println("Regular!")
        else
                println("Not Regular!")
        end
end

function get_q(P, λ)
Q = P
        for i in 1:1000
                Q *= P
        end
        display(Q)

q = Q[1, :]
println("\n")
println(q)
end

function get_PagerankMatrix(A, λ)
        sz = size(A)
        n = sz[1]
        Pr = zeros(Float64, sz[1], sz[2])
        i = 1;
        j = 1; 
        
        for row in eachrow(A)
                n_i = count(x -> x == 1, row) 
                for index in row
                        if A[i,j] == 1
                                Pr[i,j] = (1 - λ)/n_i + λ/n
                        else
                                Pr[i,j] = λ/n
                        end
                        j = j + 1
                end
                i = i + 1
                j = 1
        end
        display(Pr)
        
        return Pr
end

Aex = [ 0 1 1 1 
        0 0 1 1
        1 0 0 0
        1 0 1 0 ]

P = [ 0 1/3 1/3 1/3 
        0 0 1/2 1/2
        1 0 0 0
        1/2 0 1/2 0 ]

Pr = [  0 1/3 1/3 1/3 
        0 0 1/2 1/2
        1 0 0 0
        1/2 0 1/2 0 ]

λ = 0.5
Pres = get_PagerankMatrix(Aex, λ)
