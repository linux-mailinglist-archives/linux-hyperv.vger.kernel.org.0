Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5FB4E636F
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Mar 2022 13:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbiCXMgt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Mar 2022 08:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiCXMgt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Mar 2022 08:36:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5950C0F;
        Thu, 24 Mar 2022 05:35:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57BF11FB;
        Thu, 24 Mar 2022 05:35:16 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B9F03F73D;
        Thu, 24 Mar 2022 05:35:12 -0700 (PDT)
Message-ID: <b56621da-0f8a-06d5-15a1-7034e4274620@arm.com>
Date:   Thu, 24 Mar 2022 12:35:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] PCI: hv: Propagate coherence from VMbus device to
 PCI device
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, hch@lst.de, m.szyprowski@samsung.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
 <1648067472-13000-3-git-send-email-mikelley@microsoft.com>
 <e6d9af22-df69-bf6a-7877-b916918d0682@arm.com>
In-Reply-To: <e6d9af22-df69-bf6a-7877-b916918d0682@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2022-03-24 12:23, Robin Murphy wrote:
> On 2022-03-23 20:31, Michael Kelley wrote:
>> PCI pass-thru devices in a Hyper-V VM are represented as a VMBus
>> device and as a PCI device.  The coherence of the VMbus device is
>> set based on the VMbus node in ACPI, but the PCI device has no
>> ACPI node and defaults to not hardware coherent.  This results
>> in extra software coherence management overhead on ARM64 when
>> devices are hardware coherent.
>>
>> Fix this by setting up the PCI host bus so that normal
>> PCI mechanisms will propagate the coherence of the VMbus
>> device to the PCI device. There's no effect on x86/x64 where
>> devices are always hardware coherent.
> 
> Honestly, I don't hate this :)
> 
> It seems conceptually accurate, as far as I understand, and in 
> functional terms I'm starting to think it might even be the most correct 
> approach anyway. In the physical world we might be surprised to find the 
> PCI side of a host bridge

And of course by "the PCI side of a host bridge" I think I actually mean 
"a PCI root bus", because in my sloppy terminology I'm thinking about 
hardware bridging from PCI(e) to some SoC-internal protocol, which does 
not have to imply an actual PCI-visible Host Bridge device...

Robin.

> behind anything other than some platform/ACPI 
> device representing the other side of a physical host bridge or root 
> complex, but who's to say that a paravirtual world can't present a more 
> abstract topology? Either way, a one-line way of tying in to the 
> standard flow is hard to turn down.
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>> ---
>>   drivers/pci/controller/pci-hyperv.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c 
>> b/drivers/pci/controller/pci-hyperv.c
>> index ae0bc2f..88b3b56 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -3404,6 +3404,15 @@ static int hv_pci_probe(struct hv_device *hdev,
>>       hbus->bridge->domain_nr = dom;
>>   #ifdef CONFIG_X86
>>       hbus->sysdata.domain = dom;
>> +#elif defined(CONFIG_ARM64)
>> +    /*
>> +     * Set the PCI bus parent to be the corresponding VMbus
>> +     * device. Then the VMbus device will be assigned as the
>> +     * ACPI companion in pcibios_root_bridge_prepare() and
>> +     * pci_dma_configure() will propagate device coherence
>> +     * information to devices created on the bus.
>> +     */
>> +    hbus->sysdata.parent = hdev->device.parent;
>>   #endif
>>       hbus->hdev = hdev;
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
