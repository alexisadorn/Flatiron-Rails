Pond.create([
  {:name => "Walden", :water_type => "alkaline"},
  {:name => "Swan", :water_type => "acidic"},
  {:name => "Turtle", :water_type => "murky"},
  {:name => "Lullwater", :water_type => "saline"}
])

Frog.create([
  {:name => "Kermit",    :color => "green",  :pond_id => 1}, # 1
  {:name => "Harvey",    :color => "tan",    :pond_id => 1},
  {:name => "Josaphine", :color => "black",  :pond_id => 1}, # 3
  {:name => "Trevor",    :color => "brown",  :pond_id => 2},
  {:name => "Amanda",    :color => "maroon", :pond_id => 2}, # 5
  {:name => "Grover",    :color => "cyan",   :pond_id => 2},
  {:name => "John",      :color => "blue",   :pond_id => 3}, # 7
  {:name => "Raphael",   :color => "pink",   :pond_id => 3},
  {:name => "Samantha",  :color => "yellow", :pond_id => 3}, # 9
  {:name => "Kate",      :color => "red",    :pond_id => 4},
  {:name => "Armando",   :color => "orange", :pond_id => 4}, # 11
  {:name => "Nisha",     :color => "mint",   :pond_id => 4},
])

Tadpole.create([
  {:name => "Michael",   :color => "green",  :frog_id => 1},
  {:name => "Harold",    :color => "green",  :frog_id => 1},
  {:name => "Linda",     :color => "tan",    :frog_id => 2},
  {:name => "Elana",     :color => "black",  :frog_id => 3},
  {:name => "Julie",     :color => "brown",  :frog_id => 4},
  {:name => "Ian",       :color => "brown",  :frog_id => 4},
  {:name => "Rebecca",   :color => "maroon", :frog_id => 5},
  {:name => "Toby",      :color => "cyan",   :frog_id => 6},
  {:name => "Shawn",     :color => "blue",   :frog_id => 7},
  {:name => "Kristin",   :color => "pink",   :frog_id => 8},
  {:name => "Ted",       :color => "pink",   :frog_id => 8},
  {:name => "Travis",    :color => "pink",   :frog_id => 8},
  {:name => "Gayle",     :color => "yellow", :frog_id => 9},
  {:name => "George",    :color => "red",    :frog_id => 10},
  {:name => "Argo",      :color => "orange", :frog_id => 11},
  {:name => "Jared",     :color => "mint",   :frog_id => 12}
])
