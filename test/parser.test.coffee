expect = require('chai').expect
parse = require('../parsers/selector').parse

describe 'selector parse', ->
  it 'button', ->
    result = parse('button')
    expect(result).to.deep.equal
      type: 'selector'
      selector:
        type: 'selectorList'
        selectorList: [
          {
            type: 'complexSelector'
            complexSelector: [
              {
                type: 'compoundSelector'
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'button' }
                ]
              }
            ]
          }
        ]


  it 'a.btn', ->
    result = parse('a.btn')
    expect(result).to.deep.equal
      type: 'selector'
      selector:
        type: 'selectorList'
        selectorList: [
          {
            type: 'complexSelector'
            complexSelector: [
              type: 'compoundSelector'
              compoundSelector: [
                { type: 'typeSelector', typeSelector: 'a' }
                { type: 'classSelector', classSelector: '.btn' }
              ]
            ]
          }
        ]


  it 'a#js-popup', ->
    result = parse('a#js-popup')
    expect(result).to.deep.equal
      type: 'selector'
      selector:
        type: 'selectorList'
        selectorList: [
          {
            type: 'complexSelector'
            complexSelector: [
              {
                type: 'compoundSelector'
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'a' }
                  { type: 'idSelector', idSelector: '#js-popup' }
                ]
              }
            ]
          }
        ]


  it 'input[type="text"]', ->
    result = parse('input[type="text"]')
    expect(result).to.deep.equal
      type: 'selector'
      selector:
        type: 'selectorList'
        selectorList: [
          {
            type: 'complexSelector'
            complexSelector: [
              {
                type: 'compoundSelector'
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'input' }
                  {
                    type: 'attributeSelector'
                    attributeSelector:
                      namespace: null
                      attribute: 'type'
                      operator: '='
                      value: 'text'
                  }
                ]
              }
            ]
          }
        ]


  it 'a:hover', ->
    result = parse('a:hover')
    expect(result).to.deep.equal
      type: 'selector'
      selector:
        type: 'selectorList'
        selectorList: [
          {
            type: 'complexSelector'
            complexSelector: [
              {
                type: 'compoundSelector'
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'a' }
                  {
                    type: 'pseudoSelector'
                    pseudoSelector:
                      pseudo: ':hover'
                      arguments: null
                  }
                ]
              }
            ]
          }
        ]


  it 'article :any(.section, .article)', ->
    result = parse('article :any(.section, .article)')
    expect(result).to.deep.equal
      type: 'selector'
      selector:
        type: 'selectorList'
        selectorList: [
          {
            type: 'complexSelector'
            complexSelector: [
              {
                type: 'compoundSelector'
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'article' }
                  {
                    type: 'pseudoSelector'
                    pseudoSelector:
                      pseudo: ':any'
                  }
                ]
              }
            ]
          }
        ]

  it 'a#js-popup span', ->
    result = parse('a#js-popup span')
    expect(result).to.deep.equal
      type: 'selector'
      selector:
        type: 'selectorList'
        selectorList: [
          {
            type: 'complexSelector'
            complexSelector: [
              {
                type: 'compoundSelector'
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'a' }
                  { type: 'idSelector', idSelector: '#js-popup' }
                ]
              }
              {
                type: 'compoundSelector'
                combinator: ' '
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'span' }
                ]
              }
            ]
          }
        ]

  it 'a#js-popup > span', ->
    result = parse('a#js-popup > span')
    expect(result).to.deep.equal
      type: 'selector'
      selector:
        type: 'selectorList'
        selectorList: [
          {
            type: 'complexSelector'
            complexSelector: [
              {
                type: 'compoundSelector'
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'a' }
                  { type: 'idSelector', idSelector: '#js-popup' }
                ]
              }
              {
                type: 'compoundSelector'
                combinator: '>'
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'span' }
                ]
              }
            ]
          }
        ]

  it 'html, body', ->
    result = parse('html, body')
    expect(result).to.deep.equal
      type: 'selector'
      selector:
        type: 'selectorList'
        selectorList: [
          {
            type: 'complexSelector'
            complexSelector: [
              {
                type: 'compoundSelector'
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'html' }
                ]
              }
            ]
          }
          {
            type: 'complexSelector'
            complexSelector: [
              {
                type: 'compoundSelector'
                compoundSelector: [
                  { type: 'typeSelector', typeSelector: 'body' }
                ]
              }
            ]
          }
        ]

