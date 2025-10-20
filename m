Return-Path: <linux-hyperv+bounces-7274-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3E5BF24CD
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Oct 2025 18:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FFB4220BE
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Oct 2025 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E15527B336;
	Mon, 20 Oct 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Le4Rme1q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9560926F296;
	Mon, 20 Oct 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976187; cv=none; b=VHhK4/25ciq1HFTD8M/gJJ4eMsYrCzI1AuE/5aVd5VmuURE1BlqeU9rW/bvGMCTBo4cTn3UGw/fXTZ0ncf8pgnvGfu/l7svWxkiDqM4z37ewm1qdx5wbbGtOl0b/CGPUqJVWx22YcvE+Xv0YZA31yO4CbGc9lWlj9z2lXQ0PmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976187; c=relaxed/simple;
	bh=JvOCR57DWSFecee/oWHPQq1FBVtq9nwuQUxNx7n/1Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QV7eMiyw1ZLaMlfu7lX4ARcFcmkSro4qVH92+CLhO7wFmr7JKN5SJlXEi3dB6PChCHeYKPxl7rkv98XaPgXKoSPait+ZI/aueyf5pwTHoeQdKWvaMwJSmR/SgZiVHnGHoqitQ8zVeAmaq03UZCCjApz5mEh2fb6B9MX8p8/cC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Le4Rme1q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id ADD68201DAC4;
	Mon, 20 Oct 2025 09:03:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ADD68201DAC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760976185;
	bh=scyb7wZ7MdJMCaaNB+EvmDsakq25Zch1vo2shBY/s6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Le4Rme1qvxnweUnpgb85Vv2YhukqWFRffwZc6f0b8/nUIThLnILtPvi/4Z+f8Z19s
	 IZN+TkJ9H4AWwcNNYLs+zyB4bzLU9DjUtQfXcjHpRsvA8v10vnf6/yvgWuKu/Xq1YD
	 PbVvr4e/1z8G4g2NMx6RXEgQocq7bTSJvHLr8KOE=
Message-ID: <c673e8da-d770-414a-bd8d-715688238dd1@linux.microsoft.com>
Date: Mon, 20 Oct 2025 09:02:55 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, arnd@arndb.de, mrathor@linux.microsoft.com,
 skinsburskii@linux.microsoft.com
References: <1760727497-21158-1-git-send-email-nunodasneves@linux.microsoft.com>
 <20251017220655.GA614927@liuwe-devbox-debian-v2.local>
 <20251017222633.GA632885@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251017222633.GA632885@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/2025 3:26 PM, Wei Liu wrote:
> On Fri, Oct 17, 2025 at 10:06:55PM +0000, Wei Liu wrote:
>> On Fri, Oct 17, 2025 at 11:58:17AM -0700, Nuno Das Neves wrote:
>>> When the MSHV_ROOT_HVCALL ioctl is executing a hypercall, and gets
>>> HV_STATUS_INSUFFICIENT_MEMORY, it deposits memory and then returns
>>> -EAGAIN to userspace. The expectation is that the VMM will retry.
>>>
>>> However, some VMM code in the wild doesn't do this and simply fails.
>>> Rather than force the VMM to retry, change the ioctl to deposit
>>> memory on demand and immediately retry the hypercall as is done with
>>> all the other hypercall helper functions.
>>>
>>> In addition to making the ioctl easier to use, removing the need for
>>> multiple syscalls improves performance.
>>>
>>> There is a complication: unlike the other hypercall helper functions,
>>> in MSHV_ROOT_HVCALL the input is opaque to the kernel. This is
>>> problematic for rep hypercalls, because the next part of the input
>>> list can't be copied on each loop after depositing pages (this was
>>> the original reason for returning -EAGAIN in this case).
>>>
>>> Introduce hv_do_rep_hypercall_ex(), which adds a 'rep_start'
>>> parameter. This solves the issue, allowing the deposit loop in
>>> MSHV_ROOT_HVCALL to restart a rep hypercall after depositing pages
>>> partway through.
>>>
>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>
>> In v1 you said you will add a "Fixes" tag. Where is it?
> 
> I added this:
> 
> Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> 
> Let me know if that's not correct.
> 
Oops! That's correct, thanks.

> Wei


