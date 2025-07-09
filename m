Return-Path: <linux-hyperv+bounces-6161-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48926AFEDFC
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 17:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935915A4F27
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149D32E0B44;
	Wed,  9 Jul 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fE0oQvLj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295202D3A86
	for <linux-hyperv@vger.kernel.org>; Wed,  9 Jul 2025 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075990; cv=none; b=RxvEjeI3t1EAIPGBu7XWaTVNSoBOedZZYbCF8RqUGrb9c+ffCPPKLSwS2tsOI0RyOxQK31Wb6asyIBlk81ZjvxriRBhrZkMcpS1lubWPyjF9aS7GlgDbu56mzQ43TDCXc4GDP30Lbga7EiYR3CdzdD48sXo9hJzs3Kgi12GfBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075990; c=relaxed/simple;
	bh=WAq6X8gLKLtsCYe4GvFLjHjmRCUnVoQ8X8DTjzp3uJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fdjw5M5p9td/LabtQvqCn9xnUWVu5axMBzz30M2DxaRR3IrFLgM8djwhmiVEJ39OCBjCiExWSxoKhKlFmz6BtH5GuK5cQi5EIicI3nDLNdnAhH7EGt9ZmSiRKXLdmZDl/3yAoaEedLXroi4Kio+2Zc39drjDbLcF5nlgSelBL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fE0oQvLj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752075987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qX2+U56Doe6O5KPy8vxSLK1AIbRo7RJ7CWcz4fuNoKo=;
	b=fE0oQvLj6D9tfnJJOMCe9Aa+FOFw8hOGGYcu46oiMYy8w/a7t8jSkO77fpzsMfL/fyQiAu
	n4wAZmM6fq4NUt46B3QDIq6zxET6Pl4j8oz3gsG9OypBkBKuJhDLjQp66kr6B4Lz0hDc3n
	wVchOUioBwUbaiPGmIjtbm2n+0MqH+U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-Ti3Q4hjIM3KsgwHgF5Z9_g-1; Wed, 09 Jul 2025 11:46:25 -0400
X-MC-Unique: Ti3Q4hjIM3KsgwHgF5Z9_g-1
X-Mimecast-MFC-AGG-ID: Ti3Q4hjIM3KsgwHgF5Z9_g_1752075984
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so35173f8f.2
        for <linux-hyperv@vger.kernel.org>; Wed, 09 Jul 2025 08:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752075984; x=1752680784;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qX2+U56Doe6O5KPy8vxSLK1AIbRo7RJ7CWcz4fuNoKo=;
        b=KvUFFgwi28MZlDUIzoe04+MR2BTIA/VCBE8a89xvdnAAq9a4BUQKSZFMUkQWSHZ8RQ
         7KaLKFB+tRXDpQCilHkczqtoXNGKVrg1gVTDPBfxQAabtOiKqFmf3flClaYgatrJrmmx
         NawpFV8xsXFg2hwkWfXVVOO9/wjiTFIyJdhtCOA3lxGtNSYtN60UWCGn/N4K2wu5i4l9
         yNcceaI5B49W7CXvyhICMfnPGKkBaCm+qP2HPZnB+KyWz7nA5vOEgAVWMXMkdVk9L3HP
         koCsuIeREdEN3bkHULfCDaGNCsiXiFUeK4LnzhtliP/ZHERqFUnJChWm9O3bxMud39I6
         b3kg==
X-Forwarded-Encrypted: i=1; AJvYcCXu1l9kCZ1OtUimKRMRHN5cwT5dHkODO1pLmJ/CPSY5k+O4v+KUcGcW8nqaV7c4g/h4qd6rv24B2nd4aGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69OIRnZdkQJoGvhiQn3rew84cWQM3KbxCQ2n25hjyCsNSDoba
	rJ7T3w+7LxiiPuAO/eV9Mtb+O+4L7rH00aZJjbn67ReWxpAzxUb9S+kHhOYJ2u7Grl3RvnIQ8Oi
	fUoGK6T33TeZDk1PwyZJm9RX941ATnrh1HGPWmmTVV4jqlUNdOyVmVrud1KM4csr7+Q==
X-Gm-Gg: ASbGncugnrk4/7VJPYQsWaI6TphuAUDoSnRFq1ca3lmshyXHwcvCjksNp+VxLQs38FD
	eF7pBVHfu+cRg4mm4ao7nBgNvZ8aTdM9l73tdnqOg8vobIq8KlFALoCZSRbNUsrwfG+qlXbMXtx
	+UGqiYq6GSrjFnfwp8Hr11zlLV1qPFPxUgcEgEyYxsOyc9MFOVkJ9itDBYngMFgueaH2D8J1kCT
	ueOrAnCNJ9i5wdOD6q1NAn9e3MekGhIAcL194hEUDez44JUZ8vr6o4pg1vu6ryNaxH1nxu0Ame3
	Zo21f9jFthgtQqBxEw==
X-Received: by 2002:a5d:584a:0:b0:3b5:e631:404e with SMTP id ffacd0b85a97d-3b5e7880feamr512405f8f.11.1752075984448;
        Wed, 09 Jul 2025 08:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+VXt8UflaBx9N9+VFLECmBUXVr7laX0K70+n281DypajoTyeiy9u7ILUxrHU1Hfw4cJ1UJw==
X-Received: by 2002:a5d:584a:0:b0:3b5:e631:404e with SMTP id ffacd0b85a97d-3b5e7880feamr512358f8f.11.1752075983916;
        Wed, 09 Jul 2025 08:46:23 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5061a91sm30870505e9.17.2025.07.09.08.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:46:22 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 alanjiang@microsoft.com, chinang.ma@microsoft.com,
 andrea.pellegrini@microsoft.com, Kevin Tian <kevin.tian@intel.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] KVM: VMX: Use Hyper-V EPT flush for local TLB
 flushes
