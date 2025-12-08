package com.sky.service;

public interface ShopService {

    /**
     * 获取营业状态
     */
    Integer getStatus();

    /**
     * 设置营业状态
     */
    void updateStatus(Integer status);
}


