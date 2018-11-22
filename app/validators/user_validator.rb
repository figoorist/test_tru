class UserValidator < ActiveModel::Validator
  def validate(record)
    if !record.login.present?
      record.errors[:login] << 'must be given!'
    end

    if User.all.exists?(login: record.login)
      record.errors[:login] << 'must be unique!'
    end
  end
end