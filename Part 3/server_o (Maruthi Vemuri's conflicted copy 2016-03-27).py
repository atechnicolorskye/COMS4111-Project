#!/usr/bin/env python2.7

"""
Columbia W4111 Intro to databases
Example webserver

To run locally

    python server.py

Go to http://localhost:8111 in your browser


A debugger such as "pdb" may be helpful for debugging.
Read about it online.
"""

from flask import Flask, request, render_template, g, redirect, Response
from flask.views import MethodView
import os
import psycopg2
from sqlalchemy import *
from sqlalchemy.pool import NullPool
from sqlalchemy_utils import database_exists, create_database

tmpl_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')
app = Flask(__name__, template_folder=tmpl_dir)


#
# The following uses the sqlite3 database test.db -- you can use this for debugging purposes
# However for the project you will need to connect to your Part 2 database in order to use the
# data
#
# XXX: The URI should be in the format of:
#
#     postgresql://USER:PASSWORD@w4111db.eastus.cloudapp.azure.com/username
#
# For example, if you had username ewu2493, password foobar, then the following line would be:
#
#     DATABASEURI = "postgresql://ewu2493:foobar@w4111db.eastus.cloudapp.azure.com/ewu2493"
#
DATABASEURI = "postgresql://localhost:5432/Production"


#
# This line creates a database engine that knows how to connect to the URI above
#
engine = create_engine(DATABASEURI, isolation_level="AUTOCOMMIT")
if not database_exists(engine.url):
    create_database(engine.url)
    engine.execute(open("Tables.sql", "r").read())
    engine.execute(open("Insert_Maruthi.sql", "r").read())
    engine.execute(open("Insert_Sky.sql", "r").read())
    print True



@app.before_request
def before_request():
  """
  This function is run at the beginning of every web request
  (every time you enter an address in the web browser).
  We use it to setup a database connection that can be used throughout the request

  The variable g is globally accessible
  """
  try:
    g.conn = engine.connect()
  except:
    print "uh oh, problem connecting to database"
    import traceback; traceback.print_exc()
    g.conn = None

@app.teardown_request
def teardown_request(exception):
  """
  At the end of the web request, this makes sure to close the database connection.
  If you don't the database could run out of memory!
  """
  try:
    g.conn.close()
  except Exception as e:
    pass


#
# @app.route is a decorator around index() that means:
#   run index() whenever the user tries to access the "/" path using a GET request
#
# If you wanted the user to go to e.g., localhost:8111/foobar/ with POST or GET then you could use
#
#       @app.route("/foobar/", methods=["POST", "GET"])
#
# PROTIP: (the trailing / in the path is important)
#
# see for routing: http://flask.pocoo.org/docs/0.10/quickstart/#routing
# see for decorators: http://simeonfranklin.com/blog/2012/jul/1/python-decorators-in-12-steps/
#
@app.route('/')
def index():
    """
    request is a special object that Flask provides to access web request information:

    request.method:   "GET" or "POST"
    request.form:     if the browser submitted a form, this contains the data in the form
    request.args:     dictionary of URL arguments e.g., {a:1, b:2} for http://localhost?a=1&b=2

    See its API: http://flask.pocoo.org/docs/0.10/api/#incoming-request-data
    """

    # DEBUG: this is debugging code to see what request looks like
    print request.args

    #
    # example of a database query
    #
    # cursor = g.conn.execute("SELECT name FROM test")
    # names = []
    # for result in cursor:
    #   names.append(result['name'])  # can also be accessed using result[0]
    # print names
    names = [i for i in engine.table_names() if '_' not in i]
    print names
    # cursor.close()

    #
    # Flask uses Jinja templates, which is an extension to HTML where you can
    # pass data to a template and dynamically generate HTML based on the data
    # (you can think of it as simple PHP)
    # documentation: https://realpython.com/blog/python/primer-on-jinja-templating/
    #
    # You can see an example template in templates/index.html
    #
    # context are the variables that are passed to the template.
    # for example, "data" key in the context variable defined below will be
    # accessible as a variable in index.html:
    #
    #     # will print: [u'grace hopper', u'alan turing', u'ada lovelace']
    #     <div>{{data}}</div>
    #
    #     # creates a <div> tag for each element in data
    #     # will print:
    #     #
    #     #   <div>grace hopper</div>
    #     #   <div>alan turing</div>
    #     #   <div>ada lovelace</div>
    #     #
    #     {% for n in data %}
    #     <div>{{n}}</div>
    #     {% endfor %}
    #
    context = dict(data=names)


    #
    # render_template looks in the templates/ folder for files.
    # for example, the below file reads template/index.html
    #
    return render_template("index.html", **context)

#
# This is an example of a different path.  You can see it at
#
#     localhost:8111/another
#
# notice that the functio name is another() rather than index()
# the functions for each app.route needs to have different names
#

# @app.route('/concert')
# def another():
#     query = "SELECT * FROM concert;"
#     cursor = g.conn.execute(query)
#     output = []
#     for result in cursor:
#         output.append(result)
#     cursor.close()
#     context = dict(n='Concert', table=output)
#     return render_template("table.html", **context)


# Creates class to render all hyperlinks
class List_Search(MethodView):

    # methods = ['GET', 'POST']

    # def dispatch_request(self, name):
    #     return 'Hello %s!' % name

    def get(self, name):
        # print name
        query = "SELECT * FROM " + str(name)
        # print query
        cursor = g.conn.execute(query)
        # print cursor
        output = []
        for result in cursor:
            output.append(result)
        # print output
        cursor.close()
        context = dict(t_name=str(name), table=output)
        return render_template("table.html", **context)

    def post(self, name):
        print name
        search = request.form['search']
        print search
        if name == 'artist' or name == 'album':
            g.conn.execute('Select * FROM Artists A, Albums Al, contributes_to C WHERE A.a_id = C.a_id AND Al.al_id = C.al_id AND A.a_name = ', str(search))
        elif name == 'song':
            g.conn.execute('Select * FROM Artists A, Song S, contributes_to C WHERE A.a_id = C.a_id AND S.s_id = C.s_id AND A.a_name = VALUES(NULL, ?);', str(search))
        elif name == 'genre':
            g.conn.execute('Select * FROM Song S, Genre g, belongs_to B WHERE S.s_id = B.s_id AND B.g_id = S.g_id AND S.s_name = VALUES(NULL, ?);', str(search))
        elif name == 'label':
            g.conn.execute('Select * FROM Artist A, Label L, has_signed H WHERE A.a_id = H.a_id AND L.l_id = H.l_id AND A.a_name = VALUES(NULL, ?);', str(search))
        elif name == 'playlist':
            g.conn.execute('SELECT * FROM playlist p, contains_ c, song s WHERE p.p_id = c.p_id AND c.s_id = s.s_id AND p.p_name = VALUES (NULL, ?);', str(search))
        elif name == 'concert':
            g.conn.execute('SELECT * FROM artist a, performs_at p, concert c WHERE p.a_id = a.a_id AND p.c_id = c.c_id AND c.c_name = VALUES (NULL, ?);', str(search))
        output = []
        for result in cursor:
            output.append(result)
        print output
        cursor.close()
        context = dict(search=str(search), t_name=str(name), table=output)
        return render_template("search.html", **context)

    # def add():
    #     user_input = request.form['input']
    #     g.conn.execute('INSERT INTO '+ name + ' VALUES (NULL, ?)', user_input)
    #     return redirect('/')

ListSearch_View = List_Search.as_view('List_Table')
app.add_url_rule('/<name>', view_func=ListSearch_View)
app.add_url_rule('/search', view_func=ListSearch_View)



# Example of adding new data to the database
@app.route('/add', methods=['POST'])
def add():
  name = request.form['name']
  g.conn.execute('INSERT INTO test VALUES (NULL, ?)', name)
  return redirect('/')


@app.route('/login')
def login():
    abort(401)
    this_is_never_executed()


if __name__ == "__main__":
  import click

  @click.command()
  @click.option('--debug', is_flag=True)
  @click.option('--threaded', is_flag=True)
  @click.argument('HOST', default='0.0.0.0')
  @click.argument('PORT', default=8111, type=int)
  def run(debug, threaded, host, port):
    """
    This function handles command line parameters.
    Run the server using

        python server.py

    Show the help text using

        python server.py --help

    """

    HOST, PORT = host, port
    print "running on %s:%d" % (HOST, PORT)
    app.run(host=HOST, port=PORT, debug=debug, threaded=threaded)


  run()