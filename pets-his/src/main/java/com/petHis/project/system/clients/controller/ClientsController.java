package com.petHis.project.system.clients.controller;

import java.util.List;

import com.petHis.project.system.clients.mapper.ClientsMapper;
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
import com.petHis.project.system.clients.domain.Clients;
import com.petHis.project.system.clients.service.IClientsService;
import com.petHis.framework.web.controller.BaseController;
import com.petHis.framework.web.domain.AjaxResult;
import com.petHis.common.utils.poi.ExcelUtil;
import com.petHis.framework.web.page.TableDataInfo;

//import static com.petHis.contract.ContractUtils.generateKeyPairAndAddress;

/**
 * 客户Controller
 * 
 * @author petHis
 * @date 2025-02-16
 */
@Controller
@RequestMapping("/system/clients")
public class ClientsController extends BaseController
{
    private String prefix = "system/clients";

    @Autowired
    private IClientsService clientsService;

    @RequiresPermissions("system:clients:view")
    @GetMapping()
    public String clients()
    {
        return prefix + "/clients";
    }

    /**
     * 查询客户列表
     */
    @RequiresPermissions("system:clients:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Clients clients)
    {
        startPage();
        List<Clients> list = clientsService.selectClientsList(clients);
        return getDataTable(list);
    }

    /**
     * 导出客户列表
     */
    @RequiresPermissions("system:clients:export")
    @Log(title = "客户", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Clients clients)
    {
        List<Clients> list = clientsService.selectClientsList(clients);
        ExcelUtil<Clients> util = new ExcelUtil<Clients>(Clients.class);
        return util.exportExcel(list, "客户数据");
    }

    /**
     * 新增客户
     */
    @RequiresPermissions("system:clients:add")
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存客户
     */
    @RequiresPermissions("system:clients:add")
    @Log(title = "客户", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Clients clients)
    {
        return toAjax(clientsService.insertClients(clients));
    }

    /**
     * 修改客户
     */
    @RequiresPermissions("system:clients:edit")
    @GetMapping("/edit/{clientId}")
    public String edit(@PathVariable("clientId") Long clientId, ModelMap mmap)
    {
        Clients clients = clientsService.selectClientsByClientId(clientId);
        mmap.put("clients", clients);
        return prefix + "/edit";
    }

    /**
     * 修改保存客户
     */
    @RequiresPermissions("system:clients:edit")
    @Log(title = "客户", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Clients clients)
    {
        return toAjax(clientsService.updateClients(clients));
    }

    /**
     * 删除客户
     */
    @RequiresPermissions("system:clients:remove")
    @Log(title = "客户", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(clientsService.deleteClientsByClientIds(ids));
    }

////    校验客户手机号
//    @GetMapping("system:clients:checkPhone")
//    public AjaxResult checkPhoneDuplicate(String phone) {
////        boolean exists = clientService.checkPhoneExists(phone);
//        boolean exists = IClientsService.checkPhoneExists(phone);
//        return AjaxResult.success().put("exists", exists);
//    }
//
////    通过手机号查询客户列表
//    @RequiresPermissions("system:clients:listByPhone")
//    @PostMapping( "/listByPhone")
//    @ResponseBody
//    public TableDataInfo listClientsByPhone(String phone) {
//        startPage();
////        List<Clients> list = clientService.selectClientsByPhone(phone);
//        List<Clients> list = clientsService.selectClientsByPhone(phone);
//        return getDataTable(list);
//    }
}

