class Api::TodosController < ApplicationController

  def show
    @todo = Todo.find(params[:id])
    render json: @todo, include: :tags
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save!
      render json: @todo, include: :tags
    else
      render json: @todo.errors.full_messages, status: 422
    end
  end

  def update
    @todo = Todo.find(params[:id])

    if @todo && @todo.update(todo_params)
      render json: @todo, include: :tags
    else
      render json: @todo.errors.full_messages, status: 422
    end
  end

  def destroy
    @todo = Todo.find(params[:id])

    @todo.delete
    render json: @todo, include: :tags
  end

  def index
    @todos = Todo.all
    render json: @todos, include: :tags
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :body, :done, tag_names: [])
  end
end
