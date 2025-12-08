package com.sky.utils;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;


import java.io.ByteArrayInputStream;
import java.io.File;
import java.net.URI;
import java.nio.file.Paths;

@Data
@AllArgsConstructor
@Slf4j
public class AWSOssutil {
    //https://s3.ap-northeast-1.amazonaws.com
    private String endpoint;
    private String accessKeyId;
    private String accessKeySecret;
    private String bucketName;
    private String region;

    public String upload(byte[] bytes, String objectName) {

        // 构造 aws 客户端
        S3Client s3Client = S3Client.builder()
                .region(Region.of(region))
                .credentialsProvider(StaticCredentialsProvider.create(
                        AwsBasicCredentials.create(accessKeyId, accessKeySecret)
                ))
                .build();

        try {
            // 创建 PutObjectRequest
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(objectName)
                    .build();

            // 执行上传
            s3Client.putObject(putObjectRequest, RequestBody.fromBytes(bytes));

            // 生成可访问 URL
            String url = String.format(
                    "https://%s.s3.%s.amazonaws.com/%s",
                    bucketName,
                    region,
                    objectName
            );

            log.info("文件上传成功: {}", url);
            return url;

        } catch (software.amazon.awssdk.services.s3.model.S3Exception e) {
            log.error("S3 错误（S3Exception）: {}", e.awsErrorDetails().errorMessage(), e);
            throw new RuntimeException("S3 上传失败: " + e.awsErrorDetails().errorMessage(), e);

        } catch (software.amazon.awssdk.core.exception.SdkClientException e) {
            log.error("AWS SDK 客户端错误（SdkClientException）: {}", e.getMessage(), e);
            throw new RuntimeException("AWS SDK 调用失败: " + e.getMessage(), e);

        } catch (Exception e) {
            log.error("未知错误: {}", e.getMessage(), e);
            throw new RuntimeException("文件上传出现未知错误: " + e.getMessage(), e);

        } finally {
            // SDK v2 不要求必须关闭客户端，但可以主动关闭
            try {
                s3Client.close();
            } catch (Exception ex) {
                log.warn("关闭 S3Client 时发生异常: {}", ex.getMessage());
            }
        }
    }

}
