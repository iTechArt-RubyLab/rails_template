# frozen_string_literal: true

module Messengers
  module Slack
    class MessageFormatService
      ITALIC_SIGN = '_'
      BOLD_SIGN = '*'
      CODE_SIGN = '`'
      BLOCK_SIGN = '```'
      NEW_LINE = "\n"

      LINE_SEPARATOR_LENGTH = 120

      COLORS = {
        'Green' => '#008000',
        'Red' => '#FF0000',
        'Yellow' => '#FFFF00',
        'Grey' => '#808080'
      }.freeze

      class << self
        def new_line
          NEW_LINE
        end

        def colors
          COLORS
        end

        def separate
          NEW_LINE + '-' * LINE_SEPARATOR_LENGTH
        end

        def italic(text)
          wrap(text, ITALIC_SIGN)
        end

        def bold(text, opts)
          if opts[:bold_opening] && opts[:bold_closing]
            wrap_tag(text, opts[:bold_opening], opts[:bold_closing])
          else
            wrap(text, BOLD_SIGN)
          end
        end

        def code(text)
          wrap(text, CODE_SIGN)
        end

        def block(text)
          wrap(text, BLOCK_SIGN)
        end

        private

        def wrap(text, sign)
          [sign, text, sign].join
        end

        def wrap_tag(text, opening_tag, closing_tag)
          [opening_tag, text, closing_tag].join
        end
      end
    end
  end
end
