class ExpensesController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @expenses = @category.expenses.all
  end

  def new
    @category = Category.find(params[:category_id])
    @expense = @category.expenses.new
  end

  def create
    @category = Category.find(params[:category_id])
    @expense = @category.expenses.new(expense_params)

    if @expense.save
      redirect_to category_expenses_path(@category), notice: 'Transaction created successfully.'
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :category_id, :author_id)
  end
end
