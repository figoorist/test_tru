class RatingValidator < ActiveModel::Validator
  def validate(record)
    if record.value == nil || record.value == ""
      record.errors[:value] << 'must be given'
      
    elsif record.value < 1 || record.value > 5
      record.errors[:value] << 'out of range'
    end

  end
end