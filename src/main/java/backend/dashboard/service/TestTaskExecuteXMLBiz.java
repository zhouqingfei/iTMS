package backend.dashboard.service;

import java.io.IOException;

import org.jdom2.JDOMException;

public interface TestTaskExecuteXMLBiz {

	public void execute(int id,String loginId) throws IOException, JDOMException;

}
