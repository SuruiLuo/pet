package com.petHis.project.system.company.controller;

import java.util.List;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.petHis.framework.aspectj.lang.annotation.Log;
import com.petHis.framework.aspectj.lang.enums.BusinessType;
import com.petHis.project.system.company.domain.Company;
import com.petHis.project.system.company.service.ICompanyService;
import com.petHis.framework.web.controller.BaseController;
import com.petHis.framework.web.domain.AjaxResult;
import com.petHis.common.utils.poi.ExcelUtil;
import com.petHis.framework.web.page.TableDataInfo;

/**
 * companyController
 * 
 * @author petHis
 * @date 2025-03-17
 */
@Controller
@RequestMapping("/system/company")
public class CompanyController extends BaseController
{
    private String prefix = "system/company";

    @Autowired
    private ICompanyService companyService;

    @RequiresPermissions("system:company:view")
    @GetMapping()
    public String company()
    {
        return prefix + "/company";
    }

    /**
     * 查询company列表
     */
    @RequiresPermissions("system:company:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Company company)
    {
        startPage();
        List<Company> list = companyService.selectCompanyList(company);
        return getDataTable(list);
    }

    /**
     * 导出company列表
     */
    @RequiresPermissions("system:company:export")
    @Log(title = "company", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Company company)
    {
        List<Company> list = companyService.selectCompanyList(company);
        ExcelUtil<Company> util = new ExcelUtil<Company>(Company.class);
        return util.exportExcel(list, "company数据");
    }

    /**
     * 新增company
     */
    @RequiresPermissions("system:company:add")
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存company
     */
    @RequiresPermissions("system:company:add")
    @Log(title = "company", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Company company)
    {
        return toAjax(companyService.insertCompany(company));
    }

    /**
     * 修改company
     */
    @RequiresPermissions("system:company:edit")
    @GetMapping("/edit/{companyId}")
    public String edit(@PathVariable("companyId") Long companyId, ModelMap mmap)
    {
        Company company = companyService.selectCompanyByCompanyId(companyId);
        mmap.put("company", company);
        return prefix + "/edit";
    }

    /**
     * 修改保存company
     */
    @RequiresPermissions("system:company:edit")
    @Log(title = "company", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Company company)
    {
        return toAjax(companyService.updateCompany(company));
    }

    /**
     * 删除company
     */
    @RequiresPermissions("system:company:remove")
    @Log(title = "company", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(companyService.deleteCompanyByCompanyIds(ids));
    }
}
