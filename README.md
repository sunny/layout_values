# LayoutValues

Rails plugin to add helpers to indicate page titles and meta description.

Requirements
------------

Rails 4, Ruby 2.

Usage
-----

In your layout:

```erb
<title><%= title %></title>
<meta name="description" content="<%= meta_description %>" />
```

In your views:

```erb
<% title "Best Page Ever" %>
<% meta_description "The best page ever on the internets" %>
```

Or even:

```erb
<h1><%= title "Best Page Ever" %></h1>
```

You can use translation files to customize the title:

```yml
en:
  layout:
    title:
      format: "%{title} — My Site"
      default: "My Site"
    meta_description:
      format: "%{meta_description}, via My Site"
      default: "My description"
    meta_keywords:
      format: "%{meta_keywords}"
      default: "mysite"
```

You can also set titles in your translation files directly
by controller and action:

```yml
fr:
  users:
    show:
      title: "Mon compte"
      meta_description: "Éditer mon compte"
```

Install
-------

Add this line to your Gemfile:

```rb
gem "layout_values"
```

Then in `app/helpers/application_helper.rb`, add:

```rb
module ApplicationHelper
  include LayoutValuesHelper
end
```
