package com.example.backend.Controller;

import com.example.backend.Models.ProfileModel;
import com.example.backend.Models.UserModel;
import com.example.backend.Repo.ProfileRepo;
import com.example.backend.Services.CustomUserDetails;
import com.example.backend.Services.ProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/profile")
@CrossOrigin(origins = "*")
public class ProfileController {
    @Autowired
    private ProfileService service;
    @Autowired
    private ProfileRepo repo;

    @PostMapping("/post")
    public ResponseEntity<ProfileModel> postdata(@RequestBody ProfileModel profileModel, @AuthenticationPrincipal CustomUserDetails customUserDetails) {
           UserModel userModel=customUserDetails.getUser();
        Optional<ProfileModel> existing = repo.findByUser(userModel);
        if (existing.isPresent()) {
            return new ResponseEntity<>(HttpStatus.CONFLICT); // already has a profile
        }

        profileModel.setUser(userModel); // Set the user from the JWT-authenticated user
        ProfileModel saved = service.postingdata(profileModel);
        return new ResponseEntity<>(saved, HttpStatus.CREATED);
    }

    @GetMapping("/get")
    public ResponseEntity<ProfileModel> getprofile(@AuthenticationPrincipal CustomUserDetails customUserDetails) {
        if (customUserDetails == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        UserModel userModel = customUserDetails.getUser();
        if (userModel == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        ProfileModel profile = service.gettingdata(userModel);

        if (profile == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(profile);
    }

    @PutMapping("/update")
    public ResponseEntity<Map<String,ProfileModel>> updatedata(@AuthenticationPrincipal CustomUserDetails customUserDetails, @RequestBody ProfileModel profileModel){
      UserModel userModel=customUserDetails.getUser();
       ProfileModel prof=service.updatedata(userModel,profileModel);
        Map<String, ProfileModel> response = new HashMap<>();
        response.put("updated successfully", prof);

        return new ResponseEntity<>(response,HttpStatus.OK);
    }

    @DeleteMapping("/delete")
    public ResponseEntity<Map<String, String>> deletedata(@AuthenticationPrincipal CustomUserDetails customUserDetails ) {
        UserModel userModel=customUserDetails.getUser();
        service.delete(userModel); // delete ho gaya
        Map<String, String> response = new HashMap<>();
        response.put("message", "Profile deleted successfully");
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
