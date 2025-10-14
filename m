Return-Path: <linux-hyperv+bounces-7209-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF3BD76EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 07:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317FF3AB823
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 05:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0284224BCF5;
	Tue, 14 Oct 2025 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jv2mNxjL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5431891A9;
	Tue, 14 Oct 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420100; cv=none; b=JWSvLfk42vUVxcHnceIvPZoDHryP6DacYKYdm60WypPtzEpXnpCLBTLOCo+L03N7CgPO1UUhVDdkU0mhqDleE3jGnwmIOgy8IGrBBMiKidFnGMBhI+g9OyJR2+98vIaSSxhI2WrZMT2RULTGUMMyC418htFrYcG9FoecqxmV2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420100; c=relaxed/simple;
	bh=625WgSnJiSezsXZmXYS0mFDkULTrHAwgaxfJYWupEG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvIQLB3TVxomhffFR8MpG5WQuVPkk5V74rSIZY7X7L/we/M5p4jqP5MWswsLpCP6S+BfABWHhZoZDUcjp2az0lXJ7QmRlKG4IqjA6y4wYe/Tuv+iQQUNi12qgJD58ydzaaztwETtr/0Xt4vySB9+ZKoKztpAzDJd3+/sOkJEA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jv2mNxjL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.76.239] (unknown [167.220.238.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC8E12065951;
	Mon, 13 Oct 2025 22:34:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC8E12065951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760420098;
	bh=BlgehlMARAQjp3IsCJVfblI0gkZ7iJZCHXntzahh9kY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jv2mNxjLPebnUUabvAtBH5bm4B6u/ikigz4IC6JY1yBZPw8AO7jARAIYVsX9epMJg
	 iCV8pEOti7mMRWaPrfqh3ZGeQzm5uitXZHTaw895TlclT+mt+z7qhJIctyQyLtvHvf
	 v0f862DoePXsZXFuyV03PyerE5/MFldTDVCKreRU=
Message-ID: <ac6fc14c-3cbe-42c3-b077-1c167cbe1d31@linux.microsoft.com>
Date: Tue, 14 Oct 2025 11:04:51 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Sean Christopherson <seanjc@google.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Mukesh Rathor <mrathor@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Kelley <mhklinux@outlook.com>, Christoph Hellwig
 <hch@infradead.org>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>
References: <20251013060353.67326-1-namjain@linux.microsoft.com>
 <20251013060353.67326-3-namjain@linux.microsoft.com>
 <aO0I2va2HQ6mA-u0@google.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <aO0I2va2HQ6mA-u0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/2025 7:42 PM, Sean Christopherson wrote:
> On Mon, Oct 13, 2025, Naman Jain wrote:
>> +static int mshv_vtl_ioctl_return_to_lower_vtl(void)
>> +{
>> +	preempt_disable();
>> +	for (;;) {
>> +		u32 cancel;
>> +		unsigned long irq_flags;
>> +		struct hv_vp_assist_page *hvp;
>> +		int ret;
>> +
>> +		local_irq_save(irq_flags);
>> +		cancel = READ_ONCE(mshv_vtl_this_run()->cancel);
>> +		if (cancel)
>> +			current_thread_info()->flags |= _TIF_SIGPENDING;
> 
> There's no need to force SIGPENDING, this code can return directly if cancel is
> set[1].  And then you can wait to disable IRQs until after handling pending work,
> and thus avoid having to immediately re-enable IRQs[2].
> 
> [1] https://lore.kernel.org/all/20250828000156.23389-3-seanjc@google.com
> [2] https://lore.kernel.org/all/20250828000156.23389-4-seanjc@google.com


Thank you for reviewing and sharing your inputs. I will incorporate
these changes in the next version.

Regards,
Naman

