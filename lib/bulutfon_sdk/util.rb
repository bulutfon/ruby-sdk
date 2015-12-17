module BulutfonSDK
  module Util
    def file_content_type(path)
      if File.exist? path
        stdin,stdout,stderr = Open3.popen3(%{file --mime -b #{path}})

        file_err  = stderr.gets
        file_out  = stdout.gets

        raise BulutfonSDK::REST::SDKError.new "The 'file' command line binary was not found." if file_err

        return file_out.split(';')[0].strip if file_err.nil? && (!file_out.nil? && !file_out.empty?)
      end

      raise BulutfonSDK::REST::SDKError.new 'File content type not found'
    end
  end
end
