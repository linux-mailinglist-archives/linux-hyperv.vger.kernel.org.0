Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFF31B3564
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 05:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDVDIJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Apr 2020 23:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgDVDIJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Apr 2020 23:08:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D89E2070B;
        Wed, 22 Apr 2020 03:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587524888;
        bh=00kZ49s3t3bAlBmeWs2Vc0CxVHkvA4fbM6GiSen4rQQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wfdApLvE/3xwrwCtPcMQr1rL34+cx7YSXiAQccBXOmD97IxVPg3SHSlvcCwDOWfZk
         ZTrE+akF4LIqOg7mcI7UOXl/+wNfTSzxk0aqcnnRvo677IluDAh759XEb3Baz0um7u
         fOmSCBtBUImQw/YC+HStUtsAapP4pnoE5LDuh45o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F3BCE35226E4; Tue, 21 Apr 2020 20:08:07 -0700 (PDT)
Date:   Tue, 21 Apr 2020 20:08:07 -0700
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
        KY Srinivasan <kys@microsoft.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Message-ID: <20200422030807.GK17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <20200422012814.GB299948@T590>
 <HK0P153MB0273B954294B331E20AACB41BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <20200422020134.GC299948@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422020134.GC299948@T590>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 22, 2020 at 10:01:34AM +0800, Ming Lei wrote:
> On Wed, Apr 22, 2020 at 01:48:25AM +0000, Dexuan Cui wrote:
> > > From: Ming Lei <ming.lei@redhat.com>
> > > Sent: Tuesday, April 21, 2020 6:28 PM
> > > To: Dexuan Cui <decui@microsoft.com>
> > > 
> > > On Tue, Apr 21, 2020 at 05:17:24PM -0700, Dexuan Cui wrote:
> > > > During hibernation, the sdevs are suspended automatically in
> > > > drivers/scsi/scsi_pm.c before storvsc_suspend(), so after
> > > > storvsc_suspend(), there is no disk I/O from the file systems, but there
> > > > can still be disk I/O from the kernel space, e.g. disk_check_events() ->
> > > > sr_block_check_events() -> cdrom_check_events() can still submit I/O
> > > > to the storvsc driver, which causes a paic of NULL pointer dereference,
> > > > since storvsc has closed the vmbus channel in storvsc_suspend(): refer
> > > > to the below links for more info:
> > > >
> > > > Fix the panic by blocking/unblocking all the I/O queues properly.
> > > >
> > > > Note: this patch depends on another patch "scsi: core: Allow the state
> > > > change from SDEV_QUIESCE to SDEV_BLOCK" (refer to the second link
> > > above).
> > > >
> > > > Fixes: 56fb10585934 ("scsi: storvsc: Add the support of hibernation")
> > > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > > ---
> > > >  drivers/scsi/storvsc_drv.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > > > index fb41636519ee..fd51d2f03778 100644
> > > > --- a/drivers/scsi/storvsc_drv.c
> > > > +++ b/drivers/scsi/storvsc_drv.c
> > > > @@ -1948,6 +1948,11 @@ static int storvsc_suspend(struct hv_device
> > > *hv_dev)
> > > >  	struct storvsc_device *stor_device = hv_get_drvdata(hv_dev);
> > > >  	struct Scsi_Host *host = stor_device->host;
> > > >  	struct hv_host_device *host_dev = shost_priv(host);
> > > > +	int ret;
> > > > +
> > > > +	ret = scsi_host_block(host);
> > > > +	if (ret)
> > > > +		return ret;
> > > >
> > > >  	storvsc_wait_to_drain(stor_device);
> > > >
> > > > @@ -1968,10 +1973,15 @@ static int storvsc_suspend(struct hv_device
> > > *hv_dev)
> > > >
> > > >  static int storvsc_resume(struct hv_device *hv_dev)
> > > >  {
> > > > +	struct storvsc_device *stor_device = hv_get_drvdata(hv_dev);
> > > > +	struct Scsi_Host *host = stor_device->host;
> > > >  	int ret;
> > > >
> > > >  	ret = storvsc_connect_to_vsp(hv_dev, storvsc_ringbuffer_size,
> > > >  				     hv_dev_is_fc(hv_dev));
> > > > +	if (!ret)
> > > > +		ret = scsi_host_unblock(host, SDEV_RUNNING);
> > > > +
> > > >  	return ret;
> > > >  }
> > > 
> > > scsi_host_block() is actually too heavy for just avoiding
> > > scsi internal command, which can be done simply by one atomic
> > > variable.
> > > 
> > > Not mention scsi_host_block() is implemented too clumsy because
> > > nr_luns * synchronize_rcu() are required in scsi_host_block(),
> > > which should have been optimized to just one.
> > > 
> > > Also scsi_device_quiesce() is heavy too, still takes 2
> > > synchronize_rcu() for one LUN.
> > > 
> > > That is said SCSI suspend may take (3 * nr_luns) sysnchronize_rcu() in
> > > case that the HBA's suspend handler needs scsi_host_block().
> > > 
> > > Thanks,
> > > Ming
> > 
> > When we're in storvsc_suspend(), all the userspace processes have been
> > frozen and all the file systems have been flushed, and there should not
> > be too much I/O from the kernel space, so IMO scsi_host_block() should be
> > pretty fast here. 
> 
> I guess it depends on RCU's implementation, so CC RCU guys.
> 
> Hello Paul & Josh,
> 
> Could you clarify that if sysnchronize_rcu becomes quickly during
> system suspend?

Once you have all but one CPU offlined, it becomes extremely fast, as
in roughly a no-op (which is an idea of Josh's from back in the day).
But if there is more than one CPU online, then synchronize_rcu() still
takes on the order of several to several tens of jiffies.

So, yes, in some portions of system suspend, synchronize_rcu() becomes
very fast indeed.

							Thanx, Paul
