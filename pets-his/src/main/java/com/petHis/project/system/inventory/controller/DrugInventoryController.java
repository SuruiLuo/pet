package com.petHis.project.system.inventory.controller;

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
import com.petHis.project.system.inventory.domain.DrugInventory;
import com.petHis.project.system.inventory.service.IDrugInventoryService;
import com.petHis.framework.web.controller.BaseController;
import com.petHis.framework.web.domain.AjaxResult;
import com.petHis.common.utils.poi.ExcelUtil;
import com.petHis.framework.web.page.TableDataInfo;

/**
 * 药品库存Controller
 * 
 * @author petHis
 * @date 2025-02-23
 */
@Controller
@RequestMapping("/system/inventory")
public class DrugInventoryController extends BaseController
{
    private String prefix = "system/inventory";

    @Autowired
    private IDrugInventoryService drugInventoryService;

    @RequiresPermissions("system:inventory:view")
    @GetMapping()
    public String inventory()
    {
        return prefix + "/inventory";
    }

    /**
     * 查询药品库存列表
     */
    @RequiresPermissions("system:inventory:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(DrugInventory drugInventory)
    {
        startPage();
        List<DrugInventory> list = drugInventoryService.selectDrugInventoryList(drugInventory);
        return getDataTable(list);
    }

    /**
     * 导出药品库存列表
     */
    @RequiresPermissions("system:inventory:export")
    @Log(title = "药品库存", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(DrugInventory drugInventory)
    {
        List<DrugInventory> list = drugInventoryService.selectDrugInventoryList(drugInventory);
        ExcelUtil<DrugInventory> util = new ExcelUtil<DrugInventory>(DrugInventory.class);
        return util.exportExcel(list, "药品库存数据");
    }

    /**
     * 新增药品库存
     */
    @RequiresPermissions("system:inventory:add")
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存药品库存
     */
    @RequiresPermissions("system:inventory:add")
    @Log(title = "药品库存", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(DrugInventory drugInventory)
    {
        return toAjax(drugInventoryService.insertDrugInventory(drugInventory));
    }

    /**
     * 修改药品库存
     */
    @RequiresPermissions("system:inventory:edit")
    @GetMapping("/edit/{drugId}")
    public String edit(@PathVariable("drugId") Long drugId, ModelMap mmap)
    {
        DrugInventory drugInventory = drugInventoryService.selectDrugInventoryByDrugId(drugId);
        mmap.put("drugInventory", drugInventory);
        return prefix + "/edit";
    }

    /**
     * 修改保存药品库存
     */
    @RequiresPermissions("system:inventory:edit")
    @Log(title = "药品库存", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(DrugInventory drugInventory)
    {
        return toAjax(drugInventoryService.updateDrugInventory(drugInventory));
    }

    /**
     * 删除药品库存
     */
    @RequiresPermissions("system:inventory:remove")
    @Log(title = "药品库存", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(drugInventoryService.deleteDrugInventoryByDrugIds(ids));
    }
}
