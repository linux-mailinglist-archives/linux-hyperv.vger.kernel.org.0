Return-Path: <linux-hyperv+bounces-10987-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P7aIDS2B2o0DgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10987-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 02:11:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A69559832
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 02:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91BF5301BC2E
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 00:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EFD64A8C;
	Sat, 16 May 2026 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pqnEgP6n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B45CA52;
	Sat, 16 May 2026 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778890288; cv=none; b=FwMkCognykVkxLgUZ/kQP4/e6xBEhA6Dr88MGPgreNfxE8DdrlEyLF8MAIH9dPxMthMBadgqmeH9sEgbiVOvolnTytnQNZMtBgq8hIDB1GthI9ny1IqgyUnOlm+DqxbuA3sZFsiJzhmIa5Cctu0zH+D+9zoMFZWPHuvgAS9lffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778890288; c=relaxed/simple;
	bh=iMMYKTs0MtAf6meTZt2BHXVvX1+8zNyEKjQknw9NZ+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYoXJ66tsyPIx2VCnZd2BEmxkLX914EuSXoxCydGzc1yR2ASy0+1k3666HGh9h2jbfBLUrYHGaZhS93ePhezf7xqF6zVlZJESUUFeAsb+61J7+qCDV7V3imqnQC9aJY6llL3JVfQ1by8v80OeT2Vj63HeiawzJkAT1CatMBTX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pqnEgP6n; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4E8C320B7166;
	Fri, 15 May 2026 17:11:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E8C320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778890277;
	bh=wRm4UPHiGMIH1K4zIH9XD54Ppt6FV0jPEWJlG2DoyKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pqnEgP6ndBnLdD/vm1SvFLU8QTQNcyJMIcclpTZ0oBsVgs/p9OXG5UODl5CvSObWi
	 RBskESh/NtGLjqz8/n6cLwnSEN8oqK9ol1qMO3h+8QgVWYvmG0Lru9gTRK4Yci6w/l
	 uuB3rthzd2liibPioc/AIKr+B8jdfIYbtk6WoYd8=
Message-ID: <53754e0b-2af8-edd2-dfc0-293fac002a52@linux.microsoft.com>
Date: Fri, 15 May 2026 17:11:19 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Content-Language: en-US
To: Yu Zhang <zhangyu1@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
 "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
 "easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157FB81CC9B6347DCCC8C56D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <qeyycsdnejwrqle4zwrvkjvkvrpjifeanwxjaa7i7y2ab7rnt2@b6gvugqayarg>
 <SN6PR02MB415734108A86BDFB66AEE4CED4042@SN6PR02MB4157.namprd02.prod.outlook.com>
 <fw2pruvjgo7yigtcxssf3xv27soibsj6hmw2ls5wj4rylfhdha@e63f32cwu2x5>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <fw2pruvjgo7yigtcxssf3xv27soibsj6hmw2ls5wj4rylfhdha@e63f32cwu2x5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D9A69559832
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-10987-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,domain_id.id:url]
X-Rspamd-Action: no action

