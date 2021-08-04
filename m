Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B903DFBB0
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Aug 2021 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhHDHEQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Aug 2021 03:04:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39738 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbhHDHEN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Aug 2021 03:04:13 -0400
Received: from [192.168.1.87] (unknown [223.178.56.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2C02F20B36E0;
        Wed,  4 Aug 2021 00:03:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C02F20B36E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628060640;
        bh=9ZaqFTUSUabTOCq0gU0pkK9jc2pEBX00jmp+GcZOv0g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JHIEvDfmp/H7TPFi3UdGVZV5txesuMGg+GjVhE4Jx7Xljpo0hIVLuneKK/qsbLfLm
         zs5+T6qQbrLgMqQSh9cbdsu1Bb5/KjbY6RPzr4A4WlW4CuC9bLlCVUIE1HuFqgG3r0
         Ors/l3/xf672Y0iQsGVu3qb7pyPhE38/p4VW+cOs=
Subject: Re: [RFC v1 6/8] mshv: command line option to skip devices in
 PV-IOMMU
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
 <4a6918ea-e3e5-55c9-a12d-bee7261301fd@linux.microsoft.com>
 <20210803215617.fzx2vrzhsabrrolc@liuwe-devbox-debian-v2>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <8d9b6b9a-62b1-95ea-1bb6-258e72c1800d@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 12:33:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803215617.fzx2vrzhsabrrolc@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 04-08-2021 03:26, Wei Liu wrote:
>>>  	struct iommu_domain domain;
>>> @@ -774,6 +784,41 @@ static struct iommu_device *hv_iommu_probe_device(struct device *dev)
>>>  	if (!dev_is_pci(dev))
>>>  		return ERR_PTR(-ENODEV);
>>>  
>>> +	/*
>>> +	 * Skip the PCI device specified in `pci_devs_to_skip`. This is a
>>> +	 * temporary solution until we figure out a way to extract information
>>> +	 * from the hypervisor what devices it is already using.
>>> +	 */
>>> +	if (pci_devs_to_skip && *pci_devs_to_skip) {
>>> +		int pos = 0;
>>> +		int parsed;
>>> +		int segment, bus, slot, func;
>>> +		struct pci_dev *pdev = to_pci_dev(dev);
>>> +
>>> +		do {
>>> +			parsed = 0;
>>> +
>>> +			sscanf(pci_devs_to_skip + pos,
>>> +				" (%x:%x:%x.%x) %n",
>>> +				&segment, &bus, &slot, &func, &parsed);
>>> +
>>> +			if (parsed <= 0)
>>> +				break;
>>> +
>>> +			if (pci_domain_nr(pdev->bus) == segment &&
>>> +				pdev->bus->number == bus &&
>>> +				PCI_SLOT(pdev->devfn) == slot &&
>>> +				PCI_FUNC(pdev->devfn) == func)
>>> +			{
>>> +				dev_info(dev, "skipped by MSHV IOMMU\n");
>>> +				return ERR_PTR(-ENODEV);
>>> +			}
>>> +
>>> +			pos += parsed;
>>> +
>>> +		} while (pci_devs_to_skip[pos]);
>>
>> Is there a possibility of pci_devs_to_skip + pos > sizeof(pci_devs_to_skip)
>> and also a valid memory ?
> 
> pos should point to the last parsed position. If parsing fails pos does
> not get updated and the code breaks out of the loop. If parsing is
> success pos should point to either the start of next element of '\0'
> (end of string). To me this is good enough.

The point is, hypothetically the address to pci_devs_to_skip + pos can be valid address (later to '\0'), and thus there is a possibility, that parsing may not fail.
Another, there is also a possibility of sscanf faulting accessing the illegal address, if pci_devs_to_skip[pos] turns out to be not NULL or valid address.

> 
>> I would recommend to have a check of size as well before accessing the
>> array content, just to be safer accessing any memory.
>>
> 
> What check do you have in mind?

Something like,
size_t len = strlen(pci_devs_to_skip);
do {

	len -= parsed;
} while (len);

OR

do {
...
	pos += parsed;
} while (pos < len);

Further, I'm also fine with the existing code, if you think this won't break and already been taken care. Thanks.

Regards,

~Praveen.
