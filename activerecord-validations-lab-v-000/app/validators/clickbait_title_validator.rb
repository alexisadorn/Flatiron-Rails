class ClickbaitTitleValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\b(Won't Believe|Secret|Top \d|Guess)\b/
      record.errors[attribute] << "Title is not clickbaity enough"
    end
  end
end
