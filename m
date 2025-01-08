Return-Path: <linux-hyperv+bounces-3613-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9EAA063B1
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 18:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50961163277
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D861FE450;
	Wed,  8 Jan 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RB5qUauy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499F01A2541;
	Wed,  8 Jan 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358508; cv=none; b=C/wBwwsdGYOr5wqNnxn+RXCOogmJ93c9gGtCvptiUVEQscEApUyk+6o6phQIzuX9dWWSckPFVbTHG48yHBVKpGvt40JUjletHksM784eHC1WcwVN+knGPID357hu0lzw2oB3DDmvdFu6fNLQFx24H1iyGLejmy/crm26m71qow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358508; c=relaxed/simple;
	bh=Qp9UIWKIy5koe8nkX1NdonTrggqdbpcRjAjaCrfdOx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqu0PWEbMd5D5eRI5zmOdbzrUykGPgY3CalAIog4qgn9Syt4jmXwgNhLW3xKL1zOSUtasTDDRI2l8UHhDfKf0ALI61lhJP9+ujIA1tY+gSGc7Mv/ZdA726udxsGPPGjZFTozHCP75JwkyFsr7ZMofaX9Uaz0bsog5DOjIfG39ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RB5qUauy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id C25F6203E3A4;
	Wed,  8 Jan 2025 09:48:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C25F6203E3A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736358505;
	bh=fYpyFI68WQyn06fu9E5BAylOrhjoCh38QkrogCmGF98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RB5qUauycchQ4hTIfdKIIBR/8Qa3v7jMg/ZqLcqxKwmYVtetglcyIs9pssLlJYyUl
	 st7yoKYyQuL+LoqpzS8kP3LpSOev07Zo6g5xLjyyhVYzZhfu49p/i+cBu7H/l8gdxp
	 29RXSUBxc/b28708X3V0ZRgHhYTV2UorHL0e2r4k=
Message-ID: <2234bf95-237c-4d73-a549-93877e0b6fb2@linux.microsoft.com>
Date: Wed, 8 Jan 2025 09:48:25 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] hyperv: Define struct hv_output_get_vp_registers
To: Wei Liu <wei.liu@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
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
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-2-romank@linux.microsoft.com>
 <SN6PR02MB4157F8C28BD92F36B27C9032D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e43633f6-c303-439d-8dbe-730a5762753c@linux.microsoft.com>
 <Z34qdI3puoSe9PiR@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z34qdI3puoSe9PiR@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/7/2025 11:34 PM, Wei Liu wrote:
> On Mon, Jan 06, 2025 at 12:24:32PM -0800, Roman Kisel wrote:
>>
>>
>> On 1/6/2025 9:37 AM, Michael Kelley wrote:
>>> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, December 30, 2024 10:10 AM
>> [...]
>>>
>>> These bit field definitions don't look right. We want to "fill up"
>>> the field size, so that we're explicit about each bit, and not leave
>>> it to the compiler to add padding (which __packed tells the
>>> compiler not to do). So in aggregate, the "u64" bit fields should
>>> account for all 64 bits, but here you account for only 32 bits.
>>> There are two ways to fix this:
>>>
>>> 		u32 interruption_pending : 1;
>>> 		u32 interruption_type: 1;
>>> 		u32 reserved : 30;
>>> 		u32 error_code;
>>> Or
>>> 		u64 interruption_pending : 1;
>>> 		u64 interruption_type: 1;
>>> 		u64 reserved : 30;
>>> 		u64 error_code : 32;
>>>
>>>
>>> Nuno -- your thoughts?
>>
>> Quite a blunder on my side! Thank you very much for your help :)
>> GDB is my witness:
>>
>> (gdb) ptype /o union hv_arm64_pending_synthetic_exception_event
>> /* offset      |    size */  type = union
>> hv_arm64_pending_synthetic_exception_event {
>> /*                    16 */    u64 as_uint64[2];
>> /*                    13 */    struct {
>> /*      0: 0   |       4 */        u32 event_pending : 1;
>> /*      0: 1   |       4 */        u32 event_type : 3;
>> /*      0: 4   |       4 */        u32 reserved : 4;
>> /*      1      |       4 */        u32 exception_type;
>> /*      5      |       8 */        u64 context;
>>
>>                                     /* total size (bytes):   13 */
>>                                 };
>>
>>                                 /* total size (bytes):   16 */
>>                               }
>>
>> which looks messed up to me to put it mildly. Will fix next time.
> 
> We are pretty close to the next merge window (~2 weeks). Can you please
> resend a version this week or early next week?

Understood, will do!

> 
> Nuno, if you have any comments on this series, now it is the time to
> share them.
> 
> Thanks,
> Wei.

-- 
Thank you,
Roman


