require 'rails_helper'

RSpec.describe Tasks::SendEmailJob, type: :job do
  describe '#perform_async' do
    let(:task_id) { '1' }

    it 'sends an email' do
      task = class_double('Task').as_stubbed_const
      service = double
      object_double('Tasks::SendEmail', new: service).as_stubbed_const
      
      expect(service).to receive(:call)
      # task_id is defined on line 5
      expect(task).to receive(:find).with(task_id)

      # the described_class is Tasks::SendEmailJob on line 3
      described_class.perform_async task_id
    end
  end
end
