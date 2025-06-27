Return-Path: <linux-hyperv+bounces-6024-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BB1AEB163
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Jun 2025 10:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535B41898407
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Jun 2025 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FC223C8A2;
	Fri, 27 Jun 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFsTr+ub"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0861DEFD9
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Jun 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013108; cv=none; b=k2tWdhTIgMA8FamUTzez6PQoyEXW+C4ptYUXzuLbhwp4sf7K4FenD28SgVwqKHt0jSVqitkadVo89tKzAjzJl8yauT66txaOhsWHSHMKfC/Eys+wgldwPOJjP36y2CwlPZx9Q/gQsFMsu5uXSH/8J48A3c4nC3jX0S8RKoPkoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013108; c=relaxed/simple;
	bh=mSzYF/l1A+reJ2xStiWCI99vmFzdoQ3mDfhZ6R41LVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oIxXJv0cMDQqWQQSOmT8bJ4+CQA6uVLhCmfPHtu55e/hZE3ZPvAcq+/jVDlJiI+aeIzbwt7J85u1LNXlgk7W55sns4ktVL2OVehynEvQ6pXnAvhp80sgVcNk34rnTNS39J6Pn4/Um8Dw0ZiC0njvQPxbFaIUiAbbUconoGE3hJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFsTr+ub; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751013105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l83S+y1jfDts5TmYlfvBTvXdste6+/ImQkXXtWWTZFE=;
	b=VFsTr+ub9L+0Qi+fz0r8op0FsRV+IyZ/MjdbeIUBq/32Wpu0/WEJ3OZdWHBIU5OcW5fJo4
	Zpv1Nf2OWkDCCk9bE/ve2Cp39NaM35Fre+2VN9deotENTJltckLtgWhwRxYe9pk063o9/u
	efHKUTu1F8FO6xJA3LPUsRaUDk0LRD4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-vcS4nqMYOrO8StDAaThyIQ-1; Fri, 27 Jun 2025 04:31:43 -0400
X-MC-Unique: vcS4nqMYOrO8StDAaThyIQ-1
X-Mimecast-MFC-AGG-ID: vcS4nqMYOrO8StDAaThyIQ_1751013102
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451deff247cso14582425e9.1
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Jun 2025 01:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751013102; x=1751617902;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l83S+y1jfDts5TmYlfvBTvXdste6+/ImQkXXtWWTZFE=;
        b=kU/iFv0h9GpwOxtUiS1R354gAcx6ufSHaJwbMktwZIljbU7wn63PqjCK3ugLCmQhRV
         aCevuFAD2WRdv1AMj2hoS2IIefqWp87T5cKpc3mx0zHPFseGEXfStqXdygnd8c+vwdzA
         dlREqtv6z71HID6vP/UbCl8KGMkvF7CJD3mLu3jKm2y3pew7yVLBDqKf8WzyZ5esL/52
         wc161EGgiHZwRrYR/1S0zg8RBTmSEsFJETkmgGq9ocDSrBhaOU4W7AWCdryAd82JAV/E
         C4g5nt3/LsZQHADxN618+Sx6deQwhAS4EiG5dbgU8HXL4jJGmLnAw1pIJqLRA19RVyNt
         jhfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUqIaBnOEfOJLzI935B4Bxv75nWbwnSWL9QkWuqOfoyBbfpKcl7fQXN+saUs/buRSAHR3T8kK8xGk+yK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQIM6E4Y2OSfpJgerfp7L5AwsolxzkIt96OOo3DRQ8VNxjPIJn
	uatWdVFNIfCqs/egr1hwDsFlvXyob/qbczCccWlHO6S4iz8OBmiUKpKUWBgA4f6QT4SvDFN1m0s
	M7lZlhb/MQPbrylkHl0DQrradvzHuXCrBdxyPJ/81rOy+6zfJ9uXZX6RvoCI2LGZjNw==
