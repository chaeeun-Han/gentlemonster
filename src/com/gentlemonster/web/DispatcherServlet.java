package com.gentlemonster.web;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gentlemonster.web.handler.CommandHandler;

public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Map<String, CommandHandler> commandHandlerMap = new HashMap<>();
	
	public void init() throws ServletException{
		String basePackage = getInitParameter("basePackage");
		
        try {
            Class<?>[] handlerClasses = getClasses(basePackage);
            for (Class<?> handlerClass : handlerClasses) {
                // 클래스에 @RequestMapping 어노테이션 있는지 확인
                if (handlerClass.isAnnotationPresent(RequestMapping.class)) {
                    RequestMapping annotation = handlerClass.getAnnotation(RequestMapping.class);
                    String command = annotation.value();  // 어노테이션에서 URL 가져옴

                    // 핸들러 객체 생성
                    CommandHandler handlerInstance = (CommandHandler) handlerClass.getDeclaredConstructor().newInstance();
                    commandHandlerMap.put(command, handlerInstance);
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processServlet(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String methodOverride = request.getParameter("action");

	    if (methodOverride != null) {
	    	request.setAttribute("method", methodOverride.toUpperCase());
	    }
		
		processServlet(request, response);
	}
	
	private void processServlet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
	    
		String command = request.getRequestURI();
		
		if(command.indexOf(request.getContextPath()) == 0) {
			command = command.substring(request.getContextPath().length());
		}
 
		CommandHandler handler = commandHandlerMap.get(command);

		System.out.println(command + " : " + commandHandlerMap.get(command));
		
		String viewPage = null;
		try {
			viewPage = handler.process(request, response);
			if((viewPage != null) && (viewPage.indexOf("redirect:")) == 0) {
				viewPage = viewPage.substring(9);
				response.sendRedirect(request.getContextPath() + viewPage);
				return;
			}
		}catch(Throwable e) {
			throw new ServletException(e);
		}
		
		if(viewPage != null) {
			viewPage = "/WEB-INF/views/" + viewPage;
		}else {
			viewPage = "index.jsp";
		}
		
		RequestDispatcher disp = request.getRequestDispatcher(viewPage);
		disp.forward(request, response);
	}

    // 패키지 경로에 있는 모든 파일 가져옴
	private Class<?>[] getClasses(String basePackage) throws ClassNotFoundException {
        String path = getClass().getClassLoader().getResource(basePackage.replace('.', '/')).getFile();
        File dir = new File(path);
        File[] files = dir.listFiles((dir1, name) -> name.endsWith(".class"));
        if (files == null) {
            return new Class<?>[0];
        }

        List<Class<?>> classes = new ArrayList<>();
        for (File file : files) {
            String className = basePackage + '.' + file.getName().replace(".class", "");
            classes.add(Class.forName(className));
        }

        return classes.toArray(new Class<?>[0]);
	}
}

