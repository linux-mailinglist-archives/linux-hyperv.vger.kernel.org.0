Return-Path: <linux-hyperv+bounces-8295-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8239D2106F
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 20:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EAEF300558B
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 19:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E86346ACF;
	Wed, 14 Jan 2026 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IcFeQGiK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A5346A1F
	for <linux-hyperv@vger.kernel.org>; Wed, 14 Jan 2026 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418875; cv=none; b=CcMpr47j2Wwkf6dp8R+R0wEN+Kq0Ms51H+N27RymqCPS6/DCkB6rwWoAlUS8EmhLZnwx5m9TXcZOFSUo0s2g98OLQmfn8/3tpHWZpjeAGK/+2VkpE/d8icGpYTVWdB33RPF/8HRHeUQDhPbTqGh73auLWlpBCbShajcaz+FnYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418875; c=relaxed/simple;
	bh=MXKjZ4OREQIZdO/2yDe/kVDDEvzqiguccuJl8oeoxbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaG9OrHPpbmTqg8YNprRuBkNNh3nWVPIFGsE8nkajD6Li/FKoQRVcXpdpK4F1F/M8p/qVZurtMP6ArwTTRFE8j8DA79hCNyR2oBzhPtD4GDwFqdF1Pf8C/zqFixrLBa7wqf9xt0AJ9gk57Pj5oBl7FKhEMhcuNGvAm2OnS/GFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IcFeQGiK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 65C5620B7165;
	Wed, 14 Jan 2026 11:27:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65C5620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768418873;
	bh=MPnbxffUuF//BZqHainKBvOOAKstbu1U6KbO6WK7plk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IcFeQGiK2FguVVG6YGOC1L3b3RUOeu4fUIfIFjirSZ8meWclIwzLIdqHe9g9O8xHw
	 iPs6yoTiDvquunCmvc2BFbqNImSAR6uWNgVqQaZfZ84BAQVtTJ0uO5FYtp3CBZH8aW
	 jlkR0ZmNwsCsK5EvoFqV5dMHJnG87QOZbqVf+D4o=
Message-ID: <feeecc9d-0728-92b5-fe88-15a897438378@linux.microsoft.com>
Date: Wed, 14 Jan 2026 11:27:52 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] mshv: make certain field names descriptive in a header
 struct
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
 nunodasneves@linux.microsoft.com
References: <20260109200611.1422390-1-mrathor@linux.microsoft.com>
 <aWbmJPkrJyICk4Rh@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aWbmJPkrJyICk4Rh@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/26 16:41, Stanislav Kinsburskii wrote:
> On Fri, Jan 09, 2026 at 12:06:11PM -0800, Mukesh Rathor wrote:
>> There is no functional change. Just make couple field names in
>> struct mshv_mem_region, in a header that can be used in many
>> places, a little descriptive to make code easier to read by
>> allowing better support for grep, cscope, etc.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>   drivers/hv/mshv_regions.c   | 44 ++++++++++++++++++-------------------
>>   drivers/hv/mshv_root.h      |  6 ++---
>>   drivers/hv/mshv_root_main.c | 10 ++++-----
>>   3 files changed, 30 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
>> index 202b9d551e39..af81405f859b 100644
>> --- a/drivers/hv/mshv_regions.c
>> +++ b/drivers/hv/mshv_regions.c
>> @@ -52,7 +52,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
>>   	struct page *page;
>>   	int ret;
>>   
>> -	page = region->pages[page_offset];
>> +	page = region->mreg_pages[page_offset];
> 
> What does "m" mean here - "mreg_pages"? Is it "memory region"?
> If so, then it's misleading, because the same region stuct is used to
> the MMIO regions as well. Maybe "region_pages" would be better?

m is for memory or mmio.

> Also, while we're at it, maybe rename "mshv_mem_region" to "mshv_region" to reflect that?

Well, that turns out to be much bigger change, so probably not worth it
now. mmio is "memory" mapped io, so we can probably live with it.

Thanks,
-Mukesh

.. snip ..

