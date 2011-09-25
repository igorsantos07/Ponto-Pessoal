def Time.get_time hour, min = 0, secs = 0
  now = self.now
  return self.local now.year, now.month, now.day, hour, min, secs
end