Return-Path: <linux-hyperv+bounces-3167-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611D59A598E
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2024 06:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230D72812BC
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2024 04:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8683E1940B0;
	Mon, 21 Oct 2024 04:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QKNGZt7w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1F286A8;
	Mon, 21 Oct 2024 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729485121; cv=none; b=CaPZwCHKTB0T/hNXE7RTEtonJBwfF7Brplu1ktXtPZXN5IaWO1rdwJ3OTC8IT9BzU0fTbw0oB1U1IE5T44UciXH63Vlpf3ZNpRY3tKuIMkW8gb9usIJjqd1RlCB07u+v3LNBRNnAfpiyEWheaq0cePbWJfRoGr+UlfFb/wb+sxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729485121; c=relaxed/simple;
	bh=TtHNkk0YGhiRCPwMrIK5G3w7eXiN4gQUihzQrIcXNmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rThmxgbcjq7Yp1QGYqVVSL5jShGhtJoogE8rp8VabBEQhWn6Wwnq4QvvDqgPDmCauTd3qwJ1WktZw6uGgN4MKx+j70cLq1e1b4TxoN3cuiGj03xZ9dRzb6P83IRdl3bit687OzJ8CI0TuTXrlMLCsueuuO5SGAp/6Jif2QWfGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QKNGZt7w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.160.145] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id BCBB2210B2C6;
	Sun, 20 Oct 2024 21:31:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCBB2210B2C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729485119;
	bh=1yk49KWIJ3X19lRgWIBwpiU8ObCm6eOyFulvcp0RXZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QKNGZt7wBA8F152LENCdBYEiax8SVpnm2gRr1TqMLgtudlSzRnEAlYaXhqjvo97nI
	 4pX/hYv4xz55667GuXjzY3iimqptUJGu9X5EMhveNsYwr5FisOjkjApRJIB14WA/K9
	 w83YlLjx454EqwpekbJcHbb+AfS24fRnAiWbKdbk=
Message-ID: <b98ea1ae-0adb-4646-88ba-daabc5eb8adf@linux.microsoft.com>
Date: Mon, 21 Oct 2024 10:01:53 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Log on missing offers
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Starks <jostarks@microsoft.com>,
 jacob.pan@linux.microsoft.com,
 Easwar Hariharan <eahariha@linux.microsoft.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-3-namjain@linux.microsoft.com>
 <20241021042600.GA25279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20241021042600.GA25279@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/2024 9:56 AM, Saurabh Singh Sengar wrote:
> On Fri, Oct 18, 2024 at 04:58:11AM -0700, Naman Jain wrote:
>> From: John Starks <jostarks@microsoft.com>
>>
>> When resuming from hibernation, log any channels that were present
>> before hibernation but now are gone.
>>
>> Signed-off-by: John Starks <jostarks@microsoft.com>
>> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/hv/vmbus_drv.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index bd3fc41dc06b..1f56d138210e 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -2462,6 +2462,7 @@ static int vmbus_bus_suspend(struct device *dev)
>>   
>>   static int vmbus_bus_resume(struct device *dev)
>>   {
>> +	struct vmbus_channel *channel;
>>   	struct vmbus_channel_msginfo *msginfo;
>>   	size_t msgsize;
>>   	int ret;
>> @@ -2494,6 +2495,21 @@ static int vmbus_bus_resume(struct device *dev)
>>   
>>   	vmbus_request_offers();
>>   
>> +	mutex_lock(&vmbus_connection.channel_mutex);
>> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
>> +		if (channel->offermsg.child_relid != INVALID_RELID)
>> +			continue;
>> +
>> +		/* hvsock channels are not expected to be present. */
>> +		if (is_hvsock_channel(channel))
>> +			continue;
>> +
>> +		pr_err("channel %pUl/%pUl not present after resume.\n",
>> +			&channel->offermsg.offer.if_type,
>> +			&channel->offermsg.offer.if_instance);
> 
> Do we want to put a TODO here, so as to do cleanup of these channels
> like force rescind etc later ?
> 
> - Saurabh


Sure, we can put that.

Regards,
Naman

