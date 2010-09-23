#require 'simple_importer/tasks'
require 'csv'

task :import_usda_data => :environment do 
  Rake::Task["import:foods"].invoke 
  Rake::Task["import:nutrient_definitions"].invoke
  Rake::Task["import:nutrients"].invoke
  Rake::Task["import:weights"].invoke              
end

namespace :import do 
  
  desc "Importing Foods"
  task :foods => :environment do
    CSV.foreach("lib/import_data/FOOD_DES_VEG.csv", :col_sep => "|", :headers => true) do |row|
      Food.create(:old_pk => row['NDB_No'], :long_desc => row['Long_Desc'], 
      :short_desc => row['Shrt_Desc'], :common_name => row['ComName'], :manufacturer_name => row['ManufacName'])
    end
  end
  
  desc "Importing Nutrient Definitions"
  task :nutrient_definitions => :environment do
    CSV.foreach("lib/import_data/NUTR_DEF.csv", :col_sep => "|", :headers => true) do |row|
      NutrientDefinition.create(:old_pk => row['Nutr_No'], :units => row['Units'], :tag => row['Tagname'], :description => row['NutrDesc'])
    end
  end
  
  desc "Importing Nutrients"
  task :nutrients => :environment do
    CSV.foreach("lib/import_data/NUT_DATA_MIN.csv", :col_sep => "|", :headers => true) do |row|
      food = Food.find_by_old_pk(row['NDB_No'])
      if food
        nd = NutrientDefinition.find_by_old_pk(row['Nutr_No'])
        Nutrient.create(:food_id => food.id, :nutrient_definition_id => nd.id, :old_pk => row['Nutr_No'], :value => row['Nutr_Val'])
      end
    end
  end
   
  desc "Importing Weights"
  task :weights => :environment do
    CSV.foreach("lib/import_data/WEIGHT.csv", :col_sep => "|", :headers => true) do |row|
      food = Food.find_by_old_pk(row['NDB_No'])
      if food
        Weight.create(:food_id => food.id, :amount => row['Amount'], :measure_desc => row['Msre_Desc'], :gm_weight => row['Gm_Wgt'])
      end
    end
  end
  
  # Relationship between tables was backwards in original data source
  desc "Fixing nutrient data"
  task :fixing_nutrient_data => :environment do
    NutrientDefinition.all.each do |nd|
      Nutrient.update_all("nutrient_definition_id = #{nd.id}", "old_pk = '#{nd.old_pk}'")
    end
  end
  
end