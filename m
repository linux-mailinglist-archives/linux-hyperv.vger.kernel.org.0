Return-Path: <linux-hyperv+bounces-3609-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACE5A054AB
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 08:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC06162140
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 07:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380021A841B;
	Wed,  8 Jan 2025 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3bGwhNC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051115B984;
	Wed,  8 Jan 2025 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321817; cv=none; b=ZpyHZM/krJYJ31Oj2Pc/DN1YGXdCX/fsoRju7MPEkfskxdd3PmD79OdTsJObGJceu8/ZpiR4+oIeQ+jCSZcVUV7BK7cTDDQsAFcD6VsZIM7CtvT+mtuku2iq4giiufHLDMsuGmOhbygesdRgyk05LjxXdFR2U39FWmz8CeF3W4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321817; c=relaxed/simple;
	bh=Iw6PJgsTAa90Dih4kPZDbWljGAJrNLg1+vLv5nFpuGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwuMUGx7KoRYDljlVC1uhoz67fHdA/Uw8owDsTLiTuw8Cs0WjWIEWF+sKauVoJqSS+Hv9fJOBC/DR+YHr1uVMUmcI1eRLBshkrRbI3VPhdSL4Gky/j9ZHJhCIIZcqO2x8KoYf3tuCtLp3N5fRpZP6gxNQVYYhkGHsQHgaMdE9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3bGwhNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F0BC4CEE0;
	Wed,  8 Jan 2025 07:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736321816;
	bh=Iw6PJgsTAa90Dih4kPZDbWljGAJrNLg1+vLv5nFpuGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3bGwhNCfkOvCSKan/sRiydMO+KVYakfz+rq44w5NcUiCGIOdCBRKgV5UxZSqb3kz
	 1ZIE3WjQLVY8N6Fb/cd6L55YchEHCUBjMSi7Urhc2pmPuW09Xoul1ssl/LClkKBFwA
	 YgWtdjIPjssPhVkIivHdjYLaJk/8ZhJH9wTnKTl0tP0Q/+jwQ1e2q5na1pq6o56n2v
	 HR4FWLC7Vx7QMK2jDtr9LaOYFxOauFL7Gs/jN2PFY5uLwAaNNnUJmx7mXaETKTGF5d
	 H2PZ6tBlCTR7yMXe5e8gsdqF6XrYbO6euWM+KhO7cAC6CZ/WPQpPsYvovaVviTHV8l
	 MqFAMqJunc+dg==
Date: Wed, 8 Jan 2025 07:36:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	eahariha@linux.microsoft.com, haiyangz@microsoft.com,
	mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v5 4/5] hyperv: Do not overlap the hvcall IO areas in
 get_vtl()
Message-ID: <Z34rF2wzToTZRgem@liuwe-devbox-debian-v2>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-5-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230180941.244418-5-romank@linux.microsoft.com>

On Mon, Dec 30, 2024 at 10:09:40AM -0800, Roman Kisel wrote:
> The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
> disallows overlapping of the input and output hypercall areas, and
> get_vtl(void) does overlap them.
> 
> Use the output hypercall page of the current vCPU for the hypercall.
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
> [2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
> 
> Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

You forgot to pick up Tianyu's Reviewed-by tag in the previous version.
In the future please make sure to collect all the tags you get from
previous review rounds.

Thanks,
Wei.

> ---
>  arch/x86/hyperv/hv_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index f82d1aefaa8a..173005e6a95d 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -422,7 +422,7 @@ static u8 __init get_vtl(void)
>  
>  	local_irq_save(flags);
>  	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	output = (struct hv_output_get_vp_registers *)input;
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>  
>  	memset(input, 0, struct_size(input, names, 1));
>  	input->partition_id = HV_PARTITION_ID_SELF;
> -- 
> 2.34.1
> 

