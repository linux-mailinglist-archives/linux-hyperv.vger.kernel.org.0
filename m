Return-Path: <linux-hyperv+bounces-2094-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790768C290C
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 19:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2A9281880
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16BB15E86;
	Fri, 10 May 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XN6g+rFX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A306168BD;
	Fri, 10 May 2024 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360666; cv=none; b=uqbqAIGBT6HgEQp7MTNxQrSzxe1l8ek9NZaT003KrZdFjtF98MMame9bUftxtPVLuYzEJumIf8FOAcfaeNtYfZBVtGnwdigSzybMuGT8gw+Xqd7srfRQxLjrk9UTewGYZ/7QdUCPAN0BL3ysKsqx9x8hGSlwajdL0iiOiVs/93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360666; c=relaxed/simple;
	bh=W8ZlpyVfAQ2NmbLul5CfY32bP45vGBrmtSAre6V9Nrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0feinKfrgGBmUestw7iJwjpxHNkqPdmr7IqM+e8ZwPwHSmd/xSEx5R7IaaZe3TevHErqxhhABSGzfIGTjbBp3JkCV1q97J9anW+VlcjMb/THWqP627kEiYSr6QmsS638A3EKQSSBd1CH9oi4W4IzL401HmP6g3cHDopXaWPUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XN6g+rFX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.49.54] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id C1AA220B2C87;
	Fri, 10 May 2024 10:04:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1AA220B2C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715360665;
	bh=D6rlDT4v0DLvneUWLv+DfcU6XBGP07Du9qcg/Pby8a8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XN6g+rFX+VYKAfFTaommksIyHGDKm1XYil5liTozTFlJkjQaqdtfXVr7iX72/HsPV
	 ePInUOrUTvZwRweD7UyzSSs0PEQZAZNoOKuL+7Ki0BaqC9L3mTGAOURtVh0d1HB95p
	 3aKwDzBIHutXT9+Owql37VwUlFMplEyBMdsjKkyw=
Message-ID: <46eae37e-0c0d-4963-a39c-c9f1d2318c85@linux.microsoft.com>
Date: Fri, 10 May 2024 10:04:24 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64/hyperv: Support DeviceTree
To: romank@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, linux-hyperv@vger.kernel.org,
 rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: ssengar@microsoft.com, sunilmut@microsoft.com
References: <20240510160602.1311352-1-romank@linux.microsoft.com>
 <20240510160602.1311352-2-romank@linux.microsoft.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240510160602.1311352-2-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/2024 9:05 AM, romank@linux.microsoft.com wrote:
> From: Roman Kisel <romank@linux.microsoft.com>
> 
> Update the driver to support DeviceTree boot as well along with ACPI.
> This enables the Virtual Trust Level platforms boot up on ARM64.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index b1a4de4eee29..208a3bcb9686 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -15,6 +15,9 @@
>  #include <linux/errno.h>
>  #include <linux/version.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/libfdt.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
>  #include <asm/mshyperv.h>
>  
>  static bool hyperv_initialized;
> @@ -27,6 +30,29 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  	return 0;
>  }
>  
> +static bool hyperv_detect_fdt(void)
> +{
> +#ifdef CONFIG_OF
> +	const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
> +			of_get_flat_dt_root(), "hypervisor");
> +
> +	return (hyp_node != -FDT_ERR_NOTFOUND) &&
> +			of_flat_dt_is_compatible(hyp_node, "microsoft,hyperv");
> +#else
> +	return false;
> +#endif
> +}
> +
> +static bool hyperv_detect_acpi(void)
> +{
> +#ifdef CONFIG_ACPI
> +	return !acpi_disabled &&
> +			!strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8);
> +#else
> +	return false;
> +#endif
> +}
> +

Could using IS_ENABLED() allow collapsing these two functions into one hyperv_detect_fw()?
I am wondering if #ifdef was explicitly chosen to allow for the code to be compiled in if CONFIG* is defined
v/s IS_ENABLED() only being true if the CONFIG value is true.


>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> @@ -35,13 +61,11 @@ static int __init hyperv_init(void)
>  
>  	/*
>  	 * Allow for a kernel built with CONFIG_HYPERV to be running in
> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
> +	 * a non-Hyper-V environment.
> +	 *
>  	 * In such cases, do nothing and return success.
>  	 */
> -	if (acpi_disabled)
> -		return 0;
> -
> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +	if (!hyperv_detect_fdt() && !hyperv_detect_acpi())
>  		return 0;
>  
>  	/* Setup the guest ID */


