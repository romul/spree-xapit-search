Xapit Search
------------

### Installation

If you haven’t already, first install Xapian and the Xapian Bindings for Ruby. [wiki.github.com/ryanb/xapit/xapian-installation](http://wiki.github.com/ryanb/xapit/xapian-installation)

If you already install Xapian: 

    script/extension install git://github.com/romul/spree-xapit-search.git

**NOTE:** This extension works only with Spree 0.9.99 and higher.
    
### Index (copied from Xapit README)

To perform the indexing, run the xapit:index rake task.

    rake xapit:index

It can also be triggered through Ruby code using this command.

    Xapit.remove_database
    Xapit.index_all

You may want to trigger this via a cron job on a recurring schedule (i.e. every day) to update the Xapian database. However it will only take effect after the Rails application is restarted because the Xapian database is stored in memory.

There are two projects in development to help improve this reindexing.

  * [github.com/ryanb/xapit-sync/tree/master](http://github.com/ryanb/xapit-sync/tree/master)
  * [github.com/ryanb/xapit-server/tree/master](http://github.com/ryanb/xapit-server/tree/master)
