class ReviewsController < ApplicationController
  def index
  end

  def search
    # get product reviews page
    p_page = Nokogiri::HTML(open("https://www.walmart.com/reviews/product/#{params[:p_id]}"))

    # get all reviews
    reviews = p_page.css('.js-review-list').css('.customer-review-text').map(&:text)

    # find related reviews
    @res_reviews = refine_reviews reviews, params[:p_words]
  end

  private

  def refine_reviews(reviews, string)
    words = string.split(' ')
    reviews_to_refine = reviews.dup

    words.each do |word|
      reviews_to_refine.delete_if {|r| r.include? word}
    end
    reviews - reviews_to_refine
  end
end
