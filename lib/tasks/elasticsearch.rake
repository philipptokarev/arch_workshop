namespace :elasticsearch do
  desc 'Создать индекс и импортировать данные'
  task setup: :environment do
    Book.__elasticsearch__.create_index!
    Book.__elasticsearch__.import(batch_size: 1000)
  end

  desc 'Переиндексировать данные'
  task reindex: :environment do
    Book.__elasticsearch__.create_index! force: true
    Book.__elasticsearch__.import(batch_size: 1000)
  end
end
