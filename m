Return-Path: <linux-hyperv+bounces-7052-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1EBB46FA
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A2B179016
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA923D7E4;
	Thu,  2 Oct 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g738okH5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA2723BCF8;
	Thu,  2 Oct 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421064; cv=none; b=MwJUlvCXSCrzc3KD27P3w1WHyRZnH4iMoRI0CCpBcm7khcMdpywRe72EavuezwdRO2H+uQJ6oipiwEJM5m3VCAfguCIwD0vTv3U/HwbEDLHg9VMBU2Zscg11HoZQ39OZ5g5u59fXWBXxI22ZOdZ7UHOPKwjAZ9GeJlm5FqJAXWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421064; c=relaxed/simple;
	bh=0SJ0CRh4Yr9yCAvoBImmVaStj4l84pVKmzKCK5jyNPI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Elzkrr3QjYeaNqZNcWx3GffThvhpCTIe077UxovYmlPOYESvlEHYnVuOHjGTbus0obSVbvrc+cXyuXBMFTkLjUulb+7Q10PIXdzNZxCdRVZgHuNoxuxyEGQ5bEPLaR5qAYTWCLiVV601GPd6TvVD/aI6pNygAVs2Msr/FMLFWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g738okH5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.208.192] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 39392211B7CC;
	Thu,  2 Oct 2025 09:04:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39392211B7CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759421062;
	bh=yWS4qysllkzqMtuM1JsrMuSYlrgHWok+DemlkRqdEuk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=g738okH5uXRoEiizG+qXoJgYIaskl1ctLcZh7rqo95URKNfs4Es/8z5XimCyFJ3Zq
	 aX22ZbcI1kwCDNmyJPNr3C/YAUa8ly6VcaNobX5HtxuHZnZpWJuBjUOQPMi1JJfYo8
	 NQm1uERKEhSIzj6yCE66oSaIc+CjD7e9wl+EYWW0=
Message-ID: <089d6be9-20be-4985-a761-51bfb9879b92@linux.microsoft.com>
Date: Thu, 2 Oct 2025 09:04:21 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: decui@microsoft.com, eahariha@linux.microsoft.com,
 haiyangz@microsoft.com, kys@microsoft.com, mhklinux@outlook.com,
 nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, benhill@microsoft.com,
 bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next] hyperv: Remove the spurious null directive
 line
To: Roman Kisel <romank@linux.microsoft.com>
References: <20251001230847.5002-1-romank@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20251001230847.5002-1-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/2025 4:08 PM, Roman Kisel wrote:
> The file contains a line that consists of the lone # symbol
> followed by a newline. While that is a valid syntax as
> defined by the C99+ grammar (6.10.7 "Null directive"), it
> serves no apparent purpose in this case.
> 
> Remove the null preprocessor directive. No functional changes.
> 
> Fixes: e68bda71a238 ("hyperv: Add new Hyper-V headers in include/hyperv")
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 1be7f6a02304..77abddfc750e 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -597,8 +597,6 @@ struct ms_hyperv_tsc_page {	 /* HV_REFERENCE_TSC_PAGE */
>  #define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
>  #define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
>  
> -#
> -
>  /* Hyper-V defined statically assigned SINTs */
>  #define HV_SYNIC_INTERCEPTION_SINT_INDEX 0x00000000
>  #define HV_SYNIC_IOMMU_FAULT_SINT_INDEX  0x00000001
> 
> base-commit: e3ec97c3abaf2fb68cc755cae3229288696b9f3d

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

