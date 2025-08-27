Return-Path: <linux-hyperv+bounces-6610-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD0EB382DA
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Aug 2025 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696981BA0F3A
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Aug 2025 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66141321440;
	Wed, 27 Aug 2025 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ib8rL5CV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A22E2DC1
	for <linux-hyperv@vger.kernel.org>; Wed, 27 Aug 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299056; cv=none; b=ZAAqvFp7A6qqsflwBcdBhrUL51mV6WyBYwT32htdxQ9hElPeOAR+Vz38bJZiFfADp8YXfj8u+yrRWsPnrLT3iXvAfj6OGbbTiIhnBiCHalF/tSo6jsd5opISmRjT+2O4L487qUiXDKRpLyT4lAHjlbz4jvLD/GuBDT66LWJRqvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299056; c=relaxed/simple;
	bh=COUR0B6CWmGyYP6wkHnxjPuMDws0/vquIDccin2shww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BMFDUELZFBtUWikHarEI3dQOSnYXNN5ZkuSDAsD0x6op7qAij5cXW8EaehLqX8ymqGzOIH1YOdufSEc4/V9rYeuc/IL+dSYybg5/2p3sYSDEICxKp0QhHdMuHZ05Un240xPnhlWv8df+ac1UfOKWspA9tu7Q09NZ17dGnfRfX3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ib8rL5CV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756299053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8MX04UHub//j4USm2BfIau1LRInDZRUGwvpc14VGzUU=;
	b=Ib8rL5CVIqR6ZLnzWp6M+w3AxZZ0XYzAW3MaZrpagCXAekfGEqZMDif3Vf5xNYTyLPp/yp
	W8CmoBsTkL0Tfyqr3ueKc4dnzTNUe201LFoGW6Fz+i9txlxvPD0jiFdp7m3qUtGf8gDWsp
	yQth8wsKCn6SuekHZNiaZNpD8khxikY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-QWer73rgNHCn5P6T72ISpA-1; Wed, 27 Aug 2025 08:50:51 -0400
X-MC-Unique: QWer73rgNHCn5P6T72ISpA-1
X-Mimecast-MFC-AGG-ID: QWer73rgNHCn5P6T72ISpA_1756299051
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870623cdaso1429672385a.2
        for <linux-hyperv@vger.kernel.org>; Wed, 27 Aug 2025 05:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299051; x=1756903851;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MX04UHub//j4USm2BfIau1LRInDZRUGwvpc14VGzUU=;
        b=Ulq++pshy7BZAmv4dJTpLBEmGdd60odKKxXfbuIgztXREukUUEg5dJywNGfNv55iGB
         M3HrE2mmaMWf3/rWFgv1YUiruPuoS+3TAcSj29V+bomU4Wz2bGu4oZVpHJhpadOuS8HO
         qkaTBEyIZG9i5hhAV9Aa6ta4zuL1i8LBwD3dnLfzwDWCyv4b+zNkXDe/JXaq3pj8BlnQ
         VRwkeWJc6sONneDPFle7euZGOrJP8XQ4Gs733yLyja2mn/gGPRmmS5Cgdsih7inu3McH
         ZwGKRpTzceFDzoOicWcjj1L5KhEOkO1Gf1e9n7LsVxLCgOi+XTj5eIXW2RWZCKdk8/LK
         JRnA==
X-Forwarded-Encrypted: i=1; AJvYcCU4kFeu+VAVeTluVb9NigrnAlc9dBGQiU4H0OwaS79P52DkK2wSMqYsw8XlU5oMMex+u8gZAHrQVVGpafI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4847zB4caE3kQTIK+p0OP/6+kfJKS4L0M2ijLEiBzYDRmJR2
	ZEGdkr8J8t01pDd29mYumw/0EjgfdRn0ouqZN4YotWnnHLuthDqpZAfS8uxR9exIzpDe5/lALYz
	gPxxhazq6eacOnt4dZQeFXTUNBkADo7PtQg5snnMZy37rIy7KT6KEOuFoC0bQ+hNRmA==
X-Gm-Gg: ASbGnctPiEMvgGu9jla5SICnnKK9LS/lM+UTAYAWws52zl6ktwpfI9CbwoJKXsKWGi7
	TObUqmlnvYl1ptxCrrG1RW+81qs55q+OK63vhYYrPJB5euvkZv6I+cXu4kH5KQhW1RMOw34/zZU
	OmRh7wffv1Qe724+PtJmK2FtuggOGKo/94IOGTEa0bCiUUfPSOM+yDpfvv2oQWMSUXJ7P32u+dg
	CenkeXl48H0uFHgOeC33+4zNO9OddABV59yNL4Jg97wsPIYSLuLFkOuDFkDyQY7gA+QKxQ3VJah
	T2985045ZMVCD5YOYkFTibneH54PxW3J
