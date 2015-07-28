require "refile/s3"
Refile.configure do |config|
  aws = {
    access_key_id: ENV['AWS_ID'],
    secret_access_key: ENV['AWS_SECRET'],
    region: "us-east-1",
    bucket: ENV['S3_BUCKET'],
  }
  Refile.cache = Refile::S3.new(prefix: "cache", **aws)
  Refile.store = Refile::S3.new(prefix: "store", **aws)
  Refile.host = "//" + ENV['ASSET_HOST'] unless Rails.env.test?
end