On 5/15/26 09:53, Yu Zhang wrote:
> On Fri, May 15, 2026 at 02:51:38PM +0000, Michael Kelley wrote:
>> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, May 15, 2026 7:00 AM
>>>
>>> On Thu, May 14, 2026 at 06:13:24PM +0000, Michael Kelley wrote:
>>>> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 2026 9:24 AM
>>>>>
>>>>> Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
>>>>> This driver implements stage-1 IO translation within the guest OS.
>>>>> It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
>>>>> for:
>>>>>   - Capability discovery
>>>>>   - Domain allocation, configuration, and deallocation
>>>>>   - Device attachment and detachment
>>>>>   - IOTLB invalidation
>>>>>
>>>>> The driver constructs x86-compatible stage-1 IO page tables in the
>>>>> guest memory using consolidated IO page table helpers. This allows
>>>>> the guest to manage stage-1 translations independently of vendor-
>>>>> specific drivers (like Intel VT-d or AMD IOMMU).
>>>>>
>>>>> Hyper-V consumes this stage-1 IO page table when a device domain is
>>>>> created and configured, and nests it with the host's stage-2 IO page
>>>>> tables, therefore eliminating the VM exits for guest IOMMU mapping
>>>>> operations. For unmapping operations, VM exits to perform the IOTLB
>>>>> flush are still unavoidable.
>>>>>
>>>>> Hyper-V identifies each PCI pass-thru device by a logical device ID
>>>>> in its hypercall interface. The vPCI driver (pci-hyperv) registers the
>>>>> per-bus portion of this ID with the pvIOMMU driver during bus probe.
>>>>> The pvIOMMU driver stores this mapping and combines it with the function
>>>>> number of the endpoint PCI device to form the complete ID for hypercalls.
>>>>
>>>> As you are probably aware, Mukesh's patch series to support PCI
>>>> pass-thru devices also needs to get the logical device ID. Maybe the
>>>> registration mechanism needs to move somewhere that can be shared
>>>> with his code.
>>>>
>>>
>>> Thank you so much for the review, Michael!
>>>
>>> Yes, I looked at Mukesh's series and noticed his hv_pci_vmbus_device_id()
>>> in pci-hyperv.c has the same dev_instance byte manipulation. We do need
>>> a common registration mechanism.
>>>
>>> Any suggestion on where to put it? drivers/hv/hv_common.c seems like a
>>> natural place, but the register/lookup functions are currently only
>>> meaningful when CONFIG_HYPERV_PVIOMMU is set. If Mukesh's pass-thru
>>> code also needs them, we might need a new shared Kconfig option that
>>> both can select. Open to better ideas.
>>
>> Unfortunately, I have not looked at Mukesh's series in detail yet, so
>> I don't have enough knowledge of the full situation to offer a good
>> recommendation.
>>
> 
> Sorry I forgot to Cc Mukesh in the previous reply. :(
> @Mukesh, any thoughts on sharing the logical device ID registration mechanism?

Yeah, I went round and round trying to find the best place. I almost
created virt/hyperv/hv_utils.c file. Maybe that is the best place?

Thanks,
-Mukesh


>>>
>>> [...]
>>>
>>>>> +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
>>>>> +{
>>>>> +	u64 status;
>>>>> +	unsigned long flags;
>>>>> +	struct hv_input_flush_device_domain *input;
>>>>> +
>>>>> +	local_irq_save(flags);
>>>>> +
>>>>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>>> +	memset(input, 0, sizeof(*input));
>>>>> +	input->device_domain = hv_domain->device_domain;
>>>>
>>>> The previous version of this patch had code to set several other fields in
>>>> the input. I wanted to confirm that not setting them in this version is
>>>> intentional. Were they not needed?
>>>>
>>>
>>> Oh. The RFC v1 set partition_id, owner_vtl, domain_id.type, and domain_id.id
>>> individually. In this version, I just simplified it to a struct assignment.
>>> No functional change.
>>
>> Of course! I should have looked more closely at the details before making
>> this comment. :-(
>>
>> [...]
>>
>>>>
>>>> Previous versions of this function did hv_iommu_detach_dev(). With that call
>>>> removed from here, hv_iommu_detach_dev() is only called when attaching a
>>>> domain to a device that already has a domain attached. Is it the case that
>>>> Hyper-V doesn't require the detach as a cleanup step?
>>>>
>>>
>>> The IOMMU core attaches the device to release_domain (our blocking domain)
>>> before calling release_device(), so I believe the explicit detach in the RFC
>>> was redundant. I simply didn't realize that at the time.
>>>
>>
>> Got it. But after the IOMMU core attaches the device to the blocking
>> domain, there's the possibility that the vPCI device is rescinded by
>> Hyper-V and it goes away entirely. Or the device might be subjected
>> to an "unbind/bind" cycle in Linux. Does the detach need to be done
>> on the blocking domain in such cases? In this version of the patches, the
>> Hyper-V "attach" and "detach" hypercalls still end up unbalanced. That
>> seems a bit untidy at best, and I wonder if there are scenarios where
>> Hyper-V will complain about the lack of balance.
>>
> 
> Thank you, Michael. May I ask what "the vPCI device is rescinded by
> Hyper-V and it goes away entirely" mean?
> 
> I realized it's a bit untidy. But I want to understand this issue more
> clearly first. :)
> 
> B.R.
> Yu


