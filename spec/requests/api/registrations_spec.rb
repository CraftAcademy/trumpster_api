# frozen_string_literal: true

RSpec.describe "GET /api/auth", type: :request do
  let(:headers) { { HTTP_ACCEPT: "application/json" } }

  describe "with valid credentials" do
    before do
      post "/api/auth",
        params: {
          email: "test@test.com",
          password: "12345678",
          password_confirmation: "12345678",
        },
        headers: headers
    end

    it "is expected to return a 200 response status" do
      expect(response).to have_http_status 200
    end

    it "is expected to return a success message" do
      expect(response_json["status"]).to eq "success"
    end
  end

  context "when a user submits" do
    describe "a non-matching password confirmation" do
      before do
        post "/api/auth",
          params: {
            email: "test@test.com",
            password: "12345678",
            password_confirmation: "00000000",
          },
          headers: headers
      end

      it "is expected to return a 422 response status" do
        expect(response).to have_http_status 422
      end

      it "is expected to return an error message" do
        expect(response_json["errors"]["full_messages"]).to eq ["Password confirmation doesn't match Password"]
      end
    end

    describe "an invalid email address" do
      before do
        post "/api/auth",
          params: {
            email: "test@test",
            password: "12345678",
            password_confirmation: "12345678",
          },
          headers: headers
      end

      it "is expected to return a 422 response status" do
        expect(response).to have_http_status 422
      end

      it "is expected to return an error message" do
        expect(response_json["errors"]["full_messages"]).to eq ["Email is not an email"]
      end
    end

    describe "an email address that already exists" do
      let!(:registered_user) { create(:user, email: "test@test.com") }
      before do
        post "/api/auth",
          params: {
            email: "test@test.com",
            password: "12345678",
            password_confirmation: "12345678",
          },
          headers: headers
      end

      it "is expected to return a 422 response status" do
        expect(response).to have_http_status 422
      end

      it "is expected to return an error message" do
        expect(response_json["errors"]["full_messages"]).to eq ["Email has already been taken"]
      end
    end
  end
end
