Return-Path: <linux-hyperv+bounces-5430-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A2BAAFECE
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 17:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F310B188D469
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFC7279915;
	Thu,  8 May 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jHYTkIPB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFF427934D;
	Thu,  8 May 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716971; cv=none; b=SZ+cdpjyPMqSugSqRSzpTtFO9TacM0jmucjGQlyRLhjuMqNpnTEF84w6MwUmg2UDpwQ0XcNAQ073k6a48lRuIuoG9fMKKx4Uwc6d0cfdWjMZp8f1IMjR9GN3qwuppqCda0QNSWI20lPGHkinxuyXdZgfP+uIJV12pVpzvX3FfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716971; c=relaxed/simple;
	bh=dIUxDRQQ9VfT08/FY9cCuIoFDGDlW7Ej4+wOflv8zag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrgsOi+S1S7LE24WwoOKdmqNK7yPPnp/QiKenSi/gPFwGnuK2UNvyfOFTOAbzIR/PG1reWLaspZ+vpbaq0fOciQJM+uLjlfS59NnbaP6mKcHtkfg9M03LqlSC4PSw5W6A21fgihA0Nq/SrLwiJZOtA1zQhv+0mw2OLMuEFsQe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jHYTkIPB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 18C5A21199E9;
	Thu,  8 May 2025 08:09:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18C5A21199E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746716963;
	bh=HGRfFjvHvYenmbQuhVeAhm/NMBt8Vf8l9aGiCRvcDyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jHYTkIPBCaYL0LF6HoXl5B1lqwE5C+JvjTrmzsy9SlZ5u2+BCJN27u6IsTD7kSKdk
	 pzYrv/jq5Wnv5HVfgcRG7tCANUs1mu2IlODINDrllqGz8NLqIUwGiiQwi/ewB9lYjF
	 hkW/R6irTp43W+4HZPvPGScqt5BqsFHCzUkn/Qew=
Message-ID: <4273451f-5edb-4d39-86b9-022456bba950@linux.microsoft.com>
Date: Thu, 8 May 2025 08:09:22 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next 0/2] arch/x86, x86/hyperv: Few fixes for the
 AP startup
To: Michael Kelley <mhklinux@outlook.com>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "brgerst@gmail.com" <brgerst@gmail.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "dimitri.sivanich@hpe.com" <dimitri.sivanich@hpe.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "imran.f.khan@oracle.com" <imran.f.khan@oracle.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "justin.ernst@hpe.com" <justin.ernst@hpe.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "kyle.meyer@hpe.com" <kyle.meyer@hpe.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
 <lenb@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "nikunj@amd.com" <nikunj@amd.com>, "papaluri@amd.com" <papaluri@amd.com>,
 "patryk.wlazlyn@linux.intel.com" <patryk.wlazlyn@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "russ.anderson@hpe.com" <russ.anderson@hpe.com>,
 "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
 "steve.wahl@hpe.com" <steve.wahl@hpe.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
References: <20250507182227.7421-1-romank@linux.microsoft.com>
 <SN6PR02MB415715B9BE06E5B505F6DBB4D48BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415715B9BE06E5B505F6DBB4D48BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/2025 9:22 PM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, May 7, 2025 11:22 AM
[...]>
> I think this works. It's unfortunate that Patch 1 adds 11 lines of code/comments that
> Patch 2 then deletes, which seems like undesirable churn. I was expecting adding the
> "cpu" parameter to come first, which then makes fixing the hv_snp_boot_ap() problem
> more straightforward. But looking more closely, hv_snp_boot_ap() already has a
> parameter erroneously named "cpu", so adding the correct "cpu" parameter isn't
> transparent. Hence the order you've chosen is probably the best resolution for a
> messy situation. :-)

Thanks, Michael :) Looked as a good trade-off, went ahead with it. Will
be happy to address any concerns of that folks might have!

> 
> Michael
> 
>>
>>   arch/x86/coco/sev/core.c             | 13 ++-----
>>   arch/x86/hyperv/hv_init.c            | 33 +++++++++++++++++
>>   arch/x86/hyperv/hv_vtl.c             | 54 ++++------------------------
>>   arch/x86/hyperv/ivm.c                | 11 ++++--
>>   arch/x86/include/asm/apic.h          |  8 ++---
>>   arch/x86/include/asm/mshyperv.h      |  7 ++--
>>   arch/x86/kernel/acpi/madt_wakeup.c   |  2 +-
>>   arch/x86/kernel/apic/apic_noop.c     |  8 ++++-
>>   arch/x86/kernel/apic/apic_numachip.c |  2 +-
>>   arch/x86/kernel/apic/x2apic_uv_x.c   |  2 +-
>>   arch/x86/kernel/smpboot.c            | 10 +++---
>>   include/hyperv/hvgdk_mini.h          |  2 +-
>>   12 files changed, 76 insertions(+), 76 deletions(-)
>>
>>
>> base-commit: 9b0844d87b1407681b78130429f798beb366f43f
>> --
>> 2.43.0
> 

-- 
Thank you,
Roman


