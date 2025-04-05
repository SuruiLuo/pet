package com.petHis.project.system.inventory.service.impl;

import java.math.BigDecimal;
import java.util.List;
import com.petHis.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.petHis.project.system.inventory.mapper.DrugInventoryMapper;
import com.petHis.project.system.inventory.domain.DrugInventory;
import com.petHis.project.system.inventory.service.IDrugInventoryService;
import com.petHis.common.utils.text.Convert;

/**
 * 药品库存Service业务层处理
 * 
 * @author petHis
 * @date 2025-02-23
 */
@Service
public class DrugInventoryServiceImpl implements IDrugInventoryService 
{
    @Autowired
    private DrugInventoryMapper drugInventoryMapper;

    /**
     * 查询药品库存
     * 
     * @param drugId 药品库存主键
     * @return 药品库存
     */
    @Override
    public DrugInventory selectDrugInventoryByDrugId(Long drugId)
    {
        return drugInventoryMapper.selectDrugInventoryByDrugId(drugId);
    }

    /**
     * 查询药品库存列表
     * 
     * @param drugInventory 药品库存
     * @return 药品库存
     */
    @Override
    public List<DrugInventory> selectDrugInventoryList(DrugInventory drugInventory)
    {
        return drugInventoryMapper.selectDrugInventoryList(drugInventory);
    }

    /**
     * 新增药品库存
     * 
     * @param drugInventory 药品库存
     * @return 结果
     */
    @Override
    public int insertDrugInventory(DrugInventory drugInventory)
    {
        drugInventory.setCreateTime(DateUtils.getNowDate());

        // 插入药品库存记录
        int result = drugInventoryMapper.insertDrugInventory(drugInventory);

        if (result > 0) {
            // 获取插入后的 drugId
            Long drugId = drugInventory.getDrugId();

            // 计算药品采购成本
            // 直接将 Long 类型转换为 BigDecimal 类型
            BigDecimal stockQuantity = BigDecimal.valueOf(drugInventory.getStockQuantity());
            // 使用 multiply 方法进行乘法运算
            BigDecimal purchaseCost = drugInventory.getPurchasePrice().multiply(stockQuantity);

        }

        return result;
    }

    /**
     * 修改药品库存
     * 
     * @param drugInventory 药品库存
     * @return 结果
     */
    @Override
    public int updateDrugInventory(DrugInventory drugInventory)
    {
        // 获取旧的库存信息
        DrugInventory oldDrugInventory = drugInventoryMapper.selectDrugInventoryByDrugId(drugInventory.getDrugId());

        drugInventory.setUpdateTime(DateUtils.getNowDate());

        // 计算库存变化量
        Long oldQuantity = oldDrugInventory.getStockQuantity();
        Long newQuantity = drugInventory.getStockQuantity();
        Long quantityChange = newQuantity - oldQuantity;

        if (quantityChange > 0) {
            // 库存增加，计算增加库存的成本
            BigDecimal purchasePrice = drugInventory.getPurchasePrice();
            BigDecimal cost = purchasePrice.multiply(new BigDecimal(quantityChange));

        }
        // 更新药品库存记录
        return drugInventoryMapper.updateDrugInventory(drugInventory);
    }

    /**
     * 批量删除药品库存
     * 
     * @param drugIds 需要删除的药品库存主键
     * @return 结果
     */
    @Override
    public int deleteDrugInventoryByDrugIds(String drugIds)
    {
        return drugInventoryMapper.deleteDrugInventoryByDrugIds(Convert.toStrArray(drugIds));
    }

    /**
     * 删除药品库存信息
     * 
     * @param drugId 药品库存主键
     * @return 结果
     */
    @Override
    public int deleteDrugInventoryByDrugId(Long drugId)
    {
        return drugInventoryMapper.deleteDrugInventoryByDrugId(drugId);
    }
}
