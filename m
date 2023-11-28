Return-Path: <linux-hyperv+bounces-1089-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B7C7FB2FF
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 08:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45244281E1D
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F04214285;
	Tue, 28 Nov 2023 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0/1u7Df"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE00183
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701157363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEnBNNAbZDViVxp0lQwkboLBGvebtjQoRjp+wXTMCDw=;
	b=T0/1u7DfvtfrKyVMXsGOcywzvoFBqZkE19XLDuCGuI5Iyfgz6KHAzAZK0/5NwmrWKnBOnL
	ufjkO01EF9Jfd29X4jxysBhH8mGCu4G6hLbzZfkYjuKAV6lUHvBdx4RKaDlEl1NKJGWP3U
	Cvagzd/Dn0rEJsa14ig8tnuZsT2M0pk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-Xtxixxw4Nq6Z0OIQd7f_SQ-1; Tue, 28 Nov 2023 02:42:42 -0500
X-MC-Unique: Xtxixxw4Nq6Z0OIQd7f_SQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b3dae2285so20138155e9.2
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157361; x=1701762161;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEnBNNAbZDViVxp0lQwkboLBGvebtjQoRjp+wXTMCDw=;
        b=jqqd9lk1AkF2Kkaf99e0w3dMJEoA8CJShJ27yK/C5+O5Z0lVieN1liMmBW496tvlBT
         p4FXyDovqKCmZrMsb7F4Ut1ntomYhB0mkkU3uFE91HhijVKUiOzJx0LoiCJJHshvGjOn
         GPqw57ZMH6AQGUOXS0PTv7o+qMlpINHINFiu73cAbgFVUBxdt5yl0FCYVj03kOl0T8Rd
         jTwc41geD7IEUcrsRlWn2LjGy8nAtvv3SL90RxYk7r+PTmWKgTE7JKUvFe/sfYfvK3V/
         hZ0bl5wqm//MpTloANKt1BjDSMgEM+xgsotJ/n/HqbmnGNxskcQHIa5UXQUFa5joUjfk
         N3Wg==
X-Gm-Message-State: AOJu0Yxdv5p4vDL0o8cW0bsmVNQiJgKqjGImV9FurZNTDVVCWQg0S5MF
	MeFnABfKKdhz8P3wnFONqy5+eE7QhFBduTENizuZri04NsY273BJRFZANznutQqAkXg56+tTZGJ
	bHIrSdAbc2tFX6pzzlujJj2UZ
X-Received: by 2002:a05:600c:19d1:b0:40b:4268:f375 with SMTP id u17-20020a05600c19d100b0040b4268f375mr5201151wmq.36.1701157360941;
        Mon, 27 Nov 2023 23:42:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE53k66r5nMv2GqUUxSBwpFlLDQ3zS3AaZuf2whu3bEH/EglPV34ja5GP+W5nD3vDIW9KcsQg==
X-Received: by 2002:a05:600c:19d1:b0:40b:4268:f375 with SMTP id u17-20020a05600c19d100b0040b4268f375mr5201138wmq.36.1701157360670;
        Mon, 27 Nov 2023 23:42:40 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id p34-20020a05600c1da200b00406408dc788sm17210463wms.44.2023.11.27.23.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:42:40 -0800 (PST)
Message-ID: <78f8ff04c20c45525321247336e16d06063e57d0.camel@redhat.com>
Subject: Re: [RFC 19/33] KVM: x86: Decouple
 kvm_range_has_memory_attributes() from struct kvm's mem_attr_array
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
 anelkz@amazon.com,  graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
 corbert@lwn.net,  kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, x86@kernel.org,  linux-doc@vger.kernel.org
Date: Tue, 28 Nov 2023 09:42:38 +0200
In-Reply-To: <20231108111806.92604-20-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
	 <20231108111806.92604-20-nsaenz@amazon.com>
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
> Decouple kvm_range_has_memory_attributes() from struct kvm's
> mem_attr_array to allow other memory attribute sources to use the
> function.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c   | 3 ++-
>  include/linux/kvm_host.h | 4 ++--
>  virt/kvm/kvm_main.c      | 9 +++++----
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 96421234ca88..4ace2f8660b0 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7297,7 +7297,8 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
>  
>  	if (level == PG_LEVEL_2M)
> -		return kvm_range_has_memory_attributes(kvm, start, end, attrs);
> +		return kvm_range_has_memory_attributes(&kvm->mem_attr_array,
> +						       start, end, attrs);
>  
>  	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
>  		if (hugepage_test_mixed(slot, gfn, level - 1) ||
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4242588e3dfb..32cf05637647 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2391,8 +2391,8 @@ kvm_get_memory_attributes(struct xarray *mem_attr_array, gfn_t gfn)
>  	return xa_to_value(xa_load(mem_attr_array, gfn));
>  }
>  
> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> -				     unsigned long attrs);
> +bool kvm_range_has_memory_attributes(struct xarray *mem_attr_array, gfn_t start,
> +				     gfn_t end, unsigned long attrs);
>  bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>  					struct kvm_gfn_range *range);
>  bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fde004a0ac46..6bb23eaf7aa6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2440,10 +2440,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>   * Returns true if _all_ gfns in the range [@start, @end) have attributes
>   * matching @attrs.
>   */
> -bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
> -				     unsigned long attrs)
> +bool kvm_range_has_memory_attributes(struct xarray *mem_attr_array, gfn_t start,
> +				     gfn_t end, unsigned long attrs)
>  {
> -	XA_STATE(xas, &kvm->mem_attr_array, start);
> +	XA_STATE(xas, mem_attr_array, start);
>  	unsigned long index;
>  	bool has_attrs;
>  	void *entry;
> @@ -2582,7 +2582,8 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>  	mutex_lock(&kvm->slots_lock);
>  
>  	/* Nothing to do if the entire range as the desired attributes. */
> -	if (kvm_range_has_memory_attributes(kvm, start, end, attributes))
> +	if (kvm_range_has_memory_attributes(&kvm->mem_attr_array, start, end,
> +					    attributes))
>  		goto out_unlock;
>  
>  	/*


Same comments as for previous patch + how about 
'kvm_gfn_range_has_memory_attributes'

(I didn't review the memfd patch series and it shows :( )

Best regards,
	Maxim Levitsky




