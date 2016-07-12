class ReceiptPrinter
  COST = {
    'meat' => 5,
    'milk' => 3,
    'candy' => 1,
  }

  TAX = 0.05

  def initialize(output: $stdout, items:)
    @output = output
    @items = items
  end

  def print
    subtotal = subtotal_amount
    print_divider
    print_line(label:"subtotal", amount: format_amount(subtotal))
    print_line(label:"tax", amount: format_amount(tax_amount(subtotal)))
    print_divider
    print_line(label:"total", amount: format_amount(total_amount(subtotal)))
  end

  private

  attr_reader :output, :items

  def total_amount(amount)
    amount + tax_amount(amount)

  end

  def tax_amount(amount)
    amount * TAX
  end

  def subtotal_amount
    items.reduce(0) do |sum, item|
      item_cost = COST[item]
      print_line(label: item, amount: format_amount(item_cost))

      sum + item_cost.to_i
    end
  end

  def format_amount(amount)
    sprintf('$%.2f', amount)
  end

  def print_line(label:, amount:)
    output.puts "#{label}: #{amount}"
  end

  def print_divider
    output.puts divider
  end

  def divider
    '-' * 13
  end
end
