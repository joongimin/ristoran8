module OrderStatus
  include Application::Enum

  OrderStatus.define :PENDING, 10
  OrderStatus.define :REQUESTED, 20
  OrderStatus.define :CONFIRMED, 30
  OrderStatus.define :CANCELLED, 40
end