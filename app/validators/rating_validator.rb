class RatingValidator < ActiveModel::Validator
  def validate(record)
    if !record.value.present?
      record.errors[:value] << 'must be given'
      
    elsif (1..5).exclude?(record.value)
      record.errors[:value] << 'out of range'
    end
  end
end