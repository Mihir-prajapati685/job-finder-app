package com.example.backend.Repo;

import com.example.backend.Models.ProfileModel;
import com.example.backend.Models.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProfileRepo extends JpaRepository<ProfileModel,Long> {

    Optional<ProfileModel> findByUser(UserModel userModel);
}
