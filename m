Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E671B4A1A
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDVQTP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 12:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgDVQTO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 12:19:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 977F62076E;
        Wed, 22 Apr 2020 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587572353;
        bh=/ju+Nf/ZeNdIEbRhaDpQGOzeSE/IYkIJF4a7nzgxgRU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=swTEzOz7sfsOyPVId/9RaCJV/xkD3qVt8/D9P/cBDFB4zMtb6LS+Ck+gJqjXzUaaC
         hhALIp4sjV67d39Ki8rx9dX+lZRSjZreP3pGo+Hycp0pYIjPUXe2jCrRyqz863lInd
         yY4dC+ggXikcZtEvFN3zIf5ZeBhB9S7CKBcK02Dw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7C46D35203BC; Wed, 22 Apr 2020 09:19:13 -0700 (PDT)
Date:   Wed, 22 Apr 2020 09:19:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Message-ID: <20200422161913.GX17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <20200422012814.GB299948@T590>
 <HK0P153MB0273B954294B331E20AACB41BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <20200422020134.GC299948@T590>
 <20200422030807.GK17661@paulmck-ThinkPad-P72>
 <20200422041629.GE299948@T590>
 <HK0P153MB0273CF2901E193C03C934A47BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <20200422092351.GF299948@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422092351.GF299948@T590>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 22, 2020 at 05:23:51PM +0800, Ming Lei wrote:
> On Wed, Apr 22, 2020 at 04:58:14AM +0000, Dexuan Cui wrote:
> > > From: Ming Lei <ming.lei@redhat.com>
> > > Sent: Tuesday, April 21, 2020 9:16 PM
> > > ...
> > > > > > When we're in storvsc_suspend(), all the userspace processes have been
> > > > > > frozen and all the file systems have been flushed, and there should not
> > > > > > be too much I/O from the kernel space, so IMO scsi_host_block() should
> > > be
> > > > > > pretty fast here.
> > > > >
> > > > > I guess it depends on RCU's implementation, so CC RCU guys.
> > > > >
> > > > > Hello Paul & Josh,
> > > > >
> > > > > Could you clarify that if sysnchronize_rcu becomes quickly during
> > > > > system suspend?
> > > >
> > > > Once you have all but one CPU offlined, it becomes extremely fast, as
> > > > in roughly a no-op (which is an idea of Josh's from back in the day).
> > > > But if there is more than one CPU online, then synchronize_rcu() still
> > > > takes on the order of several to several tens of jiffies.
> > > >
> > > > So, yes, in some portions of system suspend, synchronize_rcu() becomes
> > > > very fast indeed.
> > > 
> > > Hi Paul,
> > > 
> > > Thanks for your clarification.
> > > 
> > > In system suspend path, device is suspended before
> > > suspend_disable_secondary_cpus(),
> > > so I guess synchronize_rcu() is not quick enough even though user space
> > > processes and some kernel threads are frozen.
> > > 
> > > Thanks,
> > > Ming
> > 
> > storvsc_suspend() -> scsi_host_block() is only called in the hibernation
> > path, which is not a hot path at all, so IMHO we don't really care if it
> > takes 10ms or 100ms or even 1s. :-)  BTW, in my test, typically the
> 
> Are you sure the 'we' can cover all users?
> 
> > scsi_host_block() here takes about 3ms in my 40-vCPU VM.
> 
> If more LUNs are added, the time should be increased proportionallly,
> that is why I think scsi_host_block() is bad.

If the caller must wait until the grace period ends, then the traditional
approach is to use a single synchronize_rcu() to cover all LUNs.  This of
course can require some reworking of the code.

If the caller does not need to wait, then either call_rcu() or kfree_rcu()
can work quite well.

							Thanx, Paul
