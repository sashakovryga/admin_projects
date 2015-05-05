module ApplicationHelper
  def months_split(from, to)
    months = (to.year * 12 + to.month) - (from.year * 12 + from.month)
    _days = (60 * 60 * 24)
    days = (to - from).to_i / _days
    intervals = []
    current = from
    while current <= to
      now = current
      current = current.end_of_month.end_of_day
      current = to if current > to
      intervals << (current - now).to_i / _days
      current = (current + 1.days).beginning_of_day
    end
    # intervals = intervals.map{|i| (i.to_f/days).to_f*100}
    {months: months, days: days, intervals: intervals}
  end
end
