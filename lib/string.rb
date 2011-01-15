class String
  def pad_to tSize
    return self[0..tSize - 1] if self.size > tSize
    spaces = tSize - self.size
    return self + " "*spaces
  end
  
  def starts_with_any_of strings
    strings.each do |str|
      return true if self.start_with?(str) 
    end
    return false
  end
end
