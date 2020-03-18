Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8B189C92
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2020 14:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCRNIe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 09:08:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37208 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbgCRNId (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 09:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584536911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rgQWgNAnHE0vogwLTsh7kx32rUCgr1d0X8J6mCgZzcY=;
        b=JYw6y8j+D3Q16qMkXAwZl71bLTmujGw/DW3mhHn95UqgdyuU1QGujFgx+3YRnUZmBf90yi
        cUuB5Iyk9z+jW6VLT4cIBagAuxTIBeu6h7kgXynrowWIokA83u5x3onSOPmoel6v1PIoB6
        fSYoks0hIqfAi70zgCY69zW06ik9iJI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-B4DbbyuYNEOLFSqC3u7CbQ-1; Wed, 18 Mar 2020 09:08:29 -0400
X-MC-Unique: B4DbbyuYNEOLFSqC3u7CbQ-1
Received: by mail-wr1-f69.google.com with SMTP id 94so7668130wrr.3
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2020 06:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rgQWgNAnHE0vogwLTsh7kx32rUCgr1d0X8J6mCgZzcY=;
        b=g6f8638bxVMD8KWybiPbEfU/jWoVoFTKoRHw1FWM+DN3nWLQ2P0J8t1HdrPUwXD92s
         TDWDVpOcio7+64lhcqEPvFRnSrC2qa5rX3Km/jgP24+10GXBTyw5rMHT4oifGPr6rR3o
         UjnsnueS3muTTj+Tq5Zq/qZ+zU+FPoo1O1FerwLfiJ5PDNUH0zxwXSb6qgm3PjpmdYcF
         9FnXddGLe3Sl3LL/EEu+PRcW3hEsIuwve4+VSMmUYdrjNVC1yW7VgiAwieaLjyIvZ8mq
         p7d7e+VyvgVX0FB67wnN5jWDtYx55/gcUNmqvAs+pTeRJi3gaBj7h1wxYNhpWazKfF5B
         3f3A==
X-Gm-Message-State: ANhLgQ1pNCtAX0vrCqjaFwmwnZipujTlY1/x1lYzzSBQDaH9+AN812rV
        0oJ4Uw3SURrhxoU8gDVnoJdphP1rqg+Ok9RGCFUvZFhj90TICOWhwmYq9v+o0vatytqTjEQFbM2
        l4cBB4n9xRZQqhTvRS+S5MYS3
X-Received: by 2002:a05:600c:22cd:: with SMTP id 13mr5124173wmg.186.1584536908410;
        Wed, 18 Mar 2020 06:08:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvAiRQHYa0vgKqnslAPBl/GKq2dQGW5hzeIf5K3cnZyHhAMWsSZ0jFzGMEqhvCa6NxW192qTQ==
X-Received: by 2002:a05:600c:22cd:: with SMTP id 13mr5124128wmg.186.1584536907812;
        Wed, 18 Mar 2020 06:08:27 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w81sm3831106wmg.19.2020.03.18.06.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:08:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Doron <arilou@gmail.com>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v6 3/5] x86/kvm/hyper-v: Add support for synthetic debugger capability
In-Reply-To: <20200317034804.112538-4-arilou@gmail.com>
References: <20200317034804.112538-1-arilou@gmail.com> <20200317034804.112538-4-arilou@gmail.com>
Date:   Wed, 18 Mar 2020 14:08:26 +0100
Message-ID: <87o8st3j5h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jon Doron <arilou@gmail.com> writes:

