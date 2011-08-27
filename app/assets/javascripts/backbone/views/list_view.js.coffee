class BackboneTodos.Views.ListView extends Backbone.View
  tagName: "li",
  className: "list",
  template: JST["backbone/templates/list_view"],
  
  events: {
    "click .add-todo" : "renderTodoForm"
  },
  
  initialize: ->
    _.bindAll(@, 'addOne', 'addAll', 'render');
    @model.bind('change', @render)
    @todos = new BackboneTodos.Collections.TodosCollection(@model.id)
    @todos.bind('add',     @addOne)
    #@todos.bind('refresh', @addAll)
    @todos.bind('all',     @addAll)

    @todos.fetch()
    
  render: ->
    $(@el).html(@template(@model.toJSON()))
    $(@el).attr("id", "list-#{@model.id}")
    @
  
  
  addOne: (todo) ->
    view = new BackboneTodos.Views.TodoView({model: todo}).render().el
    $(view).appendTo(@$(".todos"))
    
  addAll: ->
    @$(".todos").html("")
    @todos.each(@addOne)
  
  renderTodoForm: ->
    view = new BackboneTodos.Views.NewTodo(@todos).render().el
    @$(".todo-form").html(view)