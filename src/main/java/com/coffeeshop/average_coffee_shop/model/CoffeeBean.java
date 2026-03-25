package com.coffeeshop.average_coffee_shop.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "coffee_bean")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CoffeeBean{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    private String name;
    private String origin;
    
    @Column(name = "roast_level")
    private Integer roastLevel;
    
    @Column(name = "flavor_notes")
    private String flavorNotes;

    @Column(name = "extra_price")
    private BigDecimal extraPrice;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "is_active")
    private boolean is_active = true;

}
