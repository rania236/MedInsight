package com.sesame.user_service.entities;


import jakarta.persistence.*;

@Entity
public  class Doctor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private String prenom;
    private String email;
    private String telephone;
    private String password;


}