> Add support for Hyper-V synthetic debugger (syndbg) interface.
> The syndbg interface is using MSRs to emulate a way to send/recv packets
> data.
>
> The debug transport dll (kdvm/kdnet) will identify if Hyper-V is enabled
> and if it supports the synthetic debugger interface it will attempt to
> use it, instead of trying to initialize a network adapter.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  Documentation/virt/kvm/api.rst  |  16 ++++
>  arch/x86/include/asm/kvm_host.h |  13 +++
>  arch/x86/kvm/hyperv.c           | 135 +++++++++++++++++++++++++++++++-
>  arch/x86/kvm/hyperv.h           |   5 ++
>  arch/x86/kvm/trace.h            |  51 ++++++++++++
>  arch/x86/kvm/x86.c              |   9 +++
>  include/uapi/linux/kvm.h        |  11 +++
>  7 files changed, 239 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 4872c47bbcff..fe992dcf4f93 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5024,6 +5024,7 @@ EOI was received.
>  		struct kvm_hyperv_exit {
>    #define KVM_EXIT_HYPERV_SYNIC          1
>    #define KVM_EXIT_HYPERV_HCALL          2
> +  #define KVM_EXIT_HYPERV_SYNDBG         3
>  			__u32 type;
>  			__u32 pad1;
>  			union {
> @@ -5039,6 +5040,15 @@ EOI was received.
>  					__u64 result;
>  					__u64 params[2];
>  				} hcall;
> +				struct {
> +					__u32 msr;
> +					__u32 pad2;
> +					__u64 control;
> +					__u64 status;
> +					__u64 send_page;
> +					__u64 recv_page;
> +					__u64 pending_page;
> +				} syndbg;
>  			} u;
>  		};
>  		/* KVM_EXIT_HYPERV */
> @@ -5055,6 +5065,12 @@ Hyper-V SynIC state change. Notification is used to remap SynIC
>  event/message pages and to enable/disable SynIC messages/events processing
>  in userspace.
>  
> +	- KVM_EXIT_HYPERV_SYNDBG -- synchronously notify user-space about
> +
> +Hyper-V Synthetic debugger state change. Notification is used to either update
> +the pending_page location or to send a control command (send the buffer located
> +in send_page or recv a buffer to recv_page).
> +
>  ::
>  
>  		/* KVM_EXIT_ARM_NISV */
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 98959e8cd448..f8e58e8866bb 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -854,6 +854,18 @@ struct kvm_apic_map {
>  	struct kvm_lapic *phys_map[];
>  };
>  
> +/* Hyper-V synthetic debugger (SynDbg)*/
> +struct kvm_hv_syndbg {
> +	struct {
> +		u64 control;
> +		u64 status;
> +		u64 send_page;
> +		u64 recv_page;
> +		u64 pending_page;
> +	} control;
> +	u64 options;
> +};
> +
>  /* Hyper-V emulation context */
>  struct kvm_hv {
>  	struct mutex hv_lock;
> @@ -877,6 +889,7 @@ struct kvm_hv {
>  	atomic_t num_mismatched_vp_indexes;
>  
>  	struct hv_partition_assist_pg *hv_pa_pg;
> +	struct kvm_hv_syndbg hv_syndbg;
>  };
>  
>  enum kvm_irqchip_mode {
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index a86fda7a1d03..b6a97abe2bc9 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -266,6 +266,107 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
>  	return ret;
>  }
>  
> +static int kvm_hv_syndbg_complete_userspace(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_hv *hv = &kvm->arch.hyperv;
> +
> +	if (vcpu->run->hyperv.u.syndbg.msr == HV_X64_MSR_SYNDBG_CONTROL)
> +		hv->hv_syndbg.control.status =
> +			vcpu->run->hyperv.u.syndbg.status;
> +	return 1;
> +}
> +
> +static void syndbg_exit(struct kvm_vcpu *vcpu, u32 msr)
> +{
> +	struct kvm_hv_syndbg *syndbg = vcpu_to_hv_syndbg(vcpu);
> +	struct kvm_vcpu_hv *hv_vcpu = &vcpu->arch.hyperv;
> +
> +	hv_vcpu->exit.type = KVM_EXIT_HYPERV_SYNDBG;
> +	hv_vcpu->exit.u.syndbg.msr = msr;
> +	hv_vcpu->exit.u.syndbg.control = syndbg->control.control;
> +	hv_vcpu->exit.u.syndbg.send_page = syndbg->control.send_page;
> +	hv_vcpu->exit.u.syndbg.recv_page = syndbg->control.recv_page;
> +	hv_vcpu->exit.u.syndbg.pending_page = syndbg->control.pending_page;
> +	vcpu->arch.complete_userspace_io =
> +			kvm_hv_syndbg_complete_userspace;
> +
> +	kvm_make_request(KVM_REQ_HV_EXIT, vcpu);
> +}
> +
> +static int syndbg_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
> +{
> +	struct kvm_hv_syndbg *syndbg = vcpu_to_hv_syndbg(vcpu);
> +	int ret;

Minor nitpick: you could've initialized 'ret' to '0' here. But actually,
looking at the code, you don't really need the return value as 'default'
case can just BUG(): this can never happen. The whole function can be
'void'.

> +
> +	trace_kvm_hv_syndbg_set_msr(vcpu->vcpu_id,
> +				    vcpu_to_hv_vcpu(vcpu)->vp_index, msr, data);
> +	ret = 0;
> +	switch (msr) {
> +	case HV_X64_MSR_SYNDBG_CONTROL:
> +		syndbg->control.control = data;
> +		syndbg_exit(vcpu, msr);
> +		break;
> +	case HV_X64_MSR_SYNDBG_STATUS:
> +		syndbg->control.status = data;
> +		break;
> +	case HV_X64_MSR_SYNDBG_SEND_BUFFER:
> +		syndbg->control.send_page = data;
> +		break;
> +	case HV_X64_MSR_SYNDBG_RECV_BUFFER:
> +		syndbg->control.recv_page = data;
> +		break;
> +	case HV_X64_MSR_SYNDBG_PENDING_BUFFER:
> +		syndbg->control.pending_page = data;
> +		syndbg_exit(vcpu, msr);
> +		break;
> +	case HV_X64_MSR_SYNDBG_OPTIONS:
> +		syndbg->options = data;
> +		break;
> +	default:
> +		ret = 1;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int syndbg_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
> +{
> +	struct kvm_hv_syndbg *syndbg = vcpu_to_hv_syndbg(vcpu);
> +	int ret;
> +
> +	ret = 0;

Same comment as the above.

> +	switch (msr) {
> +	case HV_X64_MSR_SYNDBG_CONTROL:
> +		*pdata = syndbg->control.control;
> +		break;
> +	case HV_X64_MSR_SYNDBG_STATUS:
> +		*pdata = syndbg->control.status;
> +		break;
> +	case HV_X64_MSR_SYNDBG_SEND_BUFFER:
> +		*pdata = syndbg->control.send_page;
> +		break;
> +	case HV_X64_MSR_SYNDBG_RECV_BUFFER:
> +		*pdata = syndbg->control.recv_page;
> +		break;
> +	case HV_X64_MSR_SYNDBG_PENDING_BUFFER:
> +		*pdata = syndbg->control.pending_page;
> +		break;
> +	case HV_X64_MSR_SYNDBG_OPTIONS:
> +		*pdata = syndbg->options;
> +		break;
> +	default:
> +		ret = 1;
> +		break;
> +	}
> +
> +	trace_kvm_hv_syndbg_get_msr(vcpu->vcpu_id,
> +				    vcpu_to_hv_vcpu(vcpu)->vp_index, msr,
> +				    *pdata);
> +	return ret;
> +}
> +
>  static int synic_get_msr(struct kvm_vcpu_hv_synic *synic, u32 msr, u64 *pdata,
>  			 bool host)
>  {
> @@ -800,6 +901,8 @@ static bool kvm_hv_msr_partition_wide(u32 msr)
>  	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
>  	case HV_X64_MSR_TSC_EMULATION_CONTROL:
>  	case HV_X64_MSR_TSC_EMULATION_STATUS:
> +	case HV_X64_MSR_SYNDBG_OPTIONS:
> +	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
>  		r = true;
>  		break;
>  	}
> @@ -1061,6 +1164,9 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
>  		if (!host)
>  			return 1;
>  		break;
> +	case HV_X64_MSR_SYNDBG_OPTIONS:
> +	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
> +		return syndbg_set_msr(vcpu, msr, data);
>  	default:
>  		vcpu_unimpl(vcpu, "Hyper-V unhandled wrmsr: 0x%x data 0x%llx\n",
>  			    msr, data);
> @@ -1227,6 +1333,9 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
>  	case HV_X64_MSR_TSC_EMULATION_STATUS:
>  		data = hv->hv_tsc_emulation_status;
>  		break;
> +	case HV_X64_MSR_SYNDBG_OPTIONS:
> +	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
> +		return syndbg_get_msr(vcpu, msr, pdata);
>  	default:
>  		vcpu_unimpl(vcpu, "Hyper-V unhandled rdmsr: 0x%x\n", msr);
>  		return 1;
> @@ -1797,6 +1906,9 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  		{ .function = HYPERV_CPUID_ENLIGHTMENT_INFO },
>  		{ .function = HYPERV_CPUID_IMPLEMENT_LIMITS },
>  		{ .function = HYPERV_CPUID_NESTED_FEATURES },
> +		{ .function = HYPERV_CPUID_SYNDBG_VENDOR_AND_MAX_FUNCTIONS },
> +		{ .function = HYPERV_CPUID_SYNDBG_INTERFACE },
> +		{ .function = HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES	},
>  	};
>  	int i, nent = ARRAY_SIZE(cpuid_entries);
>  
> @@ -1821,7 +1933,7 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  		case HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS:
>  			memcpy(signature, "Linux KVM Hv", 12);
>  
> -			ent->eax = HYPERV_CPUID_NESTED_FEATURES;
> +			ent->eax = HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES;

This should depend on KVM_CAP_HYPERV_DEBUGGING being enabled (see below).

>  			ent->ebx = signature[0];
>  			ent->ecx = signature[1];
>  			ent->edx = signature[2];
> @@ -1856,9 +1968,12 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  
>  			ent->ebx |= HV_X64_POST_MESSAGES;
>  			ent->ebx |= HV_X64_SIGNAL_EVENTS;
> +			ent->ebx |= HV_X64_DEBUGGING;
>  
>  			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>  			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
> +			ent->edx |= HV_X64_GUEST_DEBUGGING_AVAILABLE;
> +			ent->edx |= HV_FEATURE_DEBUG_MSRS_AVAILABLE;
>  
>  			/*
>  			 * Direct Synthetic timers only make sense with in-kernel
> @@ -1903,6 +2018,24 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  
>  			break;
>  
> +		case HYPERV_CPUID_SYNDBG_VENDOR_AND_MAX_FUNCTIONS:
> +			memcpy(signature, "Linux KVM Hv", 12);
> +
> +			ent->eax = 0;
> +			ent->ebx = signature[0];
> +			ent->ecx = signature[1];
> +			ent->edx = signature[2];
> +			break;
> +
> +		case HYPERV_CPUID_SYNDBG_INTERFACE:
> +			memcpy(signature, "VS#1\0\0\0\0\0\0\0\0", 12);
> +			ent->eax = signature[0];
> +			break;
> +
> +		case HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES:
> +			ent->eax |= HV_X64_SYNDBG_CAP_ALLOW_KERNEL_DEBUGGING;
> +			break;
> +
>  		default:
>  			break;
>  		}
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 5e4780bf6dd7..29729258fa49 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -73,6 +73,11 @@ static inline struct kvm_vcpu *synic_to_vcpu(struct kvm_vcpu_hv_synic *synic)
>  	return hv_vcpu_to_vcpu(container_of(synic, struct kvm_vcpu_hv, synic));
>  }
>  
> +static inline struct kvm_hv_syndbg *vcpu_to_hv_syndbg(struct kvm_vcpu *vcpu)
> +{
> +	return &vcpu->kvm->arch.hyperv.hv_syndbg;
> +}
> +
>  int kvm_hv_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host);
>  int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host);
>  
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index f194dd058470..bf6c3852868d 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -1515,6 +1515,57 @@ TRACE_EVENT(kvm_nested_vmenter_failed,
>  		__print_symbolic(__entry->err, VMX_VMENTER_INSTRUCTION_ERRORS))
>  );
>  
> +/*
> + * Tracepoint for syndbg_set_msr.
> + */
> +TRACE_EVENT(kvm_hv_syndbg_set_msr,
> +	TP_PROTO(int vcpu_id, u32 vp_index, u32 msr, u64 data),
> +	TP_ARGS(vcpu_id, vp_index, msr, data),
> +
> +	TP_STRUCT__entry(
> +		__field(int, vcpu_id)
> +		__field(u32, vp_index)
> +		__field(u32, msr)
> +		__field(u64, data)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->vcpu_id = vcpu_id;
> +		__entry->vp_index = vp_index;
> +		__entry->msr = msr;
> +		__entry->data = data;
> +	),
> +
> +	TP_printk("vcpu_id %d vp_index %u msr 0x%x data 0x%llx",
> +		  __entry->vcpu_id, __entry->vp_index, __entry->msr,
> +		  __entry->data)
> +);
> +
> +/*
> + * Tracepoint for syndbg_get_msr.
> + */
> +TRACE_EVENT(kvm_hv_syndbg_get_msr,
> +	TP_PROTO(int vcpu_id, u32 vp_index, u32 msr, u64 data),
> +	TP_ARGS(vcpu_id, vp_index, msr, data),
> +
> +	TP_STRUCT__entry(
> +		__field(int, vcpu_id)
> +		__field(u32, vp_index)
> +		__field(u32, msr)
> +		__field(u64, data)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->vcpu_id = vcpu_id;
> +		__entry->vp_index = vp_index;
> +		__entry->msr = msr;
> +		__entry->data = data;
> +	),
> +
> +	TP_printk("vcpu_id %d vp_index %u msr 0x%x data 0x%llx",
> +		  __entry->vcpu_id, __entry->vp_index, __entry->msr,
> +		  __entry->data)
> +);
>  #endif /* _TRACE_KVM_H */
>  
>  #undef TRACE_INCLUDE_PATH
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5de200663f51..619c24bac79e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1214,6 +1214,10 @@ static const u32 emulated_msrs_all[] = {
>  	HV_X64_MSR_VP_ASSIST_PAGE,
>  	HV_X64_MSR_REENLIGHTENMENT_CONTROL, HV_X64_MSR_TSC_EMULATION_CONTROL,
>  	HV_X64_MSR_TSC_EMULATION_STATUS,
> +	HV_X64_MSR_SYNDBG_OPTIONS,
> +	HV_X64_MSR_SYNDBG_CONTROL, HV_X64_MSR_SYNDBG_STATUS,
> +	HV_X64_MSR_SYNDBG_SEND_BUFFER, HV_X64_MSR_SYNDBG_RECV_BUFFER,
> +	HV_X64_MSR_SYNDBG_PENDING_BUFFER,
>  
>  	MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
>  	MSR_KVM_PV_EOI_EN,
> @@ -2906,6 +2910,8 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		 */
>  		break;
>  	case HV_X64_MSR_GUEST_OS_ID ... HV_X64_MSR_SINT15:
> +	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
> +	case HV_X64_MSR_SYNDBG_OPTIONS:
>  	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
>  	case HV_X64_MSR_CRASH_CTL:
>  	case HV_X64_MSR_STIMER0_CONFIG ... HV_X64_MSR_STIMER3_COUNT:
> @@ -3151,6 +3157,8 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		msr_info->data = 0x20000000;
>  		break;
>  	case HV_X64_MSR_GUEST_OS_ID ... HV_X64_MSR_SINT15:
> +	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
> +	case HV_X64_MSR_SYNDBG_OPTIONS:
>  	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
>  	case HV_X64_MSR_CRASH_CTL:
>  	case HV_X64_MSR_STIMER0_CONFIG ... HV_X64_MSR_STIMER3_COUNT:
> @@ -3323,6 +3331,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_HYPERV_TLBFLUSH:
>  	case KVM_CAP_HYPERV_SEND_IPI:
>  	case KVM_CAP_HYPERV_CPUID:
> +	case KVM_CAP_HYPERV_DEBUGGING:

This is not enough: the userspace actually need to enable
KVM_CAP_HYPERV_DEBUGGING to start receiving
KVM_EXIT_HYPERV_SYNDBG. (see kvm_vcpu_ioctl_enable_cap()) 
Whem the capability is disabled, we should likely forbid writing to
these debug MSRs.

The problem here is: what if an unprepared userspace receives
KVM_EXIT_HYPERV_SYNDBG? It will likely crash or misbehave (and this is
guest triggerable!) so we need to prevent this.

>  	case KVM_CAP_PCI_SEGMENT:
>  	case KVM_CAP_DEBUGREGS:
>  	case KVM_CAP_X86_ROBUST_SINGLESTEP:
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 7ee0ddc4c457..f20b81894f23 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -188,6 +188,7 @@ struct kvm_s390_cmma_log {
>  struct kvm_hyperv_exit {
>  #define KVM_EXIT_HYPERV_SYNIC          1
>  #define KVM_EXIT_HYPERV_HCALL          2
> +#define KVM_EXIT_HYPERV_SYNDBG         3
>  	__u32 type;
>  	__u32 pad1;
>  	union {
> @@ -203,6 +204,15 @@ struct kvm_hyperv_exit {
>  			__u64 result;
>  			__u64 params[2];
>  		} hcall;
> +		struct {
> +			__u32 msr;
> +			__u32 pad2;
> +			__u64 control;
> +			__u64 status;
> +			__u64 send_page;
> +			__u64 recv_page;
> +			__u64 pending_page;
> +		} syndbg;
>  	} u;
>  };
>  
> @@ -1012,6 +1022,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_NISV_TO_USER 177
>  #define KVM_CAP_ARM_INJECT_EXT_DABT 178
>  #define KVM_CAP_S390_VCPU_RESETS 179
> +#define KVM_CAP_HYPERV_DEBUGGING 180

I'd name this KVM_CAP_HYPERV_SYNDBG to not cause confusion.

>  
>  #ifdef KVM_CAP_IRQ_ROUTING

-- 
Vitaly

