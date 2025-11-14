Return-Path: <linux-hyperv+bounces-7576-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B03AC5AB48
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 01:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A14D4E3DBA
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 00:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589991F936;
	Fri, 14 Nov 2025 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NP7IVGp4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C842CA4E
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Nov 2025 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763078705; cv=none; b=Kx+ek7wEwtNVcr/TuPrvxS44Zz4XXp0IZb2bJ1OKGHvsgoMB6TQVYYvcDZm6fiiky6G15UgYaZ4U5GxC3CoBAKD2dfi4YTUpu7sKL8zwOqumD0RoTJRcmTednqBeLQZWVuYjiNLT0e7MlRfPEmfDhUpD+qmy/BRIr1wCOlVtMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763078705; c=relaxed/simple;
	bh=DhOIN3ARG/YzOjB8Zthzpl+Qb9Mh4Rfifi9bI5nutAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEQGRjyntv4uqCcpi44p6NKp+nQKLgBiL0CZREOn4LnX9Mw22jD7NZDE2ERMS3i2nywykCjiEUL+tXC24l15b1YCPYVNg6hW4SCH0jyuiYcM2HnRuSJY1T+jMlElBu09c4LkpiNkBZRVIc76S97hW1ZPWpx0+ENJGa+6L5Fqec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NP7IVGp4; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Nov 2025 00:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763078691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzxBmeF3xd+ODUqUuNrzGl99lENkn92KYzfj1YgGIfQ=;
	b=NP7IVGp4I6LAmwEo3A0A4rC+NDfFqPVgy4dAsIgRu+U0ZkDL5wfS202+gvmH82noyaN6cn
	fU4xuW++HxttstBBAQeRjaDFCdy7ziA+Um4zwQgHReOhq1I3oocRMGSYlPr6eyJfBaQe6a
	/Y5Q3pvoNmdSkKB+ywfyP7rhGcOp8fA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH 5/9] KVM: SVM: Check for an unexpected VM-Exit after
 RETPOLINE "fast" handling
Message-ID: <ouxrqqbwodwf5gne45xvrtt7t2zqrlq4lpkptwmpsilx3zndsr@yagrxfbudyjy>
References: <20251113225621.1688428-1-seanjc@google.com>
 <20251113225621.1688428-6-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113225621.1688428-6-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 13, 2025 at 02:56:17PM -0800, Sean Christopherson wrote:
> Check for an unexpected/unhandled VM-Exit after the manual RETPOLINE=y
> handling.  The entire point of the RETPOLINE checks is to optimize for
> common VM-Exits, i.e. checking for the rare case of an unsupported
> VM-Exit is counter-productive.  This also aligns SVM and VMX exit handling.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  arch/x86/kvm/svm/svm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 638a67ef0c37..202a4d8088a2 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3435,12 +3435,6 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
>  
>  int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
>  {
> -	if (exit_code >= ARRAY_SIZE(svm_exit_handlers))
> -		goto unexpected_vmexit;
> -
> -	if (!svm_exit_handlers[exit_code])
> -		goto unexpected_vmexit;
> -
>  #ifdef CONFIG_MITIGATION_RETPOLINE
>  	if (exit_code == SVM_EXIT_MSR)
>  		return msr_interception(vcpu);
> @@ -3457,6 +3451,12 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
>  		return sev_handle_vmgexit(vcpu);
>  #endif
>  #endif
> +	if (exit_code >= ARRAY_SIZE(svm_exit_handlers))
> +		goto unexpected_vmexit;
> +
> +	if (!svm_exit_handlers[exit_code])
> +		goto unexpected_vmexit;
> +
>  	return svm_exit_handlers[exit_code](vcpu);
>  
>  unexpected_vmexit:
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

