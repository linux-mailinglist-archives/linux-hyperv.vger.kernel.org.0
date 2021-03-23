Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD4E346877
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Mar 2021 20:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhCWTFK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Mar 2021 15:05:10 -0400
Received: from foss.arm.com ([217.140.110.172]:50768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233000AbhCWTE5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Mar 2021 15:04:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15EC81042;
        Tue, 23 Mar 2021 12:04:57 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 370123F718;
        Tue, 23 Mar 2021 12:04:51 -0700 (PDT)
Subject: Re: [PATCH v2 12/15] PCI/MSI: Let PCI host bridges declare their
 reliance on MSI domains
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, kernel-team@android.com
References: <20210322184614.802565-1-maz@kernel.org>
 <20210322184614.802565-13-maz@kernel.org>
 <6a2eaa5d-1d83-159f-69e5-c9e0a00a7b50@arm.com> <87im5hkahr.wl-maz@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <be2d9ea0-6657-b7aa-01b5-1b4a704cb478@arm.com>
Date:   Tue, 23 Mar 2021 19:04:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87im5hkahr.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2021-03-23 18:09, Marc Zyngier wrote:
> Hi Robin,
> 
> On Tue, 23 Mar 2021 11:45:02 +0000,
> Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-03-22 18:46, Marc Zyngier wrote:
>>> The new 'no_msi' attribute solves the problem of advertising the lack
>>> of MSI capability for host bridges that know for sure that there will
>>> be no MSI for their end-points.
>>>
>>> However, there is a whole class of host bridges that cannot know
>>> whether MSIs will be provided or not, as they rely on other blocks
>>> to provide the MSI functionnality, using MSI domains.  This is
>>> the case for example on systems that use the ARM GIC architecture.
>>>
>>> Introduce a new attribute ('msi_domain') indicating that implicit
>>> dependency, and use this property to set the NO_MSI flag when
>>> no MSI domain is found at probe time.
>>>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>    drivers/pci/probe.c | 2 +-
>>>    include/linux/pci.h | 1 +
>>>    2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 146bd85c037e..bac9f69a06a8 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -925,7 +925,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>>    	device_enable_async_suspend(bus->bridge);
>>>    	pci_set_bus_of_node(bus);
>>>    	pci_set_bus_msi_domain(bus);
>>> -	if (bridge->no_msi)
>>> +	if (bridge->no_msi || (bridge->msi_domain && !bus->dev.msi_domain))
>>>    		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>>>      	if (!parent)
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index 48605cca82ae..d322d00db432 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -551,6 +551,7 @@ struct pci_host_bridge {
>>>    	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
>>>    	unsigned int	size_windows:1;		/* Enable root bus sizing */
>>>    	unsigned int	no_msi:1;		/* Bridge has no MSI support */
>>> +	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
>>
>> Aren't these really the same thing? Either way we're saying the bridge
>> itself doesn't handle MSIs, it's just in one case we're effectively
>> encoding a platform-specific assumption that an external domain won't
>> be provided. I can't help wondering whether that distinction is really
>> necessary...
> 
> There is a subtle difference: no_msi indicates that there is no way
> *any* MSI can be dealt with whatsoever (maybe because the RC doesn't
> forward the corresponding TLPs?). msi_domain says "no MSI unless...".

PCI says that MSIs are simply memory writes at the transaction level, so 
AFAIK unless the host bridge can't support DMA at all, it shouldn't be 
in a position to make any assumptions about what transactions mean what.

I suppose there could in theory be an issue in the other direction, 
where config space somehow didn't allow access to the MSI capability in 
the first place, but then we'd presumably just never detect any device 
as being MSI-capable in the first place, and it wouldn't matter either way.

> We could implement the former with the latter, but I have the feeling
> that's not totally bullet proof. Happy to revisit this if you think it
> really matters.

I would expect it to be a fairly safe assumption that a host bridge 
which "doesn't support MSIs" wouldn't have an msi-parent set, but I 
don't have a strong opinion either way - I just figured we could 
probably save a little bit of complexity here.

Cheers,
Robin.
