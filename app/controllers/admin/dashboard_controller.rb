class Admin::DashboardController < ApplicationController
    def index
        # @top_customers = Invoice.top_customers
        @invoices = InvoiceItem.incomplete_invoices
        @results = Invoice.customer_transactions_count

    end
  end