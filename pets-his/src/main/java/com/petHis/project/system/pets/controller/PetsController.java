package com.petHis.project.system.pets.controller;

import java.util.List;

import com.petHis.common.utils.file.FileUploadUtils;
import com.petHis.common.utils.file.MimeTypeUtils;
import com.petHis.framework.config.PetHisConfig;
import com.petHis.project.system.user.domain.User;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.petHis.framework.aspectj.lang.annotation.Log;
import com.petHis.framework.aspectj.lang.enums.BusinessType;
import com.petHis.project.system.pets.domain.Pets;
import com.petHis.project.system.pets.service.IPetsService;
import com.petHis.framework.web.controller.BaseController;
import com.petHis.framework.web.domain.AjaxResult;
import com.petHis.common.utils.poi.ExcelUtil;
import com.petHis.framework.web.page.TableDataInfo;
import org.springframework.web.multipart.MultipartFile;

/**
 * 宠物Controller
 * 
 * @author petHis
 * @date 2025-02-17
 */
@Controller
@RequestMapping("/system/pets")
//@Service("pets")
public class PetsController extends BaseController
{
    private String prefix = "system/pets";

    @Autowired
    private IPetsService petsService;

    @RequiresPermissions("system:pets:view")
    @GetMapping()
    public String pets()
    {
        return prefix + "/pets";
    }

    /**
     * 查询宠物列表
     */
    @RequiresPermissions("system:pets:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Pets pets)
    {
        startPage();
        List<Pets> list = petsService.selectPetsList(pets);
        // 将宠物列表添加到 ModelMap 中，键名为 "petList"
//        modelMap.addAttribute("petList", petList);

        return getDataTable(list);
    }

    /**
     * 导出宠物列表
     */
    @RequiresPermissions("system:pets:export")
    @Log(title = "宠物", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Pets pets)
    {
        List<Pets> list = petsService.selectPetsList(pets);
        ExcelUtil<Pets> util = new ExcelUtil<Pets>(Pets.class);
        return util.exportExcel(list, "宠物数据");
    }

    /**
     * 新增宠物
     */
    @RequiresPermissions("system:pets:add")
    @GetMapping("/add")
    public String add()
    {
        return prefix + "/add";
    }

    /**
     * 新增保存宠物
     */
    @RequiresPermissions("system:pets:add")
    @Log(title = "宠物", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Pets pets)
    {
        return toAjax(petsService.insertPets(pets));
    }

    /**
     * 宠物图片上传（复用若依工具类）
     */
//    @PostMapping("/uploadImage")
//    public AjaxResult uploadImage(@RequestParam("file") MultipartFile file) {
//        try {
//            // 校验文件类型（复用若依常量）
//            if (!FileUploadUtils.isAllowedExtension(file, MimeTypeUtils.IMAGE_EXTENSION)) {
//                return AjaxResult.error("仅允许上传图片文件");
//            }
//
//            // 生成存储路径（使用若依配置）
//            String baseDir = RuoYiConfig.getProfile();
//            String petImagePath = "/pet_images/";  // 宠物图片专用目录
//
//            // 调用若依文件工具类
//            String fileName = FileUploadUtils.upload(baseDir + petImagePath, file);
//
//            // 拼接访问URL
//            String fullPath = RuoYiConfig.getUrl() + petImagePath + fileName;
//
//            return AjaxResult.success("上传成功", Map.of("url", fullPath));
//        } catch (IOException e) {
//            return AjaxResult.error("图片上传失败：" + e.getMessage());
//        }
//    }

    /**
     * 修改宠物
     */
    @RequiresPermissions("system:pets:edit")
    @GetMapping("/edit/{petId}")
    public String edit(@PathVariable("petId") Long petId, ModelMap mmap)
    {
        Pets pets = petsService.selectPetsByPetId(petId);
        mmap.put("pets", pets);
        return prefix + "/edit";
    }

    /**
     * 修改保存宠物
     */
    @RequiresPermissions("system:pets:edit")
    @Log(title = "宠物", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Pets pets)
    {
        return toAjax(petsService.updatePets(pets));
    }

    /**
     * 删除宠物
     */
    @RequiresPermissions("system:pets:remove")
    @Log(title = "宠物", businessType = BusinessType.DELETE)
    @PostMapping( "/remove")
    @ResponseBody
    public AjaxResult remove(String ids)
    {
        return toAjax(petsService.deletePetsByPetIds(ids));
    }
}
