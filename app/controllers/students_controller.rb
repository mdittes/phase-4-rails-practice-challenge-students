class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def index
        students = Student.all 
        render json: students, status: :ok
    end

    def show
        student = Student.find(params[:id])
        render json: student, status: 200
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = Student.find(params[:id])
        render json: student, status: :ok
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end

    def render_not_found
        render json: {'error': "Student not found"}, status: :not_found
    end

    def render_invalid(error)
        render json: {error: error.message}, status: :unprocessable_entity
    end

end
