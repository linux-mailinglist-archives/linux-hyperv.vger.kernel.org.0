Return-Path: <linux-hyperv+bounces-7574-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3153CC5AA05
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 00:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 01C99241B1
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Nov 2025 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E5E32AAB6;
	Thu, 13 Nov 2025 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DqTUixnS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2BB329C5D
	for <linux-hyperv@vger.kernel.org>; Thu, 13 Nov 2025 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076846; cv=none; b=OOPSqlrVgSbyiW8Jd540DB6oQj19TasHSWSP8/3duP3e4QHhes8wVseyJesWdssbTEmzZhNTzX/ZlDl2hNHWEHecHmLy/VOOVxfNL5/nuFnzmRm0vjnu1d+Ow4uVcEPj0dt7eemzJieSIs8a4ltFuSW6C8kKL4ifktDQqkE0Rrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076846; c=relaxed/simple;
	bh=TsOVZcxyPB3PaqmFjrwQUuoUzE3GO9PGrHkk2QSuxfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU3PhM8XQhjYqGVui72XWEb0+yYRzZHQI+eEcA8hREoxvBNbaDTtgRbTutWqTYWH7ZLGElWqOy/oURPMsWmk1Wd1KQ6iHzfEw6j2u7LHSNvnZZrcOIJ7bPnKCQTVbZSguySXsZhfo4QK0Sk3uoovT6q8ow/28PDwRe0dI3DjIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DqTUixnS; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 23:33:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763076842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GwlzZJYLqlzghmM+vSBAy6yoBQiN2W6zQrFR6AQYStQ=;
	b=DqTUixnS76K8X+ATttV15/IkKsjWHSdCHK4vwNPvzazh0njIoPNbYYnSzbBSeAJa3YmCaZ
	fq14OQDU6sYrmzl8Arqqnwt7NDa8z1by+KxhWVY5IBopQOjwYVa4BHsUam+n3o26eQdlBL
	WPf71XPyuSOgDNYcWsKMVrEz3DSbtVw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH 4/9] KVM: SVM: Open code handling of unexpected exits in
 svm_invoke_exit_handler()
Message-ID: <4ct4nu4fepnzasoix6ougoyid6r7e7dcxamdvncbmlw5sgcpna@6hja4h67q6ce>
References: <20251113225621.1688428-1-seanjc@google.com>
 <20251113225621.1688428-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113225621.1688428-5-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 13, 2025 at 02:56:16PM -0800, Sean Christopherson wrote:
> Fold svm_check_exit_valid() and svm_handle_invalid_exit() into their sole
> caller, svm_invoke_exit_handler(), as having tiny single-use helpers makes
> the code unncessarily difficult to follow.  This will also allow for
> additional cleanups in svm_invoke_exit_handler().
> 
> No functional change intended.
> 
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  arch/x86/kvm/svm/svm.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 52b759408853..638a67ef0c37 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3433,23 +3433,13 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
>  		sev_free_decrypted_vmsa(vcpu, save);
>  }
>  
> -static bool svm_check_exit_valid(u64 exit_code)
> -{
> -	return (exit_code < ARRAY_SIZE(svm_exit_handlers) &&
> -		svm_exit_handlers[exit_code]);
> -}
> -
> -static int svm_handle_invalid_exit(struct kvm_vcpu *vcpu, u64 exit_code)
> -{
> -	dump_vmcb(vcpu);
> -	kvm_prepare_unexpected_reason_exit(vcpu, exit_code);
> -	return 0;
> -}
> -
>  int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
>  {
> -	if (!svm_check_exit_valid(exit_code))
> -		return svm_handle_invalid_exit(vcpu, exit_code);
> +	if (exit_code >= ARRAY_SIZE(svm_exit_handlers))
> +		goto unexpected_vmexit;
> +
> +	if (!svm_exit_handlers[exit_code])
> +		goto unexpected_vmexit;
>  
>  #ifdef CONFIG_MITIGATION_RETPOLINE
>  	if (exit_code == SVM_EXIT_MSR)
> @@ -3468,6 +3458,11 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
>  #endif
>  #endif
>  	return svm_exit_handlers[exit_code](vcpu);
> +
> +unexpected_vmexit:
> +	dump_vmcb(vcpu);
> +	kvm_prepare_unexpected_reason_exit(vcpu, exit_code);
> +	return 0;
>  }
>  
>  static void svm_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

