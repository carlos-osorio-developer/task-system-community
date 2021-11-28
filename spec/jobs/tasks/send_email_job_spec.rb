require 'rails_helper'

RSpec.describe Tasks::SendEmailJob, type: :job do
  describe '#perform_async' do
    let(:task_id) { '1' }

    it 'sends an email' do
      task = class_double('Task').as_stubbed_const
      service = double
      object_double('Task::SendEmail', new: service).as_stubbed_const
      
      expect(service).to receive(:call)
      expect(task).to receive(:find).with(task_id)

      described_class.perform_async task_id
    end
  end
end
