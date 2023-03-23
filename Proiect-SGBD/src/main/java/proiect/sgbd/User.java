package proiect.sgbd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.*;

public class User {
    public void addUser(int id_user, String username, String password, String name, String email, String job, String home, int id_movie, String date_rented, int to_pay) throws SQLException {
        Connection con = ConnectSQL.getConnection();

        con.prepareStatement("{call trigger_id}");

        con.prepareStatement("{call trigger_username}");

        con.prepareStatement("{call trigger_email}");

        try (PreparedStatement pstmt = con.prepareStatement(
                "insert into USERI (id_user, username, password, name, email, job, home, id_movie, date_rented, to_pay) values (?,?,?,?,?,?,?,?,?,?)")) {
            pstmt.setInt(1, id_user);
            pstmt.setString(2, username);
            pstmt.setString(3, password);
            pstmt.setString(4, name);
            pstmt.setString(5, email);
            pstmt.setString(6, job);
            pstmt.setString(7, home);
            pstmt.setInt(8, id_movie);
            pstmt.setString(9, date_rented);
            pstmt.setInt(10,to_pay);
            pstmt.executeUpdate();
            System.out.println("User-ul " + name + " a fost adaugat!");
        }
    }

    public void addMovie(int id_movie, String name, int year, String director, int rating, String genre, int nrOf) throws SQLException {
        Connection con = ConnectSQL.getConnection();
        try (PreparedStatement pstmt = con.prepareStatement(
                "insert into MOVIES (id_movie, name, year, director, rating, genre, nr_of) values (?,?,?,?,?,?,?)")) {
            pstmt.setInt(1, id_movie);
            pstmt.setString(2, name);
            pstmt.setInt(3, year);
            pstmt.setString(4, director);
            pstmt.setInt(5, rating);
            pstmt.setString(6, genre);
            pstmt.setInt(7, nrOf);
            pstmt.executeUpdate();
            System.out.println("Filmul " + name + " a fost adaugat!");
        }
    }



    public String findMovieById(int movieId) throws SQLException {
        Connection con = ConnectSQL.getConnection();
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(
                     "select name from movies where id_movie='" + movieId + "'")) {
            return rs.next() ? rs.getString(1) : null;
        }
    }


    public void newMovies(){
        try{
            CallableStatement statement = null;
            String sql = "{call new_movies()}";
            statement = ConnectSQL.getConnection().prepareCall(sql);
            statement.execute();
            System.out.println("Filmele noi, aparute dupa anul 2009, primesc +2 rating!");
            statement.close();
        } catch (SQLException e){
            System.out.println("Exception catched: Nu exista filme noi.");
        }
    }

    public void hasToPay() {
        try{
            CallableStatement statement = null;
            String sql = "{call has_to_pay()}";
            statement = ConnectSQL.getConnection().prepareCall(sql);
            statement.execute();
            System.out.println("Utilizatorii care au depasit numarul de zile de imprumut sunt taxati cu 50 de lei!");
            statement.close();
        } catch (SQLException e){
            System.out.println("Exception catched: Nu exita utilizatori");
        }
    }

    public void deleteMovie(){
        try{
            CallableStatement statement = null;
            String sql = "{call delete_movie()}";
            statement = ConnectSQL.getConnection().prepareCall(sql);
            statement.execute();
            System.out.println("Filmele care nu mai sunt disponibile de inchiriat sunt sterse din tabela.");
            statement.close();
        } catch (SQLException e) {
            System.out.println("Exception catched: Nu exista filme care trebuie sterse din tabela!");
        }
    }

    public void rentMovie(int userId, int movieId) {
        try{
            CallableStatement statement = null;
            String sql = "{call rent_movie(?,?)}";
            statement = ConnectSQL.getConnection().prepareCall(sql);
            statement.setInt(1, userId);
            statement.setInt(2, movieId);
            statement.execute();
            System.out.println("User-ul cu id = " + userId + " imprumuta filmul cu id = " + movieId);
        } catch (SQLException e){
            System.out.println("Exception catched: Utilizatorul sau filmul nu exista!");
        }
    }

}
