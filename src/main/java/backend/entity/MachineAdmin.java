package backend.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MachineAdmin {

	private String model;
	private String type;
	private String status;
	private String line_status;
	private String os;
	private String host_mac;
	private String host_ip;
	private String bmc_mac;
	private String bmc_ip;
	private Date time;
	private String addr;
	private String user;
	private String user_id;
	private String comment;
	private String bmc_user;
	private String bmc_psd;
	private String bmc_ver;
	private String bios_ver;
	public String getBmc_ver() {
		return bmc_ver;
	}
	public void setBmc_ver(String bmc_ver) {
		this.bmc_ver = bmc_ver;
	}
	public String getBios_ver() {
		return bios_ver;
	}
	public void setBios_ver(String bios_ver) {
		this.bios_ver = bios_ver;
	}
	public String getBmc_user() {
		return bmc_user;
	}
	public void setBmc_user(String bmc_user) {
		this.bmc_user = bmc_user;
	}
	public String getBmc_psd() {
		return bmc_psd;
	}
	public void setBmc_psd(String bmc_psd) {
		this.bmc_psd = bmc_psd;
	}
	public String getModel() {
		return model;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getLine_status() {
		return line_status;
	}
	public void setLine_status(String line_status) {
		this.line_status = line_status;
	}
	public String getOs() {
		return os;
	}
	public void setOs(String os) {
		this.os = os;
	}
	public String getHost_mac() {
		return host_mac;
	}
	public void setHost_mac(String host_mac) {
		this.host_mac = host_mac;
	}
	public String getHost_ip() {
		return host_ip;
	}
	public void setHost_ip(String host_ip) {
		this.host_ip = host_ip;
	}
	public String getBmc_mac() {
		return bmc_mac;
	}
	public void setBmc_mac(String bmc_mac) {
		this.bmc_mac = bmc_mac;
	}
	public String getBmc_ip() {
		return bmc_ip;
	}
	public void setBmc_ip(String bmc_ip) {
		this.bmc_ip = bmc_ip;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
}
