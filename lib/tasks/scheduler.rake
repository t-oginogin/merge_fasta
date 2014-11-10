task :clean_all_fasta => :environment do
  FastaDatum.destroy_all
end

