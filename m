Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224631B3B25
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDVJYQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 05:24:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51111 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725968AbgDVJYQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 05:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587547454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DMhA18q5o54p19fFpaLKF4OTjlHgtCkpRiehNkdmtk0=;
        b=grApRieNK+OmW+Ph9h2tR9zU0uKExcWmmISzc/RrgOUdVjDeysh8DaWsu+FczjWWILTAPj
        WIzMeEmSv0ZlCUw1vFqJ3GxVNUuoG4yjZ7fkrmNMYqjutoOIvIUTxPBxLB0L7SPmoT9jIe
        BuntuwErSvNNbVZzI/ZjHmqtDlZ+J5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-bYl2gzczORKSGHhwjavuQw-1; Wed, 22 Apr 2020 05:24:10 -0400
X-MC-Unique: bYl2gzczORKSGHhwjavuQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1503B8017FC;
        Wed, 22 Apr 2020 09:24:08 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B2FFB3A8F;
        Wed, 22 Apr 2020 09:23:56 +0000 (UTC)
Date:   Wed, 22 Apr 2020 17:23:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20200422092351.GF299948@T590>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <20200422012814.GB299948@T590>
 <HK0P153MB0273B954294B331E20AACB41BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <20200422020134.GC299948@T590>
 <20200422030807.GK17661@paulmck-ThinkPad-P72>
 <20200422041629.GE299948@T590>
 <HK0P153MB0273CF2901E193C03C934A47BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0P153MB0273CF2901E193C03C934A47BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 22, 2020 at 04:58:14AM +0000, Dexuan Cui wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> > Sent: Tuesday, April 21, 2020 9:16 PM
> > ...
> > > > > When we're in storvsc_suspend(), all the userspace processes have been
> > > > > frozen and all the file systems have been flushed, and there should not
> > > > > be too much I/O from the kernel space, so IMO scsi_host_block() should
> > be
> > > > > pretty fast here.
> > > >
> > > > I guess it depends on RCU's implementation, so CC RCU guys.
> > > >
> > > > Hello Paul & Josh,
> > > >
> > > > Could you clarify that if sysnchronize_rcu becomes quickly during
> > > > system suspend?
> > >
> > > Once you have all but one CPU offlined, it becomes extremely fast, as
> > > in roughly a no-op (which is an idea of Josh's from back in the day).
> > > But if there is more than one CPU online, then synchronize_rcu() still
> > > takes on the order of several to several tens of jiffies.
> > >
> > > So, yes, in some portions of system suspend, synchronize_rcu() becomes
> > > very fast indeed.
> > 
> > Hi Paul,
> > 
> > Thanks for your clarification.
> > 
> > In system suspend path, device is suspended before
> > suspend_disable_secondary_cpus(),
> > so I guess synchronize_rcu() is not quick enough even though user space
> > processes and some kernel threads are frozen.
> > 
> > Thanks,
> > Ming
> 
> storvsc_suspend() -> scsi_host_block() is only called in the hibernation
> path, which is not a hot path at all, so IMHO we don't really care if it
> takes 10ms or 100ms or even 1s. :-)  BTW, in my test, typically the

Are you sure the 'we' can cover all users?

> scsi_host_block() here takes about 3ms in my 40-vCPU VM.

If more LUNs are added, the time should be increased proportionallly,
that is why I think scsi_host_block() is bad.


Thanks,
Ming

