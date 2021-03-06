require "spec_helper"

module Alchemy
  describe Admin::EssenceFilesController do
    before do
      sign_in(admin_user)
    end

    let(:content)      { mock_model('Content', essence: essence_file) }
    let(:essence_file) { mock_model('EssenceFile', :attachment= => nil) }
    let(:attachment)   { mock_model('Attachment') }

    describe '#edit' do
      before do
        expect(Content).to receive(:find).and_return(content)
      end

      it "should assign @content with the Content found by id" do
        get :edit, content_id: content.id
        expect(assigns(:content)).to eq(content)
      end

      it "should assign @essence_file with content's essence" do
        get :edit, content_id: content.id
        expect(assigns(:essence_file)).to eq(content.essence)
      end
    end

    describe '#update' do
      before do
        expect(EssenceFile).to receive(:find).and_return(essence_file)
      end

      it "should update the attributes of essence_file" do
        expect(essence_file).to receive(:update_attributes).and_return(true)
        xhr :put, :update, id: essence_file.id
      end
    end

    describe '#assign' do
      before do
        expect(Content).to receive(:find_by).and_return(content)
        expect(Attachment).to receive(:find_by).and_return(attachment)
      end

      it "should assign @attachment with the Attachment found by attachment_id" do
        xhr :put, :assign, content_id: content.id, attachment_id: attachment.id
        expect(assigns(:attachment)).to eq(attachment)
      end

      it "should assign @content.essence.attachment with the attachment found by id" do
        expect(content.essence).to receive(:attachment=).with(attachment)
        xhr :put, :assign, content_id: content.id, attachment_id: attachment.id
      end

    end

  end
end
