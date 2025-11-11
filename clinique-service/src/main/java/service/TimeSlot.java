package service;

import com.clinique.domain.Enum.AppointmentType;
import java.time.LocalDateTime;

public class TimeSlot {
    private LocalDateTime start;
    private LocalDateTime end;
    private boolean isWork;
    private boolean isAvailable;
    private AppointmentType type;

    public TimeSlot(LocalDateTime start, LocalDateTime end, boolean isWork, boolean isAvailable, AppointmentType type) {
        this.start = start;
        this.end = end;
        this.isWork = isWork;
        this.isAvailable = isAvailable;
        this.type = type;
    }
    // Getters & setters
    public LocalDateTime getStart() { return start; }
    public void setStart(LocalDateTime start) { this.start = start; }
    public LocalDateTime getEnd() { return end; }
    public void setEnd(LocalDateTime end) { this.end = end; }
    public boolean isWork() { return isWork; }
    public void setWork(boolean work) { isWork = work; }
    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }
    public AppointmentType getType() { return type; }
    public void setType(AppointmentType type) { this.type = type; }
}