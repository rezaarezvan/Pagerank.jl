using Random, LinearAlgebra, Distributions, StatsBase, DiscreteMarkovChains

function check_regularity(P)
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

function get_pagerank_matrix(A, λ)
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

function random_surfer(P_ex, num_steps)
        sz = size(P_ex)
        max = sz[1]
        current_row      = 1
        println("Start in $current_row")
        for i = 1:num_steps
                next_state       = 0
                next_state_index = 0
                while next_state == 0
                        next_state_index = rand((1:max))
                        next_state = P_ex[current_row, next_state_index]
                end
                println("Next state: $next_state_index")
                current_row = next_state_index
        end
end

A_ex = [ 0 1 1 1 
        0 0 1 1
        1 0 0 0
        1 0 1 0 ]

P_ex = [ 0 1/3 1/3 1/3 
        0 0 1/2 1/2
        1 0 0 0
        1/2 0 1/2 0 ]

P_r = [   0.125  0.291667  0.291667  0.291667
          0.125  0.125     0.375     0.375
          0.625  0.125     0.125     0.125
          0.375  0.125     0.375     0.125]
          
λ = 0.5
# P_res = get_pagerank_matrix(A_ex, λ)
# random_surfer(P_ex, 10)
# check_regularity(P_ex)
