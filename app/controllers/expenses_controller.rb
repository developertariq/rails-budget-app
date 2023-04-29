class ExpensesController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @category_expenses = @category.category_expenses
    @expenses = Expense.joins(:category_expenses, :categories)
      .where('expenses.id = category_expenses.expense_id')
      .where('categories.id = category_expenses.category_id')
      .where('categories.id = ?', params[:category_id]).order('expenses.created_at DESC')
  end

  def new
    @expense = Expense.new
    @categories = current_user.categories
  end

  def create
    @expense = Expense.new(name: params[:name], amount: params[:amount], author_id: params[:author_id])

    if @expense.save
      category_expense = CategoryExpense.new(category_id: params[:category], expense_id: @expense.id)
      category_expense.save
      redirect_to category_expenses_path(params[:category]), notice: 'Transaction created successfully.'
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :author_id)
  end
end
