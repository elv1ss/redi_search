# frozen_string_literal: true

require "redi_search/search/term"
require "redi_search/search/and_clause"
require "redi_search/search/or_clause"

module RediSearch
  class Search
    module Clauses
      def highlight(**options)
        clauses.push(*HighlightClause.new(**options).clause)

        self
      end

      def slop(slop)
        clauses.push("SLOP", slop)

        self
      end

      def inorder
        clauses.push("INORDER")

        self
      end

      def language(language)
        clauses.push("LANGUAGE", language)

        self
      end

      def expander(expander)
        clauses.push("EXPANDER", expander)

        self
      end

      def scorer(scorer)
        clauses.push("SCORER", scorer)

        self
      end

      def payload(payload)
        clauses.push("PAYLOAD", payload)

        self
      end

      def sortby(field, order: :asc)
        raise ArgumentError unless %i(asc desc).include?(order.to_sym)

        clauses.push("SORTBY", field, order)

        self
      end

      def limit(offset, num)
        clauses.push("LIMIT", offset, num)

        self
      end

      def and(*new_terms, **terms_with_options)
        @term_clause =
          AndClause.new(@term_clause, *new_terms, **terms_with_options)

        self
      end

      def or(*new_terms, **terms_with_options)
        @term_clause =
          OrClause.new(@term_clause, *new_terms, **terms_with_options)

        self
      end
    end
  end
end
