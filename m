Return-Path: <linux-hyperv+bounces-6455-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED1B1A6B6
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Aug 2025 17:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60E63B8023
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Aug 2025 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FF8266568;
	Mon,  4 Aug 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpabmuVO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F042192EB
	for <linux-hyperv@vger.kernel.org>; Mon,  4 Aug 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322578; cv=none; b=LwCqpYhsq1YCXeADDT+n1gGSWQKQdr6GzvRsDfruccJhmcM0fwY9vJnVXAJPH4JtTnstoLvq7ToCHMXTsSEy3YmqBvUuo6ez2yaafC+x4r5800A7VbImUMkXRkAQP5FgpW7I/2qo3OenKTGV/6wZw8MYSRotgjXfRcsziVf9GPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322578; c=relaxed/simple;
	bh=fgQf3AzdPQXO0jCjF1Jj/luAySkWXiCqRjmQm+Hbd2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PNpzuQ5i0xWHwaVlHkA0rtYh2PSNyuOBXeCC2yixxUhHxDu6ZQEynwgu3xD72gMNFAohUtGZb9mqHWJdI5WMgxfQlYLXcTw+/Mo3SHQH6j7rkKGxZ5GqDghka3jeYKEKEnXmFLa+V2t5IecKa5AiXct/qGZnkGNnssSe8DVhWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpabmuVO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754322575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp91VSTUj4He/K83QIVxaDFmWFwOZixH7dnV0delk0Y=;
	b=JpabmuVOS1zfdSU7mwJWctCNhSEq+Jpkb2UyXFD9kBC4ymoCVqxhsVrlc4BuEdE3k483Cg
	E+nBhhietTI4SR5WlZWxc5n3qnuAUmZBEuAHReO2uOtzcp85BQ07Nq1OkkCHUHMqZpLlBz
	pK7Q9VpxJnQnovBbP4p0EmHMkQyqC08=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-55THWB7RPdmDCwMCmDgN1w-1; Mon, 04 Aug 2025 11:49:33 -0400
X-MC-Unique: 55THWB7RPdmDCwMCmDgN1w-1
X-Mimecast-MFC-AGG-ID: 55THWB7RPdmDCwMCmDgN1w_1754322572
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459dfbece11so2649225e9.2
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Aug 2025 08:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322572; x=1754927372;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp91VSTUj4He/K83QIVxaDFmWFwOZixH7dnV0delk0Y=;
        b=wWTAAUrLsvDlfxafrbtQTfHS5L3/SdpNDc8sUwPmQp3Qxxb9zgmvAUrh9vy6JrBDOO
         gd8VFv4m5gKXFnfoEhNb46vee3QS32+2mmpYi/VBpHBh3v42trfPyqkS3HBcTo+Kc8vS
         Pl0F+x/jPGVHaQd0nL1UtYJ9dLwPZv2vPRv4479QmXm+pB1RTjF1f/iKcd/djT/4L3wD
         DmjFxD3OyPgXZOPGnEl/OmsB/qpKfPIXISOg9/QrtUCPRrmz5f0eQhkxL8u0W+VLr6q2
         W9brBcB7SklfanMuvFsvSVpeNZWCHDe5gP0MFwkeMJ5/hz4VCz2cX+duDWt0N2ng1YfI
         AWJw==
X-Forwarded-Encrypted: i=1; AJvYcCVYo4iWhOoMgRYD1ertEhVbCeBkH0W3Upyn0+2p5c2sqQes+K0cvicIva4zx0TIJtvQ1qY0dxOOVF/fTqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwNmf90sIbvrSfqn0GY/x0iwrCzmpxECKIPGM4oauQ4E/gSmz/
	Zl+ciVqpX7T3YeTBHIjLVaEaHnV4AIuw8xorYDDOSS/kd5CbpxAe9EdVPecRVdcZIjy64+xng8Q
	G13VkMy8AVHsH6BRhjHIBDq4qwXeVTqIKpJOLX7hh6sg15GtHSsGxywHrvS+CdBEOMw==
X-Gm-Gg: ASbGncuuOPa2plMPm/DZJffKZDRriZK4GYvfo60PBTh8GSImemZjwXSuB1UXJ1wpEa9
	q/ua7Z7vcIM6P1OpNwKHzc467OMXDsudEFQGHuMhWf01m+c34VZ7IKdBVaDNHunoQBlLNX9E1nT
	7pNpGd2wVS7C1Qc8fIXPCGLJgvwNLy0crlhcEclxjdiaVw9hdVcxFB3UJrhLu/Vevdz/gj2loXn
	D0szWNXT14X4nU7TzfbrxrngS6H6G8ChDM5uW4DjgKYFnv1tohW4peOSLMC7YREEPU6qlW0lz7K
	ItS0wQJj2yCE5H8rmFVOr8vBlR6ZCmrtXfY=
X-Received: by 2002:a5d:5d0e:0:b0:3b7:8525:e9cc with SMTP id ffacd0b85a97d-3b8d9474b30mr6851032f8f.18.1754322572296;
        Mon, 04 Aug 2025 08:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIjQYt8kn5K1KiyZc+opRlRMeQATeYuM04IBXVfIUgbfBca8ACZBnnd7veGeB9S3HxGg9o9w==
