class UserStocksController < ApplicationController
    def create
        stock = Stock.check_db(params[:ticker])
        if stock.blank?
          stock = Stock.new_lookup(params[:ticker])
          stock.save
        end
        if current_user.stocks.count>=10
            flash[:alert] = "Sorry! You are already tracking 10 Stocks."
            redirect_to my_portfolio_path
        else        
            @user_stock = UserStock.create(user: current_user, stock: stock)
            flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
            redirect_to my_portfolio_path
        end    
    end
    
end
