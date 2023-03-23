package proiect.sgbd;


import java.sql.SQLException;


public class MainClass {
    public static void main(String args[]) {
        try {
            var user = new User();

            // eroare username deja exista
           // user.addUser(6,"mihaiul","parola","Mihai 2", "mihaiul2@gmail.com", "Student", "Bacau", 3, "18-04-2022", 0);


            // eroare email deja exista
           user.addUser(6,"mihaiul2","parola","Mihai 2", "mihaiul@gmail.com", "Student", "Bacau", 3, "18-04-2022", 0);


            // adaugam un user bun
          // user.addUser(6,"ciprian","parola123","Ciprian Porumbescu", "ciprian@gmail.com", "Compozitor", "Suceava", 3, "17-05-2022", 0);


            // trigger pentru id film
           // user.addMovie(10,"Finding Nemo", 2003, "Andrew", 8, "Animation", 3);

            // adaugam un film
            // user.addMovie(11,"Finding Nemo", 2003, "Andrew", 8, "Animation", 3);


            // functia findMovieById
            // System.out.println("Filmul cu id-ul = 2 este: " + user.findMovieById(2));


            // functia newMovies - filmele aparute dupa 2009 primesc +2 la rating
           //  user.newMovies();


            // functia hasToPay - daca au trecut mai mult de 30 de zile de la imprumut, utilizatorii sunt taxati cu 50 de lei
         //   user.hasToPay();


            // functia deleteMovie - filmele care nu mai sunt disponibile pe stoc (nr_of = 0) sunt sterse din tabela
            // user.deleteMovie();


            // functia rentMovie - un User inchiriaza alt film: se modifica id-ul filmului dorit si data devine cea de azi
           //user.rentMovie(3,4);

            ConnectSQL.getConnection().setAutoCommit(false);
            ConnectSQL.getConnection().commit();
            ConnectSQL.getConnection().close();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }
}
