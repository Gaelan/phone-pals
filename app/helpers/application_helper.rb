module ApplicationHelper
  def format_duration(seconds)
    str = ''
    if seconds >= 3600
      str += pluralize(seconds / 3600, 'hour')
      str += ' '
      seconds = seconds % 3600
    end
    if seconds >= 60
      str += pluralize(seconds / 60, 'minute')
      seconds = seconds % 60
    end
    str == '' ? 'less than a minute' : str
  end
end
