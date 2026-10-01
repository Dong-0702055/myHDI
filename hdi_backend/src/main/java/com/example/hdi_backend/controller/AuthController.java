package com.example.hdi_backend.controller;

import com.example.hdi_backend.dto.request.RegisterRequest;
import com.example.hdi_backend.dto.response.AuthResponse;
import com.example.hdi_backend.service.AuthService;
import com.example.hdi_backend.dto.request.LoginRequest;
import com.example.hdi_backend.dto.request.RefreshTokenRequest;
import com.example.hdi_backend.dto.request.LogoutRequest;

import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.*;
@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/register")
    public AuthResponse register(@Valid @RequestBody RegisterRequest request) {

        return authService.register(request);
    }
    @PostMapping("/login")
    public AuthResponse login(@Valid @RequestBody LoginRequest request) {

        return authService.login(request);
    }
    @PostMapping("/refresh")
    public AuthResponse refresh(@RequestBody RefreshTokenRequest request){
        return authService.refreshToken(
                request.getRefreshToken()
        );
    }
    @PostMapping("/logout")
    public String logout(@RequestBody LogoutRequest request){
        return authService.logout(
                request.getRefreshToken()
        );
    }

}