          Java Database Connectivity

Application that allows users to rent certain movies.

- in db.sql we have the tables, procedures and triggers created in sqldeveloper, which will then be called in Java
	- the triggers have been created so that there is no possibility to have 2 users with the same username and/or the same email address
	
- in the ConnectSQL class we connect the application to our database.

- in the User class we have the option to:
	- add a new user to the USERS database.
	- add a new movie to the MOVIES database.
	- find a movie by its id.
	- change the rating of all movies released after 2009.
	- rent a movie.
	- delete movies that are no longer available for rental from the MOVIES table.
	- charge users who have exceeded 30 days since they borrowed a movie.
