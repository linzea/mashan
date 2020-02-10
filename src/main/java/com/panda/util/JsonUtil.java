package com.panda.util;

import com.alibaba.fastjson.JSONObject;

import java.util.Map;

public class JsonUtil {

	/**
	 * 将map转化为string
	 * @param m
	 * @return
	 */
	public static String collectToString(Map m) {
		String s = JSONObject.toJSONString(m);
		return s;
	}
}
