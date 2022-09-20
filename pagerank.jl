using Random, LinearAlgebra, Distributions, StatsBase
# Linear Algebra of Markov chain

# Example: Weather Markov chain of Oz
#      R    S    C
P = [ 0.5 0.25 0.25
      0.5  0    0.5
      0.25 0.25 0.5]



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

checkregularity(P_2)