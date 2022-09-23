class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def index
        instructors = Instructor.all 
        render json: instructors, status: :ok
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: 200
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = Instructor.find(params[:id])
        render json: instructor, status: :ok
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def render_not_found(error)
        render json: {error: error.message}, status: :not_found
    end

    def render_invalid(error)
        render json: {error: error.message}, status: :unprocessable_entity
    end

end