X-Received: by 2002:a05:620a:400f:b0:7e8:507e:3b2d with SMTP id af79cd13be357-7ea1101ab06mr2360767085a.53.1756299050362;
        Wed, 27 Aug 2025 05:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvPsShUkZLvYsUkRnoODQITq8zvEOfgIS3gdL5VnaG4te2zR0xwymsPk+4mu4XC8pwqxoxyw==
X-Received: by 2002:a05:620a:400f:b0:7e8:507e:3b2d with SMTP id af79cd13be357-7ea1101ab06mr2360764085a.53.1756299049793;
        Wed, 27 Aug 2025 05:50:49 -0700 (PDT)
Received: from fedora ([185.49.128.238])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7f2d292e466sm476966885a.41.2025.08.27.05.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:50:49 -0700 (PDT)
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
Subject: RE: [PATCH v3] x86/hyperv: Fix kdump on Azure CVMs
In-Reply-To: <SN6PR02MB4157581777244FE17DA3C7C2D438A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250821151655.3051386-1-vkuznets@redhat.com>
 <SN6PR02MB4157581777244FE17DA3C7C2D438A@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Wed, 27 Aug 2025 15:50:44 +0300
Message-ID: <878qj5dj2z.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Kelley <mhklinux@outlook.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, August 21, 2025 8:17 AM
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
>
> This last paragraph is left over from the previous version. It's no
> longer correct and should be removed.
>

Indeed, will drop!

