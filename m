Return-Path: <linux-hyperv+bounces-7250-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93276BEB20B
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 19:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D283742AD2
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E732C93A;
	Fri, 17 Oct 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HB/ZrSFf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2DA32C93E;
	Fri, 17 Oct 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723723; cv=none; b=oY4EzJrJS5JvoxKIuPS/8/MAIw2vdY/5GZzGkba4IGipYFdjdmwQDA2KRxX2XBypKk8v61pXzjZAB5k0678KEZ00RxxZidTtwJCGPZv0OviREaqAVkwloOT6qz1b/r4EAxSCkJSGJQYGIAJ6Rfaby1s7WdbSigNyo3z1b1h+qe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723723; c=relaxed/simple;
	bh=N4vt7pjFuIoo7BQl7/ohm5WXJepV6x8APH6LvuzVMXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMV1YNo0Qac/XDA0u2FuV1GEMu1tvr67IRfKTSQCBSHa2Y2h2oOIxp24kYNAsIs93auSavcVAIJrMVi8sbUbP9KlUzB6DjrtgIfenxHE0QvShLsTnu6icYLy2IvDxn/b2PPKjnMz5ZhXxFrrkZjKuz582Yuk3BV/szZ6C8H8lHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HB/ZrSFf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.65.40] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 804702017267;
	Fri, 17 Oct 2025 10:55:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 804702017267
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760723720;
	bh=gOxo0rne7d8uoa08LQjsp965N6H1mru75WAT+GM7/dk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HB/ZrSFfqQfLePiwalAmQ/0UKhcRCGI8isixdWHkeVTRSK9BzpQ0N1iJRhNTDwIjH
	 Kq12q60MYpYW2MrbIaAj6/rhkY98bzYbGgsG0p5e+tfh9hZqD/u5urw5uooyfQCO79
	 AVWgKppdz+gvY50023sa57LJ78Tly7pogDv6w2uE=
Message-ID: <1d5a7098-dcbd-4a0c-aa6c-481f131b1491@linux.microsoft.com>
Date: Fri, 17 Oct 2025 10:55:19 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "mrathor@linux.microsoft.com"
 <mrathor@linux.microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
References: <1760644436-19937-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157E6D02773A9D7A4B9E85BD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <a0090bbf-08b4-4b36-8cf2-18687a83ee8f@linux.microsoft.com>
 <SN6PR02MB4157EE75A14F5F7EA7D6D070D4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157EE75A14F5F7EA7D6D070D4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/2025 10:33 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, October 17, 2025 10:26 AM
>>
>> On 10/16/2025 6:12 PM, Michael Kelley wrote:
>>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, October 16, 2025 12:54 PM
>>>>
>>>> When the MSHV_ROOT_HVCALL ioctl is executing a hypercall, and gets
>>>> HV_STATUS_INSUFFICIENT_MEMORY, it deposits memory and then returns
>>>> -EAGAIN to userspace.
>>>>
>>>> However, it's much easier and efficient if the driver simply deposits
>>>> memory on demand and immediately retries the hypercall as is done with
>>>> all the other hypercall helper functions.
>>>>
>>>> But unlike those, in MSHV_ROOT_HVCALL the input is opaque to the
>>>> kernel. This is problematic for rep hypercalls, because the next part
>>>> of the input list can't be copied on each loop after depositing pages
>>>> (this was the original reason for returning -EAGAIN in this case).
>>>>
>>>> Introduce hv_do_rep_hypercall_ex(), which adds a 'rep_start'
>>>> parameter. This solves the issue, allowing the deposit loop in
>>>> MSHV_ROOT_HVCALL to restart a rep hypercall after depositing pages
>>>> partway through.
>>>
>>> >From reading the above, I'm pretty sure this code change is an
>>> optimization that lets user space avoid having to deal with the
>>> -EAGAIN result by resubmitting the ioctl with a different
>>> starting point for a rep hypercall. As such, I'd suggest the patch
>>> title should be "Improve deposit memory ...." (or something similar).
>>> The word "Fix" makes it sound like a bug fix.
>>>
>>> Or is user space code currently faulty in its handling of -EAGAIN, and
>>> this really is an indirect bug fix to make things work? If so, do you
>>> want a Fixes: tag so the change is backported?
>>>
>>
>> It's the latter case, userspace doesn't handle it correctly, so I
>> consider it a fix more than just an improvement.
> 
> OK, thanks. You might want to tweak the commit message a bit
> to clarify that this really is a bug fix and why. I was leaning
> toward the wrong conclusion based on the current commit
> message.
> 

Is this clearer?

"
mshv: Fix deposit memory in MSHV_ROOT_HVCALL

When the MSHV_ROOT_HVCALL ioctl is executing a hypercall, and gets
HV_STATUS_INSUFFICIENT_MEMORY, it deposits memory and then returns
-EAGAIN to userspace. The expectation is that the VMM will retry.

However, some VMM code in the wild doesn't do this and simply fails.
Rather than force the VMM to retry, change the ioctl to deposit
memory on demand and immediately retry the hypercall as is done with
all the other hypercall helper functions.

In addition to making the ioctl easier to use, removing the need for
multiple syscalls improves performance.

There is a complication: unlike the other hypercall helper functions,
in MSHV_ROOT_HVCALL the input is opaque to the kernel. This is
problematic for rep hypercalls, because the next part of the input
list can't be copied on each loop after depositing pages (this was
the original reason for returning -EAGAIN in this case).

Introduce hv_do_rep_hypercall_ex(), which adds a 'rep_start'
parameter. This solves the issue, allowing the deposit loop in
MSHV_ROOT_HVCALL to restart a rep hypercall after depositing pages
partway through.
"

> Michael
> 
>>
>> I'll add a Fixes: tag pointing back to the original /dev/mshv patch.
>>

