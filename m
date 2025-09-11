Return-Path: <linux-hyperv+bounces-6833-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13EB53EBE
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 00:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35277A050FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 22:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEAD2F068F;
	Thu, 11 Sep 2025 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WUo++LRJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF81EA7DD
	for <linux-hyperv@vger.kernel.org>; Thu, 11 Sep 2025 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630145; cv=none; b=cUQmmrwXveaGK7hV1bDrL9DUdSyges+inidfDNT0nezKSeHf7p6kc8pl/dy0LKzGYOsCDUGUIfGrdt4FV7mBW5m9ki/l+6WZvGBxgWU7Bs7XT191ly0TOaJ0C1gXLyqCLAmSErp1ELlqiU/fjeTW2LGZS4IEHRUwV7R4I4uqs+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630145; c=relaxed/simple;
	bh=x3zdoDa5u4uDBxX4YZsmmaCqzdB0PHtQLVBUJfu5h5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgt7vz5tiWbdv2WDw1xAUx/Vu+/z7GQ7XRYoCZCKyQRn8g13KWjzCUv778dUiyNEqTSRN7YanWNudK9aj8qH3/4KX95/xO3On6RtnPINlgLkg9DarHxTKQccrWBOF4vXk8B0KxGWl69+32h4Nx5BdXfLyRTqaHNtZ9gFPd60SiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WUo++LRJ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Sep 2025 22:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757630140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73PGcH/Uoia3T/M0UNBLsyGGXuDrtKs8F5/YJ+y6DmI=;
	b=WUo++LRJQJIuE7x9zfyJcACaR0rAtTKl7XwXVGQfim3yVnBKfaGJdWndMxOrzn/CZPYG+5
	DDVO1aTqpCksZe1jwIl5iKo8RoX4IKC7OdDq3VMeVViSbNR7vSpf82NYwYrfY6rZ8qR0+Z
	V92SJ35iL5KDjZSVAzGchp1UUlKKU3g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Vineeth Pillai <viremana@linux.microsoft.com>
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, 
	Michael Kelley <mikelley@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>, 
	Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Venkatesh Srinivas <venkateshs@google.com>, @google.com
Subject: Re: [PATCH v5 4/7] KVM: SVM: Software reserved fields
Message-ID: <67feoyvmmf2sl34kikk3btrfcedafax2pazht5tplxyeb5rtv7@eakih2vxt2xc>
References: <cover.1622730232.git.viremana@linux.microsoft.com>
 <a1f17a43a8e9e751a1a9cc0281649d71bdbf721b.1622730232.git.viremana@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f17a43a8e9e751a1a9cc0281649d71bdbf721b.1622730232.git.viremana@linux.microsoft.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 03, 2021 at 03:14:37PM +0000, Vineeth Pillai wrote:
> SVM added support for certain reserved fields to be used by
> software or hypervisor. Add the following reserved fields:
>   - VMCB offset 0x3e0 - 0x3ff
>   - Clean bit 31
>   - SVM intercept exit code 0xf0000000
> 
> Later patches will make use of this for supporting Hyper-V
> nested virtualization enhancements.
> 
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>  arch/x86/include/asm/svm.h      |  9 +++++++--
>  arch/x86/include/uapi/asm/svm.h |  3 +++
>  arch/x86/kvm/svm/svm.h          | 17 +++++++++++++++--
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 772e60efe243..e322676039f4 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -156,6 +156,12 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>  	u64 avic_physical_id;	/* Offset 0xf8 */
>  	u8 reserved_7[8];
>  	u64 vmsa_pa;		/* Used for an SEV-ES guest */
> +	u8 reserved_8[720];
> +	/*
> +	 * Offset 0x3e0, 32 bytes reserved
> +	 * for use by hypervisor/software.
> +	 */
> +	u8 reserved_sw[32];
>  };
>  
>  
> @@ -314,7 +320,7 @@ struct ghcb {
>  
>  
>  #define EXPECTED_VMCB_SAVE_AREA_SIZE		1032
> -#define EXPECTED_VMCB_CONTROL_AREA_SIZE		272
> +#define EXPECTED_VMCB_CONTROL_AREA_SIZE		1024
>  #define EXPECTED_GHCB_SIZE			PAGE_SIZE
>  
>  static inline void __unused_size_checks(void)
> @@ -326,7 +332,6 @@ static inline void __unused_size_checks(void)
>  
>  struct vmcb {
>  	struct vmcb_control_area control;
> -	u8 reserved_control[1024 - sizeof(struct vmcb_control_area)];
>  	struct vmcb_save_area save;
>  } __packed;
>  
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index 554f75fe013c..efa969325ede 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -110,6 +110,9 @@
>  #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
>  #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
>  
> +/* Exit code reserved for hypervisor/software use */
> +#define SVM_EXIT_SW				0xf0000000

Apologies for reviving this 2021 thread, but it seems like the APM says
in Table C-1. SVM Intercept Codes that the host reserved value is
F000_000h.

APM typo or wrong KVM definition?

