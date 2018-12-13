module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'no_avatar.png'
    end
  end

  def declension(number, vopros, voprosa, voprosov)
    remainder_10 = number.to_i % 10
    remainder_100 = number.to_i % 100

    if ((number.between?(10,14)) || ((remainder_100).between?(10,14)))
      return voprosov
    end
    return vopros if remainder_10 == 1
    return voprosa if remainder_10.between?(1,4)
    return voprosov if (remainder_10.between?(5,9) || remainder_10 == 0)
  end
end
