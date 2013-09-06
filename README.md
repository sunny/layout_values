# LayoutValues

Module to add helpers to indicate page titles and meta description.

Usage
-----

In your layout:

  <title><%= title %></title>
  <meta name="description" content="<%= meta_description %>" />

In your views:

  <% title "Best Page Ever" %>
  <% meta_description "The best page ever on the internets" %>

Or even:

  <h1><%= title "Best Page Ever" %></h1>

You can use translation files to customize the title:

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

You can also set titles in your translation files directly
by controller and action:

  fr:
    users:
      show:
        title: "Mon compte"
        meta_description: "Éditer mon compte"

Install
-------

Add this line to your Gemfile:

    gem "layout_values"

Then in `app/helpers/application_helper.rb`, add:

  module ApplicationHelper
    include LayoutValuesHelper
  end
