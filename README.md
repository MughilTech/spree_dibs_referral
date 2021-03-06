spree_dibs_referral
===================

This is a [Spree] extension that allows tracking of sales referrals
based on a role.  It allows users with that role to send links to leads
via email, then have their account reported as the referral on
associated sales.

The customer can also manually choose or override the referral during
the payment step of checkout.

Installation
============

The master branch of spree_dibs_referral is compatible with Ruby 1.9.x
and Spree 1.3.  There are stable branches for Spree 1.1, 1.2 and 1.3.
Use the appropriate branch for your version as shown below.

1. Edit your Gemfile, adding the line:

`gem 'spree_dibs_referral', :git => 'git://github.com/binaryphile/spree_dibs_referral, :branch => '1-3-stable'`

2. Run the following commands:

```
bundle install
bundle exec rake spree_dibs_referral:install:migrations
bundle exec rake db:migrate
```

Start your Spree instance and you're done.

Known Issues
============

The spree_flexi_variants extension
----------------------------------

The referral link on the cart page cannot support carts which have items
that differ only by their ad-hoc options (i.e. they have the same Spree
variant id but different ad-hoc options) as well as having different
quantities.  The user who clicks on such a referral link will get a cart
that has both items, with the proper options, but the quantities for
both will be the quantity of the last such item.

For example, if you have two t-shirt items in your cart that only differ
by quantity and the ad-hoc option of size, say two of the small and
three of the large, then the user receiving the referral link will get a
quantity of three on both the small and large t-shirts.

There is no workaround, you simply can't do this if you're using the
spree_flexi_variants extension.

Details
=======

It is open-source, so input/pull requests will certainly be considered,
but be aware that it is being developed specifically for the needs of
DidItBetter Software's Spree implementation, which puts some
constraints on what input is accepted.  That said, please do contact
me if you have a problem or suggestion.

By referrals, we typically mean inside or outside salespeople who take
an active role in assisting customers with finding suitable product(s)
and who are compensated for assisting closed sales.  This system makes
it easier to track the referrers association with the sale so that
credit can be given where it is due.

As it stands, the system is actively being developed and will have some
significant changes to the user experience in the near future.

### dibs_referral Role

There is a new role added by the extension, called "dibs_referral".
"dibs" is short for DidItBetter Software.

![user_role]

Each referrer (salesperson) must have an account on the system and must
be assigned the dibs_referrer role.

Once the role is assigned, the referrer will show up in the list of
referrers.  This list is shown to the user on the payment step of the
checkout process.

### Choosing Referrer During Payment Step

If the user has been sent a referral link, then they will have the
referrer's id set in their session cookie.  Once they make it to
checkout, the payment step will list the referrer automatically.  The
user will have the opportunity to change the referrer at that point,
choosing from any user with the referral role.  However, they will
usually leave it alone.

![purchase]

If the user has not been sent a referral link, the referral field
defaults to blank.  They can select from the list of referrers or choose
a blank selection, but they must touch the dropdown at least once.
There is bit of javascript to make sure that they do, which pops up an
alert warning.

### Orders Admin View

In the orders list in the admin view, there is a new column that
contains the referral, if one was specified with the order.  Currently
the list isn't sortable on that field like the others can be since I
couldn't figure that part out.

![order_list]

On the order detail, the referral is listed in the order summary in the
right-hand sidebar.  If you edit the order, there is a dropdown to
change the referral.

![order_detail]

### My Account Referral View

For the referrer, a new table has been added to the "My Account" page,
which shows their referrals that have been completed as sales, so
they can see their current status.  Incomplete referrals are not
tracked.

![my_account]

### Sending a Cart Referral

As a referrer, you will also see a _Send Referral_ button on your cart.

![cart_referral]

When you click this button, you will again see an email from your local
mail client.  This time, the link will take the user to their own cart.
However, the current contents of the cart will be emptied and replaced
with the contents of the referral cart.  Your id will be saved in their
session so that any future purchase will list you as the referrer.

![cart_email]

### Email notifications

The referrer will automatically be cc'ed on any emails generated by the
purchase process for the referred user.

Future Features
===============

* Create a cart template system

Allow referrers to store pre-defined carts, tailor them and send them.

* Reporting

More detailed reports for admins and referrers

* Track compensation rates and calculate totals

Add the ability to set a rate (percentage) that the referrer receives
and put totals in reporting

More detailed specifications can be found at the [DidItBetter Wiki].

Copyright (c) 2012 DidItBetter Software, released under the New BSD
License

[Spree]: http://spreecommerce.com/
[user_role]: https://github.com/downloads/lilleyt/spree_dibs_referral/user_role.png
[purchase]: https://github.com/downloads/lilleyt/spree_dibs_referral/purchase.png
[order_list]: https://github.com/downloads/lilleyt/spree_dibs_referral/order_list.png
[order_detail]: https://github.com/downloads/lilleyt/spree_dibs_referral/order_detail.png
[my_account]: https://github.com/downloads/lilleyt/spree_dibs_referral/my_account.png
[cart_referral]: https://github.com/downloads/lilleyt/spree_dibs_referral/cart_referral.png
[cart_email]: https://github.com/downloads/lilleyt/spree_dibs_referral/cart_email.png
[DidItBetter Wiki]: http://wiki.diditbetter.com/doku.php?id=Agent_Modules:Agent_Modules
