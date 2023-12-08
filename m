Return-Path: <linux-hyperv+bounces-1299-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A9880A3B3
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Dec 2023 13:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DC928181A
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Dec 2023 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0887913ADC;
	Fri,  8 Dec 2023 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BUVmKnGD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4B1D11C;
	Fri,  8 Dec 2023 04:45:09 -0800 (PST)
Received: from [192.168.178.49] (dynamic-adsl-84-220-28-122.clienti.tiscali.it [84.220.28.122])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6D4F120B74C0;
	Fri,  8 Dec 2023 04:45:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D4F120B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702039509;
	bh=zL4AbNjbmi2aO3fv6OGRUpOmIiBiCf30fFHaYwt5Raw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BUVmKnGDTA53reQHcFIoKapthWuSsj+Fmj6JeteJHUjBCYTQnSIwz7B6+waD6/wP9
	 LGE6tu/GYfp6DCQzyVDgeWn0q3Gluu/kFJVlcB2qjuyCbBzZmqP0Lbdblyx+6U/ra1
	 o/QBLXcaByDmFUW2O9ZFuXtSmLmoR7hlTN0mpJ98=
Message-ID: <b99c0f94-da56-4963-984d-ae177b0b7b0b@linux.microsoft.com>
Date: Fri, 8 Dec 2023 13:45:01 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Content-Language: en-US
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "cascardo@canonical.com" <cascardo@canonical.com>,
 "Huang, Kai" <kai.huang@intel.com>, "Cui, Dexuan" <decui@microsoft.com>,
 "mhkelley58@gmail.com" <mhkelley58@gmail.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sashal@kernel.org" <sashal@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
 <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
 <6f27610f-afc4-4356-b297-13253bb0a232@linux.microsoft.com>
 <ffcc8c550d5ba6122b201d8170b42ee581826d47.camel@intel.com>
 <02e079e8-cc72-49d8-9191-8a753526eb18@linux.microsoft.com>
 <7b725783f1f9102c176737667bfec12f75099961.camel@intel.com>
 <fa86fbd1-998b-456b-971f-a5a94daeca28@linux.microsoft.com>
 <DM8PR11MB57503924C64E1C79FB585496E78BA@DM8PR11MB5750.namprd11.prod.outlook.com>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <DM8PR11MB57503924C64E1C79FB585496E78BA@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/12/2023 18:36, Reshetova, Elena wrote:
>>>> The TDVMCALLs are related to the I/O path (networking/block io) into the L2
>> guest, and
>>>> so they intentionally go straight to L0 and are never injected to L1. L1 is not
>>>> involved in that path at all.
>>>>
>>>> Using something different than TDVMCALLs here would lead to additional
>> traps to L1 and
>>>> just add latency/complexity.
>>>
>>> Looks by default you assume we should use TDX partitioning as "paravisor L1" +
>>> "L0 device I/O emulation".
>>>
>>
>> I don't actually want to impose this model on anyone, but this is the one that
>> could use some refactoring. I intend to rework these patches to not use a single
>> "td_partitioning_active" for decisions.
>>
>>> I think we are lacking background of this usage model and how it works.  For
>>> instance, typically L2 is created by L1, and L1 is responsible for L2's device
>>> I/O emulation.  I don't quite understand how could L0 emulate L2's device I/O?
>>>
>>> Can you provide more information?
>>
>> Let's differentiate between fast and slow I/O. The whole point of the paravisor in
>> L1 is to provide device emulation for slow I/O: TPM, RTC, NVRAM, IO-APIC, serial
>> ports.
> 
> Out of my curiosity and not really related to this discussion, but could you please
> elaborate on RTC part here? Do you actually host secure time in L1 to be provided
> to the L2? 
> 
> Best Regards,
> Elena.

Hi Elena,

I think this RTC is more for compatibility and to give the guest a way to initialize
the system clock. This could potentially be a secure time source in the future but it
isn't right now. This is what the guest sees right now (might need some more
enlightenment):

# dmesg | grep -E -i 'clock|rtc|tsc'
[    0.000000] clocksource: hyperv_clocksource_tsc_page: mask: 0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000001] tsc: Marking TSC unstable due to running on Hyper-V
[    0.003621] tsc: Detected 2100.000 MHz processor
[    0.411943] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.887459] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.895842] PM: RTC time: 16:31:58, date: 2023-12-07
[    1.043431] PTP clock support registered
[    1.096563] clocksource: Switched to clocksource hyperv_clocksource_tsc_page
[    1.384341] rtc_cmos 00:02: registered as rtc0
[    1.387469] rtc_cmos 00:02: setting system clock to 2023-12-07T16:31:58 UTC (1701966718)
[    1.392529] rtc_cmos 00:02: alarms up to one day, 114 bytes nvram
[    1.484243] sched_clock: Marking stable (1449873200, 33603000)->(3264982600, -1781506400)

Jeremi

