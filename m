Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D7B46E602
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Dec 2021 10:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhLIJ73 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Dec 2021 04:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229952AbhLIJ72 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Dec 2021 04:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639043755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tifu8jPxoXiPodobNqLDC7Ur+Twa+ScoTD0T3Hcu8HE=;
        b=HwGgK2AGdxofrS3IYWN+nY6hMzY77JyTmx4IM2ClxfMtVdFc1+Wj5FW+DU2x8k9msNf17g
        D9ytMxtjl+Lj6LFvLpBK+khbMdrkpAjMEDkvfWzbFroXcdnavi84zpnN3a8K1G5DnnU3hn
        FN2IwqQfootuNF6xm9Ooay6I7sp+6Dg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-sZtEFSB0PeeEpmLzPJ2Sgw-1; Thu, 09 Dec 2021 04:55:54 -0500
X-MC-Unique: sZtEFSB0PeeEpmLzPJ2Sgw-1
Received: by mail-ed1-f69.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so4793981edx.4
        for <linux-hyperv@vger.kernel.org>; Thu, 09 Dec 2021 01:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Tifu8jPxoXiPodobNqLDC7Ur+Twa+ScoTD0T3Hcu8HE=;
        b=3aC32wqw37s8QBXy4D4XJ7b8Hno5rXkJ/dlVHrvgW/FIZdMneDa0tEEgcAk5nWr8C5
         E+jLZ+c9j0w42uOZ7dccekDTJKWSmSXzgdEgGtcT0YzH1yAVIRH1HATq4lctQT7vGVZd
         RqFcuFtLlmeWTZtomqTe7HH1LuTZu/53pwXcEfXep4G6V56rUeb6B+f0MTmmKNon/9w6
         aNd4ucLF6pWPQCxqUE3ha6YXLZsoRnrh2bPtNvMOKgFLzAIFqd30Nm/UyiS7rMFdCCnR
         XLP2JBgCOi9xQi/3MHl3wu5Dmz1dT1d5wLeuuC64N0GWaWHyPrUOC319m1CVXjT8jzl8
         gsGw==
X-Gm-Message-State: AOAM533X7GYJd/yOSsNM4cWzBwfHRF0EGvJ+vWvmKKV0fIsT8kjb/EsC
        X4RYWo5twf0N/Jw9ACFrRPZZ2wAES/Vn28xqcV9hcozxcDgBYuVnUpzTZRCQlkXcgFZSGRJwOdq
        vDSWV7UMQwSxRQHOPDfZXRsKq
X-Received: by 2002:a50:d710:: with SMTP id t16mr27488347edi.50.1639043752305;
        Thu, 09 Dec 2021 01:55:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6QqCxdit+LRk7iJREbeQBji1uNqG143rwxeUhxS89nG10fe15dcnhEv1m6U1xRuvyXnf4ng==
X-Received: by 2002:a50:d710:: with SMTP id t16mr27488319edi.50.1639043752085;
        Thu, 09 Dec 2021 01:55:52 -0800 (PST)
Received: from fedora (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f7sm3251022edw.44.2021.12.09.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 01:55:51 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 7/8] KVM: x86: Reject fixeds-size Hyper-V hypercalls
 with non-zero "var_cnt"
In-Reply-To: <20211207220926.718794-8-seanjc@google.com>
References: <20211207220926.718794-1-seanjc@google.com>
 <20211207220926.718794-8-seanjc@google.com>
Date:   Thu, 09 Dec 2021 10:55:50 +0100
Message-ID: <87lf0u3xw9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Reject Hyper-V hypercalls if the guest specifies a non-zero variable size
> header (var_cnt in KVM) for a hypercall that has a fixed header size.
> Per the TLFS:
>
>   It is illegal to specify a non-zero variable header size for a
>   hypercall that is not explicitly documented as accepting variable sized
>   input headers. In such a case the hypercall will result in a return
>   code of HV_STATUS_INVALID_HYPERCALL_INPUT.
>
> Note, at least some of the various DEBUG commands likely aren't allowed
> to use variable size headers, but the TLFS documentation doesn't clearly
> state what is/isn't allowed.  Omit them for now to avoid unnecessary
> breakage.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/hyperv.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index f33a5e890048..522ccd2f0db4 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2250,14 +2250,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  
>  	switch (hc.code) {
>  	case HVCALL_NOTIFY_LONG_SPIN_WAIT:
> -		if (unlikely(hc.rep)) {
> +		if (unlikely(hc.rep || hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
>  		kvm_vcpu_on_spin(vcpu, true);
>  		break;
>  	case HVCALL_SIGNAL_EVENT:
> -		if (unlikely(hc.rep)) {
> +		if (unlikely(hc.rep || hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
> @@ -2267,7 +2267,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  		fallthrough;	/* maybe userspace knows this conn_id */
>  	case HVCALL_POST_MESSAGE:
>  		/* don't bother userspace if it has no way to handle it */
> -		if (unlikely(hc.rep || !to_hv_synic(vcpu)->active)) {
> +		if (unlikely(hc.rep || hc.var_cnt || !to_hv_synic(vcpu)->active)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
> @@ -2280,14 +2280,14 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  				kvm_hv_hypercall_complete_userspace;
>  		return 0;
>  	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST:
> -		if (unlikely(!hc.rep_cnt || hc.rep_idx)) {
> +		if (unlikely(!hc.rep_cnt || hc.rep_idx || hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
>  		ret = kvm_hv_flush_tlb(vcpu, &hc, false);
>  		break;
>  	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE:
> -		if (unlikely(hc.rep)) {
> +		if (unlikely(hc.rep || hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}
> @@ -2308,7 +2308,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  		ret = kvm_hv_flush_tlb(vcpu, &hc, true);
>  		break;
>  	case HVCALL_SEND_IPI:
> -		if (unlikely(hc.rep)) {
> +		if (unlikely(hc.rep || hc.var_cnt)) {
>  			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
>  			break;
>  		}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

