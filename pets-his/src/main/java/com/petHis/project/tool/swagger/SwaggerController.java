package com.petHis.project.tool.swagger;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.petHis.framework.web.controller.BaseController;

/**
 * swagger 接口
 * 
 * @author petHis
 */
@Controller
@RequestMapping("/tool/swagger")
public class SwaggerController extends BaseController
{
    @RequiresPermissions("tool:swagger:view")
    @GetMapping()
    public String index()
    {
        return redirect("/swagger-ui/index.html");
    }
}
