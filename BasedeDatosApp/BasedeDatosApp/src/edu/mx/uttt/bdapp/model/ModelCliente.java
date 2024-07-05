/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.bdapp.model;

import edu.mx.uttt.bdapp.conexion.Conexion;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import edu.mx.uttt.bdapp.entidades.Cliente;
import edu.mx.uttt.bdapp.conexion.Conexion;

/**
 *
 * @author jlgallardoadmon
 */
public class ModelCliente {
    boolean sentinel=false;
    public static boolean agregar(Cliente cli) {
    Connection con = Conexion.conectar();
        PreparedStatement pat = null;

        String query = """
                       INSERT INTO [dbo].[Customers]
                       ([CustomerID]
                       ,[CompanyName]
                       ,[ContactName]
                       ,[ContactTitle]
                       ,[Address]
                       ,[City]
                       ,[Region]
                       ,[PostalCode]
                       ,[Country]
                       ,[Phone]
                       ,[Fax])
                        VALUES(?,?,?,?,?,?,?,?,?,?,?)""";

        try {
            pat=con.prepareStatement(query);
            pat.setString(1, cli.getCustomerId());
            pat.setString(2, cli.getCompanyName());
            pat.setString(3, cli.getContactName());
            pat.setString(4, cli.getContactTitle());
            pat.setString(5, cli.getAddress());
            pat.setString(6, cli.getCity());
            pat.setString(7, cli.getRegion());
            pat.setString(8, cli.getPostalCode());
            pat.setString(9, cli.getCountry());
            pat.setString(10, cli.getPhone());
            pat.setString(11, cli.getFax());
            
            //Ejecutar la consulta
            int numRows = pat.executeUpdate();
            if (numRows > 0) {
                System.out.println("En la tabla cliente se insertaron " + numRows + " registros correctamente");
            }
            sentinel = true;
        } catch (SQLException e) {
            System.out.println("Error :" + e.getMessage());
        } finally {
            Conexion.CerrarSesion();
        }

        return sentinel;

    }
}
