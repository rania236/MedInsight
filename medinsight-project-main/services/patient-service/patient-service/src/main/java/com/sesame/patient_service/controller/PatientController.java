package com.sesame.patient_service.controller;

import com.sesame.patient_service.Service.PatientService;
import com.sesame.patient_service.entities.Patient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/patients")
public class PatientController {

    @Autowired
    private PatientService patientService;

    @PostMapping
    public Patient create(@RequestBody Patient patient) {
        return patientService.save(patient);
    }

    @GetMapping("/{id}")
    public Patient get(@PathVariable Long id) {
        return patientService.getById(id);
    }

    @GetMapping
    public List<Patient> all() {
        return patientService.getAll();
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        patientService.delete(id);
    }
}

