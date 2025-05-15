package com.example.backend.Services;

import com.example.backend.Models.UserModel;
import com.example.backend.Repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        UserModel user = userRepo.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
        return new CustomUserDetails(user);
    }



    public String login(String email, String password, PasswordEncoder passwordEncoder) {
        UserModel userModel = userRepo.findByEmail(email).orElse(null);

        if(userModel==null){
            return "Email not Match";
        }

        if (!passwordEncoder.matches(password, userModel.getPassword())) {
            return "Invalid password";
        }

        return  null;
    }
}
