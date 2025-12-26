package com.sesame.patient_service.Service;

import com.sesame.patient_service.entities.Patient;

import java.util.List;

public interface PatientService {
    Patient save(Patient patient);
    Patient getById(Long id);
    List<Patient> getAll();
    void delete(Long id);
}
