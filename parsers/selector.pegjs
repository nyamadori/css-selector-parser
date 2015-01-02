selector
  = s:selectorList
    { return { type: 'selector', selector: s } }

selectorList
  = l:complexSelector r:( _* ',' _* r:complexSelector { return r; } )*
    {
      var list = [l];
      Array.prototype.push.apply(list, r);

      return {
        type: 'selectorList', selectorList: list
      };
    }

complexSelector
  = l:compoundSelector r:( l:combinator r:compoundSelector { r.combinator = l.join(''); return r })*
    {
      var list = [l];
      Array.prototype.push.apply(list, r);

      return {
        type: 'complexSelector', complexSelector: list
      };
    }

compoundSelector
  = l:( typeSelector / universalSelector )?
    r:( attributeSelector / classSelector / idSelector / pseudoSelector )*
    {
      var list = [l];
      Array.prototype.push.apply(list, r);

      return {
        type: 'compoundSelector', compoundSelector: list
      };
    }

combinator
  = _* ( '>' / '+' / '~' / '>>' ) _* 
  / ' '+

typeSelector
  = id:ident
    { return { type: 'typeSelector', typeSelector: id } }

universalSelector
  = '*'
    { return { type: 'universalSelector', universalSelector: '*' } }

attributeSelector
  = '['
    ns:namespacePrefix? 
    id:ident 
    op:( prefixMatch / suffixMatch / substringMatch / '=' / includesMatch / dashMatch )
    value:( ident / string )
    ']'
    {
      return {
        type: 'attributeSelector',
        attributeSelector: {
          namespace: ns,
          attribute: id,
          operator: op,
          value: value
        }
      };
    }

namespacePrefix
  = ns:( ident / '*' )? '|'
    { return ns; }

classSelector
  = cls:('.' ident)
    { return { type: 'classSelector', classSelector: cls.join('') } }

idSelector
  = id:('#' ident)
    { return { type: 'idSelector', idSelector: id.join('') } }

pseudoSelector
  = pseudo:(':' ':'? ident) args:( '(' args:pseudoArgs ')' { return args; } )?
    {
      return {
        type: 'pseudoSelector',
        pseudoSelector: {
          pseudo: pseudo.join(''),
          arguments: args
        }
      };
    }

pseudoArgs
  = l:pseudoArg r:( _* ',' _* r:pseudoArg { return r } )*
    {
      var list = [l];
      Array.prototype.push(list, r);
      return list;
    }

pseudoArg
  = ( '+' / '-' / dimension / num / string / ident)+

dimension
  = dim:(num ident)
    { return { type: 'dimension', dimension: dim.join('') } }

prefixMatch
  = '^='

suffixMatch
  = '$='

substringMatch
  = '*='

includesMatch
  = '~='

dashMatch
  = '|='

ident
  = id:('-'? nmstart (r:nmchar* { return r.join('') }))
    { return id.join(''); }

string
  = '"' str:([^\n\r\f"] / '\\' nl / nonascii / escape)* '"'
    { return str.join('') }

  / "'" str:([^\n\r\f'] / '\\' nl / nonascii / escape)* "'"
    { return str.join('') }

nmstart
  = [_a-z]i / nonascii / escape

nmchar
  = [_a-z0-9-]i / nonascii / escape

escape
  = unicode / '\\' [^\n\r\f0-9a-f]i

unicode
  = '\\' [0-9a-f]i+ ( '\r\n' / [ \n\r\t\f] )?

nonascii
  = [\x80-\xff]

num
  = [0-9]+ / [0-9]* '.' [0-9]+

nl
  = '\n' / '\r\n' / '\r' / '\f'

_
  = [ \t\n\r]+
    { return ''; }