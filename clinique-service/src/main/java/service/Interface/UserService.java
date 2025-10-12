package service.Interface;

import com.clinique.domain.User;

import java.util.Optional;

public interface UserService {
    User createUser(String prenom ,String nom, String email , String plainPassword , String... roles);

    Optional<User> authenticate(String email, String plainPassword);

    boolean emailExists(String email);

    Optional<User> findByEmail(String email);
}
