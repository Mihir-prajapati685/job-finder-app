package com.example.backend.Services;

import com.example.backend.Models.CommentsModel;
import com.example.backend.Models.PostModel;
import com.example.backend.Repo.CommentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentsService {
    @Autowired
    private CommentRepo repo;

//    public List<CommentsModel> getCommentsByPostId(Long postId) {
//        return repo.findByPostModel_Id(postId);
//    }
}
