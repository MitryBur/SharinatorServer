class V1::ExpensesController < ApplicationController
  #before_filter :restrict_access
  before_action :set_expense, only: [:show, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.all
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    @expense.users.build
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)
    vk_ids = params[:vk_ids]
    vk_ids.each do |vk_id|
      user = Social.find_by_vk_id(vk_id[:uid]).user
      member = Member.find_by_user_id_and_event_id user.id, expense_params[:event_id]
      if member
        @expense.users<<user
      end
    end
    if @expense.save
      render action: 'show', status: :created, location: [:v1, @expense]
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    if @expense.update(expense_params)
      head :no_content
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:event_id, :amount, :title, :description)# users_attributes: [:id])
    end
    def restrict_access
      token = params[:access_token]
      unless token && Social.find_by_vk_token(token)
        head :unauthorized
      end
    end
end
