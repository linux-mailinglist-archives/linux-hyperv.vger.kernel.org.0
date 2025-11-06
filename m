Return-Path: <linux-hyperv+bounces-7441-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0467FC3CB00
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 18:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BEAF350F8A
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E2334366;
	Thu,  6 Nov 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gdxv0LZR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F6145B3E;
	Thu,  6 Nov 2025 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448598; cv=none; b=VcCazA/FvrpRlz1rmtr8UkKLA2p7saMfwsxbQBztekIoyXILtxcpokxgvXhNbe0lXZiIuUbe+T1OgQSas5mUxIM3gY7ZA11QN/aifySfw9ajcZ1A/RCNKFycEuomTANiEVUnDTgI8PojoXZMM+YXEcIxJh2n7X/Fux7EWkfwM5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448598; c=relaxed/simple;
	bh=rrWu3nzkmdhuH0jhgfW2/CmpbQhyqs3JLeD+VZ7jPCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMR8ZCXWRQxQWsfWCjcBrZpKS/6GgP033MRn3cSfa4AtRp6sCdC6a0O8SJGFqLhmUpqK2Nv1vF8dX+hThHyfwo8DENRVPZsxWTG0n1ByMld7nXJAm8iP/7j/sKoQ1O87Dgwu0F+mcM3OGW+0d7hMGjLjvuqe3eMmEUvKOLUQdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gdxv0LZR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.225.81] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0969F201CEF4;
	Thu,  6 Nov 2025 09:03:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0969F201CEF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762448596;
	bh=hnrJlGbkpTWpmJ1hPVp7S4M/nbBQSXDCGRX4VjItaHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gdxv0LZRkhrpyU2ztf+w32wy4FxEJy5kkqlsJbzzCTC/EamZckh0xFUwEzlXQsHSB
	 FSazdWB3i+BtPLh7Tr3EIGFjecbnnrj2tYX35lgd9Mxt3SUdqnY79zZWzCrNVMoIwi
	 FaZarYA2GbXmCq0wh/IzuYzcZVb0FLPVY4QULfnI=
Message-ID: <c7e53740-ed96-470c-b16a-46061a9dfac7@linux.microsoft.com>
Date: Thu, 6 Nov 2025 22:33:06 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Mukesh Rathor <mrathor@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Christoph Hellwig <hch@infradead.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>
References: <20251029050139.46545-1-namjain@linux.microsoft.com>
 <20251029050139.46545-3-namjain@linux.microsoft.com>
 <SN6PR02MB41574847FF9B66A3D7321167D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41574847FF9B66A3D7321167D4C2A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/2025 8:24 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, October 28, 2025 10:02 PM
>>
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
>>   arch/x86/hyperv/Makefile           |   10 +-
>>   arch/x86/hyperv/hv_vtl.c           |   43 +
>>   arch/x86/hyperv/mshv-asm-offsets.c |   37 +
>>   arch/x86/hyperv/mshv_vtl_asm.S     |   98 ++
>>   arch/x86/include/asm/mshyperv.h    |   34 +
>>   drivers/hv/Kconfig                 |   26 +-
>>   drivers/hv/Makefile                |    7 +-
>>   drivers/hv/mshv_vtl.h              |   25 +
>>   drivers/hv/mshv_vtl_main.c         | 1392 ++++++++++++++++++++++++++++
>>   include/hyperv/hvgdk_mini.h        |  106 +++
>>   include/uapi/linux/mshv.h          |   80 ++
>>   11 files changed, 1855 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/x86/hyperv/mshv-asm-offsets.c
>>   create mode 100644 arch/x86/hyperv/mshv_vtl_asm.S
>>   create mode 100644 drivers/hv/mshv_vtl.h
>>   create mode 100644 drivers/hv/mshv_vtl_main.c
>>
> 
> I've reviewed and made suggestions on most of this code pretty
> carefully over the past few months and through 10 revisions. This
> version addresses my suggestions and looks good to me. There
> are a few areas, such as the assembly code in mshv_vtl_asm.S and
> the details of the hypervisor ABI for doing VTL Return, that are
> outside my area of expertise so I'm limited to a surface level
> review.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thanks for the review Michael.

Regards
Naman

