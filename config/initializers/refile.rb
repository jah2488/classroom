require "refile/s3"
if Rails.env.production?
  aws = {
    access_key_id: ENV['AWS_ID'],
    secret_access_key: ENV['AWS_SECRET'],
    region: "us-east-1",
    bucket: ENV['S3_BUCKET'],
  }
  Refile.cache = Refile::S3.new(prefix: "cache", **aws)
  Refile.store = Refile::S3.new(prefix: "store", **aws)
  Refile.cdn_host = "//" + ENV['ASSET_HOST']
else
  backend = Refile::Backend::FileSystem.new("tmp")
  Refile.cache = backend
  Refile.store = backend
end
