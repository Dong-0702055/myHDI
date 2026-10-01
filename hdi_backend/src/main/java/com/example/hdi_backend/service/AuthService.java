package com.example.hdi_backend.service;


import com.example.hdi_backend.dto.request.LoginRequest;
import com.example.hdi_backend.dto.request.RegisterRequest;
import com.example.hdi_backend.dto.response.AuthResponse;
import com.example.hdi_backend.entity.RefreshToken;
import com.example.hdi_backend.entity.User;
import com.example.hdi_backend.exception.BadRequestException;
import com.example.hdi_backend.repository.UserRepository;
import com.example.hdi_backend.security.JwtService;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;


@Service
public class AuthService {

    private final UserRepository userRepository;

    private final PasswordEncoder passwordEncoder;

    private final JwtService jwtService;

    private final RefreshTokenService refreshTokenService;

    public AuthService(
            UserRepository userRepository,
            PasswordEncoder passwordEncoder,
            JwtService jwtService,
            RefreshTokenService refreshTokenService
    ) {

        this.userRepository = userRepository;

        this.passwordEncoder = passwordEncoder;

        this.jwtService = jwtService;

        this.refreshTokenService = refreshTokenService;

    }

    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByPhoneNumber(request.getPhoneNumber())) {
            throw new BadRequestException("Số điện thoại đã tồn tại");
        }
        User user = new User();
        user.setFullName(request.getFullName());
        user.setPhoneNumber(request.getPhoneNumber());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setRole("USER");
        user.setEnabled(true);
        userRepository.save(user);
        return new AuthResponse("Đăng ký thành công", null, null);
    }

    public AuthResponse login(LoginRequest request) {

        User user = userRepository.findByPhoneNumber(request.getPhoneNumber())
                .orElseThrow(() -> new BadRequestException("Số điện thoại không tồn tại"));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new BadRequestException("Sai mật khẩu");
        }
        // Tạo Access Token JWT
        String accessToken = jwtService.generateToken(user.getPhoneNumber());
        // Tạo Refresh Token lưu database
        RefreshToken refreshToken = refreshTokenService.createRefreshToken(user);

        return new AuthResponse("Đăng nhập thành công", accessToken, refreshToken.getToken());

    }
    public AuthResponse refreshToken(String requestRefreshToken) {

        RefreshToken refreshToken = refreshTokenService.findByToken(requestRefreshToken);

        refreshTokenService.verifyExpiration(refreshToken);

        User user = refreshToken.getUser();

        String newAccessToken = jwtService.generateToken(user.getPhoneNumber());

        return new AuthResponse("Làm mới token thành công", newAccessToken,requestRefreshToken);

    }
    public String logout(String refreshToken){

        refreshTokenService.deleteByToken(refreshToken);

        return "Đăng xuất thành công";

    }

}