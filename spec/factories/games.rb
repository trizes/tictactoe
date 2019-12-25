FactoryBot.define do
  factory :game, class: 'Game' do
    board  { '---------' }
    status { 'RUNNING' }
  end
end
