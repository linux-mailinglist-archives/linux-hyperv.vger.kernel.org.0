Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE2E105194
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Nov 2019 12:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKULo1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Nov 2019 06:44:27 -0500
Received: from foss.arm.com ([217.140.110.172]:54866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfKULo1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Nov 2019 06:44:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70368328;
        Thu, 21 Nov 2019 03:44:26 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0032F3F703;
        Thu, 21 Nov 2019 03:44:24 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:44:19 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH v2 2/4] PCI: hv: Add the support of hibernation
Message-ID: <20191121114419.GA4318@e121166-lin.cambridge.arm.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
 <1574234218-49195-3-git-send-email-decui@microsoft.com>
 <20191120172026.GE3279@e121166-lin.cambridge.arm.com>
 <PU1P153MB0169D0A99D5687FBDB02536BBF4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169D0A99D5687FBDB02536BBF4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 21, 2019 at 12:50:17AM +0000, Dexuan Cui wrote:
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Wednesday, November 20, 2019 9:20 AM
> > 
> > On Tue, Nov 19, 2019 at 11:16:56PM -0800, Dexuan Cui wrote:
> > > Implement the suspend/resume callbacks.
> > >
> > > We must make sure there is no pending work items before we call
> > > vmbus_close().
> > 
> > Where ? Why ? Imagine a developer reading this log to try to understand
> > why you made this change, do you really think this commit log is
> > informative in its current form ?
> > 
> > I am not asking a book but this is a significant feature please make
> > an effort to explain it (I can update the log for you but please
> > write one and I shall do it).
> > 
> > Lorenzo
> 
> Sorry for being sloppy on this patch's changelog! Can you please use the
> below? I can also post v3 with the new changelog if that's better.

As you wish but more importantly get hyper-V maintainers to ACK these
changes since time is running out for v5.5.

Lorenzo

> PCI: hv: Add the support of hibernation
> 
> hv_pci_suspend() runs in a process context as a callback in dpm_suspend().
> When it starts to run, the channel callback hv_pci_onchannelcallback(),
> which runs in a tasklet context, can be still running concurrently and
> scheduling new work items onto hbus->wq in hv_pci_devices_present() and
> hv_pci_eject_device(), and the work item handlers can access the vmbus
> channel, which can be being closed by hv_pci_suspend(), e.g. the work item
> handler pci_devices_present_work() -> new_pcichild_device() writes to
> the vmbus channel.
> 
> To eliminate the race, hv_pci_suspend() disables the channel callback
> tasklet, sets hbus->state to hv_pcibus_removing, and re-enables the tasklet.
> 
> This way, when hv_pci_suspend() proceeds, it knows that no new work item
> can be scheduled, and then it flushes hbus->wq and safely closes the vmbus
> channel.
> 
> Thanks,
> -- Dexuan
