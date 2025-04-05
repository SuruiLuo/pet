package com.petHis.project.system.insurance.controller;

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
import com.petHis.project.system.insurance.domain.Insurance;
import com.petHis.project.system.insurance.service.IInsuranceService;
import com.petHis.framework.web.controller.BaseController;
import com.petHis.framework.web.domain.AjaxResult;
import com.petHis.common.utils.poi.ExcelUtil;
import com.petHis.framework.web.page.TableDataInfo;

/**
 * 保险Controller
 * 
 * @author petHis
 * @date 2025-03-17
 */
@Controller
@RequestMapping("/system/insurance")
public class InsuranceController extends BaseController
{
    private String prefix = "system/insurance";

    @Autowired
    private IInsuranceService insuranceService;

    @RequiresPermissions("system:insurance:view")
    @GetMapping()
    public String insurance()
    {
        return prefix + "/insurance";
    }

    /**
     * 查询保险列表
     */
    @RequiresPermissions("system:insurance:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Insurance insurance)
    {
        startPage();
        List<Insurance> list = insuranceService.selectInsuranceList(insurance);
        return getDataTable(list);
    }

    /**
     * 导出保险列表
     */
    @RequiresPermissions("system:insurance:export")
    @Log(title = "保险", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Insurance insurance)
    {
        List<Insurance> list = insuranceService.selectInsuranceList(insurance);
        ExcelUtil<Insurance> util = new ExcelUtil<Insurance>(Insurance.class);
        return util.exportExcel(list, "保险数据");
    }

    /**
     * 新增保险
     */
    @RequiresPermissions("system:insurance:add")
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存保险
     */
    @RequiresPermissions("system:insurance:add")
    @Log(title = "保险", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Insurance insurance)
    {
        return toAjax(insuranceService.insertInsurance(insurance));
    }

    /**
     * 修改保险
     */
    @RequiresPermissions("system:insurance:edit")
    @GetMapping("/edit/{insuranceId}")
    public String edit(@PathVariable("insuranceId") Long insuranceId, ModelMap mmap)
    {
        Insurance insurance = insuranceService.selectInsuranceByInsuranceId(insuranceId);
        mmap.put("insurance", insurance);
        return prefix + "/edit";
    }

    /**
     * 修改保存保险
     */
    @RequiresPermissions("system:insurance:edit")
    @Log(title = "保险", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Insurance insurance)
    {
        return toAjax(insuranceService.updateInsurance(insurance));
    }

    /**
     * 删除保险
     */
    @RequiresPermissions("system:insurance:remove")
    @Log(title = "保险", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(insuranceService.deleteInsuranceByInsuranceIds(ids));
    }
}