In-Reply-To: <ca26fba1-c2bb-40a1-bb5e-92811c4a6fc6@linux.microsoft.com>
References: <cover.1750432368.git.jpiotrowski@linux.microsoft.com>
 <4266fc8f76c152a3ffcbb2d2ebafd608aa0fb949.1750432368.git.jpiotrowski@linux.microsoft.com>
 <875xghoaac.fsf@redhat.com>
 <ca26fba1-c2bb-40a1-bb5e-92811c4a6fc6@linux.microsoft.com>
Date: Wed, 09 Jul 2025 17:46:21 +0200
Message-ID: <87o6tttliq.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeremi Piotrowski <jpiotrowski@linux.microsoft.com> writes:

> On 27/06/2025 10:31, Vitaly Kuznetsov wrote:
>> Jeremi Piotrowski <jpiotrowski@linux.microsoft.com> writes:
>> 
>>> Use Hyper-V's HvCallFlushGuestPhysicalAddressSpace for local TLB flushes.
>>> This makes any KVM_REQ_TLB_FLUSH_CURRENT (such as on root alloc) visible to
>>> all CPUs which means we no longer need to do a KVM_REQ_TLB_FLUSH on CPU
>>> migration.
>>>
>>> The goal is to avoid invept-global in KVM_REQ_TLB_FLUSH. Hyper-V uses a
>>> shadow page table for the nested hypervisor (KVM) and has to invalidate all
>>> EPT roots when invept-global is issued. This has a performance impact on
>>> all nested VMs.  KVM issues KVM_REQ_TLB_FLUSH on CPU migration, and under
>>> load the performance hit causes vCPUs to use up more of their slice of CPU
>>> time, leading to more CPU migrations. This has a snowball effect and causes
>>> CPU usage spikes.
>>>
>>> By issuing the hypercall we are now guaranteed that any root modification
>>> that requires a local TLB flush becomes visible to all CPUs. The same
>>> hypercall is already used in kvm_arch_flush_remote_tlbs and
>>> kvm_arch_flush_remote_tlbs_range.  The KVM expectation is that roots are
>>> flushed locally on alloc and we achieve consistency on migration by
>>> flushing all roots - the new behavior of achieving consistency on alloc on
>>> Hyper-V is a superset of the expected guarantees. This makes the
>>> KVM_REQ_TLB_FLUSH on CPU migration no longer necessary on Hyper-V.
>> 
>> Sounds reasonable overall, my only concern (not sure if valid or not) is
>> that using the hypercall for local flushes is going to be more expensive
>> than invept-context we do today and thus while the performance is
>> improved for the scenario when vCPUs are migrating a lot, we will take a
>> hit in other cases.
>> 
>

Sorry for delayed reply!

....

>>>  		return;
>>>  
>>> -	if (enable_ept)
>>> +	if (enable_ept) {
>>> +		/*
>>> +		 * hyperv_flush_guest_mapping() has the semantics of
>>> +		 * invept-single across all pCPUs. This makes root
>>> +		 * modifications consistent across pCPUs, so an invept-global
>>> +		 * on migration is no longer required.
>>> +		 */
>>> +		if (vmx_hv_use_flush_guest_mapping(vcpu))
>>> +			return (void)WARN_ON_ONCE(hyperv_flush_guest_mapping(root_hpa));
>>> +
>> 
>> HvCallFlushGuestPhysicalAddressSpace sounds like a heavy operation as it
>> affects all processors. Is there any visible perfomance impact of this
>> change when there are no migrations (e.g. with vCPU pinning)? Or do we
>> believe that Hyper-V actually handles invept-context the exact same way?
>> 
> I'm going to have to do some more investigation to answer that - do you have an
> idea of a workload that would be sensitive to tlb flushes that I could compare
> this on?
>
> In terms of cost, Hyper-V needs to invalidate the VMs shadow page table for a root
> and do the tlb flush. The first part is CPU intensive but is the same in both cases
> (hypercall and invept-single). The tlb flush part will require a bit more work for
> the hypercall as it needs to happen on all cores, and the tlb will now be empty
> for that root.
>
> My assumption is that these local tlb flushes are rather rare as they will
> only happen when:
> - new root is allocated
> - we need to switch to a special root
>

KVM's MMU is an amazing maze so I'd appreciate if someone more
knowledgeble corrects me;t my understanding is that we call
*_flush_tlb_current() from two places:

kvm_mmu_load() and this covers the two cases above. These should not be
common under normal circumstances but can be frequent in some special
cases, e.g. when running a nested setup. Given that we're already
running on top of Hyper-V, this means 3+ level nesting which I don't
believe anyone really cares about.

kvm_vcpu_flush_tlb_current() from KVM_REQ_TLB_FLUSH_CURRENT. These are
things like some CR4 writes, APIC mode changes, ... which also shouldn't
be that common but VM boot time can be affected. So I'd suggest to test
big VM startup time, i.e. take the biggest available instance type on
Azure and measure how much time it takes to boot a VM which has the same
vCPU count. Honestly, I don't expect to see a significant change but I
guess it's still worth checking.

> So not very frequent post vm boot (with or without pinning). And the effect of the
> tlb being empty for that root on other CPUs should be a neutral, as users of the
> root would have performed the same local flush at a later point in
> time (when using it).
>
> All the other mmu updates use kvm_flush_remote_tlbs* which already go
> through the hypercall.

-- 
Vitaly


