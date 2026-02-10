Return-Path: <linux-hyperv+bounces-8772-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPP9LyuDi2lDVAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8772-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 20:12:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D100D11E8A0
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 20:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 489313002F74
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819A32B996;
	Tue, 10 Feb 2026 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c8RYXbt5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F12C11D3;
	Tue, 10 Feb 2026 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750758; cv=none; b=X5GfJ20y3UdzCzcXg8EiR+Y3p4ifJMSgV3IsERALnvmpl+s+CwJ/R9nWanv5GGcnlpF3VdqP1AQqcjoITgKqf2Zgef7bq5U8EbKjxHtWr4ZQgneSb7bA7evdYdfXrnKzkn0w+QqwmeA4v/YfOJurG6wbb1L1aWlr1/7gCoF2HNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750758; c=relaxed/simple;
	bh=+0ZXv0QGhG/3x2b/jaVv6iXeWyFYka3O4FUyg/SdR0c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MfScyK/GjN5G25eT44YVAKRzXHq+hPG1eKO7GAD9SnWKFf+1UR1iEi0dkANnUiTvevz4K1ts58cMnk6Zx43S7ExxEuisgRupW+IpXZZoi1LW0k/xoMwUvyvvWnUox4xiwcB4LvCVhrQxCwQYpJj9AQrwa2tcwLkhgui8+ToCnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c8RYXbt5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0996120B7167;
	Tue, 10 Feb 2026 11:12:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0996120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770750757;
	bh=QW8eqUcRSbsIjGnCMX5NbGkuou2ybu60i/e1b14Q0gM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=c8RYXbt52bhaw619o1+rhIIvDMBLAgy38T+LD68r57KXuUUWxOZBEClOt2Qa7OM/f
	 acAg+I3ZXL4hLXF5jwmr+Qq4HJHU3WEFkbh3ZhqEGk43VWUmddD8lleF+YtzFpD9Th
	 V90wttSt6qqiATtyIkPwvyiuEmcTkj7W4X++w4WE=
Message-ID: <e93046c5-38a3-c48a-c9ba-2f6c36d17003@linux.microsoft.com>
Date: Tue, 10 Feb 2026 11:12:36 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Content-Language: en-US
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com
References: <20260102220208.862818-1-mrathor@linux.microsoft.com>
In-Reply-To: <20260102220208.862818-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8772-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D100D11E8A0
X-Rspamd-Action: no action

On 1/2/26 14:02, Mukesh Rathor wrote:
> MSVC compiler, used to compile the Microsoft Hyper-V hypervisor currently,
> has an assert intrinsic that uses interrupt vector 0x29 to create an
> exception. This will cause hypervisor to then crash and collect core. As
> such, if this interrupt number is assigned to a device by linux and the
> device generates it, hypervisor will crash. There are two other such
> vectors hard coded in the hypervisor, 0x2C and 0x2D for debug purposes.
> Fortunately, the three vectors are part of the kernel driver space and
> that makes it feasible to reserve them early so they are not assigned
> later.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
> 
> v1: Add ifndef CONFIG_X86_FRED (thanks hpa)
> 
>   arch/x86/kernel/cpu/mshyperv.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 579fb2c64cfd..8ef4ca6733ac 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -478,6 +478,27 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>   }
>   EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>   
> +#ifndef CONFIG_X86_FRED
> +/*
> + * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
> + * will crash or hang or break into debugger.
> + */
> +static void hv_reserve_irq_vectors(void)
> +{
> +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
> +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
> +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
> +
> +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
> +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
> +		BUG();
> +
> +	pr_info("Hyper-V:reserve vectors: %d %d %d\n", HYPERV_DBG_ASSERT_VECTOR,
> +		HYPERV_DBG_SERVICE_VECTOR, HYPERV_DBG_FASTFAIL_VECTOR);
> +}
> +#endif          /* CONFIG_X86_FRED */
> +
>   static void __init ms_hyperv_init_platform(void)
>   {
>   	int hv_max_functions_eax, eax;
> @@ -510,6 +531,11 @@ static void __init ms_hyperv_init_platform(void)
>   
>   	hv_identify_partition_type();
>   
> +#ifndef CONFIG_X86_FRED
> +	if (hv_root_partition())
> +		hv_reserve_irq_vectors();
> +#endif  /* CONFIG_X86_FRED */
> +
>   	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
>   		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
>   


Hi Wei,

Ping on this one... this is show stopper. Are we waiting for an ack
from someone else on x86 side? If so, pl lmk  if you know best person
to ping.

Thanks,
-Mukesh



