Return-Path: <linux-hyperv+bounces-3630-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA75A06968
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 00:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB79916737B
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4772046B7;
	Wed,  8 Jan 2025 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cy5GG912"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D95203717;
	Wed,  8 Jan 2025 23:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736378727; cv=none; b=DsGafFmhTGZbirHl+H6ZbA2x8PbRTvC6c0ZayxZ30vTefvgBMY24T3ItonQwBxslKY/ZhrWjHecfe9pL8cyDjKNUiDTd5QNVg1KhKRhZl/Q9e1iHuptvZg5rpeQPzUSUn69ZhqZow4wewjWIAsruGqBSvULks6y6aJKkfAN0Z8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736378727; c=relaxed/simple;
	bh=PnMuQ6VSNdwGw0Uo9dMP5es07hPdPdXlIoFs7m/aw20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEt9cpEbZLk9AUmyKICLJ0qma7F7tMfVkQqZRiAX+wSJOIRQbtf85WKuhrV2rG56jd5UifM4198qzkdNSscvyYtkAG/apJpvtccWk2B828zR3VQG2zwA2UWFCGS6n+uiRtd+6ZIEwDvzn/1L4pCQnASqxM3UU4cwWfSyrLKK60Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cy5GG912; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.116] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 65EEA203E3AB;
	Wed,  8 Jan 2025 15:25:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65EEA203E3AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736378723;
	bh=PfQ9Xc6ZM0R9/ypO/FRxz+xNVnFZDUg4hS/ODqEytI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cy5GG912nwMuvICGQI6qM2gOaoGHK371UY3mzIsH2V/GTcDCm1XTxltSDQsGpYc9f
	 IaYKsbvcPACqNrsSgANtjsK/gicZxfc0iDgd1nawLIUmHPVULgNZ0ZZYKfwmXYROEX
	 W6/ug8fXAaKgj84WoWfqAaXlzR6uzbT+5faIyUoU=
Message-ID: <d5fb5c9b-a477-4043-8438-aff29dbd96bb@linux.microsoft.com>
Date: Wed, 8 Jan 2025 15:25:22 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] hyperv: Define struct hv_output_get_vp_registers
To: Roman Kisel <romank@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, eahariha@linux.microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
 <20250108222138.1623703-2-romank@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250108222138.1623703-2-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/2025 2:21 PM, Roman Kisel wrote:
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
>  include/hyperv/hvgdk_mini.h | 41 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index db3d1aaf7330..4fffca9e16df 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -1068,6 +1068,35 @@ union hv_dispatch_suspend_register {
>  	} __packed;
>  };
>  
> +union hv_arm64_pending_interruption_register {
> +	u64 as_uint64;
> +	struct {
> +		u64 interruption_pending : 1;
> +		u64 interruption_type: 1;
> +		u64 reserved : 30;
> +		u64 error_code : 32;
> +	} __packed;
> +};
> +
> +union hv_arm64_interrupt_state_register {
> +	u64 as_uint64;
> +	struct {
> +		u64 interrupt_shadow : 1;
> +		u64 reserved : 63;
> +	} __packed;
> +};
> +
> +union hv_arm64_pending_synthetic_exception_event {
> +	u64 as_uint64[2];
> +	struct {
> +		u8 event_pending : 1;
> +		u8 event_type : 3;
> +		u8 reserved : 4;
> +		u8 rsvd[3];
> +		u64 context;
> +	} __packed;
> +};
> +

You've omitted the exception_type field.
This is how it should be:

union hv_arm64_pending_synthetic_exception_event {
	u64 as_uint64[2];
	struct {
		u8 event_pending : 1;
		u8 event_type : 3;
		u8 reserved : 4;
		u8 rsvd[3];
		u32 exception_type;
		u64 context;
	} __packed;
};

>  union hv_x64_interrupt_state_register {
>  	u64 as_uint64;
>  	struct {
> @@ -1103,8 +1132,20 @@ union hv_register_value {
>  	union hv_explicit_suspend_register explicit_suspend;
>  	union hv_intercept_suspend_register intercept_suspend;
>  	union hv_dispatch_suspend_register dispatch_suspend;
> +#ifdef CONFIG_ARM64
> +	union hv_arm64_interrupt_state_register interrupt_state;
> +	union hv_arm64_pending_interruption_register pending_interruption;
> +#endif
> +#ifdef CONFIG_X86
>  	union hv_x64_interrupt_state_register interrupt_state;
>  	union hv_x64_pending_interruption_register pending_interruption;
> +#endif
> +	union hv_arm64_pending_synthetic_exception_event pending_synthetic_exception_event;
> +};
> +
> +/* NOTE: Linux helper struct - NOT from Hyper-V code. */
> +struct hv_output_get_vp_registers {
> +	DECLARE_FLEX_ARRAY(union hv_register_value, values);
>  };
>  
>  #if defined(CONFIG_ARM64)


