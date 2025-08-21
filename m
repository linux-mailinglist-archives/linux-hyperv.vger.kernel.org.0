Return-Path: <linux-hyperv+bounces-6572-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988C8B2F420
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Aug 2025 11:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E025872D2
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Aug 2025 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933812E0936;
	Thu, 21 Aug 2025 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBqDhl2m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E6A1DF74F
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Aug 2025 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769025; cv=none; b=OZwrSE/BWAu1xjulpUho8GO4uV4vFKyObE6OqN4gbKmDCJUsRZW1tnlB1DVNcrXbcvRhZGDukHKW+kWtx1QB8nPwSNhONeIxAWwFbIEST9akDajZ3LVQ917sOfpFY/AUlWnZI2mkd+ShyOda/oc3/XdIJlNUQZbc2pmgAdeoXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769025; c=relaxed/simple;
	bh=1dZp2JL8Bi4Z8I3PjuxTlIt1IewsM5uolaKDXT2A+6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hbaeL9NWVQOjpdDCtqpp1cY2/ryn8ubeZrRWX9Ujd+ZMq8eh2k5KA9gv855x/LRYLRdL3a+WUvT0bs8z8rNIROn7E0bF1YFfl+lV5aoSopsx6uiPVTfMebtO4/L4LchfrxwTheNYOt9R8NIe//+REqxvKKs1kCf5Egm2OXeU36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBqDhl2m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755769022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJ1NqHXU57CpI7nd6LZNVkXJDN6bHaDLdcIpenLBYOg=;
	b=DBqDhl2mlnVFXoOSxVvZM4DnKZEZx5nd1wdfoy2qK4YJmfMflvEXPFUPPuywMBtISz61wE
	i+nnUtXY1x3yu11yIhQXE6HBamUPL1yNdxpOSSfWWIvk9lZQRLlq7uE7D2HYtZRRubhbAI
	wvEXUawUbdBC/4xuD0VQ1pLS+m9LbSw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-EX7HmpC-PAyrc9LdFU3xJg-1; Thu, 21 Aug 2025 05:37:00 -0400
X-MC-Unique: EX7HmpC-PAyrc9LdFU3xJg-1
X-Mimecast-MFC-AGG-ID: EX7HmpC-PAyrc9LdFU3xJg_1755769019
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9e4146aa2so341776f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Aug 2025 02:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769019; x=1756373819;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ1NqHXU57CpI7nd6LZNVkXJDN6bHaDLdcIpenLBYOg=;
        b=Xz4T37tDoTj+VgLP1yqCkXXUZcdX6CfvSQqXDtGuvb0HCr5EIEaJldoPY9EQrukMMP
         eFO7DTg/16ujcxHGSZe56ojyubutlijV7+nyzfi7wnkPVvtx2ItvhAFvcGFmZzaLw89k
         2Y0xK+6s9hOF/mwBUG1Z2jtd6yaVZ/Ap5mzpIehVXk5z9f29aWC/FvviOP6PhuTQQRb+
         Co+BQ9QrBcALY6X+YkMcZuUOy6yL/yXt6/uaoOVd+/+3zFhLbOCfApEjciIka0MiM1G8
         9DlotjXPgqCh9Te6OutpQP0+vfC0CCawnbJSxZHoWCIRkMACZ0RmwHcn/ANOjFg/dsWR
         7K8w==
X-Forwarded-Encrypted: i=1; AJvYcCVWrDvDefHxXUPdajVUoVVUCVcsDTOvRp4Q+WOJrKUvTxBmL8S5+3jdOp1ZZDD8a6fPDoypfiAyPwJzSCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3aK0vEpguxpsYx+cni2D5Afzn4l5yJ9WwCdMtQAE+bNwf8Mo
	4fWtbie2vY5qG5MsgKynOn/Wse85YhUYWaFelv3BrTXH8vlg8iafvCeg+088YY2z1npJO1wSVpE
	4p3a3axUI8rCnRvsr9FjCWRElGJK/vyv2bReChklzlpHakIVfiRPmtEN1M4W75GVOzA==
