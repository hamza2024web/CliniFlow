package repository.Interface;

import com.clinique.domain.User;

import java.util.List;
import java.util.Optional;

public interface UserRepository {

    User save(User user);

    Optional<User> findById(Long id);

    Optional<User> findByEmail(String email);

    boolean existsByEmail(String email);

    List<User> findAll();

    void delete(User user);
}
