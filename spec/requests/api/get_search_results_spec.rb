# frozen_string_literal: true

RSpec.describe "GET /api/quotes", type: :request do
  let!(:registered_user) { create(:user) }
  let!(:registered_user_headers) { registered_user.create_new_auth_token }

  describe 'with "barack" as a query parameter' do
    before do
      get "/api/quotes",
        params: {
          query: "barack",
        },
        headers: registered_user_headers
    end

    it 'is expected to return a list of quotes that contains word "barack"' do
      expected_response_body = [{
        "id" => 1,
        "date" => "August 2012",
        "quote" => "An 'extremely credible source' has called my office and told me that Barack Obama's birth certificate is a fraud.",
        "source" => "https://twitter.com/realdonaldtrump/status/232572505238433794"},
       {
        "id" => 2,
        "date" => "November 2015",
        "quote" => "Marco Rubio would keep Barack Obama’s executive order on amnesty intact. See article. Cannot be President.\n\n  https://t.co/JW5f8OouyA",
        "source" => "https://twitter.com/realDonaldTrump/status/661570281060835328"},
      ].as_json
      expect(response_json).to eq expected_response_body
    end
  end
end
