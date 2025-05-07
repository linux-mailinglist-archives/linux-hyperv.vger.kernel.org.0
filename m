Return-Path: <linux-hyperv+bounces-5421-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CB7AAED19
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 22:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67DD47BD461
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 20:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB2628ECC7;
	Wed,  7 May 2025 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gsnrGs29"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40001C5F30;
	Wed,  7 May 2025 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649899; cv=none; b=Q4bMNOhTYAP+78R0lkrTACNgr3TLgl+hXjBnyNq7gzJVJXSem4u/Kbpc8yHJg/zeVrZseWm6huSxPHmtOc7IXEk8oh7pQEdphTdNlybPjeaTkUwgLSe6ajQnkSL6fXO4koqjTbWC7+wSylOQC6ybwX6euB1keb+F8l/vkn/Lt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649899; c=relaxed/simple;
	bh=WoPemwi0V2QyJH6Yf1Kh8i/XajixcA6gmolA/9zzlik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jd3NMGhUPzGD2ruFXnn6jG9LhumA+S6NIyFQ3xa7EEb1R1pXHdHdMH7mRiBglyKurcTveUx0HDbAxh7Og67jUPw4/PRJfdggyVurea8GI9B2xTpskz9lR8kmMQ9aVHq9iXz9dHKzTL6aS/JwfZE2hHoI04oFNIjEQVGu7TaDljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gsnrGs29; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 117D52119CB5;
	Wed,  7 May 2025 13:31:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 117D52119CB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746649897;
	bh=NvLvN0qjxq/EbxkWcOBLlauj5fOlNuy9CoKl0TZCL+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gsnrGs295/1l+r7Hpnhdg2pOgqM155CA2/hQQbKK86IECm3kkK7vDqllX0HF0YNHJ
	 GbAh5iLyK91e2azjX+jnp8pBynMRvuqH0QErfbKTGreSRCUVyl23iJ9Vc5jc0KUq3H
	 jRBWYhQECrvZwVY4ZFUZYpy/HAW3doKLNQpn3xA8=
Message-ID: <29edc00e-9797-4f4a-83b3-0b4158c94a16@linux.microsoft.com>
Date: Wed, 7 May 2025 13:31:36 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Naman Jain <namjain@linux.microsoft.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444BE7FD66EA9CA9B4B9A97BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <be04a26f-866d-43e6-9a0b-15b91405503e@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <be04a26f-866d-43e6-9a0b-15b91405503e@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/7/2025 4:21 AM, Naman Jain wrote:
> 
> 

[...]

> <snip>
> 
>>> +        return -EINVAL;
>>> +    if (copy_from_user(payload, (void __user *)message.payload_ptr,
>>> +               message.payload_size))
>>> +        return -EFAULT;
>>> +
>>> +    return hv_post_message((union
>>
>> This function definition is in separate file which can be build as 
>> independent module, this will cause
>> problem while linking . Try building with CONFIG_HYPERV=m and check.
>>
>> - Saurabh
> 
> Thanks for reviewing Saurabh. As CONFIG_HYPERV can be set to 'm'
> and CONFIG_MSHV_VTL depends on it, changing CONFIG_MSHV_VTL to tristate
> and a few tweaks in Makefile will fix this issue. This will ensure that
> mshv_vtl is also built as a module when hyperv is built as a module.
> 
> I'll take care of this in next version.

Let me ask for a clarification. How would the system boot if
CONFIG_HYPERV is set to m? The arch parts are going to be still
compiled-in, correct? Otherwise I don't see how that would
initialize.

I am thinking who would load Hyper-V modules on the system
that requires Hyper-V here. It is understandable that
distro's build Hyper-V as a module. That way, they don't have to load
anything when there is no Hyper-V. Here, it is Hyper-V in and out, what
do we need to fix?

> 
> here is the diff for reference:
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 57dcfcb69b88..c7f21b483377 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -73,7 +73,7 @@ config MSHV_ROOT
>            If unsure, say N.
> 
>   config MSHV_VTL
> -       bool "Microsoft Hyper-V VTL driver"
> +       tristate "Microsoft Hyper-V VTL driver"
>          depends on HYPERV && X86_64
>          depends on TRANSPARENT_HUGEPAGE
>          depends on OF
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 5e785dae08cc..c53a0df746b7 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -15,9 +15,11 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)    += hv_debugfs.o
>   hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>   mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
>                 mshv_root_hv_call.o mshv_portid_table.o
> +mshv_vtl-y := mshv_vtl_main.o
> 
>   # Code that must be built-in
>   obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
> -obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o mshv_common.o
> -
> -mshv_vtl-y := mshv_vtl_main.o mshv_common.o
> +obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
> +ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
> +    obj-y += mshv_common.o
> +endif
> 
> Regards,
> Naman

-- 
Thank you,
Roman


