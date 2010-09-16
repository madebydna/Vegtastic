## RMU project: Calculating Nutritional Profiles For a Recipe (Based on Ingredients)

The goal is to build a vegetarian recipe exchange site similar to allrecipes.com. For this portion of the project I'm trying to implement a feature that would calculate a nutritional profile for a user-submitted recipe, based on its ingredients.

See working example at [calorie count](http://caloriecount.about.com/cc/recipe_analysis.php)

### Data Source

As the source of nutritional data I am using a freely available DB from the UDSA (US Dept. of Agriculture). The original data source was in MS Access. 

This needed to be done for the data import:

- understand the tables and their relationships in the original data source
- identify the portion of the data that is relevant for this project (e.g. not all tables and fields were imported and I left out all non-vegetarian foods)
- export the data a CSV files
- create rails compliant models to reflect the data
- import the data from CSV into the prepared rails tables

### Lookup Tables for Nutritional Data

There are four tables that are used to look up nutritional information for an ingredient:

1. Foods: contains basically different names for a food item
2. Nutrients: has two foreign keys - (food_id) and (nutrient_definition_id) - and contains the value for different nutrients (e.g. calories, protein, carbohydrates) in 100g of the food item
3. Nutrient Definitions: contains the name of the nutrient (e.g. Kcal, Protein) and the common unit (g, mg, kcal, etc.)
4. Weights: has a foreign key (food_id) and maps different commonly used household measures of the food item (e.g. one cup of butter, one tbsp of butter) to its weight in g 

### Recipe and Ingredients

A recipe has a simple one-to-many relationship to ingredients. In order to calculate a nutritional profile, all the ingredients with their respective values will have to be taken into account.

#### Cache Tables: ingredient_profiles and recipe_profiles

Ingredients should get flagged after creation/update depending on whether they have been found in the lookup tables:

**Red flag**: ingredient not found in foods table

**Yellow flag**: ingredient found, but not with the measurement indicated (e.g. 1 "clove" of flour)

**Green flag**: ingredient found and nutritionally analyzed

If ingredient gets green flag, entries will be made into the ingredient_profiles table with the amount of nutrient (e.g. Kcal, Protein, Carbs) 
for the particular ingredient. After all ingredients have been processed this way, an entry will be made
into the recipe_profiles table with aggregated values for each nutrient over all ingredients. This would conclude the nutritional analysis of the recipe.

### Issues and Problems

- "Lookup" tables should be used in testing, too. Have to figure out how to set up testing environment to make that possible
- Callbacks on the recipe model trigger the entries into the cache tables. Since I'll be using nested forms, the ingredients 
  will not be saved or updated independently of the recipe. However, not to trigger those events when a ingredient does get saved independently
  seems like a design flaw and needs to be addressed. 
- Implement parsing/searching logic to map ingredient name (user input) to matches in the foods table. The same goes for mapping ingredient 
  units (tsp, cup) to entries into the weights table. The problem is that there will hardly ever be a perfect match, so several steps need 
  to find an adequate match.





