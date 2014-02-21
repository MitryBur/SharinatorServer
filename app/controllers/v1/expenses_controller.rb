class V1::ExpensesController < ApplicationController
  #before_filter :restrict_access
  before_action :set_expense, only: [:show, :update, :destroy]
  before_action :set_event, only: [:show, :index, :create]


  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = @event.expenses
  end


  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = @event.expenses.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = @event.expenses.new(expense_params)
    @expense.payer_id = (SocialProfile.find_by_vk_access_token params[:access_token]).user_id

    params[:expense][:users].each do |user|
      #TODO add Valid parameter to Debt
      unless user[:id]== @expense.payer_id
        amount = expense_params[:price]/params[:expense][:users].size
        debt = Debt.new(:creditor_id => user[:id], :amount => amount)
        debt.debtor_id = @expense.payer_id
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
    def set_event
      @event = Event.find(params[:event_id])
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
end
