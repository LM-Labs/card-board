# Libraries
React   = require 'react'
Parse   = require('parse').Parse
Router  = require 'react-router'

Route         = Router.Route
RouteHandler  = Router.RouteHandler
DefaultRoute  = Router.DefaultRoute

# Pages
MakeCard          = require './makeCard.coffee'
SpecificCardView  = require './specificCard.coffee'
CardsView         = require './cardsView.coffee'
Login             = require './login.coffee'
Confirm           = require './confirm.coffee'

# Loader
CardsLoader = require './cards.loader.coffee'

Parse.initialize "9FkdyLJQwebUZOEZxQtxMgXSPIEoz2nDGjlexCtM", "vbqwWBuaejePM5qWO0n1OsMJLUPEnLA7yKM7yay1"

# DOM Elements
{p, a, div, input, img} = React.DOM

IndexClass = React.createClass


  mixins: [ Router.Navigation, Router.State ]


  getInitialState: ->
    CardsLoader.getAllCards (cards) =>
      @setState cards: cards

    searchValue: ''


  makeACardToggle: ->
    @transitionTo 'makeACard'


  searchHandle: (event) ->
    @setState searchValue: event.target.value


  searchPressHandle: (event) ->
    if event.key is 'Enter'
      CardsLoader.getSearchedCards @state.searchValue, (cards) =>
        @setState cards: [], =>
          @setState cards: cards


  returnHome: ->
    window.location.assign 'http://www.phxtech.us'


  login: ->
    @transitionTo 'login'

  logout: ->
    Parse.User.logOut()
    window.location.reload()

  render: ->

    div null,

      div
        style:
          display:  'table'
          width:    '100%'

        div 
          className:      'makeACard'
          style:
            padding:      '1em'
            width:        '100%'
            height:       '4em'
            marginBottom: '1em'
            marginRight:  '1em'
            display:      'inline-block'

          # a
          #   href: 'http://www.phxtech.us'
          #   img
          #     src:            './LM3.png'
          #     style:
          #       height:       '4em'
          #       float:        'left'
          #       marginRight:  '1em'
          #     #   boxShadow:    '2px 2px 1px #59595b'

          a 
            className:  'header button'
            onClick:    @returnHome
            style:
              cursor:   'pointer'
              display:  'inline-block'
            'Phoenix Tech Card Board'


          p
            className:    'header hilight'
            style:
              display:    'inline-block'
              marginLeft: '1em'
            '|'


          a 
            className:     'header button'
            onClick:       @makeACardToggle
            style:
              cursor:      'pointer'
              marginLeft:  '1em'
            'Make a New Card'


          p
            className:    'header hilight'
            style:
              display:    'inline-block'
              marginLeft: '1em'
            '|'

          input
            className:    'bigInput'
            placeholder:  'search tags'
            onChange:     @searchHandle
            onKeyPress:   @searchPressHandle
            value:        @state.searchValue


          p
            className:    'header hilight'
            style:
              display:    'inline-block'
              marginLeft: '1em'
            '|'

          if Parse.User.current()?
            a
              className:    'header button'
              style:
                cursor:      'pointer'
                marginLeft:  '1em'
              onClick:      @logout
              'log out'
              
          else
            a
              className:    'header button'
              style:
                cursor:      'pointer'
                marginLeft:  '1em'
              onClick:      @login
              'log in'


        div
          style:
            marginLeft: '1em'

          RouteHandler
            cards: @state.cards

        div className: 'spacer'



routes =
  Route
    name:    'Main'
    path:    '/'
    handler: IndexClass

    DefaultRoute
      handler: CardsView

    Route
      name:    'post'
      path:    'post/:postId'
      handler: SpecificCardView

    Route
      name:    'makeACard'
      path:    'make'
      handler: MakeCard

    Route
      name:     'login'
      path:     'login'
      handler:  Login

    Route
      name:     'confirm'
      path:     'confirm'
      handler:  Confirm


Router.run routes, (handler) ->
  React.render handler(), (document.getElementById 'content')


