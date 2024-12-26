Return-Path: <linux-hyperv+bounces-3536-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB809FCE65
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 23:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F352F7A13E4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B9B18870C;
	Thu, 26 Dec 2024 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GhDXFjHQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC41450F2;
	Thu, 26 Dec 2024 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251060; cv=none; b=ZMeNBiplyYGZEsbmmJXz9SgFgHZ8snHgcISIbxGanwNlZctfU9AQsMuObyoamUv/B2mGw9PpKMFhQmabTE4bh02jqEctmIPcnrkwedaTshowNJOpLotT8yxuArGqK3OISOriLODFzt6lPiNec60+jw4zVNrpKjewXNmi+4yKlPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251060; c=relaxed/simple;
	bh=rlAlj5P+lotL+5KywZT06oAzaE1tE3gRjltPf9tWfrY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uL8OBS3w43fjVIQ8blq0i5lmh/FPHh6yu50ErirBAuCdBYdBd+rr89VHpdNKSXHF6eoD+gZPldyTrq6R/8JDxbnFqVph7wvyz8yocbdQU8/O3vaZb6++dKingWq9+R9mmsC2aQg7H0M1KNuy05ekAetcqi277FOXFhCZMaiPIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GhDXFjHQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.184] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 55867203EC24;
	Thu, 26 Dec 2024 14:10:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 55867203EC24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735251058;
	bh=Tb82IjJtzKu20gKng9FxEnVf4vtfirUbsOp7HN3vdG8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GhDXFjHQvzqrL9GJWfW6L1rN94QxiHgsqXKipls4t7mojsn0ra4pNm6Soc4h7HSZ/
	 VaNXgJ36o9vck5gRSVqNitYQ8tdO9Eij5SqtNsz3WTB3U/YJd/NfGUPVyVkBQ2YBB/
	 xxkDeP3/RwZMr/h2M1SRAwJu10dxidmq6jG7vH6o=
Message-ID: <1bf0ce72-a377-4c3f-b68a-0f890f8b5d09@linux.microsoft.com>
Date: Thu, 26 Dec 2024 14:11:00 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, eahariha@linux.microsoft.com,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 1/5] hyperv: Define struct hv_output_get_vp_registers
To: Roman Kisel <romank@linux.microsoft.com>, nunodasneves@linux.microsoft.com
References: <20241226213110.899497-1-romank@linux.microsoft.com>
 <20241226213110.899497-2-romank@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20241226213110.899497-2-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/26/2024 1:31 PM, Roman Kisel wrote:
> There is no definition of the output structure for the
> GetVpRegisters hypercall. Hence, using the hypercall
> is not possible when the output value has some structure
> to it. Even getting a datum of a primitive type reads
> as ad-hoc without that definition.
> 
> Define struct hv_output_get_vp_registers to enable using
> the GetVpRegisters hypercall. Make provisions for all
> supported architectures. No functional changes.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h | 58 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 2 deletions(-)
> 
>  	struct {
> @@ -1091,6 +1130,8 @@ union hv_x64_pending_interruption_register {
>  	} __packed;
>  };
>  
> +#endif
> +
>  union hv_register_value {
>  	struct hv_u128 reg128;
>  	u64 reg64;
> @@ -1098,13 +1139,26 @@ union hv_register_value {
>  	u16 reg16;
>  	u8 reg8;
>  
> -	struct hv_x64_segment_register segment;
> -	struct hv_x64_table_register table;
>  	union hv_explicit_suspend_register explicit_suspend;
>  	union hv_intercept_suspend_register intercept_suspend;
>  	union hv_dispatch_suspend_register dispatch_suspend;
> +#if defined(CONFIG_X86)
> +	struct hv_x64_segment_register segment;
> +	struct hv_x64_table_register table;
>  	union hv_x64_interrupt_state_register interrupt_state;
>  	union hv_x64_pending_interruption_register pending_interruption;
> +#elif defined(CONFIG_ARM64)
> +	union hv_arm64_pending_interruption_register pending_interruption;
> +	union hv_arm64_interrupt_state_register interrupt_state;
> +	union hv_arm64_pending_synthetic_exception_event pending_synthetic_exception_event;
> +#else
> +	#error "This architecture is not supported"
> +#endif
> +};

I don't love the #error for unsupported architectures when Kconfig takes
care of that for us, but I suppose it's for completeness since the arm64
members have to be conditioned on CONFIG_ARM64?

> +
> +/* NOTE: Linux helper struct - NOT from Hyper-V code */
> +struct hv_output_get_vp_registers {
> +	DECLARE_FLEX_ARRAY(union hv_register_value, values);
>  };

I'm not super familiar with DECLARE_FLEX_ARRAY() but it appears this
needs to be wrapped in an anonymous struct at the least per this comment
for the definition of DECLARE_FLEX_ARRAY()

> * In order to have a flexible array member [...] alone in a
> * struct, it needs to be wrapped in an anonymous struct with at least 1
> * named member, but that member can be empty.

Nuno, since you seem to be more familiar, can you provide some guidance?

Thanks,
Easwar

