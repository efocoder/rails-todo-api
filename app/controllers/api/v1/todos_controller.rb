# frozen_string_literal: true

module Api
  module V1
    class TodosController < ApplicationController
      before_action :set_api_v1_todo, only: %i[show update destroy update_status]

      # GET /api/v1/todos
      def index
        @api_v1_todos = Api::V1::Todo.where('user_id = ? AND status != ?', current_user.id, TODO_STATUS[:deleted])
        render json: create_response(200, 'Request Successful',
                                     serialize_data(Api::V1::TodoSerializer, @api_v1_todos)), status: :ok
      end

      # GET /api/v1/todos/1
      def show
        render json: create_response(200, 'Request Successful',
                                     serialize_data(Api::V1::TodoSerializer, @api_v1_todo)), status: :ok
      end

      # POST /api/v1/todos
      def create
        @api_v1_todo = Api::V1::Todo.new(api_v1_todo_params)
        @api_v1_todo.user = current_user
        if @api_v1_todo.save
          render json: create_response(201, 'Todo created successfully',
                                       serialize_data(Api::V1::TodoSerializer, @api_v1_todo)), status: :created
        else
          render json: @api_v1_todo.errors, status: :unprocessable_entity
        end
      end

      # POST /api/v1/todos
      def update_status
        status = params[:status]

        if TODO_STATUS.value?(status.to_s)
          @api_v1_todo.status = status
          if @api_v1_todo.save
            render json: create_response(200, 'Todo status updated successfully',
                                         serialize_data(Api::V1::TodoSerializer, @api_v1_todo)), status: :ok
          else
            render json: @api_v1_todo.errors, status: :unprocessable_entity
          end
        else
          render json: create_response(422, "Please provide a valid status of #{TODO_STATUS.flatten}"),
                 status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/todos/1
      def update

        if api_v1_todo_params[:status].present? && !TODO_STATUS.value?(api_v1_todo_params[:status].to_s)
          render json: create_response(422, "Please provide a valid status of #{TODO_STATUS.flatten}"),
                 status: :unprocessable_entity

        elsif @api_v1_todo.update(api_v1_todo_params)
          render json: create_response(200, 'Todo updated successfully',
                                       serialize_data(Api::V1::TodoSerializer, @api_v1_todo)), status: :ok
        else
          render json: @api_v1_todo.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/todos/1
      def destroy
        @api_v1_todo.status = TODO_STATUS[:deleted]
        if @api_v1_todo.save
          render json: create_response(200, 'Todo deleted successfully'), status: :ok
        else
          render json: @api_v1_todo.errors, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_api_v1_todo
        @api_v1_todo = Api::V1::Todo.find_by!('id = ? AND user_id = ? AND status != ?',
                                              params[:id], current_user.id, TODO_STATUS[:deleted])
        # raise ActiveRecord::RecordNotFound unless @api_v1_todo
      end

      # Only allow a list of trusted parameters through.
      def api_v1_todo_params
        params.require(:todo).permit(:title, :description, :status, :user_id)
      end
    end
  end
end
