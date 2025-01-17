Return-Path: <linux-hyperv+bounces-3712-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F838A15800
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 20:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9617D166014
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 19:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BE41A7AD0;
	Fri, 17 Jan 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lIbX3gY/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51C1A83EA;
	Fri, 17 Jan 2025 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141245; cv=none; b=qo+y5EB22Z1g/PNMc8J9PaE69No26uUFWV8Z111L/234gwGGPHW6NEwN8K3I2k310QXPok2E1YYr+tHM75MZdlyhO7rPWqMoWJIMCf2lgUFFWwgdjKOaySbFniS92IeMXEXwSNMAEGYIFwL34fb5rbvoM0IxU4HxUWrv7OsIxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141245; c=relaxed/simple;
	bh=A6SmAXi9TJp+Tybsut3orlgjlsa5LdE06dNsFPXsXco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5RsJyA8bSiUDz70pb/AHpCGQPe0Vx9GSP54wGsihYJPB6KdyBbqVWEbTN6LkaybYGGOc3Xr6hxNoSN8dBCmN0BqC8vs9SFP8gNBls0igbUP7IMUlIuQPjQyOXMd0C40O+zfLiJ7IyDZpKVnGAtUfWwtn00nXPtN5p19lT0IJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lIbX3gY/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6399E20591BD;
	Fri, 17 Jan 2025 11:14:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6399E20591BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737141243;
	bh=heO9ADPOEXaPmeUqaFU9DaVEeSeicuRglRyDJS8rexk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lIbX3gY/FUHZYppSP5wDUb5PLCweSgktPZcBE1kzgCYzei4n1lJ+a5at7Xtmx2/yJ
	 ty/Roe6qdxjAxdsNPDfybTIbysLrlGJvKO2dWSN1glipqsmXsFplOd4Gm9PjKaFljT
	 Nst4/g6gUq4lNxKXnfg2FqLGCL8Ys7tjHfh7Ligg=
Message-ID: <0f400bb9-03a7-431a-95c3-340bb3e10614@linux.microsoft.com>
Date: Fri, 17 Jan 2025 11:14:04 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hv_netvsc: Replace one-element array with flexible
 array member
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250116211932.139564-2-thorsten.blum@linux.dev>
 <0927ebf9-db17-49f5-a188-e0d486ae4bda@linux.microsoft.com>
 <20250116161727.19a3bbb0@kernel.org>
 <4f1e37f0-d72d-4748-a5e4-0ee28d33ca38@intel.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <4f1e37f0-d72d-4748-a5e4-0ee28d33ca38@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/17/2025 3:10 AM, Przemek Kitszel wrote:
> On 1/17/25 01:17, Jakub Kicinski wrote:
>> On Thu, 16 Jan 2025 13:39:52 -0800 Roman Kisel wrote:
>>> On 1/16/2025 1:19 PM, Thorsten Blum wrote:
>>>> Replace the deprecated one-element array with a modern flexible array
>>>> member in the struct nvsp_1_message_send_receive_buffer_complete.
>>>>
>>>> Use struct_size_t(,,1) instead of sizeof() to maintain the same size.
> 
> I would add a struct-specific macro or at least put the info into this
> struct' doc, that "there is legacy API requirement to allocate at least
> one element for the flex array member".
> 
Perhaps add "No functional changes", too.

Worked for me.

Tested-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

>>>
>>> Thanks!
>>>
>>>>
>>>> Compile-tested only.
>>>
>>> The code change looks good to me now. I'll build a VM with this change
>>> to clear my conscience (maybe the change triggers a compiler bug,
>>> however unlikely that sounds) before replying with any tags. Likely next
>>> Monday, but feel free to beat me to it, or perhaps, someone else will
>>> tag this as reviewed by them and/or tested by them.
>>
>> Doesn't look like a real bug fix, so would be good to get some signal
> 
> If the actual usage would be with more than 1 element UBSAN will
> complain.
Great point!

> 
>> soon. The merge window is soon so we'll likely close the trees very
>> very soon ..
>>
> 

-- 
Thank you,
Roman


