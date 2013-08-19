class Role < ActiveRecord::Base
  has_many :users

  def self.admin
    Rails.cache.fetch('role-admin') do
      self.find_by_name("Admin")
    end
  end

  def self.staff
    Rails.cache.fetch('role-staff') do
      self.find_by_name("Staff")
    end
  end

  def self.deactivated_staff
    Rails.cache.fetch('role-deactivated-staff') do
      self.find_by_name("Deactivated Staff")
    end
  end

  def self.customer
    Rails.cache.fetch('role-customer') do
      self.find_by_name("Customer")
    end
  end

  def self.guest
    Rails.cache.fetch('role-guest') do
      self.find_by_name("Guest")
    end
  end

  def self.team_roles
    [Role.admin, Role.staff, Role.deactivated_staff]
  end
end
