Return-Path: <linux-hyperv+bounces-1080-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B74E7FB2A8
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 08:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368BE281DD4
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 07:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22431134AF;
	Tue, 28 Nov 2023 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWOV07Ju"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F1182
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701156368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5IfKQ0g84TQ0CBoWOqqFsM6EdM4fH6opAzeKUDu0Ps=;
	b=FWOV07JuCOAKwrMiEhXvEtZWEtdas78DC5YKWX+tWkt56o36na6Zqn9n600kvPvLPZ9CNL
	kVt63Yp++8HGoZjQkEhSAwUHvjXBGr/j33EtGfe08WcA+IrQaGkD6eUjvKNH2+rW2xOcCX
	0uIFmxRn8S+D5i7fEYPDo49RoDwLcXw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-TTMD6NkhMLWcbTIFumSWUQ-1; Tue, 28 Nov 2023 02:26:06 -0500
X-MC-Unique: TTMD6NkhMLWcbTIFumSWUQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332f62126e9so2395249f8f.3
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156366; x=1701761166;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5IfKQ0g84TQ0CBoWOqqFsM6EdM4fH6opAzeKUDu0Ps=;
        b=Cw8p0KqdRwoX+Se1UUPIYOgZHqV39VLJ5CDSpnKxJyi3FDrcwVqZ9BlYOxB+zERW/9
         KIUh3eX8HTCdA/bytc/Y3d9wcUehVN5t1dZtVaPjWuAmJnkalWNJh9mAu4E9iT7MC69Z
         sJKn8W4ARigl0ZG4xGbtTjRSj9Vpfk5LLHrCQ4ZGP15Z7vWK2PyZYn6svMg8FbH9pEA0
         xj3zkzo3upHUvfAE47yWnNuAmwpC7hPoFyxVYeJJh35+3PmO4ekqOwLZYz0b0BXNiG6T
         CCAD+nbzFYHrr/v0KGwT61GUljPYKA8Yr3TuTDWk0/pmYjEKnvQvm7bqJaPhGbjewqlC
         STqA==
X-Gm-Message-State: AOJu0YxzXUVsOCA0ECiX2mHrDtQQSoVLjvgH52jSXCgC7ig4xx2w3nLN
	KmiJ3jgjDtciDeL9yBo1ZZD4jKA38x0BzZbkArfC6n1wePefzL58/tTkh1xxjPVpKKZQcmPfsEY
	bo+YcIiwh/mjibctkhFgwoTGZ
X-Received: by 2002:a05:6000:181b:b0:332:ca1e:679f with SMTP id m27-20020a056000181b00b00332ca1e679fmr9682398wrh.52.1701156365805;
        Mon, 27 Nov 2023 23:26:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaJGFX6B/K1UfnpX1yOqrEoYh9k4p+2e/D0ADxJMH+MoA3HjH19LZOIpIrTtOHL2qAxvn/VA==
X-Received: by 2002:a05:6000:181b:b0:332:ca1e:679f with SMTP id m27-20020a056000181b00b00332ca1e679fmr9682371wrh.52.1701156365500;
        Mon, 27 Nov 2023 23:26:05 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm13962130wrc.95.2023.11.27.23.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:26:05 -0800 (PST)
Message-ID: <e85f7a3542f6ec2bd9fb378c5da699f544dfd805.camel@redhat.com>
Subject: Re: [RFC 10/33] KVM: x86: hyper-v: Introduce KVM_HV_GET_VSM_STATE
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
 anelkz@amazon.com,  graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
 corbert@lwn.net,  kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, x86@kernel.org,  linux-doc@vger.kernel.org
Date: Tue, 28 Nov 2023 09:26:03 +0200
In-Reply-To: <20231108111806.92604-11-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
	 <20231108111806.92604-11-nsaenz@amazon.com>
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
> HVCALL_GET_VP_REGISTERS exposes the VTL call hypercall page entry
> offsets to the guest. This hypercall is implemented in user-space while
> the hypercall page patching happens in-kernel. So expose it as part of
> the partition wide VSM state.
> 
> NOTE: Alternatively there is the option of sharing this information
> through a VTL KVM device attribute (the device is introduced in
> subsequent patches).
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/include/uapi/asm/kvm.h |  5 +++++
>  arch/x86/kvm/hyperv.c           |  8 ++++++++
>  arch/x86/kvm/hyperv.h           |  2 ++
>  arch/x86/kvm/x86.c              | 18 ++++++++++++++++++
>  include/uapi/linux/kvm.h        |  4 ++++
>  5 files changed, 37 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index f73d137784d7..370483d5d5fd 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -570,4 +570,9 @@ struct kvm_apic_id_groups {
>  	__u8 n_bits; /* nr of bits used to represent group in the APIC ID */
>  };
>  
> +/* for KVM_HV_GET_VSM_STATE */
> +struct kvm_hv_vsm_state {
> +	__u64 vsm_code_page_offsets;
> +};
> +
>  #endif /* _ASM_X86_KVM_H */
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 2cf430f6ddd8..caaa859932c5 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2990,3 +2990,11 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  
>  	return 0;
>  }
> +
> +int kvm_vm_ioctl_get_hv_vsm_state(struct kvm *kvm, struct kvm_hv_vsm_state *state)
> +{
> +	struct kvm_hv* hv = &kvm->arch.hyperv;
> +
> +	state->vsm_code_page_offsets = hv->vsm_code_page_offsets.as_u64;
> +	return 0;
> +}
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 5433107e7cc8..b3d1113efe82 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -261,4 +261,6 @@ static inline bool kvm_hv_vsm_enabled(struct kvm *kvm)
>         return kvm->arch.hyperv.hv_enable_vsm;
>  }
>  
> +int kvm_vm_ioctl_get_hv_vsm_state(struct kvm *kvm, struct kvm_hv_vsm_state *state);
> +
>  #endif
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b0512e433032..57f9c58e1e32 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7132,6 +7132,24 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		r = kvm_vm_ioctl_set_apic_id_groups(kvm, &groups);
>  		break;
>  	}
> +	case KVM_HV_GET_VSM_STATE: {
> +		struct kvm_hv_vsm_state vsm_state;
> +
> +		r = -EINVAL;
> +		if (!kvm_hv_vsm_enabled(kvm))
> +			goto out;
> +
> +		r = kvm_vm_ioctl_get_hv_vsm_state(kvm, &vsm_state);
> +		if (r)
> +			goto out;
> +
> +		r = -EFAULT;
> +		if (copy_to_user(argp, &vsm_state, sizeof(vsm_state)))
> +			goto out;
> +
> +		r = 0;
> +		break;
> +	}
>  	default:
>  		r = -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 168b6ac6ebe5..03f5c08fd7aa 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -2316,4 +2316,8 @@ struct kvm_create_guest_memfd {
>  #define KVM_GUEST_MEMFD_ALLOW_HUGEPAGE		(1ULL << 0)
>  
>  #define KVM_SET_APIC_ID_GROUPS _IOW(KVMIO, 0xd7, struct kvm_apic_id_groups)
> +
> +/* Get/Set Hyper-V VSM state. Available with KVM_CAP_HYPERV_VSM */
> +#define KVM_HV_GET_VSM_STATE _IOR(KVMIO, 0xd5, struct kvm_hv_vsm_state)
> +
>  #endif /* __LINUX_KVM_H */

Looks reasonable but if we do hypercall patching in userspace as I suggested,
we might not need this.

Best regards,
	Maxim Levitsky






