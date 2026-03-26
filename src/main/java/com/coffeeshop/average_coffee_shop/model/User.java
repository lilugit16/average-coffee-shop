package com.coffeeshop.average_coffee_shop.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, unique = true, length = 100)
    private String email;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "ENUM('ADMIN', 'CUSTOMER')")
    private UserRole role = UserRole.CUSTOMER;

    @Column(name = "total_orders")
    private Integer totalOrders = 0;

    @Column(name = "is_military_reserve")
    private Boolean isMilitaryReserve = false;

    @Column(name = "created_at", updatable = false, insertable = false)
    private LocalDateTime createdAt;
}