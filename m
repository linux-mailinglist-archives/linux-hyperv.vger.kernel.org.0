Return-Path: <linux-hyperv+bounces-3519-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E9E9FCBEF
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577071882A2B
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91752AF09;
	Thu, 26 Dec 2024 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rB8dcsvz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A311EC5;
	Thu, 26 Dec 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231541; cv=none; b=IzUJuzX3qspRxp+P/hS/8CIrZijdBy/RQSNvDLVKBooN0IJUlywQunenu2iT1eixBDp2nNZtEMicGerAx5eovUQnsLvT2yJYe2yFPXQ3p7IISrhsSZsaf8Zrr7Q6tkqTBPmoyuqSPiQ7ITXx0UhU95HteXFGFWZFzNHjdTm5X0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231541; c=relaxed/simple;
	bh=0JFpi+t5yOwLFa8yrkMxcbxgu4xbekqkLfu07xsvNZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlRyp75No+iyf5AFD6jZXd/1pOmkY3Ea5cmW+zvavjda7hyUWp6Ymm2QBjy+ByuIb/G0RGtKC1ee6WjJaNBgif00xNCEBgdHHJVX9Zlc0ogZQP4kPlrRSEunAtMD2QejjEWVOZDfvrW2MYYZ1PzFdv3/u4HqLjShLsG3aF2rCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rB8dcsvz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60D29203EC1D;
	Thu, 26 Dec 2024 08:45:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60D29203EC1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735231534;
	bh=fuTxX5lIAWai6rqW4xItpk0jFf+Ihvwv3lOW0ld0T34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rB8dcsvzJsL4DS115LY0Z0Tv2YPzVLlLO9NqsIUweSzEcpmDYR1CbvFum2VALaatK
	 YtKtX0ISFuEOB1Ktof7oY6KLwP8/Itc46FY64ki4Lo+OUdxEf6opqCwqn13ViPCkAl
	 ETokRsksmuyDWME642KurPViNQSlT9GqiW1EfuCI=
Message-ID: <9c138f4e-9258-4457-b85b-69ae111894fb@linux.microsoft.com>
Date: Thu, 26 Dec 2024 08:45:34 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hyperv: Do not overlap the input and output hypercall
 areas in get_vtl(void)
To: Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
 <apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
 "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-3-romank@linux.microsoft.com>
 <Z2OIHRF-cJ92IBv2@liuwe-devbox-debian-v2>
 <8da58247-87df-4250-820a-758ea8e00bbb@linux.microsoft.com>
 <SN6PR02MB4157DD7CE09E39C524775168D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d8c4613a-33b6-4aa6-a3ae-7c888ab2d727@linux.microsoft.com>
 <BN7PR02MB41482EDAA9CD96EF2ECE6532D4072@BN7PR02MB4148.namprd02.prod.outlook.com>
 <eba74adf-4891-46f8-a3ef-e116000dd566@linux.microsoft.com>
 <SN6PR02MB4157FD829416A7ACA2FF9300D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ff359a3e-a275-4146-8e99-a06fea69b7a9@linux.microsoft.com>
 <SN6PR02MB41570091569D9365185B9F8AD4032@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41570091569D9365185B9F8AD4032@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/24/2024 8:45 AM, Michael Kelley wrote:

[...]

> 
> OK, my understanding is that your concern about spec conformance is
> just that Linux should be able to allocate enough input and output space
> for the maximum case, which is 4KiB of input *plus* 4KiB of output. If
> the total amount of input plus output for a particular hypercall is less
> than 4KiB, then there's no conformance problem with having the input
> and output share a page, as long as the "no overlap" rule is observed.
>
Appreciate bearing with me and guiding me towards expressing the intent
clearer :) Yes, the logic chain has been:

* can't overlap input and output due to TLFS req's =>
* need to fix get_vtl() *&&* dom0 uses the output page *&&* VTLs use
   the output page =>
* let us fix the overlap *&&* make get_vtl() look as get_vp_register()
   as this is what it actually is so soon we should be able to have less
   code.

Getting rid of the hypercall output page feels like too much as if the
code base is dovetailed to that and the hypervisor gets a hypercall
whose output is as large as a page (however unlikely that sounds, but
first there was an opinion that 640KiB is plenty, then 32 address lines,
then 48 bits in the PA and 4 level pages, then 57 bits and 5 levels,
...), we'd need to fix the code or allocate and deallocate on demand.
That tradeoff b/w saving a page and adding special cases makes me lean
to just allocate the page as it is allocated anyway.

> There's an idea kicking around in my head about a different way to
> handle all this that might be cleaner and less code all-around. If I
> get motivated, I may code it up and see if it really works. If so,
> I'll run it by you to see what you think.
MUCH appreciated!! The complexity appears to be increasing over time,
and it would be incredible to pack all we got into less code without
constraining ourselves too much :)

> 
> Michael

-- 
Thank you,
Roman


