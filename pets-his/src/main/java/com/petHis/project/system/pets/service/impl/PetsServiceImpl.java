package com.petHis.project.system.pets.service.impl;

import java.util.List;

//import com.petHis.project.monitor.server.domain.Sys;
import com.petHis.contract.service.PetInsuranceService;
import com.petHis.project.system.clients.domain.Clients;
import com.petHis.project.system.clients.mapper.ClientsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.petHis.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.petHis.project.system.pets.mapper.PetsMapper;
import com.petHis.project.system.pets.domain.Pets;
import com.petHis.project.system.pets.service.IPetsService;
import com.petHis.common.utils.text.Convert;

/**
 * 宠物Service业务层处理
 * 
 * @author petHis
 * @date 2025-02-17
 */
@Service
public class PetsServiceImpl implements IPetsService 
{
    @Autowired
    private PetsMapper petsMapper;

    @Autowired
    private ClientsMapper clientsMapper;

    @Autowired
    private PetInsuranceService petInsuranceService;

    /**
     * 查询宠物
     * 
     * @param petId 宠物主键
     * @return 宠物
     */
    @Override
    public Pets selectPetsByPetId(Long petId)
    {
        return petsMapper.selectPetsByPetId(petId);
    }

    /**
     * 查询宠物列表
     * 
     * @param pets 宠物
     * @return 宠物
     */
    @Override
    public List<Pets> selectPetsList(Pets pets)
    {
        return petsMapper.selectPetsList(pets);
    }

    /**
     * 新增宠物
     * 
     * @param pets 宠物
     * @return 结果
     */
    @Transactional
    @Override
    public int insertPets(Pets pets)
    {
        Long clienId = insertClients(pets);
        pets.setClientId(clienId);
//        System.out.println("yonghu Id:"+clienId);
//        System.out.println(pets);
        Pets pet1 = new Pets();
        pet1.setClientId(pets.getClientId());
        pet1.setName(pets.getName());
        List<Pets> selectPet = selectPetsList(pet1);
        System.out.println(selectPetsList(pet1));
        if (!selectPet.isEmpty()){
            throw new RuntimeException("该宠物已存在，请勿重复添加。");
        }
        int rows = petsMapper.insertPets(pets);
        Clients clients = clientsMapper.selectClientsByClientId(pets.getClientId());
        petInsuranceService.addPet(pets.getPetId(),clients.getUserId(),pets.getName());
        return rows;

    }

    /**
     * 修改宠物
     * 
     * @param pets 宠物
     * @return 结果
     */
    @Transactional
    @Override
    public int updatePets(Pets pets)
    {
        Pets pet = petsMapper.selectPetsByPetId(pets.getPetId());
        // 若没有重复，执行更新操作
        Clients clients = clientsMapper.selectClientsByClientId(pet.getClientId());
        petInsuranceService.purchaseInsurance(clients.getUserId(),pets.getPetId(),pets.getInsuranceId());
        return petsMapper.updatePets(pets);
    }

    /**
     * 批量删除宠物
     * 
     * @param petIds 需要删除的宠物主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deletePetsByPetIds(String petIds)
    {
//        petsMapper.deleteClientsByClientIds(Convert.toStrArray(petIds));
        return petsMapper.deletePetsByPetIds(Convert.toStrArray(petIds));
    }

    /**
     * 删除宠物信息
     * 
     * @param petId 宠物主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deletePetsByPetId(Long petId)
    {
//        petsMapper.deleteClientsByClientId(petId);
        return petsMapper.deletePetsByPetId(petId);
    }

    /**
     * 新增客户信息
     * 
     * @param pets 宠物对象
     */
    public Long insertClients(Pets pets)
    {
        System.out.println(pets);
//        这里要先把前台传过来的数据转成正常的，
//        然后，查询数据表clients中是否已有当前的数据，通过手机号查找
        Clients cl = new Clients();
        cl.setPhone(pets.getClientPhone());
        cl.setName(pets.getClientName());
        List<Clients> selectClient = clientsMapper.selectClientsList(cl);
//        System.out.println("ceshi"+clientsMapper.selectClientsList(cl));
        System.out.println(selectClient.isEmpty());
        if (selectClient.isEmpty()){
            int rows = clientsMapper.insertClients(cl);
//            if (rows>0){
//                return cl.getClientId();
//            }
//            return rows > 0; // 如果插入的记录数大于 0，则表示插入成功
        }
        return pets.getClientId(); // 表示客户已存在，未执行插入操作
    }
}
