# frozen_string_literal: true

class PdfsController < ApplicationController
  def print
    respond_to do |format|
      format.pdf do
        send_data WickedPdf.new.pdf_from_string('<h1>Hello There!</h1>'), file_name: 'hello_there.pdf'
      end

      format.any do
        render plain: 'Hello There!'
      end
    end
  end
end
