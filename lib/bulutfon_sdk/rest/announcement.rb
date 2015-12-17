require 'bulutfon_sdk/rest/base_request'

module BulutfonSDK
  module REST
    class Announcement < BaseRequest

      include BulutfonSDK::Util

      def initialize(*args)
        super(*args)
        @resource = 'announcements'
      end

      def all( params = {} )
        prepare_request( 'get', @resource,params)
      end

      def get( id )
        uri = prepare_uri("#{@resource}/#{id}")
        { download_path: uri.to_s }
      end

      def save( id, save_path)
        save_file( 'get', "#{@resource}/#{id}", save_path)
      end

      def create(params)
        prepare_atachment(params)
        prepare_request( 'post', @resource, params)
      end

      def delete(id)
        prepare_request( 'delete', "#{@resource}/#{id}")
      end

      private

      def prepare_atachment(params)
        file          = params[:announcement]
        basename      = File.basename file
        type          = file_content_type file
        content       = File.read(file)
        base_64_data  = Base64.strict_encode64(content)
        params[:announcement] = "data:#{type};name:#{basename};base64:#{base_64_data}"
      end

    end
  end
end
