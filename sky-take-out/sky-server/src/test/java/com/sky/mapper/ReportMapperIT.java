package com.sky.mapper;

import com.sky.dto.GoodsSalesDTO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class ReportMapperIT {

    @Autowired
    private ReportMapper reportMapper;

    @Test
    void getTotalUserCount_nonNegative() {
        Integer n = reportMapper.getTotalUserCount(LocalDateTime.now());
        assertNotNull(n);
        assertTrue(n >= 0);
    }

    @Test
    void getSalesTop10_atMostTenAndDescending() {
        LocalDateTime begin = LocalDateTime.now().minusDays(40);
        LocalDateTime end = LocalDateTime.now();
        List<GoodsSalesDTO> top = reportMapper.getSalesTop10(begin, end);
        assertNotNull(top);
        assertTrue(top.size() <= 10);
        for (int i = 1; i < top.size(); i++) {
            assertTrue(top.get(i - 1).getNumber() >= top.get(i).getNumber(),
                    "results must be sorted by number desc");
        }
    }
}
