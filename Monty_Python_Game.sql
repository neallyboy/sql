-- ========================================================================================
-- Monty Python Game 
--	Find the Probability of winning when either staying or changing choice
--	Player 1: Stays with choice
--	Player 2: Changes choice
-- ========================================================================================

DO $$

DECLARE 

doors text[] := ARRAY['Goat','Goat','Goat'];
doorWithPrize int ;
player1Choice int;
player1Wins int := 0;
player2Choice int;
player2Wins int := 0;
hostChoice int;


BEGIN 
	
	-- Sample size of 1000
	FOR counter IN 1..1000 LOOP
	
		-- Randomly pick winning door
		doorWithPrize := floor(random() * (3-1+1) + 1)::int;
		doors[doorWithPrize] := 'Car';
		
		-- Player 1 chooses door
		player1Choice := floor(random() * (3-1+1) + 1)::int;
	
		-- Host reveals door that is not picked by Player 1 and is not the Winning door
		IF player1Choice <> 1 AND doorWithPrize <> 1 THEN 
			hostChoice := 1;
		ELSEIF player1Choice <> 2 AND doorWithPrize <> 2 THEN
			hostChoice := 2;
		ELSE 
			hostChoice := 3;
		END IF;
	
		-- Player 2 chooses door that is not picked by Player 1 and is not picked by Host
		IF player1Choice <> 1 AND hostChoice <> 1 THEN 
			player2Choice := 1;
		ELSEIF player1Choice <> 2 AND hostChoice <> 2 THEN
			player2Choice := 2;
		ELSE 
			player2Choice := 3;
		END IF;
	
		-- Player1 win count
		IF player1Choice = doorWithPrize THEN 
			player1Wins := player1Wins + 1;
		END IF;
	
		-- Player2 win count
		IF player2Choice = doorWithPrize THEN 
			player2Wins := player2Wins + 1;
		END IF;
	
		END LOOP;

	RAISE NOTICE 'Player 1 Wins: %',player1Wins;
	RAISE NOTICE 'Player 2 Wins: %',player2Wins;

END $$