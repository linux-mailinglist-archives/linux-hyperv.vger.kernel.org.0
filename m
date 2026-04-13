Return-Path: <linux-hyperv+bounces-10132-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNoCJZfY3GmcWQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10132-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 13:50:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B163EB8DC
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 13:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63C2E301C880
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB3231A567;
	Mon, 13 Apr 2026 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JAJih579"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDAA31A053;
	Mon, 13 Apr 2026 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080871; cv=none; b=Fsx/srttiydpUG2G/6zfY0uYJRK6IWV1qngzeWrDDqBoeGvNNMW5hvxI0HumLWcuxyroIwN9vYW6VXLTFnlTIbc4evJPnPHj76ShJJsQIwbFdZit9YAUTs2Kuy/RxMVefd7KmTYytkWAIkgrW/Hbz3RxRCPoP0vFsPHYcsfno4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080871; c=relaxed/simple;
	bh=aeU2+j127oURWfr5UJVcdLFt+DQWuAvQ6fLNBiXsn0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kY14scaHvAMkE/0skqxb8OZRm5Jp/iVa0N8slf4oMXIlL/7zUUHCqxT8W37FfphnfVKquTu1YPVvElp4EvBNdTjmctfqDUPLUe+XOVErhwo/WcDZ1kshj4NKYjIpuW90LnFQvUpSeHoplFoq1UW6Ng4ws1QAedMSyJxqyiOtnps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JAJih579; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.106] (unknown [49.205.253.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id DCF5320B7001;
	Mon, 13 Apr 2026 04:47:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCF5320B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776080870;
	bh=ZmW9qHrrNAcfztbJPZlZq0MvOI4dcjMtr4X3leEAtg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JAJih579xlgOCRGq6eu03iWt/8vu3PufifW1GO5hqErVwiCZiNlmHCCQQ3GgGfmY6
	 2NxZAlZP7Pxak6tl8945JvIANDuERrATzkCBEQuvIEFspMafzZ00xQZVz7rxFimv7M
	 mVUXg9r8DX8Pf0yMHztGGzHXr0NzHy58Qh2sVvQk=
Message-ID: <b5125f61-173f-45d0-a6dc-d795ba0f8693@linux.microsoft.com>
Date: Mon, 13 Apr 2026 17:17:39 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] Drivers: hv: Make sint vector architecture neutral
 in MSHV_VTL
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
 <20260316121241.910764-7-namjain@linux.microsoft.com>
 <SN6PR02MB4157521DEF9EA2471B6F3359D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157521DEF9EA2471B6F3359D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10132-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E7B163EB8DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 10:27 PM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026 5:13 AM
>>
>> Generalize Synthetic interrupt source vector (sint) to use
>> vmbus_interrupt variable instead, which automatically takes care of
>> architectures where HYPERVISOR_CALLBACK_VECTOR is not present (arm64).
> 
> Sashiko AI raised an interesting question about the startup timing --
> whether the vmbus_platform_driver_probe() is guaranteed to have
> set vmbus_interrupt before the VTL functions below run and use it.
> What causes the mshv_vtl.ko module to be loaded, and hence run
> mshv_vtl_init()?

There is no race condition here. The init ordering guarantees that
vmbus_interrupt is always set before mshv_vtl_synic_enable_regs()
reads it.

The call chain for setting vmbus_interrupt:

   subsys_initcall(hv_acpi_init)                          [level 4]
     -> platform_driver_register(&vmbus_platform_driver) and so on.


The call chain for reading vmbus_interrupt:

   module_init(mshv_vtl_init)                             [level 6]
     -> hv_vtl_setup_synic()
       -> cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, ..., 
mshv_vtl_alloc_context, ...)
         -> mshv_vtl_alloc_context()
           -> mshv_vtl_synic_enable_regs()
             -> sint.vector = vmbus_interrupt

do_initcalls() processes sections in order 0 through 7, so 
hv_acpi_init() (level 4) is guaranteed to complete before 
mshv_vtl_init() (level 6) runs.



Regarding memory leak on cpu offline/online or module load/unload- it is 
beyond the scope of this series, I will fix it separately.

I may need some more time in addressing comments on rest of the patches. 
Please bear with me.

Regards,
Naman

> 
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/mshv_vtl_main.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
>> index b607b6e7e121..91517b45d526 100644
>> --- a/drivers/hv/mshv_vtl_main.c
>> +++ b/drivers/hv/mshv_vtl_main.c
>> @@ -234,7 +234,7 @@ static void mshv_vtl_synic_enable_regs(unsigned int cpu)
>>   	union hv_synic_sint sint;
>>
>>   	sint.as_uint64 = 0;
>> -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
>> +	sint.vector = vmbus_interrupt;
>>   	sint.masked = false;
>>   	sint.auto_eoi = hv_recommend_using_aeoi();
>>
>> @@ -753,7 +753,7 @@ static void mshv_vtl_synic_mask_vmbus_sint(void *info)
>>   	const u8 *mask = info;
>>
>>   	sint.as_uint64 = 0;
>> -	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
>> +	sint.vector = vmbus_interrupt;
>>   	sint.masked = (*mask != 0);
>>   	sint.auto_eoi = hv_recommend_using_aeoi();
>>
>> --
>> 2.43.0
>>
> 
> Assuming there's no timing problem vs. the VMBus driver,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>


