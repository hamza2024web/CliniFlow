package service;

import com.clinique.domain.*;
import com.clinique.domain.Enum.AppointmentStatus;
import com.clinique.domain.Enum.AppointmentType;
import com.clinique.domain.Enum.Priority;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import repository.Interface.AppointmentRepository;
import repository.Interface.AvailabilityRepository;
import repository.Interface.DoctorRepository;
import repository.Interface.WaitingListRepository;
import service.Interface.AppointmentService;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class AppointmentServiceImpl implements AppointmentService {

    @Inject
    private AppointmentRepository appointmentRepository;

    @Inject
    private AvailabilityRepository availabilityRepository;

    @Inject
    private WaitingListRepository waitingListRepository;

    @Inject
    private DoctorRepository doctorRepository;

    @Override
    public List<TimeSlot> getAvailableSlots(Doctor doctor, LocalDate date, AppointmentType type) {
        List<TimeSlot> slots = new ArrayList<>();
        DayOfWeek javaDayOfWeek = date.getDayOfWeek();
        com.clinique.domain.Enum.DayOfWeek myDayOfWeek = com.clinique.domain.Enum.DayOfWeek.valueOf(javaDayOfWeek.name());
        Optional<Availability> optAvailability  = availabilityRepository.findByDoctorAndDay(doctor , myDayOfWeek );
        if (optAvailability .isEmpty()){
            return slots;
        }
        Availability availability = optAvailability.get();

        int duration = getDurationByType(type);
        LocalTime current = availability.getStartTime();
        LocalTime end = availability.getEndTime();
        LocalDateTime now = LocalDateTime.now();

        while (current.plusMinutes(duration).isBefore(end) || current.plusMinutes(duration).equals(end)){
            LocalDateTime slotStart = LocalDateTime.of(date, current);
            LocalDateTime slotEnd = slotStart.plusMinutes(duration);

            if (slotStart.isAfter(now.plusHours(2))){
                boolean available = isSlotAvailable(doctor,slotStart,slotEnd);
                slots.add(new TimeSlot(slotStart, slotEnd, true , available , type));
            }

            current = current.plusMinutes(duration + 5);
        }
        return slots;
    }

    @Override
    public Optional<Appointment> createAppointment(Patient patient, Doctor doctor, LocalDateTime start, AppointmentType type, Priority priority) {
        int duration = getDurationByType(type);
        LocalDateTime end = start.plusMinutes(duration);

        if (isSlotAvailable(doctor,start,end)){
            Appointment appointment = new Appointment(start,end,patient,doctor);
            appointment.setAppointmentType(type);
            appointment.setStatus(AppointmentStatus.SCHEDULED);
            return Optional.of(appointmentRepository.save(appointment));
        } else {
            WaitingListEntry entry = new WaitingListEntry(start.toLocalDate(), priority, patient , doctor);
            waitingListRepository.save(entry);
            return Optional.empty();
        }
    }

    @Override
    public boolean isSlotAvailable(Doctor doctor, LocalDateTime start, LocalDateTime end) {
        return !appointmentRepository.existsByDoctorAndTime(doctor, start, end);
    }

    @Override
    public List<Appointment> getAppointmentsByPatient(Patient patient) {
        return appointmentRepository.findByPatient(patient);
    }

    @Override
    public List<Appointment> getAppointmentsByDoctorAndDate(Doctor doctor, LocalDate date) {
        LocalDateTime dayStart = date.atStartOfDay();
        LocalDateTime dayEnd = date.atTime(LocalTime.MAX);
        return appointmentRepository.findByDoctorAndDate(doctor,dayStart,dayEnd);
    }

    @Override
    public List<Doctor> getDoctorsBySpeciality(Long specialtyId) {
        return doctorRepository.findBySpecialityId(specialtyId);
    }

    private int getDurationByType(AppointmentType type){
        switch (type) {
            case CONSULTATION: return 30;
            case SPECIALIZED: return 45;
            case URGENCY: return 30;
            default: return 30;
        }
    }
}
