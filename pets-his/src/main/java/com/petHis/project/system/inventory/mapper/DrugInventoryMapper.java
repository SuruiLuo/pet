package com.petHis.project.system.inventory.mapper;

import java.util.List;
import com.petHis.project.system.inventory.domain.DrugInventory;

/**
 * 药品库存Mapper接口
 * 
 * @author petHis
 * @date 2025-02-23
 */
public interface DrugInventoryMapper 
{
    /**
     * 查询药品库存
     * 
     * @param drugId 药品库存主键
     * @return 药品库存
     */
    public DrugInventory selectDrugInventoryByDrugId(Long drugId);

    /**
     * 查询药品库存列表
     * 
     * @param drugInventory 药品库存
     * @return 药品库存集合
     */
    public List<DrugInventory> selectDrugInventoryList(DrugInventory drugInventory);

    /**
     * 新增药品库存
     * 
     * @param drugInventory 药品库存
     * @return 结果
     */
    public int insertDrugInventory(DrugInventory drugInventory);

    /**
     * 修改药品库存
     * 
     * @param drugInventory 药品库存
     * @return 结果
     */
    public int updateDrugInventory(DrugInventory drugInventory);

    /**
     * 删除药品库存
     * 
     * @param drugId 药品库存主键
     * @return 结果
     */
    public int deleteDrugInventoryByDrugId(Long drugId);

    /**
     * 批量删除药品库存
     * 
     * @param drugIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteDrugInventoryByDrugIds(String[] drugIds);
}
