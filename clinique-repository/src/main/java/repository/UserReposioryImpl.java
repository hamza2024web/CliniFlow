package repository;

import com.clinique.domain.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import repository.Interface.UserRepository;

import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class UserReposioryImpl implements UserRepository {

    @PersistenceContext(unitName = "cliniquePU")
    private EntityManager entityManager;

    @Override
    @Transactional
    public User save(User user) {
        if (user.getId() == null) {
            entityManager.persist(user);
            return user;
        } else {
            return entityManager.merge(user);
        }
    }

    @Override
    public Optional<User> findById(Long id) {
        User user = entityManager.find(User.class, id);
        return Optional.ofNullable(user);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        try {
            User user = entityManager.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email",email)
                    .getSingleResult();
            return Optional.of(user);
        } catch (NoResultException e){
            return Optional.empty();
        }
    }

    @Override
    public boolean existsByEmail(String email) {
        Long count = entityManager.createQuery("SELECT COUNT(u) FROM User u WHERE u.email= :email",Long.class)
                .setParameter("email",email)
                .getSingleResult();
        return count > 0;
    }

    @Override
    public List<User> findAll() {
        return entityManager.createQuery("SELECT u FROM User u",User.class)
                .getResultList();
    }

    @Override
    @Transactional
    public void delete(User user) {
        if (entityManager.contains(user)) {
            entityManager.remove(user);
        } else {
            entityManager.remove(entityManager.merge(user));
        }
    }
}
