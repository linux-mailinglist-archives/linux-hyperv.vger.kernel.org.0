Return-Path: <linux-hyperv+bounces-10219-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCGZGSpd5ml6vQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10219-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 19:06:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3B2430914
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 19:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A76733920DD
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AA82D24B7;
	Mon, 20 Apr 2026 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gc+2WE/e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210A324BBEE;
	Mon, 20 Apr 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698659; cv=none; b=irLuOTN6i+rsQ/RwmfjRReX5v6Id4UJPN8VekYt9dSqtP5U/WbX6x66rOJdSzPLPXCzTvDV8TcXk4t/JG8rf2lb/B6UoM7s1UAvMi7CkYhoCNoJ4i5pVkEISJUsdtpLJ8Rw/5isuQvMxftfr/xAmd/RH5kI2pC7dDjAH7zleb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698659; c=relaxed/simple;
	bh=UW0eXYKrdgq1j2hzx2L8yW4HyBPzhEy2i2Xbvs6vWWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjwIfA4yRZaUZlBl2Qqc5oT4wXFLFAtk2q36OonmUxcfkS3oHrDHddT6+AN5K9SGGa7NxCJBivlE8p9FvvVZbb7zMdY4f72lcw5Ew2/Yu/okfTxOciPXQhLO/FXBWVNQppOe+oo7RvSr1BuUK7dfAo9Wa8D5AXoIo1bx8iI6p5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gc+2WE/e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.96.139] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id BBE0220B6F08;
	Mon, 20 Apr 2026 08:24:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBE0220B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776698657;
	bh=w4/gdDUDWYUob1ngGbDVxqxNgGl8EDQI0dPMkkvkH2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gc+2WE/eO+xkaQbw1qp8fgMEoA3jNGlJO6G4ofFU2lSmXj7NJoZK6YZ+uwr2ggthz
	 own7HXfhLWSx0Gp65Uc7hwhtUsdafZywcOgz9efHgJYLtd7EfBoKNz00YBahTEHbIA
	 6GHxdYpdpwGOY4q+UtSSf9iw+hlggFkYVxMtd9TU=
Message-ID: <1407300a-83a2-41d3-a33b-e91d3178b0a2@linux.microsoft.com>
Date: Mon, 20 Apr 2026 20:54:04 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] Drivers: hv: Add support for arm64 in MSHV_VTL
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-11-namjain@linux.microsoft.com>
 <SN6PR02MB41576766C5FB291952CC58E8D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41576766C5FB291952CC58E8D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10219-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD3B2430914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 10:28 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026 5:13 AM
>>
>> Add necessary support to make MSHV_VTL work for arm64 architecture.
>> * Add stub implementation for mshv_vtl_return_call_init(): not required
>>    for arm64
>> * Remove fpu/legacy.h header inclusion, as this is not required
>> * handle HV_REGISTER_VSM_CODE_PAGE_OFFSETS register: not supported
>>    in arm64
>> * Configure custom percpu_vmbus_handler by using
>>    hv_setup_percpu_vmbus_handler()
>> * Handle hugepage functions by config checks
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   arch/arm64/include/asm/mshyperv.h |  2 ++
>>   drivers/hv/mshv_vtl_main.c        | 21 ++++++++++++++-------
>>   2 files changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mshyperv.h
>> b/arch/arm64/include/asm/mshyperv.h
>> index 36803f0386cc..027a7f062d70 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -83,6 +83,8 @@ static inline int hv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set, u
>>   	return 1;
>>   }
>>
>> +static inline void mshv_vtl_return_call_init(u64 vtl_return_offset) {}
>> +
>>   void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
>>   bool hv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu);
>>   #endif
>> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
>> index 4c9ae65ad3e8..5702fe258500 100644
>> --- a/drivers/hv/mshv_vtl_main.c
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -23,8 +23,6 @@
>>   #include <trace/events/ipi.h>
>>   #include <uapi/linux/mshv.h>
>>   #include <hyperv/hvhdk.h>
>> -
>> -#include "../../kernel/fpu/legacy.h"
> 
> Was there a particular code change that made this unnecessary? Or was it
> unnecessary from the start of this source code file? Just curious ....

This was present in initial driver changes when the assembly code was 
part of this driver. Then it moved to arch files and this was left here.
Just cleaning it up.


> 
>>   #include "mshv.h"
>>   #include "mshv_vtl.h"
>>   #include "hyperv_vmbus.h"
>> @@ -206,18 +204,21 @@ static void mshv_vtl_synic_enable_regs(unsigned int cpu)
>>   static int mshv_vtl_get_vsm_regs(void)
>>   {
>>   	struct hv_register_assoc registers[2];
>> -	int ret, count = 2;
>> +	int ret, count = 0;
>>
>> -	registers[0].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
>> -	registers[1].name = HV_REGISTER_VSM_CAPABILITIES;
>> +	registers[count++].name = HV_REGISTER_VSM_CAPABILITIES;
>> +	/* Code page offset register is not supported on ARM */
>> +	if (IS_ENABLED(CONFIG_X86_64))
>> +		registers[count++].name = HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
>>
>>   	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
>>   				       count, input_vtl_zero, registers);
>>   	if (ret)
>>   		return ret;
>>
>> -	mshv_vsm_page_offsets.as_uint64 = registers[0].value.reg64;
>> -	mshv_vsm_capabilities.as_uint64 = registers[1].value.reg64;
>> +	mshv_vsm_capabilities.as_uint64 = registers[0].value.reg64;
>> +	if (IS_ENABLED(CONFIG_X86_64))
>> +		mshv_vsm_page_offsets.as_uint64 = registers[1].value.reg64;
>>
>>   	return ret;
>>   }
> 
> This function has gotten somewhat messy to handle the x86 and arm64
> differences. Let me suggest a different approach. Have this function only
> get the VSM capabilities register, as that is generic across x86 and
> arm64. Then, update x86 mshv_vtl_return_call_init() to get the
> PAGE_OFFSETS register and then immediately use the value to update
> the static call. The global variable mshv_vms_page_offsets is no longer
> necessary.
> 
> My suggestion might be little more code because hv_call_get_vp_registers()
> is invoked in two different places. But it cleanly separates the two use
> cases, and keeps the x86 hackery under arch/x86.
> 

I implemented this in my dev branch, and it works fine. Thanks for the 
suggestion.


>> @@ -280,10 +281,13 @@ static int hv_vtl_setup_synic(void)
>>
>>   	/* Use our isr to first filter out packets destined for userspace */
>>   	hv_setup_vmbus_handler(mshv_vtl_vmbus_isr);
>> +	/* hv_setup_vmbus_handler() is stubbed for ARM64, add per-cpu VMBus handlers instead */
>> +	hv_setup_percpu_vmbus_handler(mshv_vtl_vmbus_isr);
>>
>>   	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
>>   				mshv_vtl_alloc_context, NULL);
>>   	if (ret < 0) {
>> +		hv_setup_percpu_vmbus_handler(vmbus_isr);
>>   		hv_setup_vmbus_handler(vmbus_isr);
>>   		return ret;
>>   	}
>> @@ -296,6 +300,7 @@ static int hv_vtl_setup_synic(void)
>>   static void hv_vtl_remove_synic(void)
>>   {
>>   	cpuhp_remove_state(mshv_vtl_cpuhp_online);
>> +	hv_setup_percpu_vmbus_handler(vmbus_isr);

hv_setup_percpu_vmbus_handler() calls will also be removed with the 
redesign.

Regards,
Naman

