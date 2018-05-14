# Rails App Steps:

- `rails new <app-name> --database=postgresql`
- `cd <app-name>`
- `rails db:create`
- `rails generate model <ModelName> <field:type> <field:type>`
- `rails db:migrate`
- To test your new model, go to `rails console` in the terminal and run some test commands with your new model.
- Declare a route `get '/<resource-name>' => 'controllername#actionname'`
- Start the rails server `rails server` (or `rails s` for short)
- Generate the controller: `rails g controller <controllername> <actionname> <actionname>`
- Profit.

