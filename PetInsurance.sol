// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.6.10;

contract PetInsurance {
    struct User {
        uint256 user_id;
        string name;
        uint256 amount; // 允许为负数
    }

    struct Pet {
        uint256 pet_id;
        string name;
        uint256 insurance_id;
        uint256 insurance_end_at; // 保险结束时间
    }

    struct Insurance {
        uint256 insurance_id;
        string name;
        uint256 level_1_num;
        uint256 level_1_claim_ratio; // 一级赔付比例（百分比）
        uint256 level_2_num;
        uint256 level_2_claim_ratio; // 二级赔付比例（百分比）
        uint256 premium; // Insurance premium
    }

    struct TradeLog {
        string userName;          // 涉及的用户名称
        string insuranceUserName; // 创建保险的用户名称
        uint8   tradeType;             // 0: 支付, 1: 收款
        uint256 number;           // 交易金额
        uint256 amount;
    }

    mapping(uint256 => User) public users;
    mapping(uint256 => Pet) public pets;
    mapping(uint256 => uint256[]) public userPets; // 用户和宠物的关联关系
    mapping(uint256 => Insurance) public insurances;
    mapping(uint256 => TradeLog[]) public tradeLogs; // 用户 ID 对应的交易日志

    // 添加用户
    function addUser(uint256 userCount, string memory _name, uint256 _amount) public {
        users[userCount] = User(userCount, _name, _amount);
    }

    // 添加宠物
    function addPet(uint256 petCount, uint256 _ownerId, string memory _name) public {
        require(users[_ownerId].user_id != 0, "User does not exist");
        pets[petCount] = Pet(petCount, _name, 0, 0);
        userPets[_ownerId].push(petCount);
    }

    // 添加保险
    function addInsurance(
        uint256 insuranceCount,
        string memory _name,
        uint256 _level1Num,
        uint256 _level1Ratio,
        uint256 _level2Num,
        uint256 _level2Ratio,
        uint256 _premium
    ) public {
        insurances[insuranceCount] = Insurance(
            insuranceCount,
            _name,
            _level1Num,
            _level1Ratio,
            _level2Num,
            _level2Ratio,
            _premium
        );
    }

    // 购买保险
    function purchaseInsurance(uint256 _buyerId, uint256 _petId, uint256 _insuranceId) public {
        User storage buyer = users[_buyerId];
        Pet storage pet = pets[_petId];
        Insurance storage insurance = insurances[_insuranceId];

        require(pet.pet_id != 0, "Pet does not exist");
        require(insurance.insurance_id != 0, "Insurance does not exist");

        // 扣除买家金额，增加保险公司金额
        buyer.amount -= uint256(insurance.premium);
        users[insurance.insurance_id].amount += uint256(insurance.premium);

        // 设置保险结束时间为1个月后
        pet.insurance_id = _insuranceId;
        pet.insurance_end_at = block.timestamp + 30 days;

        // 记录支付日志
        tradeLogs[_buyerId].push(TradeLog(buyer.name, insurance.name, 0, insurance.premium,buyer.amount));

        // 记录收款日志
        tradeLogs[insurance.insurance_id].push(TradeLog(insurance.name, buyer.name, 1, insurance.premium,users[insurance.insurance_id].amount));
    }

    // 理赔
    function claimInsurance(uint256 _petId, uint256 _medicalExpense) public {
        Pet storage pet = pets[_petId];
        Insurance storage insurance = insurances[pet.insurance_id];

        require(pet.insurance_id != 0, "No insurance found for this pet");
        require(block.timestamp <= pet.insurance_end_at, "Insurance has expired, please renew");

        // 计算赔付金额
        uint256 claimAmount = 0;
        if (_medicalExpense <= insurance.level_1_num) {
            claimAmount = (_medicalExpense * insurance.level_1_claim_ratio) / 100;
        } else if (_medicalExpense <= insurance.level_2_num) {
            claimAmount = (insurance.level_1_num * insurance.level_1_claim_ratio) / 100 +
                          ((_medicalExpense - insurance.level_1_num) * insurance.level_2_claim_ratio) / 100;
        } else {
            claimAmount = (insurance.level_1_num * insurance.level_1_claim_ratio) / 100 +
                          ((insurance.level_2_num - insurance.level_1_num) * insurance.level_2_claim_ratio) / 100;
        }

        // 更新用户和保险公司金额
        users[pet.pet_id].amount += uint256(claimAmount);
        users[insurance.insurance_id].amount -= uint256(claimAmount);

        // 记录收款日志
        tradeLogs[pet.pet_id].push(TradeLog(insurance.name, users[pet.pet_id].name, 1, claimAmount,users[pet.pet_id].amount));

        // 记录支付日志
        tradeLogs[insurance.insurance_id].push(TradeLog(users[insurance.insurance_id].name, insurance.name, 0, claimAmount,users[insurance.insurance_id].amount));
    }

    // 获取用户的交易日志
    function getTradeLogsByUser(uint256 _userId) public view returns (TradeLog[] memory) {
        return tradeLogs[_userId];
    }
}
