require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe LocationsController, type: :controller do
  has_authenticated_user
  render_views

  # This should return the minimal set of attributes required to create a valid
  # Location. As you add validations to Location, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { name: 'My College', street_address: '123 Main St',
      city: 'Testburgh', state: 'PA', zip: 12345, location_type: :university }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET #index" do
    it "returns a success response" do
      Location.create! valid_attributes
      get :index

      expect(response).to be_successful
      expect(response.body).to match(/My College/)
    end

    it "can filter by location_type" do
      shop_atts = valid_attributes.merge(name: 'My Shop', location_type: :shop)
      Location.create! shop_atts
      Location.create! valid_attributes
      get :index, params: { location_type: :university }

      expect(response).to be_successful
      expect(response.body).to match(/My College/)
      expect(response.body).to_not match(/My Shop/)
    end

    it "can sort by field in desired direction" do
      location1 = Location.create!(valid_attributes)
      location2 = Location.create!(valid_attributes.merge(name: 'Zzzzzz'))
      get :index, format: :json, params: { sort_by: { attribute: :name, direction: :desc } }
      parsed_body = JSON.parse(response.body)

      expect(parsed_body.first['name']).to eq(location2.name)
      expect(parsed_body.last['name']).to eq(location1.name)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      location = Location.create! valid_attributes
      get :show, params: {id: location.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      location = Location.create! valid_attributes
      get :edit, params: {id: location.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Location" do
        expect {
          post :create, params: {location: valid_attributes}
        }.to change(Location, :count).by(1)
      end

      it "redirects to the created location" do
        post :create, params: {location: valid_attributes}
        expect(response).to redirect_to(Location.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {location: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested location" do
        location = Location.create! valid_attributes
        put :update, params: {id: location.to_param, location: new_attributes}
        location.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the location" do
        location = Location.create! valid_attributes
        put :update, params: {id: location.to_param, location: valid_attributes}
        expect(response).to redirect_to(location)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        location = Location.create! valid_attributes
        put :update, params: {id: location.to_param, location: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested location" do
      location = Location.create! valid_attributes
      expect {
        delete :destroy, params: {id: location.to_param}
      }.to change(Location, :count).by(-1)
    end

    it "redirects to the locations list" do
      location = Location.create! valid_attributes
      delete :destroy, params: {id: location.to_param}
      expect(response).to redirect_to(locations_url)
    end
  end

end
