package com.nbp.myapp.component;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.multipart.MultipartHttpServletRequest;



public class CustomizeMethodArgumentResolver implements HandlerMethodArgumentResolver{


	

	public boolean supportsParameter(MethodParameter methodParameter) {
		return MapParamCollector.class.isAssignableFrom(methodParameter.getParameterType());
	}


	public Object resolveArgument(MethodParameter methodParameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		Class<?> clazz = methodParameter.getParameterType();
		MapParamCollector requestMap = new MapParamCollector();
		if (clazz.equals(MapParamCollector.class)) {
			HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();
			Enumeration<?> enumeration = request.getParameterNames();

			while (enumeration.hasMoreElements()) {
				String key = (String) enumeration.nextElement();
				String[] values = request.getParameterValues(key);
				if (values != null) {
					requestMap.put(key, (values.length > 1) ? values : values[0]);
				}
			}

		}
		return requestMap;
	}
}
