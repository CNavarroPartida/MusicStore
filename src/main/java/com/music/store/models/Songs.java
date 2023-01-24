package com.music.store.models;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class Songs {
    private int id;
    private String title;
    private String artist;
    private String album;
    private String genre;
    private BigDecimal price;
    private Integer availableQuantity;
}
