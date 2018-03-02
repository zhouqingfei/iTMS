package backend.dashboard.service.impl;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.Socket;
  
/**
 * 瀹㈡埛绔�
 */
public class Client extends Socket{
      
    private static final String SERVER_IP ="100.2.38.226";
    private static final int SERVER_PORT =2013;
      
    private Socket client;
    private FileInputStream fis;
    private DataOutputStream dos;
      
    
//    private DataInputStream dis;
//	private FileOutputStream fos;
    public Client(){
        try {
            try {
                client =new Socket(SERVER_IP, SERVER_PORT);
                //鍚戞湇鍔＄浼犻�佹枃浠�
                if(client.isConnected())
                {
                	System.out.println("Connneted");
                }
                //File file =new File("/home/acp/testTask.xml");
                File file =new File("D:\\testTask.xml");
                fis =new FileInputStream(file);
                dos =new DataOutputStream(client.getOutputStream());
                //dis = new DataInputStream(client.getInputStream());
                  
                //鏂囦欢鍚嶅拰闀垮害
                dos.writeUTF(file.getName());
                dos.flush();
                dos.writeLong(file.length());
                dos.flush();
                  
                //浼犺緭鏂囦欢
                byte[] sendBytes =new byte[1024];
                int length =0;
                while((length = fis.read(sendBytes,0, sendBytes.length)) >0){
                    dos.write(sendBytes,0, length);
                    dos.flush();
                }
                //dos.close();
                
                
                if(client.isConnected())
                {
                	System.out.println("connected");
                }
                
                
                
            }catch (Exception e) {
                e.printStackTrace();
            }
            finally{
//                if(fis !=null)
//                    fis.close();
//                if(dos !=null)
//                    dos.close();
                //client.close();
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
      
    
}