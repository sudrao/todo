module DateHelper
  def d_out(date)
    # Date display format: dd-mon-yyyy
    date.strftime('%d-%b-%Y')
  end
  
  def dstr_out(dstr)
    d_out(Date.parse(dstr))
  end
  
  def d_days(dstr)
    distance_of_time_in_words_to_now(Date.parse(dstr))
  end
end
