package backend.entity;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Component
public class ItmsTestCase {

	private int id;
	private String name;
	private String number;
	private String version;
	private String writer;
	private String category1;
	private String category2;
	private String category3;
	private String level;
	private String product;
	private String manualtime;
	private String autotime;
	private String status;
	private String versionchangelog;
	private String condition;
	private String comment;
	private String autoconnect;
	private String step;
	private String expect;
	
	private String script;
	private String param;
	private String ip;
	private String script_status;
	private String result;
	private String result_location;
	public String getScript() {
		return script;
	}
	public void setScript(String script) {
		this.script = script;
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getScript_status() {
		return script_status;
	}
	public void setScript_status(String script_status) {
		this.script_status = script_status;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getResult_location() {
		return result_location;
	}
	public void setResult_location(String result_location) {
		this.result_location = result_location;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getCategory1() {
		return category1;
	}
	public void setCategory1(String category1) {
		this.category1 = category1;
	}
	public String getCategory2() {
		return category2;
	}
	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	public String getCategory3() {
		return category3;
	}
	public void setCategory3(String category3) {
		this.category3 = category3;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getManualtime() {
		return manualtime;
	}
	public void setManualtime(String manualtime) {
		this.manualtime = manualtime;
	}
	public String getAutotime() {
		return autotime;
	}
	public void setAutotime(String autotime) {
		this.autotime = autotime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getVersionchangelog() {
		return versionchangelog;
	}
	public void setVersionchangelog(String versionchangelog) {
		this.versionchangelog = versionchangelog;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getAutoconnect() {
		return autoconnect;
	}
	public void setAutoconnect(String autoconnect) {
		this.autoconnect = autoconnect;
	}
	public String getStep() {
		return step;
	}
	public void setStep(String step) {
		this.step = step;
	}
	public String getExpect() {
		return expect;
	}
	public void setExpect(String expect) {
		this.expect = expect;
	}
}
