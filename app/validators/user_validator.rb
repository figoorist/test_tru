class UserValidator < ActiveModel::Validator
  def validate(record)
    if record.login == nil || record.login.strip == ""
      record.errors[:login] << 'must be given!'
    end

    if User.all.exists?(login: record.login)
      record.errors[:login] << 'must be unique!'
    end
  end
end