X-Gm-Gg: ASbGnctwzTF4PEVgEaUSXXl5MNNTIoGy4JubxkSHZHsqwKptEj+Fwmw+8T/5dpH/CEp
	Fn/wCb/NwlJmKOyxu8lfR/xbRhTJmSAtT8YbYNElTEZVZH5OC5ufnx5aVHRUr4/enwJUqZWbqcT
	M97VqpTwz2Qc7zY5J3yw6XKs7joAVcNN9rEFfElyCYfV4pnCD/FdEmnIODRCRflejmz4MNR12BI
	hCfBV3BrgEM15WRgLjjyLgm2d8uZ9UyYKxXf/FQprnOT2D2IUONfpldtSiewILNR81Z+jHY/w/n
	keS71a5M0X+M+6Zm6JYMLyATJJumTG+iTz8=
X-Received: by 2002:a05:6000:2411:b0:3b7:8146:4640 with SMTP id ffacd0b85a97d-3c4977414d6mr1508073f8f.56.1755769018658;
        Thu, 21 Aug 2025 02:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtPJS6UfWlgJd2AHPUnsMetevT2NI9PYc9OLrDN5lDzBrt9+5QyFybKNVcobSwBwJ6LHIxQA==
X-Received: by 2002:a05:6000:2411:b0:3b7:8146:4640 with SMTP id ffacd0b85a97d-3c4977414d6mr1508039f8f.56.1755769018019;
        Thu, 21 Aug 2025 02:36:58 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c520d37833sm791289f8f.45.2025.08.21.02.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:36:57 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nuno Das
 Neves <nunodasneves@linux.microsoft.com>, Tianyu Lan
 <tiala@microsoft.com>, Li Tian <litian@redhat.com>, Philipp Rudo
 <prudo@redhat.com>
Subject: RE: [PATCH v2] x86/hyperv: Fix kdump on Azure CVMs
In-Reply-To: <SN6PR02MB415738B7E821D2EF6F19B4E1D430A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250818095400.1610209-1-vkuznets@redhat.com>
 <SN6PR02MB415738B7E821D2EF6F19B4E1D430A@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Thu, 21 Aug 2025 11:36:56 +0200
Message-ID: <877byxm2x3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Kelley <mhklinux@outlook.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Monday, August 18, 2025 2:54 AM
>> 
>> Azure CVM instance types featuring a paravisor hang upon kdump. The
>> investigation shows that makedumpfile causes a hang when it steps on a page
>> which was previously share with the host
>> (HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY). The new kernel has no
>> knowledge of these 'special' regions (which are Vmbus connection pages,
>> GPADL buffers, ...). There are several ways to approach the issue:
>> - Convey the knowledge about these regions to the new kernel somehow.
>> - Unshare these regions before accessing in the new kernel (it is unclear
>> if there's a way to query the status for a given GPA range).
>> - Unshare these regions before jumping to the new kernel (which this patch
>> implements).
>> 
>> To make the procedure as robust as possible, store PFN ranges of shared
>> regions in a linked list instead of storing GVAs and re-using
>> hv_vtom_set_host_visibility(). This also allows to avoid memory allocation
>> on the kdump/kexec path.
>> 
>> The patch skips implementing weird corner case in hv_list_enc_remove()
>> when a PFN in the middle of a region is unshared. First, it is unlikely
>> that such requests happen. Second, it is not a big problem if
>> hv_list_enc_remove() doesn't actually remove some regions as this will
>> only result in an extra hypercall doing nothing upon kexec/kdump; there's
>> no need to be perfect.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> Changes since v1:
>>  - fix build on ARM [kernel test robot]
>> ---
>>  arch/arm64/include/asm/mshyperv.h |   3 +
>>  arch/x86/hyperv/ivm.c             | 153 ++++++++++++++++++++++++++++++
>>  arch/x86/include/asm/mshyperv.h   |   2 +
>>  drivers/hv/vmbus_drv.c            |   2 +
>>  4 files changed, 160 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index b721d3134ab6..af11abf403b4 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -53,6 +53,9 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
>>  	return hv_get_msr(reg);
>>  }
>> 
>> +/* Isolated VMs are unsupported on ARM, no cleanup needed */
>> +static inline void hv_ivm_clear_host_access(void) {}
>

Michael!

Thanks a bunch for your detailed review!

> Stubs such as this should be handled differently. We've instead
> put __weak stubs in drivers/hv/hv_common.c, and let x86 code
> override. That approach avoids needing to update arch/arm64
> code and to get acks from arm64 maintainers for functionality that
> is (currently) x86-only. arch/arm64/include/asm/mshyperv.h is
> pretty small because of this approach.
>
> For consistency, this stub should follow that existing pattern. See
> hv_is_isolation_supported() as an example.
>

Sure, will switch to __weak.

