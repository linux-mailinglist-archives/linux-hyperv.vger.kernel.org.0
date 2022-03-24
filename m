Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA74E6582
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Mar 2022 15:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351144AbiCXOn2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Mar 2022 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351331AbiCXOnU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Mar 2022 10:43:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFEEDAA02A;
        Thu, 24 Mar 2022 07:41:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 708AA1515;
        Thu, 24 Mar 2022 07:41:48 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B8173F73D;
        Thu, 24 Mar 2022 07:41:45 -0700 (PDT)
Message-ID: <e3cf16f2-e9d7-b169-cccf-038df5acdb79@arm.com>
Date:   Thu, 24 Mar 2022 14:41:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: Propagate VMbus coherence to
 each VMbus device
Content-Language: en-GB
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
 <1648067472-13000-2-git-send-email-mikelley@microsoft.com>
 <f984116a-c748-ada0-c073-6e62f486b4f5@arm.com>
 <PH0PR21MB3025C5DFB189B9609F7A601FD7199@PH0PR21MB3025.namprd21.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <PH0PR21MB3025C5DFB189B9609F7A601FD7199@PH0PR21MB3025.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-03-24 13:18, Michael Kelley (LINUX) wrote:
> From: Robin Murphy <robin.murphy@arm.com> Sent: Thursday, March 24, 2022 4:59 AM
>>
>> On 2022-03-23 20:31, Michael Kelley wrote:
>>> VMbus synthetic devices are not represented in the ACPI DSDT -- only
>>> the top level VMbus device is represented. As a result, on ARM64
>>> coherence information in the _CCA method is not specified for
>>> synthetic devices, so they default to not hardware coherent.
>>> Drivers for some of these synthetic devices have been recently
>>> updated to use the standard DMA APIs, and they are incurring extra
>>> overhead of unneeded software coherence management.
>>>
>>> Fix this by propagating coherence information from the VMbus node
>>> in ACPI to the individual synthetic devices. There's no effect on
>>> x86/x64 where devices are always hardware coherent.
>>>
>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>>> ---
>>>    drivers/hv/hv_common.c         | 11 +++++++++++
>>>    drivers/hv/vmbus_drv.c         | 23 +++++++++++++++++++++++
>>>    include/asm-generic/mshyperv.h |  1 +
>>>    3 files changed, 35 insertions(+)
>>>
>>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>>> index 181d16b..820e814 100644
>>> --- a/drivers/hv/hv_common.c
>>> +++ b/drivers/hv/hv_common.c
>>> @@ -20,6 +20,7 @@
>>>    #include <linux/panic_notifier.h>
>>>    #include <linux/ptrace.h>
>>>    #include <linux/slab.h>
>>> +#include <linux/dma-map-ops.h>
>>>    #include <asm/hyperv-tlfs.h>
>>>    #include <asm/mshyperv.h>
>>>
>>> @@ -216,6 +217,16 @@ bool hv_query_ext_cap(u64 cap_query)
>>>    }
>>>    EXPORT_SYMBOL_GPL(hv_query_ext_cap);
>>>
>>> +void hv_setup_dma_ops(struct device *dev, bool coherent)
>>> +{
>>> +	/*
>>> +	 * Hyper-V does not offer a vIOMMU in the guest
>>> +	 * VM, so pass 0/NULL for the IOMMU settings
>>> +	 */
>>> +	arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
>>> +}
>>> +EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
>>> +
>>>    bool hv_is_hibernation_supported(void)
>>>    {
>>>    	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
>>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>>> index 12a2b37..2d2c54c 100644
>>> --- a/drivers/hv/vmbus_drv.c
>>> +++ b/drivers/hv/vmbus_drv.c
>>> @@ -905,6 +905,14 @@ static int vmbus_probe(struct device *child_device)
>>>    	struct hv_device *dev = device_to_hv_device(child_device);
>>>    	const struct hv_vmbus_device_id *dev_id;
>>>
>>> +	/*
>>> +	 * On ARM64, propagate the DMA coherence setting from the top level
>>> +	 * VMbus ACPI device to the child VMbus device being added here.
>>> +	 * On x86/x64 coherence is assumed and these calls have no effect.
>>> +	 */
>>> +	hv_setup_dma_ops(child_device,
>>> +		device_get_dma_attr(&hv_acpi_dev->dev) == DEV_DMA_COHERENT);
>>
>> Would you mind hooking up the hv_bus.dma_configure method to do this?
>> Feel free to fold hv_setup_dma_ops entirely into that if you're not
>> likely to need to call it from anywhere else.
> 
> I'm pretty sure using hv_bus.dma_configure() is doable.  A separate
> hv_setup_dma_ops() is still needed because arch_setup_dma_ops() isn't
> exported and this VMbus driver can be built as a module.

Ah, right you are, I keep forgetting that.

>>> +
>>>    	dev_id = hv_vmbus_get_id(drv, dev);
>>>    	if (drv->probe) {
>>>    		ret = drv->probe(dev, dev_id);
>>> @@ -2428,6 +2436,21 @@ static int vmbus_acpi_add(struct acpi_device *device)
>>>
>>>    	hv_acpi_dev = device;
>>>
>>> +	/*
>>> +	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
>>> +	 * method on the top level VMbus device in the DSDT. But devices
>>> +	 * are hardware coherent in all current Hyper-V use cases, so fix
>>> +	 * up the ACPI device to behave as if _CCA is present and indicates
>>> +	 * hardware coherence.
>>> +	 */
>>> +	ACPI_COMPANION_SET(&device->dev, device);
>>> +	if (IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED) &&
>>> +	    device_get_dma_attr(&device->dev) == DEV_DMA_NOT_SUPPORTED) {
>>> +		pr_info("No ACPI _CCA found; assuming coherent device I/O\n");
>>> +		device->flags.cca_seen = true;
>>> +		device->flags.coherent_dma = true;
>>> +	}
>>
>> I'm not the biggest fan of this, especially since I'm not convinced that
>> there are any out-of-support deployments of ARM64 Hyper-V that can't be
>> updated. However I suppose it's not "real" firmware, and one Hyper-V
>> component is at liberty to hack another Hyper-V component's data if it
>> really wants to...
> 
> Agreed, it's a hack.  But Hyper-V instances are out there as part of
> Windows 10/11 on ARM64 PCs, and they run ARM64 VMs for the
> Windows Subsystem for Linux.  Microsoft gets pilloried for breaking
> stuff, and this removes the potential for that happening if someone
> runs a new Linux kernel version in that VM.

And actually that one's on me as well - for some reason I was thinking 
that this had never worked, and therefore you could likely get a Hyper-V 
update pushed out long before users get this patch through distros, but 
of course it only becomes an issue now because previously there was no 
connection to any ACPI node at all. As I said, personally I'm happy to 
consider this a Hyper-V internal workaround, but if anyone else objects 
to poking at the ACPI flags, I suppose you've also got the fallback 
option of flipping it around and making the ACPI_COMPANION_SET() 
conditional, so that the behaviour for older versions remains entirely 
unchanged. If it happens, feel free to keep my ack for that approach too.

Cheers,
Robin.

> 
> Michael
> 
>>
>> If you can hook up .dma_configure, or clarify if it wouldn't work,
>>
>> Acked-by: Robin Murphy <robin.murphy@arm.com>
>>
>> Cheers,
>> Robin.
>>
>>> +
>>>    	result = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>>>    					vmbus_walk_resources, NULL);
>>>
>>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>>> index c08758b..c05d2ce 100644
>>> --- a/include/asm-generic/mshyperv.h
>>> +++ b/include/asm-generic/mshyperv.h
>>> @@ -269,6 +269,7 @@ static inline int cpumask_to_vpset_noself(struct hv_vpset
>> *vpset,
>>>    u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
>>>    void hyperv_cleanup(void);
>>>    bool hv_query_ext_cap(u64 cap_query);
>>> +void hv_setup_dma_ops(struct device *dev, bool coherent);
>>>    void *hv_map_memory(void *addr, unsigned long size);
>>>    void hv_unmap_memory(void *addr);
>>>    #else /* CONFIG_HYPERV */
