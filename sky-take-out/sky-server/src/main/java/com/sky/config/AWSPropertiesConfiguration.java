package com.sky.config;

import com.sky.properties.AWSOssProperties;
import com.sky.utils.AWSOssutil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@Slf4j
public class AWSPropertiesConfiguration {
    @Bean
    @ConditionalOnMissingBean
    public AWSOssutil awsOssutil(AWSOssProperties awsOssProperties) {
        log.info("开始创建AWS上传工具类对象: {}", awsOssProperties);
        return new AWSOssutil(awsOssProperties.getEndpoint(), awsOssProperties.getAccessKeyId(), awsOssProperties.getAccessKeySecret(), awsOssProperties.getBucketName(), awsOssProperties.getRegion());


    }
}
