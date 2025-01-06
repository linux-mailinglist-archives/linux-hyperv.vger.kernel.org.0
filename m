Return-Path: <linux-hyperv+bounces-3590-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00700A031D3
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 22:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE21886C79
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 21:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0701DED6C;
	Mon,  6 Jan 2025 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PyskZAmc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D15F1474B9;
	Mon,  6 Jan 2025 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197647; cv=none; b=rExPapXS/2pgu54/e+2K+iZu2/t1NEW75LuxigCWqQRFtEC44IGCcXqTv9liiCKhIW5AUPSQyQGouSC9c5neyasUbeB1s8xYe8lFosrS5klpywX5gimL/BIk0TvRFvPHBC71FkXLEL1697+y9TaOQNQfebozG28Bx4PXZC+LDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197647; c=relaxed/simple;
	bh=pOpCKDk5YKFJSUt6qfEJwbedMYvG54AaCPaiHVYubyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwyjOO39Um8tbPR5d0ECC1z1bwdEFskFqROtikmovSnGrQ5j4hFuk1OZf1oSw35niL1QrYAnIIJVGxQZkI7eygQjVE2VtxV6TDOl62vYOgbPOsPqM1D3VZGM68aVzRX4Mf1FMc+OUWlPGnsac1A77EUEYMJfJ+E66nVZqqj+mWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PyskZAmc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E5952046750;
	Mon,  6 Jan 2025 13:07:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E5952046750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736197645;
	bh=sAVl1P8EECZJn1mjyR3mQcUY3wch3nt78KNtpcLq/Cc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PyskZAmc0+2w6eo4HNM4gON508SHPs3wi6qfioFSSA79kQFCHk1lb3ofhuEjXUbfu
	 zx9wb7AzGSOkIlxI56kS0HOBQQAx5pKkjH2xi+dku93sULCXQjPwygCTZkj8AhfiJG
	 6NN6oB7TcBf2HBEdJulY4LoqpHxhhiwa7JPTHMbU=
Message-ID: <3c90bc0f-be28-4f10-8057-be5e780c5a24@linux.microsoft.com>
Date: Mon, 6 Jan 2025 13:07:25 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 eahariha@linux.microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, nunodasneves@linux.microsoft.com, tglx@linutronix.de,
 tiala@microsoft.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
 vdso@hexbites.dev
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <24594814-6b31-4dc9-83c3-2bafbd14e819@linux.microsoft.com>
 <20250106171114.GA18270@skinsburskii.>
 <a1577153-95c0-4791-8f6a-0ec00fae48f7@linux.microsoft.com>
 <20250106193248.GB18346@skinsburskii.>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250106193248.GB18346@skinsburskii.>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/6/2025 11:32 AM, Stanislav Kinsburskii wrote:
> On Mon, Jan 06, 2025 at 10:11:16AM -0800, Roman Kisel wrote:
[...]s

> From my POV a decision between a unified approach and interim solutions
> in upstream should usually be resolved in favor of the former.
> Given there are different stake holders in VTL code integration, I'd
> suggest we step back a bit and think about how to proceed with the
> overall design.
I don't see any compelling reason for stalling this fix and think for
no one knows how long. What is going to be fixed is clear, and it has
not been demonstrated what is going to be broken when this change is
merged.

> 
> In my opinion, although I undestand why Underhill project decided to
> come up with the original VTL kernels separation during build time, it's
> time to reconsider this approach and to come up with a more generic
> design, supporting booting the same kernel in different VTLs.
"The same kernel" means supporting ACPI/UEFI for VTL0, VTL1, VTL2 as
otherwise VTL0 won't boot. But why would VTL>0 even consider relying on
ACPI or compiling it in? I would fix your broad assertion with adding
one constraint: share as much Hyper-V code as possible, booting is not
expected, rather refuse building.

> 
> The major reason for this is that LVBS project relies on binary
> compatibility of the kernels running in different VTLs.
> The simplest way to provide such a guarantee in both development and
> deployment is to run the same kernel in both VTLs.

OpenHCL aka Underhill is the only shipping product relying on
the code in question (others might be dom0 and LVBS). What the LVBS
project relies on might change any number of times any day before it
ships. OpenHCL works for customers and slicing and dicing it ought to
be well thought through.

> Not having this ability will require carefull crafting of both the
> kernels upon build, making kexec servicing of such kernels in production
> complicated and error prone.

Too vague, imho. I'd respond that "careful crafting" shouldn't lead to
being complicated and error prone as long as it's automatic and, well,
careful.

It is harder and harder to me to see how enabling the hypercall output
page is related to where the discussion has drifted. My claims are:

* enabling the hypercall output page poses no harm (doesn't break hyper-
next),
* allows to bring the code to the clear and concise form of getting a VP
register.

Can you refute any of that?

> 
> Thanks,
> Stas

-- 
Thank you,
Roman


