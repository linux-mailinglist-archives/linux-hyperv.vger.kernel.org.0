Return-Path: <linux-hyperv+bounces-1085-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D47FB2D3
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 08:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB081C209E3
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7529B1427B;
	Tue, 28 Nov 2023 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMZCWAl1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19290D60
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701156889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Af4R3R0mC73NeF28UK2gUhxOsO8EQNBm/EtMet76tN8=;
	b=TMZCWAl1YFrj0p40h19m7aHMll1YxApAteej9gk3xZDcApc4w1JeJMN+ftUlbse4vwjoW0
	QrPXlY6z2zWbS9YpFkEII3UPK0JJPeUc7l9yWG5gX0jNjb7B0bVoYg4ZGXGAVYcbjf9BnY
	Wswc0XMBs8grfNx2oA9djGg+MS/yTJw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-3k4hdiDUPmC3yF9wqoQrbQ-1; Tue, 28 Nov 2023 02:34:47 -0500
X-MC-Unique: 3k4hdiDUPmC3yF9wqoQrbQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50aa8fbf1e6so5481866e87.2
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156886; x=1701761686;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Af4R3R0mC73NeF28UK2gUhxOsO8EQNBm/EtMet76tN8=;
        b=UaTo6QPCOY3c74FhEExmoK7EDMSZi7Rau7WJAy/ZLdNy1ljngssEvdwuIMQk0hrlr3
         P+35292oejK/rc1vLlrCjNXi6/njcqaNPOcvtJfeqFOPG1m8b03jA1A0OOHPSG9eTZd3
         wPjPmqqPbwhcUcuMbHz8tRZ+hZ7ud7as6KvxlSjOAbz1YV/2wRhPI1k+PXgFqye9f+CJ
         NaNe//WQLJnpdjSsOnyWp2R1xG8DOQj1dnTde6vaZc9obR+AA4b/W2bCHdUb1JxJ/T7w
         pFevhkkkW13OZclFJ+m4s8E5YYo3JWrSNmbdibwKvk6xD3bXh8OrdMcYMfgX6chVA3xd
         0hbg==
X-Gm-Message-State: AOJu0YxphU1ooY42JzquNeg9SzMlvdNG44R3DlvyYzKOH6D5iDby5DrM
	SG0ofbusUch7A942JDY85OAbCXOEijGyaOWww3o27z5JYxEe4MSQLqoO5TzGLg/lTwE62KRfqlz
	yRa7xeSMtlaJdBcOWSclRWDav
X-Received: by 2002:a05:6512:124a:b0:50b:b505:4f4f with SMTP id fb10-20020a056512124a00b0050bb5054f4fmr3321279lfb.33.1701156886271;
        Mon, 27 Nov 2023 23:34:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4mUGubmaDvDINFkQm2EatID8OHN179Us3EEdFYWLdprOFopXHoieMVKbKo+nPjj8TopAfRw==
X-Received: by 2002:a05:6512:124a:b0:50b:b505:4f4f with SMTP id fb10-20020a056512124a00b0050bb5054f4fmr3321274lfb.33.1701156886088;
        Mon, 27 Nov 2023 23:34:46 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id bd11-20020a05600c1f0b00b0040b4e44cf8dsm719001wmb.47.2023.11.27.23.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:34:45 -0800 (PST)
Message-ID: <2abdad452c601461869365fa804fa02a6a50df0a.camel@redhat.com>
Subject: Re: [RFC 15/33] KVM: x86/mmu: Introduce infrastructure to handle
 non-executable faults
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
 anelkz@amazon.com,  graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
 corbert@lwn.net,  kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, x86@kernel.org,  linux-doc@vger.kernel.org
Date: Tue, 28 Nov 2023 09:34:43 +0200
In-Reply-To: <20231108111806.92604-16-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
	 <20231108111806.92604-16-nsaenz@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> The upcoming per-VTL memory protections support needs to fault in
> non-executable memory. Introduce a new attribute in struct
> kvm_page_fault, map_executable, to control whether the gfn range should
> be mapped as executable.
> 
> No functional change intended.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c          | 6 +++++-
>  arch/x86/kvm/mmu/mmu_internal.h | 2 ++
>  arch/x86/kvm/mmu/tdp_mmu.c      | 8 ++++++--
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 2afef86863fb..4e02d506cc25 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3245,6 +3245,7 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  	struct kvm_mmu_page *sp;
>  	int ret;
>  	gfn_t base_gfn = fault->gfn;
> +	unsigned access = ACC_ALL;
>  
>  	kvm_mmu_hugepage_adjust(vcpu, fault);
>  
> @@ -3274,7 +3275,10 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  	if (WARN_ON_ONCE(it.level != fault->goal_level))
>  		return -EFAULT;
>  
> -	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, ACC_ALL,
> +	if (!fault->map_executable)
> +		access &= ~ACC_EXEC_MASK;
> +
> +	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, access,
>  			   base_gfn, fault->pfn, fault);
>  	if (ret == RET_PF_SPURIOUS)
>  		return ret;


> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index b66a7d47e0e4..bd62c4d5d5f1 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -239,6 +239,7 @@ struct kvm_page_fault {
>  	kvm_pfn_t pfn;
>  	hva_t hva;
>  	bool map_writable;
> +	bool map_executable;
>  
>  	/*
>  	 * Indicates the guest is trying to write a gfn that contains one or
> @@ -298,6 +299,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  		.req_level = PG_LEVEL_4K,
>  		.goal_level = PG_LEVEL_4K,
>  		.is_private = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),
> +		.map_executable = true,
>  	};
>  	int r;
>  
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 6cd4dd631a2f..46f3e72ab770 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -957,14 +957,18 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
>  	u64 new_spte;
>  	int ret = RET_PF_FIXED;
>  	bool wrprot = false;
> +	unsigned access = ACC_ALL;
>  
>  	if (WARN_ON_ONCE(sp->role.level != fault->goal_level))
>  		return RET_PF_RETRY;
>  
> +	if (!fault->map_executable)
> +		access &= ~ACC_EXEC_MASK;
> +
>  	if (unlikely(!fault->slot))
> -		new_spte = make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
> +		new_spte = make_mmio_spte(vcpu, iter->gfn, access);
>  	else
> -		wrprot = make_spte(vcpu, sp, fault->slot, ACC_ALL, iter->gfn,
> +		wrprot = make_spte(vcpu, sp, fault->slot, access, iter->gfn,
>  					 fault->pfn, iter->old_spte, fault->prefetch, true,
>  					 fault->map_writable, &new_spte);

Overall this patch makes sense but I don't know the mmu well enough to be sure
that there are no corner cases which are not handeled here.

>  


Best regards,
	Maxim Levitsky


