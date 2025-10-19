package repository.Interface;

import com.clinique.domain.WaitingListEntry;

public interface WaitingListRepository {
    WaitingListEntry save(WaitingListEntry wailtinglist);
}
