require 'csv'

CSV.generate do |csv|
  column_names = %w(Date Started Finished)
  csv << column_names
  @dates.each do |date|
    column_values = [
      date.worked_on.to_s(:date),
      if date.started_at.present?
        date.started_at.strftime("%H:%M")
      end,
      if  date.finished_at.present?
        date.finished_at.strftime("%H:%M")
      end
    ]
    csv << column_values
  end
end