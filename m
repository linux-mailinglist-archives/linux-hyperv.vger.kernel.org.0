Return-Path: <linux-hyperv+bounces-8118-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC07CEF00B
	for <lists+linux-hyperv@lfdr.de>; Fri, 02 Jan 2026 17:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DB2F3029210
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jan 2026 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243322C11CF;
	Fri,  2 Jan 2026 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AIPbXQJR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02FD2727F3
	for <linux-hyperv@vger.kernel.org>; Fri,  2 Jan 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767372304; cv=none; b=HMsWRDqL1kP6PQ9T8vHp0khP9RZW2OC+taK+MISfU4LuYVRoei7N8evZYVtqGW6Jhrn6gg3Kh90OpdjZTGYie85U2uo09hTqpiA2wpFJOmPoTggbkJi69Q3lEzAebkCArbbLictrKm+KGXye8Y1wR873WIu2osAOm35MiyQq/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767372304; c=relaxed/simple;
	bh=BHjbAUVzcL7wkG+FOEnjl3GAZHZGprb+ov7pjrPLyHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGLUlsgo1OGEEigGVmlOzNmqj9eIiNuKgE1iA1RXhLe1Sd/8Jln9gRQtNgJkHR1OL8nKOnqvN6kHzGND/tk+Ot2U6QNkB4DA+H5rUZF6C1S9FOllMuCjn/r6lDkGEv1VQzzuKDeS1pBsLyIDE7uvWSMIX0nnPbssGuCG6kJdIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AIPbXQJR; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Jan 2026 16:44:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767372299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sGTXQ3Yq5MXJIN703v988FK1sYychJeSQStnM/rxMI0=;
	b=AIPbXQJRJXqsc7kM5qXfJE1/KvidXXy4UVN+baBTqEREuaZnRDqKRz9BhPHd8Yo52toOTv
	ThsNU/EvYBR7CErHStwjuzgpXnoP3DsLz1j3aW07vHpV5eKVP3iZSIdfnu0wnz9KHDG1Qw
	9Ag0VlbAC+Y9RzemgVKUA7e4rmqqdLM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 1/8] KVM: SVM: Add a helper to detect VMRUN failures
Message-ID: <qq4672iziv5blzyvangbrk3kw4xzvg7bnwdkwjdkk2oz6x7wex@onnqrxwkyrxt>
References: <20251230211347.4099600-1-seanjc@google.com>
 <20251230211347.4099600-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230211347.4099600-2-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 30, 2025 at 01:13:40PM -0800, Sean Christopherson wrote:
> Add a helper to detect VMRUN failures so that KVM can guard against its
> own long-standing bug, where KVM neglects to set exitcode[63:32] when
> synthesizing a nested VMFAIL_INVALID VM-Exit.  This will allow fixing
> KVM's mess of treating exitcode as two separate 32-bit values without
> breaking KVM-on-KVM when running on an older, unfixed KVM.
> 
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  arch/x86/kvm/svm/nested.c | 16 +++++++---------
>  arch/x86/kvm/svm/svm.c    |  4 ++--
>  arch/x86/kvm/svm/svm.h    |  5 +++++
>  3 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index ba0f11c68372..f5bde972a2b1 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1134,7 +1134,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>  	vmcb12->control.exit_info_1       = vmcb02->control.exit_info_1;
>  	vmcb12->control.exit_info_2       = vmcb02->control.exit_info_2;
>  
> -	if (vmcb12->control.exit_code != SVM_EXIT_ERR)
> +	if (!svm_is_vmrun_failure(vmcb12->control.exit_code))
>  		nested_save_pending_event_to_vmcb12(svm, vmcb12);
>  
>  	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
> @@ -1425,6 +1425,9 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
>  	u32 exit_code = svm->vmcb->control.exit_code;
>  	int vmexit = NESTED_EXIT_HOST;
>  
> +	if (svm_is_vmrun_failure(exit_code))
> +		return NESTED_EXIT_DONE;
> +
>  	switch (exit_code) {
>  	case SVM_EXIT_MSR:
>  		vmexit = nested_svm_exit_handled_msr(svm);
> @@ -1432,7 +1435,7 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
>  	case SVM_EXIT_IOIO:
>  		vmexit = nested_svm_intercept_ioio(svm);
>  		break;
> -	case SVM_EXIT_EXCP_BASE ... SVM_EXIT_EXCP_BASE + 0x1f: {
> +	case SVM_EXIT_EXCP_BASE ... SVM_EXIT_EXCP_BASE + 0x1f:
>  		/*
>  		 * Host-intercepted exceptions have been checked already in
>  		 * nested_svm_exit_special.  There is nothing to do here,
> @@ -1440,15 +1443,10 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
>  		 */
>  		vmexit = NESTED_EXIT_DONE;
>  		break;
> -	}
> -	case SVM_EXIT_ERR: {
> -		vmexit = NESTED_EXIT_DONE;
> -		break;
> -	}
> -	default: {
> +	default:
>  		if (vmcb12_is_intercept(&svm->nested.ctl, exit_code))
>  			vmexit = NESTED_EXIT_DONE;
> -	}
> +		break;
>  	}
>  
>  	return vmexit;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 24d59ccfa40d..c2ddf2e0aa1a 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3540,7 +3540,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  			return 1;
>  	}
>  
> -	if (svm->vmcb->control.exit_code == SVM_EXIT_ERR) {
> +	if (svm_is_vmrun_failure(svm->vmcb->control.exit_code)) {
>  		kvm_run->exit_reason = KVM_EXIT_FAIL_ENTRY;
>  		kvm_run->fail_entry.hardware_entry_failure_reason
>  			= svm->vmcb->control.exit_code;
> @@ -4311,7 +4311,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
>  
>  		/* Track VMRUNs that have made past consistency checking */
>  		if (svm->nested.nested_run_pending &&
> -		    svm->vmcb->control.exit_code != SVM_EXIT_ERR)
> +		    !svm_is_vmrun_failure(svm->vmcb->control.exit_code))
>                          ++vcpu->stat.nested_run;
>  
>  		svm->nested.nested_run_pending = 0;
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 01be93a53d07..0f006793f973 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -424,6 +424,11 @@ static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
>  	return container_of(vcpu, struct vcpu_svm, vcpu);
>  }
>  
> +static inline bool svm_is_vmrun_failure(u64 exit_code)
> +{
> +	return (u32)exit_code == (u32)SVM_EXIT_ERR;
> +}
> +
>  /*
>   * Only the PDPTRs are loaded on demand into the shadow MMU.  All other
>   * fields are synchronized on VM-Exit, because accessing the VMCB is cheap.
> -- 
> 2.52.0.351.gbe84eed79e-goog
> 

