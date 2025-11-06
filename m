Return-Path: <linux-hyperv+bounces-7424-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22DC3B228
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 14:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65AAB507357
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841F32937E;
	Thu,  6 Nov 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g/zGGMgR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6E5322533;
	Thu,  6 Nov 2025 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434064; cv=none; b=Iz9hJz6tthN0U4O1UZ22Z5lcs0/wk2bImkaXmr+bQjxAVk/bqhXLTzt2Y7qeXR71m5oez90ryPpn8RjS/JD4ZfErTpcHmfDINlwF3kEwcy4/XBhrgqjuoN1CyECr4M5VX2HcOJHNmkd7gOqGQFou/WxQPfCEdF8S4CkDGY/cH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434064; c=relaxed/simple;
	bh=sIdmkOlklbdUeXbbmmQ8uH8kjWwUsCKYxEVwZZSgns4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMSSuLq3hXA5nrO1nJLFO4N78UpXlY7wrU6VnOhhthwY1D7EF1Yr1nXY06Qg57MEExnEFIkVLuvr5Sf2jXwBTAqgrpeW9RBULyu++8iEWRX17ARmnwf1zOpbThlxx8dYqeGesetxVTD6PTRD0m1mXyg0NUqKH+Bq+oKJxlzJXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g/zGGMgR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.19] (unknown [103.212.145.25])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5E8062120391;
	Thu,  6 Nov 2025 05:00:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E8062120391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762434060;
	bh=oJDH7+GUsgWHDbJLdKnF0OjdtOyo5nb2QP3ep2Mj55o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g/zGGMgRW91Cq6o9e1mqsHmhNchjKquvwz6daoqWK6clliedPglJgHiUU1FS5xO3U
	 XKbQACxg/MZxdqZ+kffxcfj09wmZV8IEdCVFLD03CsDpzRweGT4BbmRXc+8ENOrVM7
	 9k3oJBybiUeJJ2CLFBVpR6DEGxpl5SOVezhdba18=
Message-ID: <bb692420-25f9-4d6e-a68b-dd83c8f4be10@linux.microsoft.com>
Date: Thu, 6 Nov 2025 18:30:50 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 gargaditya@microsoft.com
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20251031162611.2a981fdf@kernel.org>
 <82bcd959-571e-42ce-b341-cbfa19f9f86d@linux.microsoft.com>
 <20251105161754.4b9a1363@kernel.org>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20251105161754.4b9a1363@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06-11-2025 05:47, Jakub Kicinski wrote:
> On Wed, 5 Nov 2025 22:10:23 +0530 Aditya Garg wrote:
>>>>    	if (err) {
>>>>    		(void)skb_dequeue_tail(&txq->pending_skbs);
>>>> +		mana_unmap_skb(skb, apc);
>>>>    		netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
>>>
>>> You have a print right here and in the callee. This condition must
>>> (almost) never happen in practice. It's likely fine to just drop
>>> the packet.
>>
>> The logs placed in callee doesn't covers all the failure scenarios,
>> hence I feel to have this log here with proper status. Maybe I can
>> remove the log in the callee?
> 
> I think my point was that since there are logs (per packet!) when the
> condition is hit -- if it did in fact hit with any noticeable frequency
> your users would have complained. So handling the condition gracefully
> and returning BUSY is likely just unnecessary complexity in practice.
> 

In this, we are returning tx_busy when the error reason is -ENOSPC, for 
all other errors, skb is dropped.
Is it okay requeue only for -ENOSPC cases or should we drop the skb?

> The logs themselves I don't care all that much about. Sure, having two
> lines for one error is a bit unclean.
>   
>>> Either way -- this should be a separate patch.
>>>    
>> Are you suggesting a separate patch altogether or two patch in the same
>> series?
> 
> The changes feel related enough to make them a series, but either way
> is fine.

Regards,
Aditya


