require('pry')
require_relative('models/bounty.rb')
Bounty.delete_all

bounty1 = Bounty.new({
  'name' => 'Jim',
  'danger_level' => 'high',
  'value' => '500',
  'homeworld' => 'Pluto'
  })

bounty2 = Bounty.new({
  'name' => 'Bob',
  'danger_level' => 'medium',
  'value' => '150',
  'homeworld' => 'Tattooine'
  })

bounty3 = Bounty.new({
  'name' => 'Mabel',
  'danger_level' => 'ermagerdyermaderd',
  'value' => '502',
  'homeworld' => 'Zolac'
  })

bounty1.save
bounty2.save
bounty3.save

bounty2.delete

bounty1.name = "Keith"
bounty1.value = "501"
bounty1.update()



all_bounties = Bounty.all

criminal = Bounty.find_by_name('Kevin')

# find_id = Bounty.find_by_id('6')

binding.pry
nil
