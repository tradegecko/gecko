module VCRHelper
  def load_vcr_hash(fixture, key)
    yaml = YAML.load_file(VCR.configuration.cassette_library_dir + "/#{fixture}.yml")
    response = VCR::HTTPInteraction.from_hash(yaml["http_interactions"][0]).response.decompress.body
    JSON.parse(response)[key]
  end
end
