package service;

import com.clinique.domain.Enum.Role;
import com.clinique.domain.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.mindrot.jbcrypt.BCrypt;
import repository.Interface.UserRepository;
import service.Interface.UserService;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
@Transactional
public class UserServiceImpl implements UserService {

    @Inject
    private UserRepository userRepository;

    @Override
    public User createUser(String prenom, String nom, String email, String plainPassword, Role role) {
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Cet email est déjà utilisé");
        }

        User user = new User();
        user.setFirstName(prenom);
        user.setLastName(nom);
        user.setEmail(email);
        user.setPassword(BCrypt.hashpw(plainPassword, BCrypt.gensalt(12)));
        user.setRole(role);

        return userRepository.save(user);
    }

    @Override
    @Transactional  // Lecture seule, mais garde la cohérence
    public Optional<User> authenticate(String email, String plainPassword) {
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isPresent()){
            User user = userOpt.get();

            if (!user.isActive()){
                return Optional.empty();
            }

            if (BCrypt.checkpw(plainPassword, user.getPassword())){
                return Optional.of(user);
            }
        }

        return Optional.empty();
    }

    @Override
    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public User updateUser(Long id, String prenom, String nom, String email, Role role) {
        User user = userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Utilisateur introuvable avec l'ID : " + id));

        Optional<User> existingUser = userRepository.findByEmail(email);
        if (existingUser.isPresent() && !existingUser.get().getId().equals(id)){
            throw new IllegalArgumentException("Cet email est déjà utilisé par un autre utilisateur");
        }

        user.setFirstName(prenom);
        user.setLastName(nom);
        user.setEmail(email);
        user.setRole(role);

        return userRepository.save(user);
    }

    @Override
    public void changePassword(Long userId, String newPlainPassword) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Utilisateur introuvable avec l'ID : " + userId));

        String hashedPassword = BCrypt.hashpw(newPlainPassword, BCrypt.gensalt(12));
        user.setPassword(hashedPassword);

        userRepository.save(user);
    }

    @Override
    public void toggleUserStatus(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Utilisateur introuvable avec l'ID : " + userId));

        user.setActive(!user.isActive());
        userRepository.save(user);
    }

    @Override
    public void deleteUser(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("Utilisateur introuvable avec l'ID : " + userId));

        userRepository.delete(user);
    }

    @Override
    public List<User> searchUsers(String keyword) {
        return userRepository.findAll();
    }
}