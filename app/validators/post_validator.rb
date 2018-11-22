class PostValidator < ActiveModel::Validator
  def validate(record)
    if record.title == nil || record.title.strip == ""
      record.errors[:title] << 'must be given'
    end

    if record.body == nil || record.body.strip == ""
      record.errors[:body] << 'must be given'
    end

    if record.user == nil
      record.errors[:user] << 'must be given'
    end
  end
end