FactoryGirl.define do
  factory :programmer do
    name 'Alan Turing' 
    home_country 'United Kingdom' 
    birth_date '1912-06-23' 
    death_date '1954-06-07' 
    image 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Alan_Turing_Aged_16.jpg' 
    wikipedia_page 'https://en.wikipedia.org/wiki/Alan_Turing' 
    quote 'A computer would deserve to be called intelligent if it could deceive a human into believing that it was human.' 
    claim_to_fame 'The Turing machine, breaking the Enigma code'
  end

end
