Return-Path: <linux-hyperv+bounces-5403-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC9AADD5E
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 13:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA851BC139F
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 11:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903EE1865EB;
	Wed,  7 May 2025 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bPXDLx8j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5F76FC5;
	Wed,  7 May 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617449; cv=none; b=Pa6KQAfW1qa3ezgx6yCr11ckmsTes7iUFarrOVCa1elJiKPqnDfQ0br6Rt8l2LKs9lLhm9gOrSUGMu+446pGtGzKiUCNf2WCXx0s8Ej6xKhMuhhQAbGqLwTff/jhuboCCXZfYOsek00P4r7iS0bCvppUSPFhJ+QsyR+fZH2zd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617449; c=relaxed/simple;
	bh=BT5flKrqdULW+U+spcOhTaxlNK6ECqi3PjYzjthRMyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BENMtcagZ1fW5Et6iUtDbhVVd1Pui0ltCc2xbSwNNihCYB4Dy5LXtgE9SLtr9SyZZBzYC3yLZhCc79qTDZggX003PxcUrGyHswUiO9N9TfabRsRxZUC+yXeHfwYM7II4v47SAj1aAl1BDv/LoeSFW+E3birFCtfRfNhXEcDCpJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bPXDLx8j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.218.35] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id E944E21180CA;
	Wed,  7 May 2025 04:21:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E944E21180CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746616916;
	bh=YqDRKtZG+1qSllTV6hrI3N5y77O1WF8OhkPzBs8Ho3A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bPXDLx8jx7FJJIDSCZ7NsGBFopGHWZmbDslW+Q7oSJR9Gro2OQosggYFSZ7uNaIcr
	 KeG8tJHb2PO6dKajP7Lxseu72h6RVyd0Z95E24sQNYIxXep4bSdskBlDXbj9eYpVgj
	 Jci8uIVErP+W+D1/HJJIvNN0Gl38fMCUW83SRRcE=
Message-ID: <be04a26f-866d-43e6-9a0b-15b91405503e@linux.microsoft.com>
Date: Wed, 7 May 2025 16:51:50 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Saurabh Singh Sengar <ssengar@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444BE7FD66EA9CA9B4B9A97BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <KUZP153MB1444BE7FD66EA9CA9B4B9A97BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/2025 3:49 PM, Saurabh Singh Sengar wrote:
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
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>
>> OpenVMM :
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fopenv
>> mm.dev%2Fguide%2F&data=05%7C02%7Cssengar%40microsoft.com%7Ce3b
>> 0a61c2c72423aa33408dd8c7af2e9%7C72f988bf86f141af91ab2d7cd011db47%
>> 7C1%7C0%7C638821181946438191%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
>> 0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp
>> bCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=uYUgaqKTazf0BL8ukdeUEor
>> d9hN8NidMLwE19NdprlE%3D&reserved=0
>>
>> ---

<snip>

>> +		return -EINVAL;
>> +	if (copy_from_user(payload, (void __user *)message.payload_ptr,
>> +			   message.payload_size))
>> +		return -EFAULT;
>> +
>> +	return hv_post_message((union
> 
> This function definition is in separate file which can be build as independent module, this will cause
> problem while linking . Try building with CONFIG_HYPERV=m and check.
> 
> - Saurabh

Thanks for reviewing Saurabh. As CONFIG_HYPERV can be set to 'm'
and CONFIG_MSHV_VTL depends on it, changing CONFIG_MSHV_VTL to tristate
and a few tweaks in Makefile will fix this issue. This will ensure that
mshv_vtl is also built as a module when hyperv is built as a module.

I'll take care of this in next version.

here is the diff for reference:
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 57dcfcb69b88..c7f21b483377 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -73,7 +73,7 @@ config MSHV_ROOT
           If unsure, say N.

  config MSHV_VTL
-       bool "Microsoft Hyper-V VTL driver"
+       tristate "Microsoft Hyper-V VTL driver"
         depends on HYPERV && X86_64
         depends on TRANSPARENT_HUGEPAGE
         depends on OF
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 5e785dae08cc..c53a0df746b7 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -15,9 +15,11 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)    += hv_debugfs.o
  hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
  mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
                mshv_root_hv_call.o mshv_portid_table.o
+mshv_vtl-y := mshv_vtl_main.o

  # Code that must be built-in
  obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
-obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o mshv_common.o
-
-mshv_vtl-y := mshv_vtl_main.o mshv_common.o
+obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
+ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
+    obj-y += mshv_common.o
+endif

Regards,
Naman

