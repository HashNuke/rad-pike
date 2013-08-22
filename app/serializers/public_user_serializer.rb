class PublicUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_support_team

  def is_support_team
    object.support_team?
  end
end 