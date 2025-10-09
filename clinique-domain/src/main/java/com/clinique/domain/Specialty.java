package com.clinique.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "specialties")
public class Specialty {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "le code est obligatoire")
    @Size(max = 10)
    @Column(name = "code" , nullable = false , length = 10 , unique = true)
    private String code;

    @NotBlank(message = "Le nom est obligatoire")
    @Size(max = 100)
    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "department_id", nullable = false)
    private Department department;

    @OneToMany(mappedBy = "specialty", cascade = CascadeType.ALL)
    private List<Doctor> doctors = new ArrayList<>();

    public Specialty() {}

    public Specialty(String code , String name , Department department){
        this.code = code;
        this.name = name;
        this.department = department;
    }

    public Long getId(){
        return id;
    }

    public void setId(Long id){
        this.id = id;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    public Department getDepartment(){
        return department;
    }

    public void setDepartment(Department department){
        this.department = department;
    }

    public List<Doctor> getDoctors(){
        return doctors;
    }

    public void setDoctors(List<Doctor> doctors){
        this.doctors = doctors;
    }

    @Override
    public String toString() {
        return "Specialty{id=" + id + ", code='" + code + "', name='" + name + "'}";
    }
}
