using DiscreteMarkovChains, BenchmarkTools

#= Using the DiscreteMarkovChains.jl library we can get the stationary distribution aswell
function get_stationary_distribution(A::Matrix)::Vector 
        P = DiscreteMarkovChain(A)
        q = stationary_distribution(P)

        return q
end
=# 

# Checks if a given matrix is regular or not
function check_regularity(P::Matrix)
        P ^= 100;
        if(isempty(findall(<=(0), P)))
                println("Regular!")
                return true
        else
                println("Not Regular!")
                return false
        end
end

# get the q vector which solves q=qP
function get_q(P::Matrix)::Vector{Float64}
        isRegular = check_regularity(P)
        if isRegular == true
                P ^= 100;
                q = P[1, :]
                return q
        else
                return [-1.0, -1.0, -1.0] 
        end

end

# get the q vector wich solves q=qP, where P is the Pagerank matrix, input is a adjacency matrix and λ
function get_q_pagerank_matrix(A::Matrix, λ::Float64)
        sz = size(A)
        n = sz[1]
        Pr = zeros(Float64, sz[1], sz[2])
        i = 1;
        j = 1; 
        
        for row in eachrow(A)
                n_i = count(x -> x == 1, row) 
                for index in row
                        Pr[i, j] = A[i, j] * (1 - λ)/n_i + λ/n
                        j += 1
                end
                i += 1
                j  = 1
        end
        q = get_q(Pr)
        return q
end

# Simulates a random surfer which takes num_steps of steps in a given Stochastic/Markov matrix
function random_surfer(P_ex::Matrix, num_steps::Integer)
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

# A adjacency matrix which represent the relationship between different pages
A_ex = [ 0 1 1 1 
        0 0 1 1
        1 0 0 0
        1 0 1 0 ]

A = [ 0 1 0 0 
        1 0 0 0
        0 1 0 1
        1 0 1 0 ]

# Another example adjacency matrix
G_ex = [ 1 1 1  
         0 1 1 
         1 0 1 ]

# The Markov/Stochastic matrix, given from A_ex
P_ex = [ 0 1/3 1/3 1/3 
        0 0 1/2 1/2
        1 0 0 0
        1/2 0 1/2 0 ]

#  A example Pagerank matrix given a λ
P_r = [   0.125  0.291667  0.291667  0.291667
          0.125  0.125     0.375     0.375
          0.625  0.125     0.125     0.125
          0.375  0.125     0.375     0.125]


# Dampening factor, which describes how "bored" the surfer is getting
λ = 0.15

#= For question 1(h)
        u = [ 1/4 1/4 1/4 1/4 ]
        P2 = P_ex^10
        ans = u * P2
        println(ans)
=#

get_q(P_ex)
q_res_example = get_q_pagerank_matrix(A_ex, λ)
println(q_res_example)
q_res_general = get_q_pagerank_matrix(G_ex, λ)
println(q_res_general)
random_surfer(P_ex, 10)
check_regularity(P_ex)