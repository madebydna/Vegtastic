## RMU project: Calculating Nutritional Profiles For a Recipe (Based on Ingredients)

The goal is to build a vegetarian recipe exchange site similar to allrecipes.com. For this portion of the project I'm trying to implement a feature that would calculate a nutritional profile for a user-submitted recipe, based on its ingredients.

See working example at [calorie count](http://caloriecount.about.com/cc/recipe_analysis.php)

### Data Source

As the source of nutritional data I am using a freely available DB from the UDSA (US Dept. of Agriculture). The original data source was in MS Access. 

*What I did so far*:

- understand the tables and their relationships in the original data source
- identify the portion of the data that is relevant for this project (e.g. not all tables and fields were imported and I left out all non-vegetarian foods)
- export the data a CSV files
- create rails compliant models to reflect the data
- import the data from CSV into the prepared rails tables

### Lookup Tables for Nutritional Data

There are four tables that are used to look up nutritional information for an ingredient:

1. Foods: contains basically different names for a food item
2. Nutrients: has a foreign key (food_id) and contains the value for different nutrients (e.g. calories, protein, carbohydrates) in 100g of the food item
3. Nutrient Definitions: has a foreign key (nutrient_id) and contains the name of the nutrient and the common unit (g, mg, kcal, etc.)
4. Weights: has a foreign key (food_id) and maps different commonly used household measures of the food item (e.g. one cup of butter, one tbsp of butter) to its weight in g 

## Recipe and Ingredients

A recipe has a simple one-to-many relationship to ingredients. In order to calculate a nutritional profile, all the ingredients with their respective values will have to be taken into account.




