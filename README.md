Installation
--------------

In config/routes.rb at the end of routes declarations include:

   EasyDataRouting.routes(map)

<p>After, in [RAILS_HOME]/Rakefile copy this line:</p>

<pre><code> require "easy_data/tasks" </code></pre>

<p>At the end, execute the next task:</p>

<pre><code>   rake easy_data:install RAILS_ENV=development </code></pre>


<p>To start with administration, you should assign at admin user:</p>

<pre><code>   rake easy_data:add_user[user,pass] RAILS_ENV=development </code></pre>


Commandas and Query
--------------------

<p>To get all possibles querys and URI's offers use this url:</p>

<pre><code>   http://[project_host]/list_models </code></pre>


<p>After, to get any information about any model or resource, used this url: </p>

<pre><code>  http://[project_host]/foaf/[model]/[id][.format] </code></pre>

<ul>
<li>[model] = any model list in first url</li>
<li>[id] = to get any information with primary key</li>
<li>[format] = this is for advance users, get response in this format</li>
</ul>

Collaborations
------------------

<p>If you want to collaborate on this project or have any ideas and would like to share, please email me at my email, all are welcome!</p>
<p><a href="mailto:jnillo9@gmail.com" title="jnillo's mail">jnillo9@gmail.com</a></p>

License
--------------------

<p>EasyData uses the <a href="www.opensource.org/licenses/MIT" title="MIT license description">MIT</a> lincense.</p>
