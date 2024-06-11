Return-Path: <linux-hyperv+bounces-2383-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE8A903F3A
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 16:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91352866FF
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A811720;
	Tue, 11 Jun 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nXrwlDwr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F498C8FB;
	Tue, 11 Jun 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117510; cv=none; b=BMRm3bmQFfN5BuzcnXEVkXH+5P1FNGsCcc7tHhOWCibnwCvQyfQCuIdc4aA+VWPw03sIS97plN/Q506LwXoI8qayXSFPHpwe8IafRepwu0AiwTHDnrbPA53JIExMNeqa/g8Vu61JGNWG9PhUWu+6zRbAZaTWmilaF+VLku342XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117510; c=relaxed/simple;
	bh=cm03x+RBmnfPa2LDYFByAa2NHN0RjhBscn0RaLP8YqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QNaogcMA4mO7OsjXdY3WlsYKwjmOyVpnpnk1hPZtmrwcqQjmOQgV8KVKzg2QzkT1qzsfYoQxHtgevv36oL4zOOUGVprQRaZxoJ27Sr7xHGTbBo4VR5Ud6IxnHzN3GFHL/xMmAG7IrRMs4vHRsSGreQy/94OpZ2O6U4chHeuCips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nXrwlDwr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id A007A20B915A;
	Tue, 11 Jun 2024 07:51:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A007A20B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718117508;
	bh=CX3LM0zn1cL7JnOIqMQ9YrKLCw9NH+PTMmWHE/mZ478=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=nXrwlDwrpLxVgQEtVyg0XSwepN2uNMhyczU0NvN8MODFrNYNKt9+KwjwJ+F/VvmhG
	 v7o8RfM4wmse43zFUFkPc5jBcLJ7u3HS6MrY9aGG4KOe9BoE3enpN20HiPVCQ1D5XG
	 wkadud+2xqk7ubzmkI5yKPmmwcnLtxOWZT7pgdVE=
Message-ID: <226804eb-af9d-4a56-aef5-e3045e83b551@linux.microsoft.com>
Date: Tue, 11 Jun 2024 07:51:48 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when
 Hyper-V provides frequency
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240606025559.1631-1-mhklinux@outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240606025559.1631-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/5/2024 7:55 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> A Linux guest on Hyper-V gets the TSC frequency from a synthetic MSR, if
> available. In this case, set X86_FEATURE_TSC_KNOWN_FREQ so that Linux
> doesn't unnecessarily do refined TSC calibration when setting up the TSC
> clocksource.
> 
> With this change, a message such as this is no longer output during boot
> when the TSC is used as the clocksource:
> 
> [    1.115141] tsc: Refined TSC clocksource calibration: 2918.408 MHz
> 
> Furthermore, the guest and host will have exactly the same view of the
> TSC frequency, which is important for features such as the TSC deadline
> timer that are emulated by the Hyper-V host.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>   arch/x86/kernel/cpu/mshyperv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index e0fd57a8ba84..c3e38eaf6d2f 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -424,6 +424,7 @@ static void __init ms_hyperv_init_platform(void)
>   	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
>   		x86_platform.calibrate_tsc = hv_get_tsc_khz;
>   		x86_platform.calibrate_cpu = hv_get_tsc_khz;
> +		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>   	}
>   
>   	if (ms_hyperv.priv_high & HV_ISOLATION) {

LGTM

Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

-- 
Thank you,
Roman

