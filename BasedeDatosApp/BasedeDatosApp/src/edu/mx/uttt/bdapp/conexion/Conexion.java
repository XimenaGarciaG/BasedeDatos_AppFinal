package edu.mx.uttt.bdapp.conexion;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author j
 */
public class Conexion {

    static Connection con = null;

    public static Connection conectar() {
        String url
                = "jdbc:sqlserver://LAPTOP-29S7VP2M\\SQLEXPRESS;databaseName=Northwind;encrypt=true;trustServerCertificate=true";

        String user = "sa";
        String password = "123456789";

        try {
            con = DriverManager.getConnection(url, user, password);
            System.out.println("Conexion exitosa a la base de datos!");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            System.out.println("Error al conectar a la base de datos.");
        }
        return con;
    }

    public static void CerrarSesion() {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                System.out.println("No se pudo cerrar la conexion");
            }
        } else {
            System.out.println("La conexion esta cerrada");            
       }
    }
}
