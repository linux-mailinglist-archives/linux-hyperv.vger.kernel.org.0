Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBCA108BFB
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2019 11:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfKYKpG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Nov 2019 05:45:06 -0500
Received: from foss.arm.com ([217.140.110.172]:47966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfKYKpG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Nov 2019 05:45:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 903EF328;
        Mon, 25 Nov 2019 02:45:05 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2618F3F52E;
        Mon, 25 Nov 2019 02:45:04 -0800 (PST)
Date:   Mon, 25 Nov 2019 10:44:59 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH v2 2/4] PCI: hv: Add the support of hibernation
Message-ID: <20191125104459.GA14328@e121166-lin.cambridge.arm.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
 <1574234218-49195-3-git-send-email-decui@microsoft.com>
 <20191120172026.GE3279@e121166-lin.cambridge.arm.com>
 <PU1P153MB0169D0A99D5687FBDB02536BBF4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20191121114419.GA4318@e121166-lin.cambridge.arm.com>
 <CY4PR21MB06290283219FC78C45688DC4D74B0@CY4PR21MB0629.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR21MB06290283219FC78C45688DC4D74B0@CY4PR21MB0629.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Nov 24, 2019 at 10:19:46PM +0000, Michael Kelley wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>  Sent: Thursday, November 21, 2019 3:44 AM
> > 
> > On Thu, Nov 21, 2019 at 12:50:17AM +0000, Dexuan Cui wrote:
> > > > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Sent: Wednesday, November 20, 2019 9:20 AM
> > > >
> > > > On Tue, Nov 19, 2019 at 11:16:56PM -0800, Dexuan Cui wrote:
> > > > > Implement the suspend/resume callbacks.
> > > > >
> > > > > We must make sure there is no pending work items before we call
> > > > > vmbus_close().
> > > >
> > > > Where ? Why ? Imagine a developer reading this log to try to understand
> > > > why you made this change, do you really think this commit log is
> > > > informative in its current form ?
> > > >
> > > > I am not asking a book but this is a significant feature please make
> > > > an effort to explain it (I can update the log for you but please
> > > > write one and I shall do it).
> > > >
> > > > Lorenzo
> > >
> > > Sorry for being sloppy on this patch's changelog! Can you please use the
> > > below? I can also post v3 with the new changelog if that's better.
> > 
> > As you wish but more importantly get hyper-V maintainers to ACK these
> > changes since time is running out for v5.5.
> > 
> > Lorenzo
> > 
> > > PCI: hv: Add the support of hibernation
> > >
> > > hv_pci_suspend() runs in a process context as a callback in dpm_suspend().
> > > When it starts to run, the channel callback hv_pci_onchannelcallback(),
> > > which runs in a tasklet context, can be still running concurrently and
> > > scheduling new work items onto hbus->wq in hv_pci_devices_present() and
> > > hv_pci_eject_device(), and the work item handlers can access the vmbus
> > > channel, which can be being closed by hv_pci_suspend(), e.g. the work item
> > > handler pci_devices_present_work() -> new_pcichild_device() writes to
> > > the vmbus channel.
> > >
> > > To eliminate the race, hv_pci_suspend() disables the channel callback
> > > tasklet, sets hbus->state to hv_pcibus_removing, and re-enables the tasklet.
> > >
> > > This way, when hv_pci_suspend() proceeds, it knows that no new work item
> > > can be scheduled, and then it flushes hbus->wq and safely closes the vmbus
> > > channel.
> > >
> > > Thanks,
> > > -- Dexuan
> 
> FWIW, I'd like to see the above level of detail also as comments in the code
> Itself so that whoever next looks at the code sees the explanation directly
> without having to review the commit logs.
> 
> Also, the commit message doesn't say what the commit actually does and
> why.  I'd suggest the commit message along these lines:
> 
> Add suspend() and resume() functions so that Hyper-V virtual PCI devices are
> handled properly when the VM hibernates and resumes from hibernation.
> 
> Note that the suspend() function must make sure there are no pending work
> items before calling vmbus_close(), since it runs in a process context as a
> callback in dpm_suspend().  When it starts to run, the channel callback
> hv_pci_onchannelcallback(), which runs in a tasklet context, can be still running
> concurrently and scheduling new work items onto hbus->wq in
> hv_pci_devices_present() and hv_pci_eject_device(), and the work item 
> handlers can access the vmbus channel, which can be being closed by
> hv_pci_suspend(), e.g. the work item handler pci_devices_present_work() ->
> new_pcichild_device() writes to the vmbus channel.
> 
> To eliminate the race, hv_pci_suspend() disables the channel callback
> tasklet, sets hbus->state to hv_pcibus_removing, and re-enables the tasklet.
> This way, when hv_pci_suspend() proceeds, it knows that no new work item
> can be scheduled, and then it flushes hbus->wq and safely closes the vmbus
> channel.

This is much better, thank you, if you are happy with the patches
please add your tags so that I can pull the series asap, hopefully
we can merge it in v5.5.

Thanks,
Lorenzo
