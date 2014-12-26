task :clean_all_fasta => :environment do
  FastaDatum.destroy_all
end

task :clean_hours_fasta, ['amount'] => :environment do |tasks, args|
  fasta = FastaDatum.where('updated_at <= ?', args.amount.to_i.hours.ago)
  FastaDatum.destroy fasta if fasta.count > 0
end

