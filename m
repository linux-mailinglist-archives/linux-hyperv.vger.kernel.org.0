Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239FA2560B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgH1Sm1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Aug 2020 14:42:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1SmZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Aug 2020 14:42:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598640142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i9PL1UZyrvXtvYwXm50JgVKEMKlhclTur/QaPxXNrW4=;
        b=WpnVo7bVNT/b8XQDt+j58pe6KdQuC0AaMuaG96ld2pT19xmZmgIfhwIL2aToKAQCuHplbl
        babtlLWVtGtJoKe554lnL+lrSbC+m2P80aoFcGewVi1cvJw89TLCA+RKvIpl3nB1tz+atR
        Rpt1UAY/0C2Jh7S/HVLrWc1d3i6FRctcoggPvOgispeAzX31o/e0KIecYrxPcVTe02glak
        xvt/5cf0eEZL35Cs55nb+A3Mx+nimOdxcufa2dUvIghy3OgLuWzePAHaWMcUDkE7FZclcC
        P6D3MhploGKAumda2RRUUhTFcp/3dtDRczfHHNjGZzGxRU3c3M1LzqDqHVmpHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598640142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i9PL1UZyrvXtvYwXm50JgVKEMKlhclTur/QaPxXNrW4=;
        b=ChwUrHsMyAvL0EU/Y4hgs1mQPBN+7Zk3PLK+0Sz5YppkJGFQXT2iBnk0EWmZfwq4Jm1Lwb
        mDs4YAIFWBPd+5CQ==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 43/46] genirq/msi: Provide and use msi_domain_set_default_info_flags()
In-Reply-To: <b80607e87e43730133dd9f619c6464dc@kernel.org>
References: <20200826111628.794979401@linutronix.de> <20200826112334.889315931@linutronix.de> <b80607e87e43730133dd9f619c6464dc@kernel.org>
Date:   Fri, 28 Aug 2020 20:42:21 +0200
Message-ID: <87zh6ek3xu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 27 2020 at 09:17, Marc Zyngier wrote:
> On 2020-08-26 12:17, Thomas Gleixner wrote:
>>  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>> +void msi_domain_set_default_info_flags(struct msi_domain_info *info)
>> +{
>> +	/* Required so that a device latches a valid MSI message on startup 
>> */
>> +	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
>
> As far as I remember the story behind this flag (it's been a while),
> it was working around a PCI-specific issue, hence being located in
> the PCI code.

Yes. Some cards misbehave when there is no valid message programmed and
MSI is enabled.

> Now, the "program the MSI before enabling it" concept makes sense no
> matter what bus this is on, and I wonder why we are even keeping this
> flag around.

> Can't we just drop it together with the check in
> msi_domain_alloc_irqs()?

I'm fine with that.

Thanks,

        tglx
