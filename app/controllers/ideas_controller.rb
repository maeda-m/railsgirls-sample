class IdeasController < ApplicationController
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ideas }
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea = Idea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.json
  def new
    @idea = Idea.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    @idea = Idea.find(params[:id])
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(params[:idea])

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.html { render action: "new" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.json
  def update
    @idea = Idea.find(params[:id])

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :no_content }
    end
  end

  # 
  def liked
    @idea = Idea.find(params[:id])
    @idea.likes.create(comment: params[:comment])
    render action: :show
  end

  def top5
    @ideas = Idea.top5
  end

  def print_top5
    @ideas = Idea.top5

    report = ThinReports::Report.new(layout: File.join(Rails.root, 'app', 'reports', 'top5.tlf'))
    @ideas.each do |idea|
      report.list.add_row do |row|
        row.item(:rank).value(idea.rank)
        row.item(:name).value(idea.name)
        row.item(:description).value(idea.description)
        row.item(:picture).src(idea.picture)
        row.item(:likes).value(idea.likes.count)

        # row.values rank: idea.rank,
        #   name: idea.name, description: idea.description,
        #   picture: idea.picture, likes: idea.likes.count
      end
    end

    send_data report.generate, filename: 'top5.pdf', 
                               type: 'application/pdf', 
                               disposition: 'attachment'
                               # disposition: 'inline'
  end

end
