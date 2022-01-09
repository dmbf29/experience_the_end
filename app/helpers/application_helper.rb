module ApplicationHelper
  def currency(amount)
    number_to_currency(amount, { unit: '¥', precision: 0 })
  end

  def booking_status_badge(booking)
    if booking.date < Date.today
      label = { pending: 'Expired', accepted: 'Completed', rejected: 'Rejected' }[booking.status.to_sym]
      color = { pending: 'secondary', accepted: 'primary', rejected: 'secondary' }[booking.status.to_sym]
    elsif booking.user == current_user
      label = { pending: 'Awaiting confirmation', accepted: 'Confirmed', rejected: 'Rejected' }[booking.status.to_sym]
      color = { pending: 'warning', accepted: 'primary', rejected: 'secondary' }[booking.status.to_sym]
    else
      label = { pending: 'Request', accepted: 'Confirmed', rejected: 'Rejected' }[booking.status.to_sym]
      color = { pending: 'primary', accepted: 'primary', rejected: 'secondary' }[booking.status.to_sym]
    end
    tag.span(label, class: "me-2 badge bg-#{color}")
  end
end
