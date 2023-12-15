SELECT *
FROM "Acid_production" FULL OUTER JOIN "Cities" 
ON "Acid_production"."City" = "Cities"."ID_city"
FULL OUTER JOIN "Reactors"
ON "Acid_production"."Reactor" = "Reactors"."ID_reactor"
