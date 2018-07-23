# Plot1
Employing Freddie Mac data on mortgages to determine state-level housing market health over time

To begin to understand housing market health in the United States, I downloaded information provided by Freddie Mac 
on over 600k anonymized home mortgage loans.

I was most interested in the changing FICO score requirements for home buyers to be granted loans. Additionally, I wanted to know which
housing markets were friendly or hostile to First Time Home Buyers (FTHB). For FICO scores, I just took the median FICO score among borrowers
in a given area/time. For FTHB-friendliness, I took the ratio of FTHBs over all buyers in a given area/time.

I aggregated this data by county and by month; this would be very useful for making predictions of future changes and 
for creating a predictor program for individual users (i.e. answering "Which region should I move to if I'm a FTHB with a credit score of 'x'?").
However, such specific data is not helpful for visualization. For this exercise, I plotted only a few selected states and show my chosen values
by year instead of by month. 

A few key insights:
1. Texas scores surprisingly well as having a housing market that is friendly to FTHBs and allows buyers with lower FICO scores to recieve loans.
2. The effects of the housing crisis are clearly evident in the over-time graphs. In almost all states, the rates of first time home buying 
dropped and the requirements for FICO scores increased. However, in California, FTHBs flourished. Perhaps this is because while many established home-owners in
California were unable to maintain payments on their expensive loans, California may have a higher rate of wealthy individuals who had not yet had a chance
to secure their first home loan. The shock of the housing crisis seems to have created opportunities for many in California, comapred to the rest of the United States.
