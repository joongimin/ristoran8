# encoding: utf-8

module I18n
  module Backend
    module Korean
      class Korean
        PROPOSITIONS = {'이' => '가', '은' => '는', '을' => '를', '과' => '와'}

        def self.get_proposition word, proposition
          return proposition if /[가-힣]/.match(word).nil?

          if word.mb_chars.last.decompose[2].nil?
            PROPOSITIONS[proposition] || proposition
          else
            PROPOSITIONS.invert[proposition] || proposition
          end
        end
      end

      def interpolate(locale, string, values = {})
        if string.is_a?(::String) && !values.empty?
          string = I18n.interpolate(string, values)
          string.gsub(/(.{1})\(\(([이가은는을를과와])\)\)/) do
            "#{$1}#{Korean.get_proposition $1, $2}"
          end
        else
          string
        end
      end
    end
  end
end