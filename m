Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C045E167B10
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2020 11:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgBUKpD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Feb 2020 05:45:03 -0500
Received: from foss.arm.com ([217.140.110.172]:36426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgBUKpD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Feb 2020 05:45:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B45C31B;
        Fri, 21 Feb 2020 02:45:02 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63E163F68F;
        Fri, 21 Feb 2020 02:45:00 -0800 (PST)
Date:   Fri, 21 Feb 2020 10:44:54 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/3] PCI: hv: Generify pci-hyperv.c
Message-ID: <20200221104454.GA8595@e121166-lin.cambridge.arm.com>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
 <20200221023344.GJ69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221023344.GJ69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 21, 2020 at 10:33:44AM +0800, Boqun Feng wrote:
> Ping ;-)
> 
> Any suggestion or plan on this patchset?

Hi,

I shall have a look shortly, thanks.

Lorenzo

> Thanks and Regards,
> Boqun
> 
> On Mon, Feb 10, 2020 at 11:39:50AM +0800, Boqun Feng wrote:
> > Hi,
> > 
> > This is the first part for virtual PCI support of Hyper-V guest on
> > ARM64. The whole patchset doesn't have any functional change, but only
> > refactors the pci-hyperv.c code to make it more arch-independent.
> > 
> > Previous version:
> > v1: https://lore.kernel.org/lkml/20200121015713.69691-1-boqun.feng@gmail.com/
> > v2: https://lore.kernel.org/linux-arm-kernel/20200203050313.69247-1-boqun.feng@gmail.com/
> > 
> > Changes since v2:
> > 
> > *	Rebased on 5.6-rc1
> > 
> > *	Reword commit logs as per Andrew's suggestion.
> > 
> > *	It makes more sense to have a generic interface to set the whole
> > 	msi_entry rather than only the "address" field. So change
> > 	hv_set_msi_address_from_desc() to hv_set_msi_entry_from_desc().
> > 	Additionally, make it an inline function as per the suggestion
> > 	of Andrew and Thomas.
> > 
> > *	Add the missing comment saying the partition_id of
> > 	hv_retarget_device_interrupt must be self.
> > 
> > *	Add the explanation for why "__packed" is needed for TLFS
> > 	structures.
> > 
> > I've done compile and boot test of this patchset, also done some tests
> > with a pass-through NVMe device.
> > 
> > Suggestions and comments are welcome!
> > 
> > Regards,
> > Boqun
> > 
> > Boqun Feng (3):
> >   PCI: hv: Move hypercall related definitions into tlfs header
> >   PCI: hv: Move retarget related structures into tlfs header
> >   PCI: hv: Introduce hv_msi_entry
> > 
> >  arch/x86/include/asm/hyperv-tlfs.h  | 41 +++++++++++++++++++++++++++
> >  arch/x86/include/asm/mshyperv.h     |  8 ++++++
> >  drivers/pci/controller/pci-hyperv.c | 43 ++---------------------------
> >  3 files changed, 52 insertions(+), 40 deletions(-)
> > 
> > -- 
> > 2.24.1
> > 
