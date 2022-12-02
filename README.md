# Crop-Insurance for Farmers

This decentralised application was created to solve the problems for insurances of crops for farmers.
The farmers can register on the contract with their addresses and the location of the crops(cities) and can pay the premiums whenever and as many times as they want.
Whenever a draught or flood arises which can be checked using two ways: first is through generating API calls to a weather site through chainlink oracle
asking for the rain in mm and for second I created a smart contract which behaved as an oracle and weather of every city is fed into it in a centralised manner
and can be used by our contract as and when it requires it. 

The insured amount was calcualated using 3 variables like severity of draught or flood(measured by analysis the rain data), 
amount of the premiums paid by the farmers and the and time on which they paid the premiums. Each of the above variable has a different weightage with the amount of premiums having the most weightage.

This dAPP was created for the blockchain mania hackathon orgainsed by the web & coding club, IIT Bombay in collaboration with CION Digital and I received the first position.
