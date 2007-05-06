#bst2.awk
#DJ's Binary Search Tree Functions


#Insert a new root node
function insertR(RootInstance, Tree, Value, Attr, Rec)
{
  if (RootInstance ~/\v/) #defaultvalue)
  {
    return newtree(Attr SUBSEP Rec,Tree, Value)
  }
  Tree[RootInstance,all]++
  if (Value == Tree[RootInstance,val])
  {
    Tree[RootInstance,here]++
    return RootInstance
  }
  if (Value < Tree[RootInstance,val])
  {
    Tree[RootInstance,left] = insertR(Tree[RootInstance,left], Tree, Value)
    RootInstance = rotateR(RootInstance,Tree)
   
  }
  else
  {
    Tree[RootInstance,right] = insertR(Tree[RootInstance,right], Tree, Value)
    RootInstance = rotateL(RootInstance,Tree)
  }
  return RootInstance
}

#Insert a new node (could be at root, but otherwise wherever it fits)
function insertNR(RootInstance, Tree, Value, Attr, Rec)
{
  if (RootInstance ~ /\v/ )#defaultvalue
  {
    return newtree()
  }
  Tree[RootInstance,all]++
  if (Value == Tree[RootInstance,val])
  {
    Tree[RootInstance,here]++
    return RootInstance
  }
  else 
  {
    if (Value < Tree[RootInstance,val])
    {
      Tree[RootInstance,left] = insertNR(Tree[RootInstance,left], Tree, Value)
    }
    else
    {
      Tree[RootInstance,right] = insertNR(Tree[RootInstance,right], Tree, Value)
    }
    return RootInstance
  }
}

function rotateR(RootInstance, Tree,    temp)
{
  temp = Tree[RootInstance,left]
  Tree[RootInstance,left] = Tree[temp,right]
  Tree[temp,right] = RootInstance
  Tree[temp,all] = Tree[RootInstance,all]
  if((Tree[RootInstance,left] !~ /\v/) && (Tree[RootInstance,right] !~ /\v/))
  {
    Tree[RootInstance,all]=Tree[Tree[RootInstance,left],all]+Tree[Tree[RootInstance,right],all]+Tree[RootInstance,here]
  }
  else
  {
    if((Tree[RootInstance,left] !~ /\v/))
    {
      Tree[RootInstance,all] = Tree[RootInstance,here]+Tree[Tree[RootInstance,left],all]
    }
    else
    {
      if((Tree[RootInstance,right] !~ /\v/))
      {
        Tree[RootInstance,all] = Tree[RootInstance,here]+Tree[Tree[RootInstance,right],all]
      }
      else
      {
	Tree[RootInstance,all] = Tree[RootInstance,here]
      }

    }
  }
  return temp
}

function RotateL(RootInstance, Tree,     temp)
{
  temp = Tree[RootInstance,right]
  Tree[RootInstance,right] = Tree[temp,left]
  Tree[temp,left] = RootInstance
  Tree[temp,all] = Tree[RootInstance,all]
  if((Tree[RootInstance,left] !~ /\v/) && (Tree[RootInstance,right] !~ /\v/))
  {
    Tree[RootInstance,all]=Tree[Tree[RootInstance,left],all]+Tree[Tree[RootInstance,right],all]+Tree[RootInstance,here]
  }
  else
  {
    if((Tree[RootInstance,left] !~ /\v/))
    {
      Tree[RootInstance,all] = Tree[RootInstance,here]+Tree[Tree[RootInstance,left],all]
    }
    else
    {
      if((Tree[RootInstance,right] !~ /\v/))
      {
        Tree[RootInstance,all] = Tree[RootInstance,here]+Tree[Tree[RootInstance,right],all]
      }
      else
      {
	Tree[RootInstance,all] = Tree[RootInstance,here]
      }

    }
  }
  return temp
}

function newtree(RootInstance, Tree, Value)
{
  Tree[RootInstance,value]=Value
  Tree[RootInstance,all]=1
  Tree[RootInstance,here]=1
  Tree[RootInstance,left]="\v"
  Tree[RootInstance,right]="\v"
  return RootInstance
}

function printtree(RootInstance, Tree, b4, indent)
{
  #Current code obtained and slightly modified from Timm's code's src website
  print indent b4 RootInstance " = " Tree[RootInstance, val] " [" Tree[RootInstance,here] "]"
    if(Tree[RootInstance,left] !~ /\v/)
      printtree(Tree[RootInstance,left], Tree, " < ", indent "|    ")
    if(Tree[RootInstance,right] !~ /\v/)
      printtree(Tree[RootInstance,right], Tree, " > ", indent "|    ")
}

function rbstinsert(RootInstance, Tree, Value, Attr, Rec)
{
  if (RootInstance ~ /\v/)#defaultvalue
  {
    return newtree(Attr SUBSEP Rec, Tree,Value)
  }
  if (Value == Tree[RootInstance,val])
  {
    Tree[RootInstance,here]++
    Tree[RootInstance,all]++
    return RootInstance
  }
  else 
  {
    
    if ((rand()*Tree[RootInstance,all]) < 1.0)
    {
      return insertR(RootInstance,Tree,Value)
    }
    if (Value < Tree[RootInstance,val])
    {
      Tree[RootInstance,left] = rbstinsert(Tree[RootInstance,left], Tree, Value)
    }
    else
    {
      Tree[RootInstance,right] = rbstinsert(Tree[RootInstance,right], Tree, Value)
    }
    Tree[RootInstance,all]++
    return RootInstance
  }
}
