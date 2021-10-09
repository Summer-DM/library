package com.example.library.controller;

import com.example.library.commonResult.CommonDateResult;
import com.example.library.model.Borrow;
import com.example.library.model.SpaceApplication;
import com.example.library.service.AuditService;
import com.example.library.utils.paramUtils.ParamUtils;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @Author Summer_DM
 * @Summary TODO  审核管理页面
 * @Version 1.0
 * @Date 2021/10/9 下午 02:03
 **/
@Controller
@RequestMapping("/audit")
public class AuditController {
    private static final Logger log = LoggerFactory.getLogger(AuditController.class);
    @Autowired
    private AuditService auditService;
    /**
     * 跳转到审核管理页面
     * @param map
     * @return
     */
    @RequestMapping("auditIndex")
    public String auditIndex(Map map) {
        log.info("通过首页跳转到审核管理页面");
        return "audit/spaceApply";
    }
    /**
     * 跳转到审核管理页面
     * @return
     */
    @RequestMapping("/spaceApply")
    @ResponseBody
    public PageInfo<SpaceApplication> queryBorrowers(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        int pageNo = ParamUtils.getInt(request, "pageNo", 1); // 页码
        int pageSize = ParamUtils.getInt(request, "pageSize", 10); // 取得显示条数
        PageInfo<SpaceApplication> applylist = auditService.spaceApply(pageNo,pageSize);
        return applylist;
    }
}
