# Classroom
[![Code Climate](https://codeclimate.com/github/jah2488/classroom/badges/gpa.svg)](https://codeclimate.com/github/jah2488/classroom)
[![Build Status](https://travis-ci.org/jah2488/classroom.svg?branch=master)](https://travis-ci.org/jah2488/classroom)
[![Test Coverage](https://codeclimate.com/github/jah2488/classroom/badges/coverage.svg)](https://codeclimate.com/github/jah2488/classroom/coverage)
[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Deployment

The app is deployed on [Heroku](https://tiy-classroom.herokuapp.com/) as `tiy-classroom`

## Development

To setup your machine for development run `script/setup`.
`script/server` starts a dev server.
Follows the [Github Scripts](https://github.com/github/scripts-to-rule-them-all) pattern.

To login as the seed instructor, visit `/instructors/sign_in` and use `instructor@example.com` with `password`

#### Philosophy
Any instructor who comes to use this app is going to have questions about the functionality and any instructor who tries to develop in this app is going to have even more questions. I think it is worth going over some of the driving philosophical ideas behind this app during its development process. This will probably not answer any of those questions, but maybe some of the decisions will make more sense. Most of these points are not taken to be truths or best practice, but this app was ultimately a way for me to explore new way of developing a rails application from my new context as an instructor an educator.

- No instance variables, ever.
  - Instance variables are a horrible leaky abstraction, lead to bugs, bad code, and horrible error messages for beginners
- Only write what is needed and being used now, not what may be used in the future.
- Leverage the css frameworks being imployed whenever possible and use scss to tweak.
- Use small React components for any javascript/ajax functionality. 
- Prefer static data of complicated computed properties. _(Might be off to a bad start with this one)_
- Be able to use the source code for demonstration purposes at several points through the cohort.
- Minimize and avoid using much rails magic / meta programming as possible.
- Prefer being explicit over being implicit.
  - Call a helper method instead of using a `before_filter`
  - Build up your test data instead of using `FactoryGirl`
  - Write class methods instead of fancy rails scopes
  - Require files when and where they are needed
  - Always pass dependencies
- Don't refactor duplication until the abstraction is as clear as the pain of the duplication.
  - I've been a strong proponent of this for years and now
    - [I've](http://devblog.avdi.org/2012/06/25/every-day-in-every-way/) 
    - [got](http://c2.com/cgi/wiki?PrematureOptimization)
    - [backup](http://www.sandimetz.com/blog/2014/05/28/betting-on-wrong)
- Prefer a functional style of an imperative one
  - Functional object-oriented is a style that can be applied very well in most ruby/rails projects.
  - Avoid state and mutation whenever outside of the context of a database transaction.
  - Prefer modules and pure functions over class and methods.
  - Prefer composition over inhereitance. 
- Prefer hand rolled implementations over easy fix gems in most cases.
  - This one I believe will be the most devisive. Why use devise for authenticate but not pundit for authorization? Why handrolled activities and public-activity gem? The why may be hard to define sometimes, and up until now I've been the sole judge of what is or isn't too much, so I expect there to be debates on this in the future, but I hope we can find the line in most situations.
  - If something would take days to get right and seriously grow the code base or is mission critical, it is probably the realm of a gem.
  - If something is a design pattern, or if the gem is full of 10000 features and we want 1, its best to do it ourselves.