>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> Changes since v2 [Michael Kelley]:
>>  - Rebase to hyperv-next.
>>  - Move hv_ivm_clear_host_access() call to hyperv_cleanup(). This also
>>    makes ARM stub unneeded.
>>  - Implement the missing corner case in hv_list_enc_remove(). With this,
>>    the math should (hopefully!) always be correct so we don't rely on
>>    the idempotency of HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY
>>    hypercall. As the case is not something we see, I tested the code
>>    with a few synthetic tests.
>>  - Fix the math in hv_list_enc_remove() (count -> ent->count).
>>  - Typos.
>> ---
>>  arch/x86/hyperv/hv_init.c       |   3 +
>>  arch/x86/hyperv/ivm.c           | 213 ++++++++++++++++++++++++++++++--
>>  arch/x86/include/asm/mshyperv.h |   2 +
>>  3 files changed, 210 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 2979d15223cf..4bb1578237eb 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -596,6 +596,9 @@ void hyperv_cleanup(void)
>>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>>  	union hv_reference_tsc_msr tsc_msr;
>> 
>> +	/* Retract host access to shared memory in case of isolation */
>> +	hv_ivm_clear_host_access();
>> +
>>  	/* Reset our OS id */
>>  	wrmsrq(HV_X64_MSR_GUEST_OS_ID, 0);
>>  	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
>> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
>> index 3084ae8a3eed..0d74156ad6a7 100644
>> --- a/arch/x86/hyperv/ivm.c
>> +++ b/arch/x86/hyperv/ivm.c
>> @@ -462,6 +462,188 @@ void hv_ivm_msr_read(u64 msr, u64 *value)
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
>> +
>> +static LIST_HEAD(hv_list_enc);
>> +static DEFINE_RAW_SPINLOCK(hv_list_enc_lock);
>> +
>> +static int hv_list_enc_add(const u64 *pfn_list, int count)
>> +{
>> +	struct hv_enc_pfn_region *ent;
>> +	unsigned long flags;
>> +	u64 pfn;
>> +	int i;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		pfn = pfn_list[i];
>> +
>> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
>> +		/* Check if the PFN already exists in some region first */
>> +		list_for_each_entry(ent, &hv_list_enc, list) {
>> +			if ((ent->pfn <= pfn) && (ent->pfn + ent->count - 1 >= pfn))
>> +				/* Nothing to do - pfn is already in the list */
>> +				goto unlock_done;
>> +		}
>> +
>> +		/*
>> +		 * Check if the PFN is adjacent to an existing region. Growing
>> +		 * a region can make it adjacent to another one but merging is
>> +		 * not (yet) implemented for simplicity. A PFN cannot be added
>> +		 * to two regions to keep the logic in hv_list_enc_remove()
>> +		 * correct.
>> +		 */
>> +		list_for_each_entry(ent, &hv_list_enc, list) {
>> +			if (ent->pfn + ent->count == pfn) {
>> +				/* Grow existing region up */
>> +				ent->count++;
>> +				goto unlock_done;
>> +			} else if (pfn + 1 == ent->pfn) {
>> +				/* Grow existing region down */
>> +				ent->pfn--;
>> +				ent->count++;
>> +				goto unlock_done;
>> +			}
>> +		}
>> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
>> +
>> +		/* No adjacent region found -- create a new one */
>> +		ent = kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
>> +		if (!ent)
>> +			return -ENOMEM;
>> +
>> +		ent->pfn = pfn;
>> +		ent->count = 1;
>> +
>> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
>> +		list_add(&ent->list, &hv_list_enc);
>> +
>> +unlock_done:
>> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void hv_list_enc_remove(const u64 *pfn_list, int count)
>> +{
>> +	struct hv_enc_pfn_region *ent, *t;
>> +	struct hv_enc_pfn_region new_region;
>> +	unsigned long flags;
>> +	u64 pfn;
>> +	int i;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		pfn = pfn_list[i];
>> +
>> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
>> +		list_for_each_entry_safe(ent, t, &hv_list_enc, list) {
>> +			if (pfn == ent->pfn + ent->count - 1) {
>> +				/* Removing tail pfn */
>> +				ent->count--;
>> +				if (!ent->count) {
>> +					list_del(&ent->list);
>> +					kfree(ent);
>> +				}
>> +				goto unlock_done;
>> +			} else if (pfn == ent->pfn) {
>> +				/* Removing head pfn */
>> +				ent->count--;
>> +				ent->pfn++;
>> +				if (!ent->count) {
>> +					list_del(&ent->list);
>> +					kfree(ent);
>> +				}
>> +				goto unlock_done;
>> +			} else if (pfn > ent->pfn && pfn < ent->pfn + ent->count - 1) {
>> +				/*
>> +				 * Removing a pfn in the middle. Cut off the tail
>> +				 * of the existing region and create a template for
>> +				 * the new one.
>> +				 */
>> +				new_region.pfn = pfn + 1;
>> +				new_region.count = ent->count - (pfn - ent->pfn + 1);
>> +				ent->count = pfn - ent->pfn;
>> +				goto unlock_split;
>> +			}
>> +
>> +		}
>> +unlock_done:
>> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
>> +		continue;
>> +
>> +unlock_split:
>> +		raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
>> +
>> +		ent = kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KERNEL);
>> +		/*
>> +		 * There is no apparent good way to recover from -ENOMEM
>> +		 * situation, the accouting is going to be wrong either way.
>> +		 * Proceed with the rest of the list to make it 'less wrong'.
>> +		 */
>> +		if (WARN_ON_ONCE(!ent))
>> +			continue;
>> +
>> +		ent->pfn = new_region.pfn;
>> +		ent->count = new_region.count;
>> +
>> +		raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
>> +		list_add(&ent->list, &hv_list_enc);
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
>> +	int batch_size, cur, i;
>> +
>> +	if (!hv_is_isolation_supported())
>> +		return;
>
> I seem to recall that some separate work has been done
> to support kexec/kdump for the more generic SEV-SNP and
> TDX cases where there's no paravisor mediating. I haven't
> gone looking for that code to see when it runs. 
> hv_ivm_clear_host_access() is needed to update the
> paravisor records about the page state, but if other code
> has already updated the hypervisor/processor state, that
> might be problematic. If this runs first, then the more
> generic code will presumably find nothing to do, which
> should be OK.
>
> I'll try to go look further at this situation, unless you already
> have. If necessary, this function could be gated to run
> only when a paravisor is present.

Yes, there are SEV-SNP and TDX specific
snp_kexec_finish()/tdx_kexec_finish() which do memory unsharing but I
convinced myself that these are not called on Azure CVM which uses
paravisor. In particular, for SEV-SNP 'sme_me_mask == 0' in
sme_early_init(). 

I have to admit I've never seen an Azure/Hyper-V CVM without a
paravisor, but I agree it may make sense to hide all this tracking and
cleanup logic under 'if (hyperv_paravisor_present)' (or even 'if
(hv_is_isolation_supported() && hyperv_paravisor_present)').

>
>> +
>> +	raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
>
> Since this function is now called after other CPUs have
> been stopped, the spin lock is no longer necessary, unless
> you were counting on it to provide the interrupt disable
> needed for accessing the per-cpu hypercall argument page.
> But even then, I'd suggest just doing the interrupt disable
> instead of the spin lock so there's no chance of the
> panic or kexec path getting hung waiting on the spin lock.

Makes sense, will do.

>
> There's also a potentially rare problem if other CPUs are
> stopped while hv_list_enc_add() or hv_list_nec_remove()
> is being executed. The list might be inconsistent, or not
> fully reflect what the paravisor and hypervisor think about
> the private/shared state of the page. But I don't think there's
> anything we can do about that. Again, I'd suggest a code
> comment acknowledging this case, and that there's nothing
> that can be done.

True, will add a comment. Just like with a lot of other corner cases in
panic, it's hard to guarantee correctness in ALL cases as the system can
be in any state (e.g. if the panic is caused by memory corruption -- who
knows what's corrupted?). I'm hoping that with the newly added logic
we're covering the most common kdump case and it'll 'generally work' on
Azure CVMs.

>
>> +
>> +	batch_size = MIN(hv_setup_in_array(&input, sizeof(*input),
>> +					   sizeof(input->gpa_page_list[0])),
>> +			 HV_MAX_MODIFY_GPA_REP_COUNT);
>
> The patches that added hv_setup_in_array() were pulled from
> hyperv-next due to some renewed discussion. You'll need to revert
> back to the previous handling of hyperv_pcpu_input_arg. :-(
>

No worries, it's not a big change for this patch)

>> +	if (unlikely(!input))
>> +		goto unlock;
>> +
>> +	list_for_each_entry(ent, &hv_list_enc, list) {
>> +		for (i = 0, cur = 0; i < ent->count; i++) {
>> +			input->gpa_page_list[cur] = ent->pfn + i;
>> +			cur++;
>> +
>> +			if (cur == batch_size || i == ent->count - 1) {
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
>> @@ -476,24 +658,33 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
>>  	u64 hv_status;
>>  	int batch_size;
>>  	unsigned long flags;
>> +	int ret;
>> 
>>  	/* no-op if partition isolation is not enabled */
>>  	if (!hv_is_isolation_supported())
>>  		return 0;
>> 
>> +	if (visibility == VMBUS_PAGE_NOT_VISIBLE) {
>> +		hv_list_enc_remove(pfn, count);
>> +	} else {
>> +		ret = hv_list_enc_add(pfn, count);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	local_irq_save(flags);
>>  	batch_size = hv_setup_in_array(&input, sizeof(*input),
>>  					sizeof(input->gpa_page_list[0]));
>>  	if (unlikely(!input)) {
>> -		local_irq_restore(flags);
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto unlock;
>>  	}
>> 
>>  	if (count > batch_size) {
>>  		pr_err("Hyper-V: GPA count:%d exceeds supported:%u\n", count,
>>  		       batch_size);
>> -		local_irq_restore(flags);
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto unlock;
>>  	}
>> 
>>  	input->partition_id = HV_PARTITION_ID_SELF;
>> @@ -502,12 +693,18 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
>>  	hv_status = hv_do_rep_hypercall(
>>  			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
>>  			0, input, NULL);
>> -	local_irq_restore(flags);
>> -
>>  	if (hv_result_success(hv_status))
>> -		return 0;
>> +		ret = 0;
>>  	else
>> -		return -EFAULT;
>> +		ret = -EFAULT;
>> +
>> +unlock:
>> +	local_irq_restore(flags);
>> +
>> +	if (ret)
>> +		hv_list_enc_remove(pfn, count);
>
> If making the pages shared fails, this is an "undo". But what
> about an "undo" if making the pages private fails? Maybe
> your thinking is that leaving the pages on the shared list just
> sets things up for a failure when hv_ivm_clear_host_access()
> tries to make them private. But I wonder if it would be better
> to go ahead and "undo" here in case the failure is transient
> and hv_ivm_clear_host_access() might later succeed. I don't
> understand the hypercall failure modes well enough to
> know whether that's plausible. But if you think the "undo"
> here really isn't warranted, please add a code comment to
> that effect since a future reader might expect to the two
> cases to be symmetrical here.

Nice catch, I missed the fact that making pages private can fail too. As
the assumption we have is that the hypercall does 'all or nothing', it's
better to handle the case symmetrically. Will add the logic.

>
>> +
>> +	return ret;
>>  }
>> 
>>  /*
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
>> --
>> 2.50.1
>

-- 
Vitaly


