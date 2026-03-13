package com.agri.auth.controller;

import com.agri.auth.dto.LoginRequest;
import com.agri.auth.dto.LoginResponse;
import com.agri.auth.service.AuthService;
import com.agri.common.dto.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/platform/login")
    public Result<LoginResponse> platformLogin(@Valid @RequestBody LoginRequest request) {
        LoginResponse response = authService.platformLogin(request);
        return Result.success(response);
    }

    @PostMapping("/merchant/login")
    public Result<LoginResponse> merchantLogin(@Valid @RequestBody LoginRequest request) {
        LoginResponse response = authService.merchantLogin(request);
        return Result.success(response);
    }

    @PostMapping("/user/login")
    public Result<LoginResponse> userLogin(@Valid @RequestBody LoginRequest request) {
        LoginResponse response = authService.userLogin(request);
        return Result.success(response);
    }
}
