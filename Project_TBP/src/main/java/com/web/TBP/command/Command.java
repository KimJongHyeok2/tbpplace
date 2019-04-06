package com.web.TBP.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public abstract class Command {
	public void execute(Model model) { }
	public void execute2(Model model, HttpServletRequest request) {	}
	public void execute3(Model model, HttpServletRequest response) { }
	public void execute4(Model model, HttpServletRequest request, HttpServletResponse response) { }
}
