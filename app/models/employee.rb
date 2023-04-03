class Employee < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  belongs_to :manager, class_name: 'Employee', optional: true
  has_many :employees, class_name: 'Employee', foreign_key: 'manager_id'

  validates_uniqueness_of :email

  def self.my_import(file)
    employees = []
    emp_id_email_hash = Employee.pluck(:email, :id).to_h
    CSV.foreach(File.open(file), headers: true) do |row|
      employee_hash = row.to_hash
      manager_email = employee_hash["manager_id"]
      if manager_email.present?
        employee_hash["manager_id"] = emp_id_email_hash[manager_email]
      end
      employees << Employee.new(employee_hash)
    end 
    Employee.import(employees)
  end
end
