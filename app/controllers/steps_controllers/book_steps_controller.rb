module StepsControllers
  class BookStepsController < ApplicationController
    include Wicked::Wizard

    steps *Book.form_steps.keys

    def show
      book_attrs = Rails.cache.fetch params[:build_book_id]
      @book = Book.new book_attrs
      render_wizard
    end

    def update
      book_attrs = Rails.cache.fetch(params[:build_book_id]).merge book_params
      p book_attrs
      @book = Book.new book_attrs.merge(form_step: step.to_sym)

      if @book.valid?
        Rails.cache.write params[:build_book_id], book_attrs
        redirect_to_next next_step
      else
        render_wizard nil, status: :unprocessable_entity
      end
    end

    private

    def book_params
      params.require(:book).permit(Book.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      book_attrs = Rails.cache.fetch(params[:build_book_id])
      @book = Book.new book_attrs
      @book.save!
      Rails.cache.delete params[:build_book_id]
      book_path(@book)
    end
  end
end
