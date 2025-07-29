Return-Path: <linux-hyperv+bounces-6429-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3870B14773
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 07:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ADD188AFCA
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jul 2025 05:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10A91F0E50;
	Tue, 29 Jul 2025 05:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CXVfl0BH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334DB231C91;
	Tue, 29 Jul 2025 05:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753765795; cv=none; b=PeUL4ktp2eO3JaiOV+ni74f7ExA5TmnR4E+ZHPivdZsW44mIz5nZ+0KIEbD19OXFqWhETZDvwUDfSSWmQW8KI1yKmUrvVvHy/8Kyuys6NhdkA8cT429KhF0XyTmXUl4BEZGlztqJBpRzKaLYo4/cXK7/9LGiXWItRpfdBt2+Okc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753765795; c=relaxed/simple;
	bh=/Uf+Pxz21IzDt0yntLmrEa/esebmzlSCFWhcb6GbOUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Afa4bIvBtCxdFR6XGD7TOmtWWW3YjIKay2ItA1DTw4R0hsZLCEf1m66ppkkYqmgMr5f0n41WLtsSukcDf+ff6Gnzra8XawA+jMMpYieP36DOTwNha+c5ULdz4UN2esHWAFkZwgvo03KEKIAvD7PLX/ZMYWJ96ZVRX7I6XWaMNjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CXVfl0BH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.161.187] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 39B9F2116DD5;
	Mon, 28 Jul 2025 22:09:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39B9F2116DD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753765793;
	bh=SBrdiyjvaPw73d4co86gOHCd9t5BOIS2mb3SAsHzhxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CXVfl0BHjY25Cq7SrhAQXqtzKtixCOYK+4nX9U0Pb0ep5u8ajOO0pWkoyKfWUZvRN
	 1Zxrd6z7BieT14IVlLQW0L8zM3onQ7nZ2CKOMIjI5QyLeFwN+/DNMrWMtA0M2GngZu
	 wVDPczOzfmc92INYGUyceQ9BC4kcBDvSPJqYWT7Q=
Message-ID: <6a6e50da-43e8-4fb1-a010-13f43b062adc@linux.microsoft.com>
Date: Tue, 29 Jul 2025 10:39:46 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>,
 Markus Elfring <Markus.Elfring@web.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
 <20250724082547.195235-3-namjain@linux.microsoft.com>
 <SN6PR02MB4157495A60189FB3D9A7C5CAD458A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157495A60189FB3D9A7C5CAD458A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/27/2025 5:20 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, July 24, 2025 1:26 AM
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
>> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
>> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>> Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>
>> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/Kconfig          |   22 +
>>   drivers/hv/Makefile         |    7 +-
>>   drivers/hv/mshv_vtl.h       |   52 ++
>>   drivers/hv/mshv_vtl_main.c  | 1508 +++++++++++++++++++++++++++++++++++
>>   include/hyperv/hvgdk_mini.h |  106 +++
>>   include/uapi/linux/mshv.h   |   80 ++
>>   6 files changed, 1774 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/hv/mshv_vtl.h
>>   create mode 100644 drivers/hv/mshv_vtl_main.c
>>
> 
> [snip]
> 
>> +
>> +static int mshv_vtl_set_reg(struct hv_register_assoc *regs)
>> +{
>> +	u64 reg64;
>> +	enum hv_register_name gpr_name;
>> +	int i;
>> +
>> +	gpr_name = regs->name;
>> +	reg64 = regs->value.reg64;
>> +
>> +	/* Search for the register in the table */
>> +	for (i = 0; i < ARRAY_SIZE(reg_table); i++) {
>> +		if (reg_table[i].reg_name == gpr_name) {
>> +			if (reg_table[i].debug_reg_num != -1) {
>> +				/* Handle debug registers */
>> +				if (gpr_name == HV_X64_REGISTER_DR6 &&
>> +				    !mshv_vsm_capabilities.dr6_shared)
>> +					goto hypercall;
>> +				native_set_debugreg(reg_table[i].debug_reg_num, reg64);
>> +			} else {
>> +				/* Handle MSRs */
>> +				wrmsrl(reg_table[i].msr_addr, reg64);
>> +			}
>> +			return 0;
>> +		}
>> +	}
>> +
>> +hypercall:
>> +	return 1;
>> +}
>> +
>> +static int mshv_vtl_get_reg(struct hv_register_assoc *regs)
>> +{
>> +	u64 *reg64;
>> +	enum hv_register_name gpr_name;
>> +	int i;
>> +
>> +	gpr_name = regs->name;
>> +	reg64 = (u64 *)&regs->value.reg64;
>> +
>> +	/* Search for the register in the table */
>> +	for (i = 0; i < ARRAY_SIZE(reg_table); i++) {
>> +		if (reg_table[i].reg_name == gpr_name) {
>> +			if (reg_table[i].debug_reg_num != -1) {
>> +				/* Handle debug registers */
>> +				if (gpr_name == HV_X64_REGISTER_DR6 &&
>> +				    !mshv_vsm_capabilities.dr6_shared)
>> +					goto hypercall;
>> +				*reg64 = native_get_debugreg(reg_table[i].debug_reg_num);
>> +			} else {
>> +				/* Handle MSRs */
>> +				rdmsrl(reg_table[i].msr_addr, *reg64);
>> +			}
>> +			return 0;
>> +		}
>> +	}
>> +
>> +hypercall:
>> +	return 1;
>> +}
>> +
> 
> One more comment on this patch. What do you think about
> combining mshv_vtl_set_reg() and mshv_vtl_get_reg() into a single
> function? The two functions have a lot code duplication that could be
> avoided. Here's my untested version (not even compile tested):
> 
> +static int mshv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set)
> +{
> +	u64 *reg64;
> +	enum hv_register_name gpr_name;
> +	int i;
> +
> +	gpr_name = regs->name;
> +	reg64 = &regs->value.reg64;
> +
> +	/* Search for the register in the table */
> +	for (i = 0; i < ARRAY_SIZE(reg_table); i++) {
> +		if (reg_table[i].reg_name != gpr_name)
> +			continue;
> +		if (reg_table[i].debug_reg_num != -1) {
> +			/* Handle debug registers */
> +			if (gpr_name == HV_X64_REGISTER_DR6 &&
> +			    !mshv_vsm_capabilities.dr6_shared)
> +				goto hypercall;
> +			if (set)
> +				native_set_debugreg(reg_table[i].debug_reg_num, *reg64);
> +			else
> +				*reg64 = native_get_debugreg(reg_table[i].debug_reg_num);
> +		} else {
> +			/* Handle MSRs */
> +			if (set)
> +				wrmsrl(reg_table[i].msr_addr, *reg64);
> +			else
> +				rdmsrl(reg_table[i].msr_addr, *reg64);
> +		}
> +		return 0;
> +	}
> +
> +hypercall:
> +	return 1;
> +}
> +
> 
> Two call sites would need to be updated to pass "true" and "false",
> respectively, for the "set" parameter.
> 
> I changed the gpr_name matching to do "continue" on a mismatch
> just to avoid a level of indentation. It's functionally the same as your
> code.
> 
> Michael

Acked, looks good. Thanks for sharing the improvements. Sending v7 now.

Regards,
Naman

