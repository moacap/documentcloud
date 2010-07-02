class RemoteUrl < ActiveRecord::Base

  belongs_to :document

  def self.record_hits(doc_id, url, hits)
    row = self.find_or_create_by_document_id_and_url(doc_id, url)
    row.update_attributes :hits => row.hits + hits
  end

  # Return the top documents (with a :limit option) with the most hits.
  def self.top_documents(options={})
    self.all(options.merge({:order => 'hits desc', :include => ['document']})).map do |remote|
      doc            = remote.document
      doc.remote_url = remote.url
      doc.hits       = remote.hits
      doc
    end
  end

end