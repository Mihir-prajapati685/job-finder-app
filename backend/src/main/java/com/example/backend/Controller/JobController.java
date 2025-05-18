package com.example.backend.Controller;

import com.example.backend.Models.JobModels;
import com.example.backend.Services.JobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/job")
public class JobController {
     @Autowired
    private JobService jobService;

     @GetMapping("/get")
     public ResponseEntity<List<JobModels>> getalljob(){
         List<JobModels> jobModels=jobService.getalljob();
         return new ResponseEntity<>(jobModels, HttpStatus.OK);
     }

    @PostMapping("/post")
    public ResponseEntity<JobModels> postdata(@RequestBody JobModels jobModels){
        JobModels job1=jobService.postdata(jobModels);
        return new ResponseEntity<>(job1, HttpStatus.OK);
    }

}
