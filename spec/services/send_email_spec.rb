require 'rails_helper'

RSpec.describe Task::SendEmail do
  let(:participants_count) { 3 }
  let(:task) { build(:task_with_participants, participants_count: participants_count) }

  subject(:service) { described_class.new }

  describe '#call' do

    #if I would like to run only one test, I can use:
    # context 'email sent after a valid task', focus: true do
    context 'email sent after a valid task' do
      before(:each) { task.save }

      it 'should return success' do
        # parallel asignment
        success, message = service.call task
        expect(success).to be_truthy
        expect(message).to eq 'Email sent'
      end
    end

    context 'email unsent for a nil task' do    
      it 'should return success' do
        # parallel asignment
        success, message = service.call nil
        expect(success).to be_falsey
        expect(message).to eq 'Email not sent'
      end
    end
  end
end