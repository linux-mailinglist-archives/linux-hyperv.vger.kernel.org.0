Return-Path: <linux-hyperv+bounces-3503-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E379F83DA
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 20:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13A71881C32
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Dec 2024 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2481A704C;
	Thu, 19 Dec 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qALNb0if"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C701A4F2D;
	Thu, 19 Dec 2024 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635604; cv=none; b=aYQzjK+P1InmukaDTMogf6PGRxKgEpCFeF8LnJGZRQYSe4oNbOCYlyGHsvR9aNJTsUl4SdY5/An/RtWZ4AHJphGI+npkqsLvz+e897emfxQZCIU0B/vUYEp9TFebOw83nqg2Z9/OS2ElGUEijCWe5q76/4aJESHt2pjABrV+O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635604; c=relaxed/simple;
	bh=Epvc05yZp+JriEP1qzC/ayKd+iOTtR7QXO0IJqVep6c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LL4NwP1R70eNz3e4l4JIl1H4nHXS7xxrDn5jOSxgbs5BTZoE6qk8DL02Xsp7quW4Dz+Kmha6ICbgsPNfLIGBdCL14TxHZ+5mhgHtXyP1d6000QnJgAH8yNiwAhMkjaqT/q/I8nTSYjVJes5lvFkOwrHIvmmmURl6x1CVWKJCCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qALNb0if; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.65.151] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3787D203FC94;
	Thu, 19 Dec 2024 11:13:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3787D203FC94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734635603;
	bh=Mba+4T/AX0gSvO32ObFAyK9BFdMDXvwhmVsHsmcIloc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qALNb0ifgemTV7U9ZxwYMHG3KZbI32kyISCenHQiESZSRgYKOBi1YYGhV7Wltwlrh
	 X1VzAlDrcMuOOWTVVCQEv4g1WyTYNdB5jFDpuPhuef0/eGEVl3PnPVqq0+aZrhEz2u
	 w4IStOKoOhOTK5xV6in/pToKRMv9KE0vGEXcDt+k=
Message-ID: <48d3a3e0-8e2f-4eb8-b725-b6eed37c290c@linux.microsoft.com>
Date: Thu, 19 Dec 2024 11:13:21 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Roman Kisel <romank@linux.microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, tglx@linutronix.de, tiala@microsoft.com,
 wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, eahariha@linux.microsoft.com,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH 1/2] hyperv: Fix pointer type for the output of the
 hypercall in get_vtl(void)
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
 <20241218205421.319969-2-romank@linux.microsoft.com>
 <17f81f98-a7ca-45e0-87be-9f1cfa5c5a95@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <17f81f98-a7ca-45e0-87be-9f1cfa5c5a95@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/2024 10:40 AM, Nuno Das Neves wrote:
> On 12/18/2024 12:54 PM, Roman Kisel wrote:
>> Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
>> changed the type of the output pointer to `struct hv_register_assoc` from
>> `struct hv_get_vp_registers_output`. That leads to an incorrect computation,
>> and leaves the system broken.
>>
> My bad! But, lets not use `struct hv_get_registers_output`. Instead, use
> `struct hv_register_value`, since that is the more complete definition of a
> register value. The output of the get_vp_registers hypercall is just an array
> of these values.
> 
> Ideally we remove `struct hv_get_vp_registers_output` at some point, since
> it serves the same role as `struct hv_register_value` but in a more limited
> capacity.
> 
> Thanks
> Nuno
> 

I had much the same conversation with Roman off-list yesterday.

The choice is between using hv_get_registers_output which is clearly the
output of the GetVpRegisters hypercall by name, albeit limited as you
said, and hv_register_value which is the more complete definition and
what the hypervisor actually returns, but does not currently include the
arm64 definitions in our copy of hvgdk_mini.h. hv_get_registers_output
and hv_register_value overlap in layout for Roman's purposes.

FWIW, I'm in favor of adding the arm64 definitions to hv_register_value
and using it for this get_vtl() patch.

This could be accompanied with migration of hv_get_vpreg128 in arm64/
and removal of struct hv_get_registers_output, or that could be deferred
to a later patch.

- Easwar


