class PostValidator < ActiveModel::Validator
  def validate(record)
    if !record.title.present?
      record.errors[:title] << 'must be given'
    end

    if !record.body.present?
      record.errors[:body] << 'must be given'
    end

    if !record.user.present?
      record.errors[:user] << 'must be given'
    end
  end
end