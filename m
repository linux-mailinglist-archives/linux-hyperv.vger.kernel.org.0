Return-Path: <linux-hyperv+bounces-3589-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2731A03158
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 21:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DB63A595B
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 20:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE81DFD81;
	Mon,  6 Jan 2025 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="swzuVlrb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360751DFE1D;
	Mon,  6 Jan 2025 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195074; cv=none; b=AH5g6CebGgrO7BAJTapxkJB0r6wKjFoIvyhCr9xQclQcE9L3v+m//DeytkqqthP6ufFGLDgGMz56F2MKgGKCMJ/P656hfBSB6z+HPC3QRWAX2IHAhr5CWylCB+fl4UlUhUQzOc2DtgnyX22yHMZr++JMkskIhoo+Ikc7HcMGOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195074; c=relaxed/simple;
	bh=ymJj0WuAZ4Xq9+485pr1MC2gtuMeSVJrQIXhuKjpE38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=As41d7uVhgpYQ9mOJaCcHRSUvxNDm8HqnBVCDLmF2MXxOX3ccus+DdLuZCdVlziqutpH0HQiAD0U50nr0+k2dTjcMyQ0eqg4HFiNk6zlFiTNX8PBl4irfXm3VU/dU0CGVP6BpXATTNh0WESrBfDQDNQmRT9t73jqLDDxt5578vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=swzuVlrb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 386D9204674D;
	Mon,  6 Jan 2025 12:24:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 386D9204674D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736195072;
	bh=tzVqf3eYGW2QWkU1ZlXnnFT+d8Dy3114yUMtXxcTZEQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=swzuVlrbz6yOwYH/hWPl0tgeytCc+QCFt6Xoip7UppOpFBJ1o5vEjT/a9qCuUABoL
	 Gy5clQTE37byYuuCph//0S22zTgu6YsTeuBmsm8ZMxEoLw4uufzgEijfQyri+me7S+
	 mIzyhnif1/W+bkFObufYtOz/EjxbBUlCaFRCmcTg=
Message-ID: <e43633f6-c303-439d-8dbe-730a5762753c@linux.microsoft.com>
Date: Mon, 6 Jan 2025 12:24:32 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] hyperv: Define struct hv_output_get_vp_registers
To: Michael Kelley <mhklinux@outlook.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-2-romank@linux.microsoft.com>
 <SN6PR02MB4157F8C28BD92F36B27C9032D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157F8C28BD92F36B27C9032D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/6/2025 9:37 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, December 30, 2024 10:10 AM
[...]
> 
> These bit field definitions don't look right. We want to "fill up"
> the field size, so that we're explicit about each bit, and not leave
> it to the compiler to add padding (which __packed tells the
> compiler not to do). So in aggregate, the "u64" bit fields should
> account for all 64 bits, but here you account for only 32 bits.
> There are two ways to fix this:
> 
> 		u32 interruption_pending : 1;
> 		u32 interruption_type: 1;
> 		u32 reserved : 30;
> 		u32 error_code;
> Or
> 		u64 interruption_pending : 1;
> 		u64 interruption_type: 1;
> 		u64 reserved : 30;
> 		u64 error_code : 32;
> 
> 
> Nuno -- your thoughts?

Quite a blunder on my side! Thank you very much for your help :)
GDB is my witness:

(gdb) ptype /o union hv_arm64_pending_synthetic_exception_event
/* offset      |    size */  type = union 
hv_arm64_pending_synthetic_exception_event {
/*                    16 */    u64 as_uint64[2];
/*                    13 */    struct {
/*      0: 0   |       4 */        u32 event_pending : 1;
/*      0: 1   |       4 */        u32 event_type : 3;
/*      0: 4   |       4 */        u32 reserved : 4;
/*      1      |       4 */        u32 exception_type;
/*      5      |       8 */        u64 context;

                                    /* total size (bytes):   13 */
                                };

                                /* total size (bytes):   16 */
                              }

which looks messed up to me to put it mildly. Will fix next time.

[...]

> 
> Michael
> 
>> +
>> +/*
>> + * NOTE: Linux helper struct - NOT from Hyper-V code.
>> + * DECLARE_FLEX_ARRAY() needs to be wrapped into
>> + * a structure and have at least one more member besides
>> + * DECLARE_FLEX_ARRAY.
>> + */
>> +struct hv_output_get_vp_registers {
>> +	struct {
>> +		DECLARE_FLEX_ARRAY(union hv_register_value, values);
>> +		struct {} values_end;
>> +	};
>>   };
>>
>>   #if defined(CONFIG_ARM64)
>> --
>> 2.34.1

-- 
Thank you,
Roman


