require 'algoliasearch'

namespace :search_terms do
  desc 'Publish search terms to Algolia'
  task 'algolia:generate': :environment do
    Algolia.init(application_id: ENV['ALGOLIA_APPLICATION_ID'], api_key: ENV['ALGOLIA_API_KEY'])
    index = Algolia::Index.new "#{Rails.env}_nexmo_developer"
    search_articles = SearchTerms.generate
    
    search_articles.each do |search_article|
      begin
        index.add_object(search_article)
      rescue Algolia::AlgoliaProtocolError
        # puts search_article
        puts "#{search_article[:document_path]} could not be processed"
      end
    end
  end

  desc 'Clear the index in Algolia'
  task 'algolia:clear': :environment do
    Algolia.init(application_id: ENV['ALGOLIA_APPLICATION_ID'], api_key: ENV['ALGOLIA_API_KEY'])
    index = Algolia::Index.new "#{Rails.env}_nexmo_developer"
    index.clear_index
  end

  desc 'Refresh the Algolia index'
  task 'algolia:refresh': :environment do
    Rake::Task['search_terms:algolia:clear'].invoke
    Rake::Task['search_terms:algolia:generate'].invoke
  end
end
