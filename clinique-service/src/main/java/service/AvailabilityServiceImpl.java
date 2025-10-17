package service;

import com.clinique.domain.Availability;
import com.clinique.domain.Doctor;
import com.clinique.domain.Enum.DayOfWeek;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import repository.Interface.AvailabilityRepository;
import service.Interface.AvailabilityService;

import java.time.Duration;
import java.time.LocalTime;
import java.util.List;

@ApplicationScoped
public class AvailabilityServiceImpl implements AvailabilityService {
    @Inject
    AvailabilityRepository availabilityRepository;

    @Override
    @Transactional
    public Availability createAvailability(Doctor doctor, DayOfWeek dayOfWeek, LocalTime startTime, LocalTime endTime) {
        if (availabilityRepository.findByDoctorAndDay(doctor,dayOfWeek).isPresent()){
            throw new IllegalArgumentException("Vous avez déja un créneau pour ce jour.");
        }
        validateTimes(startTime,endTime);
        Availability availability = new Availability(dayOfWeek,startTime,endTime,doctor);
        availability.setActive(true);
        return availabilityRepository.save(availability);
    }

    @Override
    @Transactional
    public Availability updateAvailability(Long id, DayOfWeek dayOfWeek, LocalTime startTime, LocalTime endTime, boolean active) {
        Availability existing = availabilityRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Disponibilité introuvable ."));
        if (!existing.getDayOfWeek().equals(dayOfWeek)){
            if (availabilityRepository.findByDoctorAndDay(existing.getDoctor(), dayOfWeek).isPresent()){
                throw new IllegalArgumentException("Vous avez déja un créneau pour ce jour.");
            }
        }
        validateTimes(startTime,endTime);
        existing.setDayOfWeek(dayOfWeek);
        existing.setStartTime(startTime);
        existing.setEndTime(endTime);
        existing.setActive(active);
        return availabilityRepository.save(existing);
    }

    @Override
    @Transactional
    public void deleteAvailability(Long id) {
        // To do : vérifiez ce qu'il n'y pas un rendez-vous associez avant de supprimer .
        availabilityRepository.delete(id);
    }

    @Override
    public Availability getAvailabilityById(Long id) {
        return availabilityRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Disponibilité Introuvable."));
    }

    @Override
    public List<Availability> getAvailabilityByDoctor(Doctor doctor) {
        return availabilityRepository.findByDoctor(doctor);
    }

    @Override
    public List<Availability> getAvailabilitiesByDoctor(Doctor doctor) {
        return availabilityRepository.findAvailabilityByDoctor(doctor);
    }

    private void validateTimes(LocalTime startTime , LocalTime endTime){
        if (startTime == null || endTime == null){
            throw new IllegalArgumentException("Heures de début et de fin obligatoires.");
        }

        Long durationMinutes;
        if (endTime.isAfter(startTime)){
            durationMinutes = Duration.between(startTime,endTime).toMinutes();
        } else if (endTime.isBefore(startTime)){
            durationMinutes = Duration.between(startTime, LocalTime.MIDNIGHT).toMinutes() + Duration.between(LocalTime.MIN , endTime).toMinutes();
        } else {
            throw new IllegalArgumentException("L'heure de début et de fin ne peuvent pas étre identiques.");
        }

        if (durationMinutes > 480){
            throw new IllegalArgumentException("La durée maximale d'un créneau est de 8 heures");
        }
        if (durationMinutes <= 0){
            throw new IllegalArgumentException("La durée du créneau doit étre positive.");
        }
    }
}
