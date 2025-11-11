package service.Interface;

import com.clinique.domain.Availability;
import com.clinique.domain.Doctor;
import com.clinique.domain.Enum.DayOfWeek;

import java.time.LocalTime;
import java.util.List;

public interface AvailabilityService {
    Availability createAvailability(Doctor doctor,DayOfWeek dayOfWeek,LocalTime startTime,LocalTime endTime);
    Availability updateAvailability(Long id,DayOfWeek dayOfWeek,LocalTime startTime,LocalTime endTime,boolean active);
    void deleteAvailability(Long id);
    Availability getAvailabilityById(Long id);
    List<Availability> getAvailabilityByDoctor(Doctor doctor);
    List<Availability> getAvailabilitiesByDoctor(Doctor doctor);
}
