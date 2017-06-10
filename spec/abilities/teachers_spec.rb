require 'rails_helper'
require 'cancan/matchers'

describe Canard::Abilities, '#teachers' do
  let(:acting_teacher) { FactoryGirl.create(:user, :teacher) }
  subject(:teacher_ability) { Ability.new(acting_teacher) }

  describe 'on Teacher' do
    let(:user) { FactoryGirl.create(:user) }

    it { is_expected.to be_able_to(:manage, acting_teacher) }
    it { is_expected.to_not be_able_to(:destroy, user) }
  end
  # on Teacher
end
