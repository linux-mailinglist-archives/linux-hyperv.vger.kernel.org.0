Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1544D3CBB29
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jul 2021 19:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhGPRbH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Jul 2021 13:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhGPRbG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Jul 2021 13:31:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5618A613FD;
        Fri, 16 Jul 2021 17:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626456490;
        bh=M2I/HaAF2t1p5V1162lM9GPJnRQ8sAYIEYzt6UQRuCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkTCoKJskYPAl/8zlMwaMwS6RNFF9yDvv+86+qGODMKWfo2za1Avl8EJgQKP/+Dlc
         n8TYlFvLo8VUku33Vk82jfOel01Ba3d/l6sWEZZo6U/W6cQwykE3PG4iNT1P2QTcTK
         1SqFivZHNhkKP2mrEXk8YJjT7FyfHsMhBbZEVqQE=
Date:   Fri, 16 Jul 2021 19:28:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YPHBpo1n/COMegcE@kroah.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15937DF3FB30DDA65EF58EE1D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15937DF3FB30DDA65EF58EE1D7119@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 16, 2021 at 03:56:14PM +0000, Michael Kelley wrote:
> > +static int az_blob_remove(struct hv_device *dev)
> > +{
> > +	az_blob_dev.removing = true;
> > +	/*
> > +	 * RCU lock guarantees that any future calls to az_blob_fop_open()
> > +	 * can not use device resources while the inode reference of
> > +	 * /dev/azure_blob is being held for that open, and device file is
> > +	 * being removed from /dev.
> > +	 */
> > +	synchronize_rcu();
> 
> I don't think this works as you have described.  While it will ensure that
> any in-progress RCU read-side critical sections have completed (i.e.,
> in az_blob_fop_open() ), it does not prevent new read-side critical sections
> from being started.  So as soon as synchronize_rcu() is finished, another
> thread could find and open the device, and be executing in
> az_blob_fop_open().
> 
> But it's not clear to me that this (and the rcu_read_locks in az_blob_fop_open)
> are really needed anyway.  If az_blob_remove_device() is called while one or more
> threads have it open, I think that's OK.  Or is there a scenario that I'm missing?

This should not be different from any other tiny character device, why
the mess with RCU at all?

> > +	az_blob_info("removing device\n");
> > +	az_blob_remove_device();
> > +
> > +	/*
> > +	 * At this point, it's not possible to open more files.
> > +	 * Wait for all the opened files to be released.
> > +	 */
> > +	wait_event(az_blob_dev.file_wait, list_empty(&az_blob_dev.file_list));
> 
> As mentioned in my most recent comments on the previous version of the
> code, I'm concerned about waiting for all open files to be released in the case
> of a VMbus rescind.  We definitely have to wait for all VSP operations to
> complete, but that's different from waiting for the files to be closed.  The former
> depends on Hyper-V being well-behaved and will presumably happen quickly
> in the case of a rescind.  But the latter depends entirely on user space code
> that is out of the kernel's control.  The user space process could hang around
> for hours or days with the file still open, which would block this function
> from completing, and hence block the global work queue.
> 
> Thinking about this, the core issue may be that having a single static
> instance of az_blob_device is problematic if we allow the device to be
> removed (either explicitly with an unbind, or implicitly with a VMbus
> rescind) and then re-added.  Perhaps what needs to happen is that
> the removed device is allowed to continue to exist as long as user
> space processes have an open file handle, but they can't perform
> any operations because the "removing" flag is set (and stays set).
> If the device is re-added, then a new instance of az_blob_device
> should be created, and whether or not the old instance is still
> hanging around is irrelevant.

You should never have a single static copy of the device, that was going
to be my first review comment once this all actually got to a place that
made sense to review (which it is not even there yet.)  When you do
that, then you have these crazy race issues you speak of.  Use the misc
api correctly and you will not have any of these problems, why people
try to make it harder is beyond me...

thanks,

greg k-h
