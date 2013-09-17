module UploadFile
  class CarrierWave::Uploader::Base

    storage :file 

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def extension_white_list
      %w(xls xlsx)
    end

    def filename
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path)).to_s + ".#{file.extension}" if current_path && original_filename
    end

  end
end
