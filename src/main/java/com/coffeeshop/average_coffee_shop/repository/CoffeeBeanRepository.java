package com.coffeeshop.average_coffee_shop.repository;

import com.coffeeshop.average_coffee_shop.model.CoffeeBean;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CoffeeBeanRepository extends JpaRepository<CoffeeBean, Integer> {

    
}