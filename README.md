# seshat-web
Implementing [seshat](https://github.com/falvaro/seshat) with a web api to parse handwritten mathematical equations.

[![Build Status](https://travis-ci.org/jusleg/seshat-web.svg?branch=master)](https://travis-ci.org/jusleg/seshat-web) [![codebeat badge](https://codebeat.co/badges/89221ca6-ae12-4acf-a4c5-a967f2f8a77e)](https://codebeat.co/projects/github-com-jusleg-seshat-web-master) [![Maintainability](https://api.codeclimate.com/v1/badges/8a958baf7fd286770d40/maintainability)](https://codeclimate.com/github/jusleg/seshat-web/maintainability)

the web server is in [`/web`](https://github.com/jusleg/seshat-web/tree/master/web) and the seshat program is in [`/seshat`](https://github.com/jusleg/seshat-web/tree/master/seshat)

## Introduction
From [falvaro/seshat](https://github.com/falvaro/seshat):

> _Seshat_  is an open-source system for recognizing handwritten mathematical expressions. Given a sample represented as a sequence of
> strokes, the parser is able to convert it to LaTeX or other formats
> like InkML or MathML. You can see an example of application of this
> parser in
>
> [http://cat.prhlt.upv.es/mer/](http://cat.prhlt.upv.es/mer/)
>
> where  _seshat_  is the underlying engine.
>
> This parser has been developed by Francisco Álvaro as part of his PhD
> thesis while he was a member of the \[PRHLT research center\]
> [1](http://www.prhlt.upv.es/)  at \[Universitat Politècnica de
> València\]  [2](http://www.upv.es/).
>
> _Seshat_  represents a state-of-the-art system that has participated in several \[international competitions\]
> [3](http://www.isical.ac.in/~crohme/), and it was awarded the best
> system trained on the competition dataset in:
>
> -   Mouchère H., Viard-Gaudin C., Zanibbi R., Garain U.  _ICFHR 2014 Competition on Recognition of On-line Handwritten Mathematical
> Expressions (CROHME 2014)_. International Conference on Frontiers in
> Handwriting Recognition (ICFHR), Crete Island, Greece (2014)
>
> The math expression recognition model that  _seshat_  implements is
> described in:
>
> -   Francisco Álvaro, Joan-Andreu Sánchez and José-Miguel Benedí.  _An Integrated Grammar-based Approach for Mathematical Expression
> Recognition_. Pattern Recognition, pp. 135-147, 2016
>
> and it is the main part of my PhD thesis.
>
> -   Francisco Álvaro (advisors: Joan-Andreu Sánchez and José-Miguel Benedí).  [Mathematical Expression Recognition based on Probabilistic
> Grammars](http://hdl.handle.net/10251/51665). Doctor of Philosophy in
> Computer Science, Universitat Politècnica de València, 2015.

## Setup
1. Clone the repo
```
$ git clone https://github.com/jusleg/seshat-web.git
```

3. Install [boost](http://www.boost.org/)
```
sudo apt-get install libboost-all-dev
```

4. install [xerces](http://xerces.apache.org/xerces-c/)
```
apt-cache search libxerces
# run this command and install both that matches the following pattern
sudo apt-get install libxercesXXX libxercesXXX-dev
# eg. sudo apt-get install libxerces-c3.1 libxerces-c-dev
```

4. Make the project + bundle
```
cd seshat; make; cd ../web; bundle install
```

## Run the Server
```
rackup
```

this will start a sinatra server. You need yo do a POST request to the `/equation` endpoint. The request should have a parameter named `strokes` and the value should be the content of the .scgink file as a string.

## Sample Request/Responses
```
# Valid request
{"strokes": "SCG_INK\n2\n2\n270 1372\n466 1549\n2\n437 1393\n261 1546\n"}

# Valid response
{ "data": { "equation": "x"} }

# Invalid request
{"strokes": "jhgf"}

# Response
{ "error" { "code": 400, "message": "Error: input file format is not SCG_INK" } }
```
