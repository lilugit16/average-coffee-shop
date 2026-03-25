package com.coffeeshop.average_coffee_shop.controller;

import org.springframework.beans.factory.annotation.*;
import org.springframework.web.bind.annotation.*;

import com.coffeeshop.average_coffee_shop.model.CoffeeBean;
import com.coffeeshop.average_coffee_shop.repository.CoffeeBeanRepository;

import java.util.List;

@RestController
@RequestMapping("/api/beans")

public class CoffeeBeanController {
    
    @Autowired
    private CoffeeBeanRepository repository;

    @GetMapping
    public List<CoffeeBean> getAllBeans() {
        return repository.findAll();
    }

    @PostMapping
    public CoffeeBean addBean(@RequestBody CoffeeBean bean) {
        return repository.save(bean);
    }

    @DeleteMapping("/{id}")
    public void deleteBean(@PathVariable Integer id) {
        repository.deleteById(id);
    }
}
