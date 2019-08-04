class Reservation < ApplicationRecord
  before_validation :overlaping_reservation?
  before_validation :start_must_be_before_end_time
  validates :start_date,
    presence: true
  validates :end_date,
    presence: true
  belongs_to :guest, class_name: "User"
  belongs_to :listing

  def duration
    end_date.to_f
    start_date.to_f
    return duration = ((end_date - start_date)/(1000*60*60*24)).round(0)
  end
  def overlaping_reservation?
    reservations = listing.reservations
    overlap = false
    reservations.each do |reservation|
      overlap = true if self.start_date.between?(reservation.start_date, reservation.end_date) 
    end 
    errors.add(:start_date, "The listing is already booked for those dates ") unless
      overlap == false
    # vérifie dans toutes les réservations du listing s'il y a une réservation qui tombe sur le datetime en entrée
  end


  private

  def start_must_be_before_end_time
    errors.add(:start_date, "must be before end date") unless
    start_date < end_date
  end
end
