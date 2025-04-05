package com.petHis.project.system.record.controller;

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
import com.petHis.project.system.record.domain.MedicationRecord;
import com.petHis.project.system.record.service.IMedicationRecordService;
import com.petHis.framework.web.controller.BaseController;
import com.petHis.framework.web.domain.AjaxResult;
import com.petHis.common.utils.poi.ExcelUtil;
import com.petHis.framework.web.page.TableDataInfo;

/**
 * 用药记录Controller
 * 
 * @author petHis
 * @date 2025-02-23
 */
@Controller
@RequestMapping("/system/record")
public class MedicationRecordController extends BaseController
{
    private String prefix = "system/record";

    @Autowired
    private IMedicationRecordService medicationRecordService;

    @RequiresPermissions("system:record:view")
    @GetMapping()
    public String record()
    {
        return prefix + "/record";
    }

    /**
     * 查询用药记录列表
     */
    @RequiresPermissions("system:record:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(MedicationRecord medicationRecord)
    {
        startPage();
        List<MedicationRecord> list = medicationRecordService.selectMedicationRecordList(medicationRecord);
        return getDataTable(list);
    }

    /**
     * 导出用药记录列表
     */
    @RequiresPermissions("system:record:export")
    @Log(title = "用药记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(MedicationRecord medicationRecord)
    {
        List<MedicationRecord> list = medicationRecordService.selectMedicationRecordList(medicationRecord);
        ExcelUtil<MedicationRecord> util = new ExcelUtil<MedicationRecord>(MedicationRecord.class);
        return util.exportExcel(list, "用药记录数据");
    }

    /**
     * 新增用药记录
     */
    @RequiresPermissions("system:record:add")
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存用药记录
     */
    @RequiresPermissions("system:record:add")
    @Log(title = "用药记录", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(MedicationRecord medicationRecord)
    {
        return toAjax(medicationRecordService.insertMedicationRecord(medicationRecord));
    }

    /**
     * 修改用药记录
     */
    @RequiresPermissions("system:record:edit")
    @GetMapping("/edit/{medicationId}")
    public String edit(@PathVariable("medicationId") Long medicationId, ModelMap mmap)
    {
        MedicationRecord medicationRecord = medicationRecordService.selectMedicationRecordByMedicationId(medicationId);
        mmap.put("medicationRecord", medicationRecord);
        return prefix + "/edit";
    }

    /**
     * 修改保存用药记录
     */
    @RequiresPermissions("system:record:edit")
    @Log(title = "用药记录", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(MedicationRecord medicationRecord)
    {
        return toAjax(medicationRecordService.updateMedicationRecord(medicationRecord));
    }

    /**
     * 删除用药记录
     */
    @RequiresPermissions("system:record:remove")
    @Log(title = "用药记录", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(medicationRecordService.deleteMedicationRecordByMedicationIds(ids));
    }
}
