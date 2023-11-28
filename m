Return-Path: <linux-hyperv+bounces-1087-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483617FB2F0
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 08:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764DD1C20B4C
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26813FF3;
	Tue, 28 Nov 2023 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGynDuZ4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A75D41
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701157195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLrNRkdD5Hr4y2mW5Po+XDD+kga+nzWJCxtSKJ7NmZ4=;
	b=OGynDuZ4AG07T2D4BZDhjZyRwK+XbXfEFKShY55b2hZYh6r/EH7rqtOi9Fl/uIry9tpuhS
	PZGq9zFQWHGDA+87S1Y1tDyChNXBqtZmpLODCmNHWsKRfopwtCnG4mMpw4BU83aWdpr6DD
	qofiDp2W1TGd9kWXu5udZtFk7pjij0c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-RZl8efOiN7Kn7oW3WpnKnw-1; Tue, 28 Nov 2023 02:39:53 -0500
X-MC-Unique: RZl8efOiN7Kn7oW3WpnKnw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b29875913so30299985e9.0
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157192; x=1701761992;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLrNRkdD5Hr4y2mW5Po+XDD+kga+nzWJCxtSKJ7NmZ4=;
        b=fVusQ5zPVlizJ4vauvsnGnYRE8MyQW1p0rl00FxfrzaQJXYSzQ+6EMfSc668LmxDhH
         XtwIyZZeQYSi/nas4D78DdjwNZSSyG8bKcKw3cR2rilGc/0l4yICwB6/FaQEgUqIBZLG
         NKcGQjByLqAyokyfLZc2XKAwshVwKeRhJCIaZTJ7eDjgDhZ/N+CFLadILZNhGEaK5d80
         TPp7p0DSeNeFOBspir+8PNm59F/8e9wSd33S6XsjrLu4cJ1kO8PwmOnmEFqjpxBffC+k
         5UMkLILwk7ITG01J+caE7aeeWUovGa9ducQ2a1vq2DlvqoLpr3utOl/QuKZX2Okq3gqx
         owyA==
X-Gm-Message-State: AOJu0YyKKCFXLQYFpuSekoV6pWOpJCoJYgLIjEq3KSmQysb8n4BL894t
	1FKY01kn/ilpwUZj/vvutETP7k0Dmy23MIsZr4XG+HwIz91CBmmzu5pWaKg67lfWXbCmGe+BAUE
	QF3/k/zGvFF2pkJUEvfXWzBO+
X-Received: by 2002:adf:da45:0:b0:333:d38:9cf8 with SMTP id r5-20020adfda45000000b003330d389cf8mr703339wrl.23.1701157192448;
        Mon, 27 Nov 2023 23:39:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERlzB4vdViVC/ZzK0126j8AEfeNbvrpu7qTpdFP9K+CAsLwSGT0XYxI2khjFZG7X1sLqDpUg==
X-Received: by 2002:adf:da45:0:b0:333:d38:9cf8 with SMTP id r5-20020adfda45000000b003330d389cf8mr703318wrl.23.1701157192138;
        Mon, 27 Nov 2023 23:39:52 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d4a8e000000b00332e073f12bsm14064219wrq.19.2023.11.27.23.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:39:51 -0800 (PST)
Message-ID: <31cd6a37f565e07f3890027b3b3305a225f84956.camel@redhat.com>
Subject: Re: [RFC 17/33] KVM: x86/mmu: Allow setting memory attributes if
 VSM enabled
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
 anelkz@amazon.com,  graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
 corbert@lwn.net,  kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, x86@kernel.org,  linux-doc@vger.kernel.org
Date: Tue, 28 Nov 2023 09:39:49 +0200
In-Reply-To: <20231108111806.92604-18-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
	 <20231108111806.92604-18-nsaenz@amazon.com>
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
> VSM is also a user of memory attributes, so let it use
> kvm_set_mem_attributes().
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index feca077c0210..a1fbb905258b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7265,7 +7265,8 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>  	 * Zapping SPTEs in this case ensures KVM will reassess whether or not
>  	 * a hugepage can be used for affected ranges.
>  	 */
> -	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
> +	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm) &&
> +			 !kvm_hv_vsm_enabled(kvm)))
>  		return false;

IMHO on the long term, memory attributes should either be always enabled,
or the above check should became more generic.

But otherwise this patch looks reasonable.

>  
>  	return kvm_unmap_gfn_range(kvm, range);
> @@ -7322,7 +7323,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>  	 * a range that has PRIVATE GFNs, and conversely converting a range to
>  	 * SHARED may now allow hugepages.
>  	 */
> -	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
> +	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm) &&
> +			 !kvm_hv_vsm_enabled(kvm)))
>  		return false;
>  
>  	/*

Best regards,
	Maxim Levitsky


