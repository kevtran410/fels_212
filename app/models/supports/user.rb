class Supports::User
  def initialize item = {}
    @words_count = item[:words_count]
    @user = item[:user]
  end
  
  def users_to_follow
    @users = User.people_to_follow @user.id
  end

  def sum
    sum = 0
    @words_count.values.each do |count|
      sum += count
    end
    sum
  end
end
