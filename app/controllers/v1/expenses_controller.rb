class V1::ExpensesController < ApplicationController
  #before_filter :restrict_access
  #before_action :set_expense, only: [:show, :update, :destroy]


  # GET /expenses
  # GET /expenses.json
  def index
    @event = get_event(params[:event_id])
    @expenses = @event.expenses
  end


  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @event = get_event(params[:event_id])
    @expense = @event.expenses.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @event = get_event(params[:event_id])
    @expense = @event.expenses.new(expense_params)

    if @expense.save
      format.json { render json: @tweet }
    end
      format.json { render json: @tweet.errors,
                           status: :unprocessable_entity}

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



  def get_event(id)
    Expense.find(id)
  end




  private

    def expense_params
      params.require(:event_id, :amount, :description)
    end
end
