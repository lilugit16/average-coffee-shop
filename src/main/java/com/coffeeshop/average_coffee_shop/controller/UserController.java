package com.coffeeshop.average_coffee_shop.controller;

import com.coffeeshop.average_coffee_shop.model.User;
import com.coffeeshop.average_coffee_shop.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "*")
public class UserController {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public UserController(UserRepository userRepository, BCryptPasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    // פונקציית רישום (Registration)
    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@RequestBody Map<String, Object> userData) {
        String email = (String) userData.get("email");
        if (userRepository.findByEmail(email).isPresent()) {
            return ResponseEntity.badRequest().body("Error: Email is already in use!");
        }

        User newUser = new User();
        newUser.setEmail(email);
        
        String rawPassword = (String) userData.get("password");
        newUser.setPasswordHash(passwordEncoder.encode(rawPassword));

        if (userData.containsKey("isMilitaryReserve")) {
            newUser.setIsMilitaryReserve((Boolean) userData.get("isMilitaryReserve"));
        }
        
        userRepository.save(newUser);
        return ResponseEntity.ok("User registered successfully with secure hashing!");
    }

    // --- כאן נכנס החלק החדש של ה-LOGIN ---
    
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> loginData) {
        String email = loginData.get("email");
        String rawPassword = loginData.get("password");

        // 1. מחפשים את המשתמש לפי האימייל
        return userRepository.findByEmail(email)
            .map(user -> {
                // 2. בודקים אם הסיסמה שהוקלדה (rawPassword) תואמת ל-Hash מה-DB
                if (passwordEncoder.matches(rawPassword, user.getPasswordHash())) {
                    // כאן אפשר להחזיר את פרטי המשתמש (בלי הסיסמה!) או הודעת הצלחה
                    return ResponseEntity.ok(Map.of(
                        "message", "Login successful!",
                        "role", user.getRole(),
                        "isMilitaryReserve", user.getIsMilitaryReserve()
                    ));
                } else {
                    return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid email or password");
                }
            })
            .orElse(ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid email or password"));
    }
       @GetMapping("/{id}")
public ResponseEntity<?> getUserProfile(@PathVariable Integer id) {
    // 1. ננסה למצוא את המשתמש
    java.util.Optional<User> userOpt = userRepository.findById(id);

    // 2. אם הוא לא קיים - נחזיר 404 מיד
    if (userOpt.isEmpty()) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
    }

    // 3. אם הוא קיים - נשלוף אותו ונבנה את הפרופיל
    User user = userOpt.get();
    Map<String, Object> profile = new HashMap<>();
    profile.put("email", user.getEmail());
    profile.put("role", user.getRole());
    profile.put("isMilitaryReserve", user.getIsMilitaryReserve());

    return ResponseEntity.ok(profile);
}
}