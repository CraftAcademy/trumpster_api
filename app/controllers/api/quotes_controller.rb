class Api::QuotesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  API_URL = "https://api.tronalddump.io".freeze

  def show
    if params[:id] == "random"
      url = "#{API_URL}/random/quote"
      result = RestClient.get(url)
    end
    quote = JSON.parse(result.body)
    render json: format_json_response(quote)
  end

  def index
    if params[:query] = params["query"]
      url = "#{API_URL}/search/quote"
      result = RestClient.get(url, params: { query: params["query"] })
    end
    quotes = JSON.parse(result.body)["_embedded"]["quotes"]
    render json: format_json_search_results(quotes)
  end

  private

  def format_json_response(obj)
    {
      date: DateTime.parse(obj["appeared_at"]).strftime("%B %Y"),
      source: obj["_embedded"]["source"][0]["url"],
      random_quote: obj["value"],
    }
  end

  def format_json_search_results(quotes)
    quotes.map { |quote|
      {
        id: (quotes.index(quote) + 1),
        date: DateTime.parse(quote["appeared_at"]).strftime("%B %Y"),
        quote: quote["value"],
        source: quote["_embedded"]["source"][0]["url"],
      }
    }
  end
end