X-Gm-Gg: ASbGncunMWUO0KG/JKNcRaIhKvPeWn/dbKnq3Wddt0NEHDa2c1R0EDUnbvBcpolb0Z/
	oT/J/PAZss55lZv2MNNEtfWRTwXQvYobXWuIIIs0HM1JHoMVMPlYMoBPFAjSzz/YWzFoXpSG0tL
	4TqXDsl+sCtl7VYQySVfEj9f7evUQXyaFeuDPlFOpnmoEOaajuAoeH2UWvyRfWYpR4Q2shzaGY5
	1duVzzsbX+4et+YBvclna3rlnp3kRljrc+O2mRNHzUSVkAOx2DTWno6rb/SkoL2018feaeNewFu
	7ayQ0lGZkfP491krjQ==
X-Received: by 2002:a05:6000:1789:b0:3a0:b565:a2cb with SMTP id ffacd0b85a97d-3a97fcd271amr1933555f8f.1.1751013102087;
        Fri, 27 Jun 2025 01:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpAq+GX0z7Tgxlh9jYNr6p5XnDNGBPWZShD8anGUPNisIyuqXuny7kFa3r1rfjaUq4iY4FAQ==
X-Received: by 2002:a05:6000:1789:b0:3a0:b565:a2cb with SMTP id ffacd0b85a97d-3a97fcd271amr1933506f8f.1.1751013101607;
        Fri, 27 Jun 2025 01:31:41 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5979dsm2032976f8f.75.2025.06.27.01.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:31:40 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 alanjiang@microsoft.com, chinang.ma@microsoft.com,
 andrea.pellegrini@microsoft.com, Kevin Tian <kevin.tian@intel.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, Jeremi Piotrowski
 <jpiotrowski@linux.microsoft.com>
Subject: Re: [RFC PATCH 1/1] KVM: VMX: Use Hyper-V EPT flush for local TLB
 flushes
In-Reply-To: <4266fc8f76c152a3ffcbb2d2ebafd608aa0fb949.1750432368.git.jpiotrowski@linux.microsoft.com>
References: <cover.1750432368.git.jpiotrowski@linux.microsoft.com>
 <4266fc8f76c152a3ffcbb2d2ebafd608aa0fb949.1750432368.git.jpiotrowski@linux.microsoft.com>
Date: Fri, 27 Jun 2025 10:31:39 +0200
Message-ID: <875xghoaac.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeremi Piotrowski <jpiotrowski@linux.microsoft.com> writes:

> Use Hyper-V's HvCallFlushGuestPhysicalAddressSpace for local TLB flushes.
> This makes any KVM_REQ_TLB_FLUSH_CURRENT (such as on root alloc) visible to
> all CPUs which means we no longer need to do a KVM_REQ_TLB_FLUSH on CPU
> migration.
>
> The goal is to avoid invept-global in KVM_REQ_TLB_FLUSH. Hyper-V uses a
> shadow page table for the nested hypervisor (KVM) and has to invalidate all
> EPT roots when invept-global is issued. This has a performance impact on
> all nested VMs.  KVM issues KVM_REQ_TLB_FLUSH on CPU migration, and under
> load the performance hit causes vCPUs to use up more of their slice of CPU
> time, leading to more CPU migrations. This has a snowball effect and causes
> CPU usage spikes.
>
> By issuing the hypercall we are now guaranteed that any root modification
> that requires a local TLB flush becomes visible to all CPUs. The same
> hypercall is already used in kvm_arch_flush_remote_tlbs and
> kvm_arch_flush_remote_tlbs_range.  The KVM expectation is that roots are
> flushed locally on alloc and we achieve consistency on migration by
> flushing all roots - the new behavior of achieving consistency on alloc on
> Hyper-V is a superset of the expected guarantees. This makes the
> KVM_REQ_TLB_FLUSH on CPU migration no longer necessary on Hyper-V.

Sounds reasonable overall, my only concern (not sure if valid or not) is
that using the hypercall for local flushes is going to be more expensive
than invept-context we do today and thus while the performance is
improved for the scenario when vCPUs are migrating a lot, we will take a
hit in other cases.

