require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end
  
  #uses CSS selector to grab HTML elements containing a course
  def get_courses
    get_page.css(".post")
  end
  
  #instantiates Course objects and gives them a title, schedule, description attribute scraped from the page
  def make_courses
    doc = get_courses
    doc.each do |element|
      new_course = Course.new
      new_course.title = element.css("h2").text
      new_course.schedule = element.css(".date").text
      element.css("p").text
      #binding.pry
    end
  end
  
  
    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end



