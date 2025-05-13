Return-Path: <linux-hyperv+bounces-5484-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19152AB4A95
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 06:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DA519E0D95
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 04:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC019DF5B;
	Tue, 13 May 2025 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WyjtLEW7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F61189B91;
	Tue, 13 May 2025 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747110778; cv=none; b=eZBXY6Oi/XEnXS3jI+Aa//6ex+5gpogNdyLnjvpzkPk4Wcw78yhOcbv6ST+/GxhWrbSdccKTpsAg8w5Knsjq4M3qSM7da6Bwk3MoHGz2ROtcuNzrgyjzQB6ppK4EIHIQS63wsNYPhM3Bn8/yvyhvkGikcyHJ+8aLL76oC9ZMxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747110778; c=relaxed/simple;
	bh=glsXX3NzTpFART/SNkif/stFqryAJrvuV/l81shnKKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvTxTndepQndbUnDZ3FkFcyeY4gCTCBXc2cDS+8zLvM2SyoC4TYRbo3RamRZyIOm6fp32Y4s00APM8DcvrhG5gxNiLLGxJ3UP+hZbTb906c6C/nEpudqh6mEulUFYk8vE1j8RTVAVYMH13c007FqQDr8he2DPrmLhQEEJ0uRTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WyjtLEW7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.65.22] (unknown [167.220.238.86])
	by linux.microsoft.com (Postfix) with ESMTPSA id D26FF201DB08;
	Mon, 12 May 2025 21:32:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D26FF201DB08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747110770;
	bh=OV7kXzu/atLmoHnZAxCd7MLuce+mPeBMNERqD4Xjfzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WyjtLEW76E+J/gkzzyr6+pABFvVF3nASn5qsVLuF0/7ui4XAkcxXmyo7nzmDanu8f
	 oxXpmMwL8SvQKvbDAFnEM5VD62nHkzuCWCQ+pzlhV4OdCTj0GE3SLh4jwkFnzoMknw
	 yowXCjPnpe24qqhY2PocC3peU/QTSyNAneOkB+CE=
Message-ID: <686e2f6b-2032-4485-b84b-1ae9bddb9341@linux.microsoft.com>
Date: Tue, 13 May 2025 10:02:43 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Saurabh Singh Sengar <ssengar@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250512140432.2387503-1-namjain@linux.microsoft.com>
 <20250512140432.2387503-3-namjain@linux.microsoft.com>
 <KUZP153MB1444CF7C66D521208B0CAC76BE97A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <KUZP153MB1444CF7C66D521208B0CAC76BE97A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/12/2025 7:42 PM, Saurabh Singh Sengar wrote:
> 
>> Provide an interface for Virtual Machine Monitor like OpenVMM and its
>> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
>> Expose devices and support IOCTLs for features like VTL creation,
>> VTL0 memory management, context switch, making hypercalls,
>> mapping VTL0 address space to VTL2 userspace, getting new VMBus
>> messages and channel events in VTL2 etc.
>>
>> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/Kconfig          |   21 +
>>   drivers/hv/Makefile         |    7 +-
>>   drivers/hv/mshv_vtl.h       |   52 +
>>   drivers/hv/mshv_vtl_main.c  | 1783
>> +++++++++++++++++++++++++++++++++++
>>   include/hyperv/hvgdk_mini.h |   81 ++
>>   include/hyperv/hvhdk.h      |    1 +
>>   include/uapi/linux/mshv.h   |   82 ++
>>   7 files changed, 2026 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/hv/mshv_vtl.h
>>   create mode 100644 drivers/hv/mshv_vtl_main.c
>>
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index eefa0b559b73..05f990306d40 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -72,4 +72,25 @@ config MSHV_ROOT
>>
>>   	  If unsure, say N.
>>
>> +config MSHV_VTL
>> +	tristate "Microsoft Hyper-V VTL driver"
>> +	depends on HYPERV && X86_64
>> +	depends on TRANSPARENT_HUGEPAGE
>> +	depends on OF
> 
> I am aware that OpenHCL works only with DeviceTree and hence we have to

yes, that was the reason for keeping it.

> enable CONFIG_OF, but I am not aware of any dependency in this driver, why
> we need to enable CONFIG_OF by this driver.
> 
> We can always enable CONFIG_OF separately in OpenHCL kernel configs. Please check.
> 
> - Saurabh

But this is right, I'll remove it. Just FYI, rest of the configs and
header files are required for it to compile.


Regards,
Naman

