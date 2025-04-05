package com.petHis.project.system.pets.mapper;

import java.util.List;

import com.petHis.project.system.clients.domain.Clients;
import com.petHis.project.system.pets.domain.Pets;

/**
 * 宠物Mapper接口
 * 
 * @author petHis
 * @date 2025-02-17
 */
public interface PetsMapper 
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
     * 删除宠物
     * 
     * @param petId 宠物主键
     * @return 结果
     */
    public int deletePetsByPetId(Long petId);

    /**
     * 批量删除宠物
     * 
     * @param petIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deletePetsByPetIds(String[] petIds);

    /**
     * 批量删除客户
     * 
     * @param petIds 需要删除的数据主键集合
     * @return 结果
     */
//    public int deleteClientsByClientIds(String[] petIds);
//
//    /**
//     * 批量新增客户
//     *
//     * @param clientsList 客户列表
//     * @return 结果
//     */
//    public int batchClients(List<Clients> clientsList);
//
//
//    /**
//     * 通过宠物主键删除客户信息
//     *
//     * @param petId 宠物ID
//     * @return 结果
//     */
//    public int deleteClientsByClientId(Long petId);
}
