package com.example.backend.Services;

import com.example.backend.Models.PostModel;
import com.example.backend.Models.UserModel;
import com.example.backend.Repo.CommentRepo;
import com.example.backend.Repo.PostRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PostService {
    @Autowired
    private PostRepo postRepo;

    @Autowired
    private CommentRepo commentRepo;

    public PostModel addpost(PostModel postModel, UserModel userModel) {
        PostModel savedPost = postRepo.save(postModel);
        return savedPost;
    }

    public List<PostModel> getallpost(UserModel currentUser) {
        List<PostModel> userPosts = postRepo.findByUser(currentUser);
        return userPosts;
    }

    public boolean deletePostById(Long postId, UserModel currentUser) {
        Optional<PostModel> optionalPost = postRepo.findById(postId);
        if (optionalPost.isPresent()) {
            PostModel post = optionalPost.get();

            // Only allow deletion if the current user is the owner
            if (post.getUser().getId().equals(currentUser.getId())) {

                // Pehle post ke comments delete karein
                commentRepo.deleteByPostModel(post);  // Here we are using post object

                // Fir post ko delete karein
                postRepo.delete(post);
                return true;
            }
        }
        return false;
    }

    public List<PostModel> searchPosts(String keyword) {
        return postRepo.findByTitleContainingIgnoreCaseOrContentContainingIgnoreCase(keyword, keyword);
    }
}