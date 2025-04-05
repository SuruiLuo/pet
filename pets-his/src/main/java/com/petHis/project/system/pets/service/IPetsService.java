package com.petHis.project.system.pets.service;

import java.util.List;
import com.petHis.project.system.pets.domain.Pets;

/**
 * 宠物Service接口
 * 
 * @author petHis
 * @date 2025-02-17
 */
public interface IPetsService 
{
    /**
     * 查询宠物
     * 
     * @param petId 宠物主键
     * @return 宠物
     */
    public Pets selectPetsByPetId(Long petId);

    /**
     * 查询宠物列表
     * 
     * @param pets 宠物
     * @return 宠物集合
     */
    public List<Pets> selectPetsList(Pets pets);

    /**
     * 新增宠物
     * 
     * @param pets 宠物
     * @return 结果
     */
    public int insertPets(Pets pets);

    /**
     * 修改宠物
     * 
     * @param pets 宠物
     * @return 结果
     */
    public int updatePets(Pets pets);

    /**
     * 批量删除宠物
     * 
     * @param petIds 需要删除的宠物主键集合
     * @return 结果
     */
    public int deletePetsByPetIds(String petIds);

    /**
     * 删除宠物信息
     * 
     * @param petId 宠物主键
     * @return 结果
     */
    public int deletePetsByPetId(Long petId);
}