>> +
>>  /* SMCCC hypercall parameters */
>>  #define HV_SMCCC_FUNC_NUMBER	1
>>  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index ade6c665c97e..a6e614672836 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -462,6 +462,150 @@ void hv_ivm_msr_read(u64 msr, u64 *value)
>>  		hv_ghcb_msr_read(msr, value);
>>  }
>> 
>> +/*
>> + * Keep track of the PFN regions which were shared with the host. The access
>> + * must be revoked upon kexec/kdump (see hv_ivm_clear_host_access()).
>> + */
>> +struct hv_enc_pfn_region {
>> +	struct list_head list;
>> +	u64 pfn;
>> +	int count;
>> +};
>
> I'm wondering if there's an existing kernel data structure that would handle
> the requirements here. Did you look at using xarray()? It's probably not as
> memory efficient since it presumably needs a separate entry for each PFN,
> whereas your code below uses a single entry for a range of PFNs. But
> maybe that's a worthwhile tradeoff to simplify the code and avoid some
> of the messy issues I point out below.  Just a thought ....

I thought about it before I looked at how these regions really look
like. Here's what I see on a DC2ads instance upon kdump (with debug
printk added):

[   37.255921] hv_ivm_clear_host_access: PFN_START: 102548 COUNT:8
[   37.256833] hv_ivm_clear_host_access: PFN_START: 10bc60 COUNT:16
[   37.257743] hv_ivm_clear_host_access: PFN_START: 10bd00 COUNT:256
[   37.259177] hv_ivm_clear_host_access: PFN_START: 10ada0 COUNT:255
[   37.260639] hv_ivm_clear_host_access: PFN_START: 1097e8 COUNT:24
[   37.261630] hv_ivm_clear_host_access: PFN_START: 103ce3 COUNT:45
[   37.262741] hv_ivm_clear_host_access: PFN_START: 103ce1 COUNT:1

... 57 more items with 1-4 PFNs ...

[   37.320659] hv_ivm_clear_host_access: PFN_START: 103c98 COUNT:1
[   37.321611] hv_ivm_clear_host_access: PFN_START: 109d00 COUNT:4199
[   37.331656] hv_ivm_clear_host_access: PFN_START: 10957f COUNT:129
[   37.332902] hv_ivm_clear_host_access: PFN_START: 103c9b COUNT:2
[   37.333811] hv_ivm_clear_host_access: PFN_START: 1000 COUNT:256
[   37.335066] hv_ivm_clear_host_access: PFN_START: 100 COUNT:256
[   37.336340] hv_ivm_clear_host_access: PFN_START: 100e00 COUNT:256
[   37.337626] hv_ivm_clear_host_access: PFN_START: 7b000 COUNT:131072

Overall, the liked list contains 72 items of 32 bytes each so we're
consuming 2k of extra memory. Handling of such a short list should also
be pretty fast.

If we switch to handling each PFN separately, that would be 136862
items. I'm not exactly sure about xarray's memory consumption but I'm
afraid we are talking megabytes for this case. This is the price
every CVM user is going to pay. Also, the chance of getting into
(interim) memory allocation problems is going to be much higher.

