package com.example.hdi_backend.service;


import com.example.hdi_backend.entity.RefreshToken;
import com.example.hdi_backend.entity.User;
import com.example.hdi_backend.exception.BadRequestException;
import com.example.hdi_backend.repository.RefreshTokenRepository;
import org.springframework.stereotype.Service;


import java.time.LocalDateTime;
import java.util.UUID;


@Service
public class RefreshTokenService {

    private final RefreshTokenRepository refreshTokenRepository;

    public RefreshTokenService(RefreshTokenRepository refreshTokenRepository){
        this.refreshTokenRepository = refreshTokenRepository;
    }

    public RefreshToken createRefreshToken(User user){

        RefreshToken refreshToken = new RefreshToken();

        refreshToken.setUser(user);
        refreshToken.setToken(UUID.randomUUID().toString());
        refreshToken.setExpiryDate(LocalDateTime.now().plusDays(7));

        return refreshTokenRepository.save(refreshToken);

    }
    public RefreshToken findByToken(String token) {

        return refreshTokenRepository
                .findByToken(token)
                .orElseThrow(() -> new BadRequestException("Refresh token không tồn tại"));
    }
    public RefreshToken verifyExpiration(RefreshToken refreshToken) {
        if(refreshToken
                .getExpiryDate()
                .isBefore(LocalDateTime.now())) {refreshTokenRepository.delete(refreshToken);
            throw new BadRequestException("Refresh token đã hết hạn");
        }
        return refreshToken;
    }
    public void deleteByToken(String token) {
        RefreshToken refreshToken = refreshTokenRepository
                        .findByToken(token)
                        .orElseThrow(() -> new BadRequestException("Refresh token không tồn tại"));
        refreshTokenRepository.delete(refreshToken);
    }


}