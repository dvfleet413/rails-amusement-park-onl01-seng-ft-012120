class AttractionsController < ApplicationController
    def index
        @attractions = Attraction.all
    end

    def show 
        set_attraction
    end

    def new
        @attraction = Attraction.new
    end

    def create
        @attraction = Attraction.create(attraction_params)
        redirect_to attraction_path(@attraction)
    end

    def edit 
        set_attraction
    end

    def update 
        set_attraction 
        @attraction.update(attraction_params)
        redirect_to attraction_path(@attraction)
    end


    def ride 
        set_attraction
        if current_user.height < @attraction.min_height && current_user.tickets < @attraction.tickets
            flash[:notice] = "You are not tall enough to ride the #{@attraction.name}. You do not have enough tickets to ride the #{@attraction.name}"
        elsif current_user.height < @attraction.min_height
            flash[:notice] = "You are not tall enough to ride the #{@attraction.name}"
        elsif current_user.tickets < @attraction.tickets
            flash[:notice] = "You do not have enough tickets to ride the #{@attraction.name}"
        else
            current_user.attractions << @attraction
            tickets = current_user.tickets - @attraction.tickets
            happiness = current_user.happiness + @attraction.happiness_rating
            nausea = current_user.nausea + @attraction.nausea_rating
            current_user.update({tickets: tickets, happiness: happiness, nausea: nausea})
            flash[:notice] = "Thanks for riding the #{@attraction.name}!"            
        end
        redirect_to user_path(current_user)
    end

    private
        def set_attraction
            @attraction = Attraction.find(params[:id])
        end

        def attraction_params 
            params.require(:attraction).permit(:name, :tickets, :happiness_rating, :nausea_rating, :min_height)
        end
end