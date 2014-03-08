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
    #@expense = //@event.expenses.find(params[:id])
    set_payer
    set_debtors
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = @event.expenses.new(expense_params)
    @expense.payer_id = (SocialProfile.find_by_vk_access_token params[:access_token]).user_id

    params[:expense][:users].each do |user|
      unless user[:id]== @expense.payer_id
        amount = expense_params[:price]/params[:expense][:users].size
        debt = Debt.new(:debtor_id => user[:id], :amount => amount)
        debt.creditor_id = @expense.payer_id
        debt.save
        @expense.debts << debt
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
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:event_id, :price, :currency, :title, :due_date, :description, :image_url)
    end
    #Pass token as parameter
    def restrict_access
      token = params[:access_token]
      unless token && SocialProfile.find_by_vk_access_token(token)
        head :unauthorized
      end
    end

    def set_debtors
      @debtors = []
      @expense.debts.each do |debt|
        @debtors<<User.find(debt.debtor_id)
      end
    end
    def set_payer
      @payer = User.find(@expense.payer_id)
    end
end
