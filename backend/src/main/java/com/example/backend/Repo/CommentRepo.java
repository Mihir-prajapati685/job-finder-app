package com.example.backend.Repo;

import com.example.backend.Models.CommentsModel;
import com.example.backend.Models.PostModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepo extends JpaRepository<CommentsModel, Long> {
    List<CommentsModel> findByPostModel(PostModel postModel);

//    List<CommentsModel> findByPostModel_Id(Long postId);

    void deleteByPostModel(PostModel post);
}
