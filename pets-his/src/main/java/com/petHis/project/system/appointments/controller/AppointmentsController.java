package com.petHis.project.system.appointments.controller;

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
import com.petHis.project.system.appointments.domain.Appointments;
import com.petHis.project.system.appointments.service.IAppointmentsService;
import com.petHis.framework.web.controller.BaseController;
import com.petHis.framework.web.domain.AjaxResult;
import com.petHis.common.utils.poi.ExcelUtil;
import com.petHis.framework.web.page.TableDataInfo;

/**
 * 预约Controller
 * 
 * @author petHis
 * @date 2025-02-16
 */
@Controller
@RequestMapping("/system/appointments")
public class AppointmentsController extends BaseController
{
    private String prefix = "system/appointments";

    @Autowired
    private IAppointmentsService appointmentsService;

    @RequiresPermissions("system:appointments:view")
    @GetMapping()
    public String appointments()
    {
        return prefix + "/appointments";
    }

    /**
     * 查询预约列表
     */
    @RequiresPermissions("system:appointments:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Appointments appointments)
    {
        startPage();
        List<Appointments> list = appointmentsService.selectAppointmentsList(appointments);
        return getDataTable(list);
    }

    /**
     * 导出预约列表
     */
    @RequiresPermissions("system:appointments:export")
    @Log(title = "预约", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Appointments appointments)
    {
        List<Appointments> list = appointmentsService.selectAppointmentsList(appointments);
        ExcelUtil<Appointments> util = new ExcelUtil<Appointments>(Appointments.class);
        return util.exportExcel(list, "预约数据");
    }

    /**
     * 新增预约
     */
    @RequiresPermissions("system:appointments:add")
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存预约
     */
    @RequiresPermissions("system:appointments:add")
    @Log(title = "预约", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Appointments appointments)
    {
        try {
            int rows = appointmentsService.insertAppointments(appointments);
            return toAjax(rows);
        }catch (RuntimeException e){
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 修改预约
     */
    @RequiresPermissions("system:appointments:edit")
    @GetMapping("/edit/{appointmentId}")
    public String edit(@PathVariable("appointmentId") Long appointmentId, ModelMap mmap)
    {
        Appointments appointments = appointmentsService.selectAppointmentsByAppointmentId(appointmentId);
        mmap.put("appointments", appointments);
        return prefix + "/edit";
    }

    /**
     * 修改保存预约
     */
    @RequiresPermissions("system:appointments:edit")
    @Log(title = "预约", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Appointments appointments)
    {
        return toAjax(appointmentsService.updateAppointments(appointments));
    }

    /**
     * 删除预约
     */
    @RequiresPermissions("system:appointments:remove")
    @Log(title = "预约", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(appointmentsService.deleteAppointmentsByAppointmentIds(ids));
    }

    /**
     * 判断数据表里是否已经存在同宠物同时间的预约信息
     * */

    public int isPetAlreadyBookedOnDate(Appointments appointments){
        return appointmentsService.isPetAlreadyBookedOnDate(appointments);
    }

}
