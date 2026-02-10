Return-Path: <linux-hyperv+bounces-8774-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFM4LTmWi2m+WQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8774-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 21:34:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9485011F09A
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 21:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D28303C4E2
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 20:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F042322B8B;
	Tue, 10 Feb 2026 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hBycHZC+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286E30F924;
	Tue, 10 Feb 2026 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770755638; cv=none; b=qqfgLdqQpMQMBne/GszT+8i1HESYddsNVFOtpWKFC5ve0iHMy45k6DwocvTYjeKtZN6yRXuPNRHlaEOUm/VpCp/1vooGTnOVU62pWepZDmEl6hmAa35jZv4xFlMVcURGSSPUfMJhZJgnqBdxuzsmteMmICPwW9sNekbODXN/X3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770755638; c=relaxed/simple;
	bh=3f+eUNidv3Qr7hqGK/60/VOeLfzvgdNSpomNRAO9eTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZmDMrmUiuCUiuPezzk3FO7lW/HZGv+FJB3mQ4ilKB6lxQxY/Y6JXgT7/UKh3K6Xouh2mqgZJHUPZgFhEE51uqYvzvAij7dyJGyqWHD5gv0giUzw+puliYwN44sWqyF20hfSC0B0zQfybPyJjiNjbRJjc0dbcGTgXkrNOSgxcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hBycHZC+; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61AKXMR53520022
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 10 Feb 2026 12:33:25 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61AKXMR53520022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770755606;
	bh=QVvvjU8eNZoPcL27Mda6c7RaeR+r35YBTYL0DuqDyLY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hBycHZC++zNlWgVh+SogCzZnNrLzYp75xHDwvKi8ktw7qnv2hOliI0xwNJ/SjNbIn
	 kKbViyxv7b//Oig1BaAnIoWLfa3SFzYDaW/BObxbGtILKUcj0me9VoRNYI+mGo1cY8
	 xVfU1oo0E0V/jEFZurT2dhoU3FjGTGENtJmhkx0+HF9ME2mwmdaz4aIBp2tOJioHUr
	 pPzMoaXvgKAZoYjtpWl2B7GckmpLzmddT/GsUeh56YN5/fVClRzNkqipjADoA647gv
	 DUNtG8DmRtj7i3aO7XVue0FeX8pVdARdWZjbknsmE6/Eg88tEtaxymZKsghzoeihfK
	 DE5B/BsK/t3OA==
Message-ID: <72687e18-ecdc-438a-9ea6-fd935f599b27@zytor.com>
Date: Tue, 10 Feb 2026 12:33:17 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
To: Mukesh Rathor <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org
References: <20260102220208.862818-1-mrathor@linux.microsoft.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260102220208.862818-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8774-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zytor.com:mid,zytor.com:dkim]
X-Rspamd-Queue-Id: 9485011F09A
X-Rspamd-Action: no action

On 2026-01-02 14:02, Mukesh Rathor wrote:
> 
> v1: Add ifndef CONFIG_X86_FRED (thanks hpa)
> 

It just clicked in my brain.

This must be cpu_feature_enabled() not a static #ifndef. Just because the
kernel is compiled with FRED support doesn't mean that it is *using* FRED!

	-hpa


>  arch/x86/kernel/cpu/mshyperv.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 579fb2c64cfd..8ef4ca6733ac 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -478,6 +478,27 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  }
>  EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
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
>  static void __init ms_hyperv_init_platform(void)
>  {
>  	int hv_max_functions_eax, eax;
> @@ -510,6 +531,11 @@ static void __init ms_hyperv_init_platform(void)
>  
>  	hv_identify_partition_type();
>  
> +#ifndef CONFIG_X86_FRED
> +	if (hv_root_partition())
> +		hv_reserve_irq_vectors();
> +#endif  /* CONFIG_X86_FRED */
> +
>  	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
>  		ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
>  


