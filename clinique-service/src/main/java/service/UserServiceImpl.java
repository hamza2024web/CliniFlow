package service;

import com.clinique.domain.Enum.Role;
import com.clinique.domain.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.mindrot.jbcrypt.BCrypt;
import repository.Interface.UserRepository;
import service.Interface.UserService;

import java.util.Optional;

@ApplicationScoped
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

        String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
        user.setPassword(hashedPassword);

        user.setRole(role);

        return userRepository.save(user);
    }

    @Override
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
}