>
>> +
>> +static LIST_HEAD(hv_list_enc);
>> +static DEFINE_RAW_SPINLOCK(hv_list_enc_lock);
>> +
>> +static int hv_list_enc_add(const u64 *pfn_list, int count)
>> +{
>> +	struct hv_enc_pfn_region *ent;
>> +	unsigned long flags;
>> +	bool found = false;
>> +	u64 pfn;
>> +	int i;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		pfn = pfn_list[i];
>> +
>> +		found = false;
>> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
>> +		list_for_each_entry(ent, &hv_list_enc, list) {
>> +			if ((ent->pfn <= pfn) && (ent->pfn + ent->count - 1 >= pfn)) {
>> +				/* Nothin to do - pfn is already in the list */
>
> s/Nothin/Nothing/
>
>> +				found = true;
>> +			} else if (ent->pfn + ent->count == pfn) {
>> +				/* Grow existing region up */
>> +				found = true;
>> +				ent->count++;
>> +			} else if (pfn + 1 == ent->pfn) {
>> +				/* Grow existing region down */
>> +				found = true;
>> +				ent->pfn--;
>> +				ent->count++;
>> +			}
>
> Observations that might be worth a comment here in the code:
> After a region is grown up or down, there's no check to see if the
> region is now adjacent to an existing region. Additionally, if a PFN
> that is already in some region is added, it might get appended to
> some other adjacent region that occurs earlier in the list, rather than
> being recognized as a duplicate. Hence the PFN could be included
> in two different regions.

Having two regions which can be merged should not be a problem but the
fact that we can have the same PFN in two regions is. I think I can
solve this by checking for existence first and doing the addition only
if the PFN was not found.

>
>> +		};
>> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
>> +
>> +		if (found)
>> +			continue;
>> +
>> +		/* No adajacent region found -- creating a new one */
>
> s/adajacent/adjacent/
>
>> +		ent = kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
>> +		if (!ent)
>> +			return -ENOMEM;
>> +
>> +		ent->pfn = pfn;
>> +		ent->count = 1;
>> +
>> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
>> +		list_add(&ent->list, &hv_list_enc);
>> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void hv_list_enc_remove(const u64 *pfn_list, int count)
>> +{
>> +	struct hv_enc_pfn_region *ent, *t;
>> +	unsigned long flags;
>> +	u64 pfn;
>> +	int i;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		pfn = pfn_list[i];
>> +
>> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
>> +		list_for_each_entry_safe(ent, t, &hv_list_enc, list) {
>> +			if (pfn == ent->pfn + count - 1) {
>
> This should be:
> 			if (pfn == ent->pfn + ent->count - 1) {
>
>> +				/* Removing tail pfn */
>> +				ent->count--;
>> +				if (!ent->count) {
>> +					list_del(&ent->list);
>> +					kfree(ent);
>> +				}
>> +			} else if (pfn == ent->pfn) {
>> +				/* Removing head pfn */
>> +				ent->count--;
>> +				ent->pfn++;
>> +				if (!ent->count) {
>> +					list_del(&ent->list);
>> +					kfree(ent);
>> +				}
>
> Apropos my comment on hv_list_enc_add(), if a PFN does appear in
> more than one region, this code removes it from all such regions.
>
>> +			}
>> +
>> +			/*
>> +			 * Removing PFNs in the middle of a region is not implemented; the
>> +			 * list is currently only used for cleanup upon kexec and there's
>> +			 * no harm done if we issue an extra unneeded hypercall making some
>> +			 * region encrypted when it already is.
>> +			 */
>
> In working with Hyper-V CVMs, I have never been entirely clear on whether the
> HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY hypercall is idempotent.
> Consequently, in other parts of the code, we've made sure not to re-encrypt
> memory that is already encrypted. There may have been some issues back in the
> early days of CVMs that led to me think that it is not idempotent, but I don't
> remember for sure.
>
> Do you have a particular basis for asserting that it is idempotent? I just ran an
> experiment on a TDX and a SEV-SNP VM in Azure, and the behavior is idempotent
> in both cases, so that's good. But both are configurations with a paravisor, which
> intercepts the hypercall and then makes its own decision about whether to invoke
> the hypervisor. I don't have the ability to run configurations with no paravisor, and
> see whether the hypercall as implemented by the hypervisor is idempotent. Also,
> there's the new OpenHCL paravisor that similarly intercepts the hypercall, and 
> its behavior could be different.
>
> Lacking a spec for any of this, it's hard to know what behavior can be depended
> upon. Probably should get clarity from someone at Microsoft who can
> check.

I'm only relying on the results of my experiments, unfortunately. It
would be great indeed to see HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY's 
documentation. At the same time, with your comments I'm leaning towards
implementing the corner case which I highlight above even though we
don't see such cases now: hypervisor's behavior may change in the
future, drivers may start doing weird things, ... Better safe than sorry.

>
>> +		};
>> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
>> +	}
>> +}
>> +
>> +void hv_ivm_clear_host_access(void)
>> +{
>> +	struct hv_gpa_range_for_visibility *input;
>> +	struct hv_enc_pfn_region *ent;
>> +	unsigned long flags;
>> +	u64 hv_status;
>> +	int cur, i;
>> +
>> +	if (!hv_is_isolation_supported())
>> +		return;
>> +
>> +	raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
>> +
>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	if (!input)
>> +		goto unlock;
>
> The latest hyperv-next tree has code changes in how the
> per-cpu hypercall input arg is handled. Check it for examples.
>
>> +
>> +	list_for_each_entry(ent, &hv_list_enc, list) {
>> +		for (i = 0, cur = 0; i < ent->count; i++) {
>> +			input->gpa_page_list[cur] = ent->pfn + i;
>> +			cur++;
>> +
>> +			if (cur == HV_MAX_MODIFY_GPA_REP_COUNT || i == ent->count - 1) {
>> +				input->partition_id = HV_PARTITION_ID_SELF;
>> +				input->host_visibility = VMBUS_PAGE_NOT_VISIBLE;
>> +				input->reserved0 = 0;
>> +				input->reserved1 = 0;
>> +				hv_status = hv_do_rep_hypercall(
>> +					HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY,
>> +					cur, 0, input, NULL);
>> +				WARN_ON_ONCE(!hv_result_success(hv_status));
>> +				cur = 0;
>> +			}
>> +		}
>> +
>> +	};
>> +
>> +unlock:
>> +	raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(hv_ivm_clear_host_access);
>> +
>>  /*
>>   * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
>>   *
>> @@ -475,6 +619,7 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
>>  	struct hv_gpa_range_for_visibility *input;
>>  	u64 hv_status;
>>  	unsigned long flags;
>> +	int ret;
>> 
>>  	/* no-op if partition isolation is not enabled */
>>  	if (!hv_is_isolation_supported())
>> @@ -486,6 +631,14 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
>>  		return -EINVAL;
>>  	}
>> 
>> +	if (visibility == VMBUS_PAGE_NOT_VISIBLE) {
>> +		hv_list_enc_remove(pfn, count);
>> +	} else {
>> +		ret = hv_list_enc_add(pfn, count);
>> +		if (ret)
>> +			return ret;
>> +	}
>
> What's the strategy if there's a failure from the hypercall
> further down in this function? The list could then be out-of-sync
> with what the paravisor/hypervisor thinks.

I wrote this under the assumption that extra items on the list is not a
problem but this is changing. What we don't really know is what
HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY failure actually means: if
we gave it a list of PFNs and it managed to change the visibilisy of
some of them before it hits a problem: will it revert back or do we end
in an inconsistent state? In case it's the later, I think that broken
accounting is not the only problem we have. So let's assume it's 'all or
nothing'.

>
>> +
>>  	local_irq_save(flags);
>>  	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> 
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index abc4659f5809..6a988001e46f 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -263,10 +263,12 @@ static inline int hv_snp_boot_ap(u32 apic_id, unsigned long
>> start_ip,
>>  void hv_vtom_init(void);
>>  void hv_ivm_msr_write(u64 msr, u64 value);
>>  void hv_ivm_msr_read(u64 msr, u64 *value);
>> +void hv_ivm_clear_host_access(void);
>>  #else
>>  static inline void hv_vtom_init(void) {}
>>  static inline void hv_ivm_msr_write(u64 msr, u64 value) {}
>>  static inline void hv_ivm_msr_read(u64 msr, u64 *value) {}
>> +static inline void hv_ivm_clear_host_access(void) {}
>>  #endif
>> 
>>  static inline bool hv_is_synic_msr(unsigned int reg)
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 2ed5a1e89d69..2e891e108218 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -2784,6 +2784,7 @@ static void hv_kexec_handler(void)
>>  	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
>>  	mb();
>>  	cpuhp_remove_state(hyperv_cpuhp_online);
>
> At this point, all vCPUs are still running. Changing the state of decrypted pages
> to encrypted has the potential to upset code running on those other vCPUs.
> They might try to access a page that has become encrypted using a PTE that
> indicates decrypted. And changing a page from decrypted to encrypted changes
> the memory contents of the page that would be seen by the other vCPU.
> Either situation could cause a panic, and ruin the kexec().
>
> It seems to me that it would be safer to do hv_ivm_clear_host_access()
> at the beginning of hyperv_cleanup(), before clearing the guest OS ID
> and the hypercall page. But maybe there's a reason that doesn't work
> that I'm missing.

I agree hyperv_cleanup() looks like a more suitable place, will move!

>
>> +	hv_ivm_clear_host_access();
>>  };
>> 
>>  static void hv_crash_handler(struct pt_regs *regs)
>> @@ -2799,6 +2800,7 @@ static void hv_crash_handler(struct pt_regs *regs)
>>  	cpu = smp_processor_id();
>>  	hv_stimer_cleanup(cpu);
>>  	hv_synic_disable_regs(cpu);
>
> Same here about waiting until only one vCPU is running.
>
>> +	hv_ivm_clear_host_access();
>>  };
>> 
>>  static int hv_synic_suspend(void)
>> --
>> 2.50.0
>

Thanks for the feedback, will try to address in v3!

-- 
Vitaly


