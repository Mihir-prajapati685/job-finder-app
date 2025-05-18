package com.example.backend.Services;

import com.example.backend.Models.JobModels;
import com.example.backend.Repo.JobRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JobService {
    @Autowired
    private JobRepo jobRepo;


    public List<JobModels> getalljob() {
        List<JobModels> jobModels=jobRepo.findAll();
        return jobModels;
    }


    public JobModels postdata(JobModels jobModels) {
        return jobRepo.save(jobModels);
    }
}
