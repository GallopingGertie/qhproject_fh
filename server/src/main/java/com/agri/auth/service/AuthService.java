package com.agri.auth.service;

import com.agri.admin.entity.AdminUser;
import com.agri.admin.mapper.AdminUserMapper;
import com.agri.auth.dto.LoginRequest;
import com.agri.auth.dto.LoginResponse;
import com.agri.common.exception.BizException;
import com.agri.common.util.JwtUtil;
import com.agri.merchant.entity.Merchant;
import com.agri.merchant.mapper.MerchantMapper;
import com.agri.user.entity.User;
import com.agri.user.mapper.UserMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private AdminUserMapper adminUserMapper;

    @Autowired
    private MerchantMapper merchantMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private JwtUtil jwtUtil;

    public LoginResponse platformLogin(LoginRequest request) {
        LambdaQueryWrapper<AdminUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AdminUser::getUsername, request.getUsername());
        AdminUser admin = adminUserMapper.selectOne(wrapper);

        if (admin == null) {
            throw new BizException("账号或密码错误");
        }

        if (admin.getStatus() == 0) {
            throw new BizException("账号已被禁用");
        }

        String token = jwtUtil.generateToken(admin.getId(), "platform");
        return new LoginResponse(token, "platform");
    }

    public LoginResponse merchantLogin(LoginRequest request) {
        LambdaQueryWrapper<Merchant> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Merchant::getAccount, request.getUsername());
        Merchant merchant = merchantMapper.selectOne(wrapper);

        if (merchant == null) {
            throw new BizException("账号或密码错误");
        }

        if (merchant.getStatus() != 1) {
            throw new BizException("账号未通过审核或已被停用");
        }

        String token = jwtUtil.generateToken(merchant.getId(), "merchant");
        return new LoginResponse(token, "merchant");
    }

    public LoginResponse userLogin(LoginRequest request) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getPhone, request.getUsername());
        User user = userMapper.selectOne(wrapper);

        if (user == null) {
            throw new BizException("账号或密码错误");
        }

        if (user.getStatus() == 0) {
            throw new BizException("账号已被禁用");
        }

        String token = jwtUtil.generateToken(user.getId(), "user");
        return new LoginResponse(token, "user");
    }
}
