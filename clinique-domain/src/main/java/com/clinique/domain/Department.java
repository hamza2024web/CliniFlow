package com.clinique.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "departments")
public class Department {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Le code est obligatoire")
    @Size(max = 10)
    @Column(name = "code",nullable = false , length = 10 , unique = true)
    private String code;

    @NotBlank(message = "le nom est obligatoire")
    @Size(max = 100)
    @Column(name = "name", nullable = false , length = 100)
    private String name;

    @OneToMany(mappedBy = "department" , cascade = CascadeType.ALL)
    private List<Doctor> doctors = new ArrayList<>();

    public Department() {}

    public Department (String code , String name){
        this.code = code;
        this.name = name;
    }

    public Long getId(){
        return id;
    }

    public void setId(Long id){
        this.id = id;
    }

    public String getCode(){
        return code;
    }

    public void setCode(String code){
        this.code = code;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    public List<Doctor> getDoctors(){
        return doctors;
    }

    public void setDoctors(List<Doctor> doctors){
        this.doctors = doctors;
    }

    @Override
    public String toString(){
        return "Department{id=" + id + ",code='" + code + "',name = '" + name + "'}";
    }
}
