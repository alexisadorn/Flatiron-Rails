require 'rails_helper'

describe CouponsController do

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new coupon" do
        expect{
          post :create, { :coupon => { :coupon_code => "ASD123", :store => "Dean and Deluca" } }
        }.to change(Coupon,:count).by(1)
      end
      
      it "redirects to the new coupon" do
        post :create, { :coupon => { :coupon_code => "ASD123", :store => "Dean and Deluca" } }
        expect(response).to redirect_to Coupon.last
      end
    end
  end

end