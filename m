Return-Path: <linux-hyperv+bounces-1086-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B47727FB2E0
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 08:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2ECB2106A
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7F813FEA;
	Tue, 28 Nov 2023 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRSTe3AJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351FF1BDF
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701156966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsdX9JWACBEXSXLe6/UFcpYHlYKNddh0vSmdD6PItQ0=;
	b=DRSTe3AJD+EV/njZcwbuzYrqKv4/Aih6tmlA1wIzAxz8oykBqSrDCPTnMIs/iiTjAnj/IT
	E/QRMioGRCtNhzp4Ncmy3SxFub5c/dCeq209qOaGySoOxnuVsR+aotjYnQTcKqhagivBok
	Jer84wrYj/1BewkI06rHUBpkNapV1PM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-2SQdLFJaNeKEDXSS_3Ko_A-1; Tue, 28 Nov 2023 02:36:04 -0500
X-MC-Unique: 2SQdLFJaNeKEDXSS_3Ko_A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b4e24adc7so1399555e9.0
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156963; x=1701761763;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsdX9JWACBEXSXLe6/UFcpYHlYKNddh0vSmdD6PItQ0=;
        b=lHkQVn0BWkurFhYi54PShL4uSoFUwFN3XKJrxCHN+y15gfbgDDGBJBPCvVY2uQACmp
         OTSiaHyFpBzOMTBINkejhV+QkAkvaTcwihRiuIx0nW2xB3bOn4vc8xYs4SIuLEJj4b3h
         ukjyu7cgTatPOmXN16ntjDbK61pNFSzprNZsrCfHNinadrhEJf6DH8K3TjlBOy26l3Ip
         ak0VzTbhCuhLBauFHWm+j8aHSfA/RLkbrVbcCndlLnt+TFLLFa0i251ECXctYIsoR+r5
         fXVC5l+e4Yx8torPjzm6n40q4HndyfbENnj8xlMR27Afwvw/t2qpY1XXCe78aJCajr/X
         CHFw==
X-Gm-Message-State: AOJu0YxsT3T9t/r4F8218qIZLl9W66M6VUJYi/uLtXkExEWL8z9Glgk7
	ePZeggSYIKGHtlD0rZyEBKajTs6qcY+A9T3saL7DFxnswqCX+ABtb9dZ7R5ZFapBrbc4ThOEAdv
	IUgzIw11SQ9unT6qLKl7i15Qm
X-Received: by 2002:a05:600c:290:b0:40b:377a:2ac1 with SMTP id 16-20020a05600c029000b0040b377a2ac1mr10104664wmk.20.1701156963681;
        Mon, 27 Nov 2023 23:36:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAOpVyXJnyHDBx5SdhWAQsdciuEWUKK9zbiujUHqCWUzkEMj7vCi7I9Y4a12hutDtc/rzKcw==
X-Received: by 2002:a05:600c:290:b0:40b:377a:2ac1 with SMTP id 16-20020a05600c029000b0040b377a2ac1mr10104637wmk.20.1701156963320;
        Mon, 27 Nov 2023 23:36:03 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600c3d0500b00405d9a950a2sm17293024wmb.28.2023.11.27.23.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:36:03 -0800 (PST)
Message-ID: <69c10848d4a4f36ab71ca518f4b23d4dee377572.camel@redhat.com>
Subject: Re: [RFC 16/33] KVM: x86/mmu: Expose R/W/X flags during memory
 fault exits
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
 anelkz@amazon.com,  graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
 corbert@lwn.net,  kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, x86@kernel.org,  linux-doc@vger.kernel.org
Date: Tue, 28 Nov 2023 09:36:00 +0200
In-Reply-To: <20231108111806.92604-17-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
	 <20231108111806.92604-17-nsaenz@amazon.com>
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
> Include the fault's read, write and execute status when exiting to
> user-space.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c   | 4 ++--
>  include/linux/kvm_host.h | 9 +++++++--
>  include/uapi/linux/kvm.h | 6 ++++++
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4e02d506cc25..feca077c0210 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4300,8 +4300,8 @@ static inline u8 kvm_max_level_for_order(int order)
>  static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
>  					      struct kvm_page_fault *fault)
>  {
> -	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> -				      PAGE_SIZE, fault->write, fault->exec,
> +	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT, PAGE_SIZE,
> +				      fault->write, fault->exec, fault->user,
>  				      fault->is_private);
>  }
>  
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 71e1e8cf8936..631fd532c97a 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2367,14 +2367,19 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
>  static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
>  						 gpa_t gpa, gpa_t size,
>  						 bool is_write, bool is_exec,
> -						 bool is_private)
> +						 bool is_read, bool is_private)

It almost feels like there is a need for a struct to hold all of those parameters.

>  {
>  	vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
>  	vcpu->run->memory_fault.gpa = gpa;
>  	vcpu->run->memory_fault.size = size;
>  
> -	/* RWX flags are not (yet) defined or communicated to userspace. */
>  	vcpu->run->memory_fault.flags = 0;
> +	if (is_read)
> +		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_READ;
> +	if (is_write)
> +		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_WRITE;
> +	if (is_exec)
> +		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_EXECUTE;
>  	if (is_private)
>  		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_PRIVATE;
>  }
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 03f5c08fd7aa..0ddffb8b0c99 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -533,7 +533,13 @@ struct kvm_run {
>  		} notify;
>  		/* KVM_EXIT_MEMORY_FAULT */
>  		struct {
> +#define KVM_MEMORY_EXIT_FLAG_READ	(1ULL << 0)
> +#define KVM_MEMORY_EXIT_FLAG_WRITE	(1ULL << 1)
> +#define KVM_MEMORY_EXIT_FLAG_EXECUTE	(1ULL << 2)
>  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
> +#define KVM_MEMORY_EXIT_NO_ACCESS                            \
> +	(KVM_MEMORY_EXIT_FLAG_NR | KVM_MEMORY_EXIT_FLAG_NW | \
> +	 KVM_MEMORY_EXIT_FLAG_NX)
>  			__u64 flags;
>  			__u64 gpa;
>  			__u64 size;


I don't think that KVM_MEMORY_EXIT_FLAG_NR, KVM_MEMORY_EXIT_FLAG_NW, KVM_MEMORY_EXIT_FLAG_NX are defined anywhere.
Also why KVM_MEMORY_EXIT_NO_ACCESS is needed - userspace can infer it from the lack of other access flags.

Best regards,
	Maxim Levitsky


