Return-Path: <linux-hyperv+bounces-5436-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 970BCAB0241
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 20:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9461C4007A
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 18:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE32874FE;
	Thu,  8 May 2025 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T3jLATy5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303A52874EB;
	Thu,  8 May 2025 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728016; cv=none; b=fJx/VjlUrTZVpBySjecAaiKrJ2K2a+CCwokfxawF/Pbca0hSvJrEYmKZjrowe22rtitbfVH6dvJomaJR9BDlky/6/fucehEdHqUEzQ506i9TSAj2lmbDjXHBWBPoJnOMvpGSkLhB1xWgHmxkAHm3eyiCE4dM8YWczin0J1kBrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728016; c=relaxed/simple;
	bh=7YNxL1Vm89Ly6NfdTnBUxIowWrliUwR2DRgb+MJjmrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdGs/0Bu3/IgIviWhr+jMkVSK7xAP91G7EzwEptTp7cJ3vOkXBDjSYDBUtEo5u+zsos7ctbuxzXN9kAqHuGDRlcA8qlJv9LBgNDngfj9PKh4oUjQyLe8ZTiB121icfAlKuYHr0zBCgu+vR57rYOYMk/KZCplMt88BL1R0MPHMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T3jLATy5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1790209846A;
	Thu,  8 May 2025 11:13:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1790209846A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746728013;
	bh=LO/oU31zQKuZfvDv0dRtOXlLNZ7bEkZUhWrRkKEMaKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T3jLATy5Kr4R+l+iK6j0Iu/2R+WKgl56UrzjK/gv7IYcJVlPswenenA+T9uT/4heJ
	 oHEH8osYF+vn+GvUUVPPoTjl3rMNdO4Q3ckRQEVzhxPfPBztqFb349jUE5M7IdcHJ/
	 2lOkAkozHsEubravHQF9lk8GnZSYVEuhks5mtfsE=
Message-ID: <2cd63d5d-21af-408b-869a-b38118f4cad6@linux.microsoft.com>
Date: Thu, 8 May 2025 11:13:33 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Wei Liu <wei.liu@kernel.org>
Cc: Saurabh Singh Sengar <ssengar@microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444BE7FD66EA9CA9B4B9A97BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <be04a26f-866d-43e6-9a0b-15b91405503e@linux.microsoft.com>
 <29edc00e-9797-4f4a-83b3-0b4158c94a16@linux.microsoft.com>
 <KUZP153MB14448028621F8148D5129D9FBE8BA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <1edea7f4-5ad2-4103-8eb5-9d5d9f0c7b0d@linux.microsoft.com>
 <aBztdK82ZQQvnWsh@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aBztdK82ZQQvnWsh@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/8/2025 10:44 AM, Wei Liu wrote:
> On Thu, May 08, 2025 at 08:44:14AM -0700, Roman Kisel wrote:
[...]
>>
>> You seem to know for whom it is broken, would be great to share this
>> knowledge. When CONFIG_MSHV_VTL is set to "m", OpenHCL will break down
>> without additional work. So why do we need to be able to build that
>> as a module, to let someone build the firmware that doesn't work?
>>
>> So far the request comes off as absurd to me.
>>
> 
> I don't think this is an absurd request.
> 
> While obviously Microsoft will only build the code as builtin, there are
> bots that do randconfig build tests but never run the resulting binary.

Thanks, Wei, for the thorough explanation!

> 
> Thanks,
> Wei.
> 
>>>
>>> - Saurabh
>>>
>>>>
>>>>>
>>>>> here is the diff for reference:
>>>>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig index
>>>>> 57dcfcb69b88..c7f21b483377 100644
>>>>> --- a/drivers/hv/Kconfig
>>>>> +++ b/drivers/hv/Kconfig
>>>>> @@ -73,7 +73,7 @@ config MSHV_ROOT
>>>>>              If unsure, say N.
>>>>>
>>>>>     config MSHV_VTL
>>>>> -       bool "Microsoft Hyper-V VTL driver"
>>>>> +       tristate "Microsoft Hyper-V VTL driver"
>>>>>            depends on HYPERV && X86_64
>>>>>            depends on TRANSPARENT_HUGEPAGE
>>>>>            depends on OF
>>>>> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile index
>>>>> 5e785dae08cc..c53a0df746b7 100644
>>>>> --- a/drivers/hv/Makefile
>>>>> +++ b/drivers/hv/Makefile
>>>>> @@ -15,9 +15,11 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)    +=
>>>>> hv_debugfs.o
>>>>>     hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>>>>>     mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o
>>>>> mshv_irq.o \
>>>>>                   mshv_root_hv_call.o mshv_portid_table.o
>>>>> +mshv_vtl-y := mshv_vtl_main.o
>>>>>
>>>>>     # Code that must be built-in
>>>>>     obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o -obj-$(subst
>>>>> m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o mshv_common.o
>>>>> -
>>>>> -mshv_vtl-y := mshv_vtl_main.o mshv_common.o
>>>>> +obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o ifneq
>>>>> +($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
>>>>> +    obj-y += mshv_common.o
>>>>> +endif
>>>>>
>>>>> Regards,
>>>>> Naman
>>>>
>>>> --
>>>> Thank you,
>>>> Roman
>>>
>>
>> -- 
>> Thank you,
>> Roman
>>

-- 
Thank you,
Roman


