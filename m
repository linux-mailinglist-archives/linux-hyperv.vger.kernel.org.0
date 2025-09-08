Return-Path: <linux-hyperv+bounces-6782-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6BB496E2
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 19:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E751C20E44
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7A0201266;
	Mon,  8 Sep 2025 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DKN4vcgz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E6E18BC3B;
	Mon,  8 Sep 2025 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352145; cv=none; b=m0O+O7bz3/6Kwix2mFVw2TcuDvJdrpAnaalCGMdou6DBesPrseBz8l4h/szQJALrGLuZBNTvaVjzZMfWDGY9s705AeIMzurnL48mLqFBpfuPHOTAKRURSRFpJzfHgHLori1TVXI4LNqxtGwn7vJC7TxNUMjyLotmbngehRomdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352145; c=relaxed/simple;
	bh=dzBeGxfxuyt2NiQ7l4Fa8YVxYtqaVc1snI0fUe/YLT0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wbunal8Q0Mh11ZmuN0RyD/pw0XCX3uR9OyACxbMTgiLibe0m6Y8nazzEsAjFMFffv16E0mWDB2VLdPQlPdA9kd31jru1dtd+e080urGYQ6MjkJ8abRSiE2CCDVcMQkv/rIzGCimvxV9LWteCxqPjOnA0ErsRHRCPKnJ7s3Kx2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DKN4vcgz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.33.115] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id B8E142119392;
	Mon,  8 Sep 2025 10:22:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8E142119392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757352143;
	bh=KXuXBEUyzqbW1aJ6g3je46Pjk9eCR3/uJsox3zE2WHo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DKN4vcgzxF+jcZ5dfAimLWPzWUaS3rQD+45CShgvrwqZdkIQ+ceAbmleOCbgbt6DW
	 XbX1fo3ouIBl3xo7ZIpMVNC3f+v33E9FvBws2AjxhyC8G3uKwrh3XR9FMxISoy1pXd
	 WeBtqyLpMIn+TUg5ovdkHqIpBn+uBAeBlus1dw4c=
Message-ID: <7b4fafc7-cf89-45f6-ac5c-59a4c9f53f79@linux.microsoft.com>
Date: Mon, 8 Sep 2025 10:22:21 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: easwar.hariharan@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 2/6] mshv: Ignore second stats page map result failure
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
 <efc78065-3556-410a-866f-961a7f1fc1ac@linux.microsoft.com>
 <874a2370-84f1-4cec-bb06-a13fe11b49ca@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <874a2370-84f1-4cec-bb06-a13fe11b49ca@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/2025 10:04 AM, Nuno Das Neves wrote:
> On 9/5/2025 12:21 PM, Easwar Hariharan wrote:
>> On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
>>> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>>>
>>> Some versions of the hypervisor do not support HV_STATUS_AREA_PARENT and
>>> return HV_STATUS_INVALID_PARAMETER for the second stats page mapping
>>> request.
>>>
>>> This results a failure in module init. Instead of failing, gracefully
>>> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
>>> already-mapped stats_pages[HV_STATS_AREA_SELF].
>>
>> What's the impact of this graceful fallback? It occurs to me that if a stats
>> accumulator, in userspace perhaps, expected to get stats from the 2 pages,
>> it'd get incorrect values.
>>
> This is going out of scope of this series a bit but I'll explain briefly.
> 
> When we do add the code to expose these stats to userspace, the SELF and
> PARENT pages won't be exposed separately, there is no duplication.
> 
> For each stat counter in the page, we'll expose either the SELF or PARENT
> value, depending on whether there is anything in that slot (whether it's zero
> or not).
> 
> Some stats are available via the SELF page, and some via the PARENT page, but
> the counters in the page have the same layout. So some counters in the SELF
> page will all stay zero while on the PARENT page they are updated, and vice
> versa.
> 
> I believe the hypervisor takes this strange approach for the purpose of
> backward compatibility. Introducing L1VH created the need for this SELF/PARENT
> distinction.
> 
> Hope that makes some kind of sense...it will be clearer when we post the mshv
> debugfs code itself.
> 
> To put it another way, falling back to the SELF page won't cause any impact
> to userspace because the distinction between the pages is all handled in the
> driver, and we only read each stat value from either SELF or PARENT.
> 
> Nuno

Thank you for that explanation, it sorta makes sense.

I think it'd be better if this patch is part of the series that exposes the stats
to userspace, so that it can be reviewed in context with the rest of the code in
the driver that manages the pick-and-choose of a stat value from the SELF/PARENT
page.

Unless there's an active problem now in the upstream kernel that this patch solves?
i.e. are the versions of the hypervisor that don't support the PARENT stats
page available in the wild?

Thanks,
Easwar (he/him)


