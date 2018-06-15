require 'spec_helper'

describe 'Ingredient' do
  it 'is invalid with a blank name' do
    ingredient1 = Ingredient.new(name: nil)
    ingredient2 = Ingredient.new(name: '')

    expect(ingredient1).to have(1).errors_on(:name)
    expect(ingredient2).to have(1).errors_on(:name)
  end
end