X-Received: by 2002:a5d:5d0e:0:b0:3b7:8525:e9cc with SMTP id ffacd0b85a97d-3b8d9474b30mr6850997f8f.18.1754322571839;
        Mon, 04 Aug 2025 08:49:31 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm65384015e9.22.2025.08.04.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:49:31 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 alanjiang@microsoft.com, chinang.ma@microsoft.com,
 andrea.pellegrini@microsoft.com, Kevin Tian <kevin.tian@intel.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] KVM: VMX: Use Hyper-V EPT flush for local TLB
 flushes
In-Reply-To: <aHWjPSIdp5B-2UBl@google.com>
References: <cover.1750432368.git.jpiotrowski@linux.microsoft.com>
 <4266fc8f76c152a3ffcbb2d2ebafd608aa0fb949.1750432368.git.jpiotrowski@linux.microsoft.com>
 <875xghoaac.fsf@redhat.com>
 <ca26fba1-c2bb-40a1-bb5e-92811c4a6fc6@linux.microsoft.com>
 <87o6tttliq.fsf@redhat.com> <aHWjPSIdp5B-2UBl@google.com>
Date: Mon, 04 Aug 2025 17:49:29 +0200
Message-ID: <87tt2nm6ie.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

...

>
> It'll take more work than the below, e.g. to have VMX's construct_eptp() pull the
> level and A/D bits from kvm_mmu_page (vendor code can get at the kvm_mmu_page with
> root_to_sp()), but for the core concept/skeleton, I think this is it?
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6e838cb6c9e1..298130445182 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3839,6 +3839,37 @@ void kvm_mmu_free_guest_mode_roots(struct kvm *kvm, struct kvm_mmu *mmu)
>  }
>  EXPORT_SYMBOL_GPL(kvm_mmu_free_guest_mode_roots);
>  
> +struct kvm_tlb_flush_root {
> +       struct kvm *kvm;
> +       hpa_t root;
> +};
> +
> +static void kvm_flush_tlb_root(void *__data)
> +{
> +       struct kvm_tlb_flush_root *data = __data;
> +
> +       kvm_x86_call(flush_tlb_root)(data->kvm, data->root);
> +}
> +
> +void kvm_mmu_flush_all_tlbs_root(struct kvm *kvm, struct kvm_mmu_page *root)
> +{
> +       struct kvm_tlb_flush_root data = {
> +               .kvm = kvm,
> +               .root = __pa(root->spt),
> +       };
> +
> +       /*
> +        * Flush any TLB entries for the new root, the provenance of the root
> +        * is unknown.  Even if KVM ensures there are no stale TLB entries
> +        * for a freed root, in theory another hypervisor could have left
> +        * stale entries.  Flushing on alloc also allows KVM to skip the TLB
> +        * flush when freeing a root (see kvm_tdp_mmu_put_root()), and flushing
> +        * TLBs on all CPUs allows KVM to elide TLB flushes when a vCPU is
> +        * migrated to a different pCPU.
> +        */
> +       on_each_cpu(kvm_flush_tlb_root, &data, 1);

Would it make sense to complement this with e.g. a CPU mask tracking all
the pCPUs where the VM has ever been seen running (+ a flush when a new
one is added to it)?

I'm worried about the potential performance impact for a case when a
huge host is running a lot of small VMs in 'partitioning' mode
(i.e. when all vCPUs are pinned). Additionally, this may have a negative
impact on RT use-cases where each unnecessary interruption can be seen
problematic. 

> +}
> +
>  static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
>                             u8 level)
>  {
> @@ -3852,7 +3883,8 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
>         WARN_ON_ONCE(role.direct && role.has_4_byte_gpte);
>  
>         sp = kvm_mmu_get_shadow_page(vcpu, gfn, role);
> -       ++sp->root_count;
> +       if (!sp->root_count++)
> +               kvm_mmu_flush_all_tlbs_root(vcpu->kvm, sp);
>  
>         return __pa(sp->spt);
>  }
> @@ -5961,15 +5993,6 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
>         kvm_mmu_sync_roots(vcpu);
>  
>         kvm_mmu_load_pgd(vcpu);
> -
> -       /*
> -        * Flush any TLB entries for the new root, the provenance of the root
> -        * is unknown.  Even if KVM ensures there are no stale TLB entries
> -        * for a freed root, in theory another hypervisor could have left
> -        * stale entries.  Flushing on alloc also allows KVM to skip the TLB
> -        * flush when freeing a root (see kvm_tdp_mmu_put_root()).
> -        */
> -       kvm_x86_call(flush_tlb_current)(vcpu);
>  out:
>         return r;
>  }
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index 65f3c89d7c5d..3cbf0d612f5e 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -167,6 +167,8 @@ static inline bool is_mirror_sp(const struct kvm_mmu_page *sp)
>         return sp->role.is_mirror;
>  }
>  
> +void kvm_mmu_flush_all_tlbs_root(struct kvm *kvm, struct kvm_mmu_page *root);
> +
>  static inline void kvm_mmu_alloc_external_spt(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
>  {
>         /*
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 7f3d7229b2c1..3ff36d09b4fa 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -302,6 +302,7 @@ void kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu, bool mirror)
>          */
>         refcount_set(&root->tdp_mmu_root_count, 2);
>         list_add_rcu(&root->link, &kvm->arch.tdp_mmu_roots);
> +       kvm_mmu_flush_all_tlbs_root(vcpu->kvm, root);
>  
>  out_spin_unlock:
>         spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
>

-- 
Vitaly


