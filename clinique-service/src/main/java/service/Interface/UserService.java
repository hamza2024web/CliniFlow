package service.Interface;

import com.clinique.domain.Enum.Role;
import com.clinique.domain.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    User createUser(String prenom ,String nom, String email , String plainPassword , Role role);

    Optional<User> authenticate(String email, String plainPassword);

    boolean emailExists(String email);

    Optional<User> findByEmail(String email);

    Optional<User> findById(Long id);

    List<User> findAll();

    User updateUser(Long id, String prenom, String nom, String email, Role role);

    void changePassword(Long userId, String newPlainPassword);

    void toggleUserStatus(Long userId);

    void deleteUser(Long userId);

    List<User> searchUsers(String keyword);
}
