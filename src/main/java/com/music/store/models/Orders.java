package com.music.store.models;

import lombok.Data;

import java.util.Date;

@Data
public class Orders {
    private int id;
    private Customer customer_id;
    private Songs songs_id;
    private Date purchase_date;
    private Double purcharse_price;
}
