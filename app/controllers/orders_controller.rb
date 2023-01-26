class OrdersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
    # set an order where showing it is needed
    before_action :set_order, only: %i[show edit update destroy]
    layout 'order_layout'

    # GET /orders/ or /orders.json
    def index
        @orders = Order.all
    end

    # GET /orders/1 or /orders/1.json, initialized from before_action
    def show
    end

    # GET /orders/new
    def new
        @order = Order.new
        if @order.save
            flash.notice = "The order record was created successfully."
            redirect_to @order
        else
            flash.now.alert = @order.errors.full_messages.to_sentence
            render :new  
        end
    end
    # GET /orders/1 or /orders/1.json
    def edit
    end

    # POST /orders/1 or /orders/1.json
    def  create
        @order = Order.new(order_params)
        respond_to do |format|
            if @order.save
                format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
                format.json { render :show, status: :created, location: @order }
            else
                format.html { render :new }
                format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # PATCH/PUT /orders/1 or /orders/1.json
    def update
        if @order.update(order_params)
            flash.notice = "The order was updated successfully."
            redirect_to @order
          else
            flash.now.alert = @order.errors.full_messages.to_sentence
            render :edit
        end
    end

    # DELETE /orders/1 or /orders/1.json, set from before_action
    def destroy
        @order.destroy
        respond_to do |format|
          format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
          format.json { head :no_content }
        end
    end
    private
    def set_order
        @order = Order.find(params[:id])
    end

    def order_params
        params.require(:order).permit(:product_naem, :product_count, :order_id)
    end

    def catch_not_found(e)
        Rails.logger.debug("We had a not found exception.")
        flash.alert = e.to_s
        redirect_to orders_path
    end
end

 