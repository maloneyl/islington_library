RSpec.describe IslingtonLibrary::QueryResultInterpreter do
  subject do
    described_class.new(
      doc: parsed_query_result_xml,
      requested_title: requested_title
    )
  end

  let(:parsed_query_result_xml) do
    Nokogiri::XML(File.read(File.expand_path(query_result_file_path, File.dirname(__FILE__))))
  end
  let(:query_result_file_path) { "../fixtures/query_results/#{fixture_filename}" }
  let(:requested_title) { "The Fake Book: A subtitle that's slightly different" }

  describe "#initialize" do
    let(:fixture_filename) { "four_items_incl_two_non_books_and_one_dud.xml" }

    it "filters out non-book items and unlikely matches" do
      filtered_doc = subject.instance_variable_get(:@doc)

      expect(filtered_doc.xpath("//rss:item").count).to eq(1)
      expect(filtered_doc.xpath("//rss:item/dc:format").text).to eq("HardbackBook")
      expect(filtered_doc.xpath("//rss:item/rss:title").text).to eq("The Fake Book: With some kind of subtitle")
    end
  end

  describe "#result" do
    context "when there are book items" do
      let(:fixture_filename) { "two_items.xml" }
      let(:requested_title) { "The Martian" }

      it "returns the newer book" do
        result = subject.result

        expect(result.book.year).to eq("2015")
        expect(result.book.link).to eq("http://capitadiscovery.co.uk/islington/items/872958")
        expect(result.book.isbn).to eq("1785031139")
        expect(result.book.title).to eq("The Martian")
        expect(result.book.author).to eq("Weir, Andy, author.")
      end

      context "when the book officially has one or more editors instead of authors" do
        let(:fixture_filename) { "one_item_with_contributors_instead_of_creators.xml" }
        let(:requested_title) { "The Recovery Letters: Addressed to People Experiencing Depression" }

        it "doesn't blow up and treats the first editor as the author" do
          result = subject.result

          expect(result.book.author).to eq("Sagan, Olivia, editor.")
        end
      end
    end

    context "when there are no book items" do
      let(:fixture_filename) { "zero_items.xml" }

      it "returns a result with no book" do
        result = subject.result

        expect(result.book).to be_nil
      end
    end
  end
end
