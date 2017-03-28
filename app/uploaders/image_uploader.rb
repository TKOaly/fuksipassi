class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def default_url
  end

  process :tags => ['fuksipassi']
  process :convert => 'jpg'
  process :resize_to_fit => [1000, 1000]
  cloudinary_transformation :quality => 80


  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  version :list do
    process :resize_to_fill => [80, 100]
  end

  version :display do
    process :resize_to_fit => [300, 300]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end