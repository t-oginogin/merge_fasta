task :clean_all_fasta => :environment do
  FastaDatum.destroy_all
end

task :clean_hours_fasta, ['amount'] => :environment do |tasks, args|
  FastaDatum.where('updated_at <= ?', args.amount.to_i.hours.ago).destroy_all
end

