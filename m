Return-Path: <linux-hyperv+bounces-6780-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE237B4952A
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79441899917
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4021730CDB7;
	Mon,  8 Sep 2025 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ioq9wIL0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB630C616;
	Mon,  8 Sep 2025 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348776; cv=none; b=b36lUb1Sb2Hk/9HIj/Md5OTHg2l3iwDpPbxxWz/w8koSxijvQ3WSozcgb8+J/D2qHaPpg/QRLk6Kc69P4FhF5XzRrxPabDfzv3m1bF5D1dXrM6oNMVzPLvL/rKnvzM+bomz13r2BT937IbgTI4ZkSn83w9A9I2k1wo3feilqxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348776; c=relaxed/simple;
	bh=5DUxBn+1vzv4egNRDBomxUUQ6FLjpdRO/YrTTBbd1c0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qjVzr+zXIiIyrbBZMZ7IjH0D795bGfW7MTGHJAUiXK8WQmpgYjDEWgkN9R5MsYMnmfb9Evi3WN4MQphOQNoGmNgQKqKVju51aFdG7E5rj5puQt4wYh9bn+EGq6MZwD6iCDUL2u75PzWh6Z0inIE+VoLKXAVmcaA0F2YZs9quSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ioq9wIL0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.200.9] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id EC8892117647;
	Mon,  8 Sep 2025 09:26:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC8892117647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757348774;
	bh=RFZehntewohKo8pC+IgwgTMs5B61cY63Nxp1jY8S4m0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ioq9wIL08/tTxDunwGx0RWcFHWdITH4xnE2MygUz9xzJiur5o/wvkwWdnx4JUqmCo
	 bz0JGrUkr0F7syPj23w0BajOqWL2wVB4tpICk0Lm0pKECTgb8hnc9UofqU4JZPvF9J
	 5ZQKdBqVjsbkd6LhQKxPJ4RG+DmzS9EWltK+tGD4=
Message-ID: <4b8dba3e-3ad5-4769-80b1-214c8b1cd3ae@linux.microsoft.com>
Date: Mon, 8 Sep 2025 09:26:13 -0700
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
 paekkaladevi@linux.microsoft.com,
 Jinank Jain <jinankjain@linux.microsoft.com>
Subject: Re: [PATCH 6/6] mshv: Introduce new hypercall to map stats page for
 L1VH partitions
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-7-git-send-email-nunodasneves@linux.microsoft.com>
 <ed4ebc67-dc98-4ce4-af5e-b2f371d27c5b@linux.microsoft.com>
 <15532d34-0005-4cba-9fca-212c30db1f18@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <15532d34-0005-4cba-9fca-212c30db1f18@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/2025 4:12 PM, Nuno Das Neves wrote:
> On 9/5/2025 12:50 PM, Easwar Hariharan wrote:
>> On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
>>> From: Jinank Jain <jinankjain@linux.microsoft.com>
>>>
>>> Introduce HVCALL_MAP_STATS_PAGE2 which provides a map location (GPFN)
>>> to map the stats to. This hypercall is required for L1VH partitions,
>>> depending on the hypervisor version. This uses the same check as the
>>> state page map location; mshv_use_overlay_gpfn().
>>>
>>> Add mshv_map_vp_state_page() helpers to use this new hypercall or the
>>> old one depending on availability.
>>>
>>> For unmapping, the original HVCALL_UNMAP_STATS_PAGE works for both
>>> cases.
>>>
>>> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>>> ---
>>>  drivers/hv/mshv_root.h         | 10 ++--
>>>  drivers/hv/mshv_root_hv_call.c | 92 ++++++++++++++++++++++++++++++++--
>>>  drivers/hv/mshv_root_main.c    | 25 +++++----
>>>  include/hyperv/hvgdk_mini.h    |  1 +
>>>  include/hyperv/hvhdk_mini.h    |  7 +++
>>>  5 files changed, 115 insertions(+), 20 deletions(-)
>>>

<snip>

>>
>> Shouldn't this be in the previous patch where the other hv_call_map_stat_page() calls were
>> converted, same below?
>>
> The previous patch converts hv_call_(un)map_vp_state_page to hv_(un)map_vp_state_page, i.e.
> "state" not "stats".
> 

Ugh, thanks for the catch. I guess my eyes glazed over a little bit with the diffs.

Thanks,
Easwar (he/him)