>
> Coincidentally - we now match the behavior of SVM on Hyper-V.
>
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/vmx/vmx.c          | 20 +++++++++++++++++---
>  arch/x86/kvm/vmx/vmx_onhyperv.h |  6 ++++++
>  arch/x86/kvm/x86.c              |  3 +++
>  4 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b4a391929cdb..d3acab19f425 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1077,6 +1077,7 @@ struct kvm_vcpu_arch {
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	hpa_t hv_root_tdp;
> +	bool hv_vmx_use_flush_guest_mapping;
>  #endif
>  };
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4953846cb30d..f537e0df56fc 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1485,8 +1485,12 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu)
>  		/*
>  		 * Flush all EPTP/VPID contexts, the new pCPU may have stale
>  		 * TLB entries from its previous association with the vCPU.
> +		 * Unless we are running on Hyper-V where we promotes local TLB

s,promotes,promote, or, as Sean doesn't like pronouns, 

"... where local TLB flushes are promoted ..."

> +		 * flushes to be visible across all CPUs so no need to do again
> +		 * on migration.
>  		 */
> -		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> +		if (!vmx_hv_use_flush_guest_mapping(vcpu))
> +			kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
>  
>  		/*
>  		 * Linux uses per-cpu TSS and GDT, so set these when switching
> @@ -3243,11 +3247,21 @@ void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
>  	if (!VALID_PAGE(root_hpa))
>  		return;
>  
> -	if (enable_ept)
> +	if (enable_ept) {
> +		/*
> +		 * hyperv_flush_guest_mapping() has the semantics of
> +		 * invept-single across all pCPUs. This makes root
> +		 * modifications consistent across pCPUs, so an invept-global
> +		 * on migration is no longer required.
> +		 */
> +		if (vmx_hv_use_flush_guest_mapping(vcpu))
> +			return (void)WARN_ON_ONCE(hyperv_flush_guest_mapping(root_hpa));
> +

HvCallFlushGuestPhysicalAddressSpace sounds like a heavy operation as it
affects all processors. Is there any visible perfomance impact of this
change when there are no migrations (e.g. with vCPU pinning)? Or do we
believe that Hyper-V actually handles invept-context the exact same way?

>  		ept_sync_context(construct_eptp(vcpu, root_hpa,
>  						mmu->root_role.level));
> -	else
> +	} else {
>  		vpid_sync_context(vmx_get_current_vpid(vcpu));
> +	}
>  }
>  
>  void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h b/arch/x86/kvm/vmx/vmx_onhyperv.h
> index cdf8cbb69209..a5c64c90e49e 100644
> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
> @@ -119,6 +119,11 @@ static inline void evmcs_load(u64 phys_addr)
>  }
>  
>  void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf);
> +
> +static inline bool vmx_hv_use_flush_guest_mapping(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.hv_vmx_use_flush_guest_mapping;
> +}
>  #else /* !IS_ENABLED(CONFIG_HYPERV) */
>  static __always_inline bool kvm_is_using_evmcs(void) { return false; }
>  static __always_inline void evmcs_write64(unsigned long field, u64 value) {}
> @@ -128,6 +133,7 @@ static __always_inline u64 evmcs_read64(unsigned long field) { return 0; }
>  static __always_inline u32 evmcs_read32(unsigned long field) { return 0; }
>  static __always_inline u16 evmcs_read16(unsigned long field) { return 0; }
>  static inline void evmcs_load(u64 phys_addr) {}
> +static inline bool vmx_hv_use_flush_guest_mapping(struct kvm_vcpu *vcpu) { return false; }
>  #endif /* IS_ENABLED(CONFIG_HYPERV) */
>  
>  #endif /* __ARCH_X86_KVM_VMX_ONHYPERV_H__ */
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b58a74c1722d..cbde795096a6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -25,6 +25,7 @@
>  #include "tss.h"
>  #include "kvm_cache_regs.h"
>  #include "kvm_emulate.h"
> +#include "kvm_onhyperv.h"
>  #include "mmu/page_track.h"
>  #include "x86.h"
>  #include "cpuid.h"
> @@ -12390,6 +12391,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	vcpu->arch.hv_root_tdp = INVALID_PAGE;
> +	vcpu->arch.hv_vmx_use_flush_guest_mapping =
> +		(kvm_x86_ops.flush_remote_tlbs == hv_flush_remote_tlbs);
>  #endif
>  
>  	r = kvm_x86_call(vcpu_create)(vcpu);

-- 
Vitaly


