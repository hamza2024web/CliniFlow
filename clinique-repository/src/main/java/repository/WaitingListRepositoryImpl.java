package repository;

import com.clinique.domain.WaitingListEntry;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import repository.Interface.WaitingListRepository;

@ApplicationScoped
public class WaitingListRepositoryImpl implements WaitingListRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public WaitingListEntry save(WaitingListEntry waitinglist) {
        if (waitinglist.getId() == null ){
            entityManager.persist(waitinglist);
            return waitinglist;
        } else {
            return entityManager.merge(waitinglist);
        }
    }
}
