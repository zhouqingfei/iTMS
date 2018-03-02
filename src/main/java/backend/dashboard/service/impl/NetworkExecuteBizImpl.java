package backend.dashboard.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;


import backend.dashboard.service.MachineBiz;
import backend.dashboard.service.NetworkBiz;
import backend.dashboard.service.NetworkExecuteBiz;
import backend.entity.Machine;
import backend.entity.Network;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.annotation.Resource;


@Service
public class NetworkExecuteBizImpl implements NetworkExecuteBiz {

	static Logger logger = LoggerFactory.getLogger(NetworkExecuteBizImpl.class);
	@Resource(name = "networkBizImpl")
    private NetworkBiz netwokBiz;
    @Resource(name = "machineBizImpl")
    private MachineBiz machineBiz;
    
	@Override
	public String execute(int id,String loginID) throws Exception {
		 Network network = netwokBiz.findByid(Integer.valueOf(id));
		 String addr=network.getAddr();
		 String ip=network.getIp();
		 String user=network.getUser();
		 String psd=network.getPsd();
		 System.out.println(ip+"~~~"+user+"~~~"+psd);
		 machineBiz.delete(loginID);
		 String msg=ssh(ip,user,psd,addr,loginID);
		 return  msg;
		
	}
    public String ssh(String ip,String user,String psd,String addr,String loginID) throws Exception{
    	String msg="";
    	ArrayList<String> IPList=new ArrayList<>();
    	ArrayList<String> MACList=new ArrayList<>();
    	
    	//SshClient client=new SshClient();
    	Date date=new Date();
    	/*DateFormat format =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	Date time=format.format(date);*/
        try{
        	JSch jsch = new JSch();  
        	Session session = jsch.getSession(user, ip, 22);  
        	session.setPassword(psd);  
            java.util.Properties config = new java.util.Properties();  
            config.put("StrictHostKeyChecking", "no");  
            session.setConfig(config);  
            session.connect();  
            ChannelSftp  channel = (ChannelSftp)session.openChannel("sftp");
            channel.connect(5000);  
            FileOutputStream  outputStream = new FileOutputStream(new File("/dhcpd.leases"));  
            channel.get("/var/lib/dhcpd/dhcpd.leases", outputStream);  
            outputStream.flush();  
            channel.quit();
            session.disconnect();
           // client.connect(ip);
            //设置用户名和密码
          /*  PasswordAuthenticationClient pwd = new PasswordAuthenticationClient();
            pwd.setUsername(user);
            pwd.setPassword(psd);
            int result=client.authenticate(pwd);*/
            String content="";
            String encoding="UTF-8";
            /*logger.warn("==============="+result);
            if(result==AuthenticationProtocolState.COMPLETE){//如果连接完成 
                System.out.println("==============="+result);*/
                /*OutputStream os = new FileOutputStream("/dhcpd.leases");
                client.openSftpClient().get("/var/lib/dhcpd/dhcpd.leases", os);*/
                        //以行为单位读取文件start
                        File file = new File("/dhcpd.leases");
                        Long filelength=file.length();
                        byte[] filecontent=new byte[filelength.intValue()];
                        try {
                        	FileInputStream in=new FileInputStream(file);
                        	in.read(filecontent);
                        	in.close();
                        }catch(FileNotFoundException e) {
                        	e.printStackTrace();
                        }catch(IOException e) {
                        	e.printStackTrace();
                        }
                        content=new String(filecontent,encoding);
                        //System.out.println(content+"~~~~~~~~~~~~~~~~~~~~~~~");
                        String arry[]=content.split("lease");
                        System.out.println(arry.length);
                        for(int i=0;i<arry.length;i++) {
                        	String dhcpdata=arry[i];
                        	/*System.out.println(i);
                        	System.out.println(arry[i]);*/
                        	
                        	if(dhcpdata.contains("binding state active") && dhcpdata.contains("hardware ethernet")) {
                        		/*String resex_ip="\\d+\\.\\d+\\.\\d+\\.\\d+";
                        		Pattern patten_ip=Pattern.compile(resex_ip);
                        		System.out.println("4444444444");
                        		Matcher matcher_ip=patten_ip.matcher(dhcpdata);
                        		String ipdata=matcher_ip.group(0);
                        		System.out.println(ipdata);
                        		
                        		System.out.println("1111111111111111111");*/
                        		String ipdata=dhcpdata.substring(0,dhcpdata.indexOf("{")).trim();
                        		if(!IPList.contains(ipdata)) {
                        			//System.out.println(ipdata);
                            		IPList.add(ipdata);
                            		String arry1[]=dhcpdata.split("hardware ethernet");
                            		String macdata=arry1[1].substring(0, arry1[1].indexOf(";")).trim();
                            		//System.out.println(macdata);
                                    if(!MACList.contains(macdata)) {
                                    	MACList.add(macdata);
                                		Machine machine=new Machine();
                                		machine.setIp(ipdata);
                                		machine.setMac(macdata);
                                		machine.setTime(date);
                                		machine.setAddr(addr);
                                		machine.setUser_id(loginID);
                                		System.out.println(machine.getIp()+machine.getAddr()+machine.getMac()+machine.getTime()+machine.getUser_id());
                                        machineBiz.add(machine);
                                    }else {
                                    	Machine machine=new Machine();
                                		machine.setIp(ipdata);
                                		machine.setMac(macdata);
                                		machine.setTime(date);
                                		machine.setAddr(addr);
                                		machine.setUser_id(loginID);
                                		 machineBiz.update(machine);
                                    }
                            		
                        		}
                        	}
                        }
                        msg="Scan Success";
                   // }
        }catch(IOException e){
            e.printStackTrace();
            logger.warn("Scan Fail: ", e);
            msg="Scan Fail";
        } catch (JSchException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        return msg;
     /*   for(String ipda:IPList) {
        	System.out.println(ipda);
        }
        for(String ipda:MACList) {
        	System.out.println(ipda);
        }*/
        /*System.out.println(IPList.size());
        System.out.println(MACList.size());*/
    }
}
