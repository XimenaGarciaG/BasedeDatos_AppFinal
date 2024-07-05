import javax.swing.JOptionPane;
import edu.mx.uttt.bdapp.control.CtrlCliente;
import edu.mx.uttt.bdapp.entidades.Cliente;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author j
 */
public class Vista_Cliente {
    public static void main(String[] args) {
         Cliente cl = new Cliente();
        cl.setCustomerId("DSMG3");
        cl.setCompanyName("Gallina de Hule");
        cl.setContactName("Lizetg Kasumi pando");
        cl.setContactTitle("Gerente de ASI");
        cl.setAddress("Av. Libre");
        cl.setCity("Salte si puedes");
        cl.setRegion("Este");
        cl.setPostalCode("42800");
        cl.setCountry("Irlandia");
        cl.setPhone("1234-456789");
        cl.setFax("546789IHH");
        // Enviar
        CtrlCliente ctrlCli = new CtrlCliente();
        ctrlCli.agregar(cl);
        
    }
}
