package service.Interface;

import com.clinique.domain.Enum.Role;
import com.clinique.domain.User;

import java.util.Optional;

public interface UserService {
    User createUser(String prenom ,String nom, String email , String plainPassword , Role role);

    Optional<User> authenticate(String email, String plainPassword);

    boolean emailExists(String email);

    Optional<User> findByEmail(String email);
}
