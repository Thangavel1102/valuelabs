class EmployeesController < ApplicationController
  def index
    @employees = Employee.includes(:manager)
  end

  def import
    Employee.my_import(params[:file])
    redirect_to employees_index_path, notice: 'Employee data was successfully imported.'
  end
end
