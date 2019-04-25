# Movie Portal
A full-stack rails app leveraging the [movie db API.](https://developers.themoviedb.org/3/getting-started)

Initial features include:

* Upon accessing the hompage the user is displayed with a list of the current top twenty most popular tv shows.
* The user can click any tv show name to bring them to a more detailed overview of the tv show.
* The tv show view renders and overview of the tv show with the origin country, first air date, viewer rating, and a poster of the tv show.
* The tv shows are persisted in postgres as an instance of a show object. This was done by requesting the top tv show data from the movie db api with the HTTParty gem. 
* Upon loading the home page this request is made to update the data checking if any new shows are in the top 20 list. 
* On the navigation bar the user can also search the queried tv shows and any matches will be displayed in the view. 

Possible updates for the future: 

* Add pagination.
* Include top movies.
* Include actor/actress details.
* Better rendering of show details in view. 
* Add comments/reviews section and user authentication and authorization.
