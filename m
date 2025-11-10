Return-Path: <linux-hyperv+bounces-7484-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CA4C467C5
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA3B1887FF6
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896C30C36F;
	Mon, 10 Nov 2025 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nqYx3uI5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA42FD678;
	Mon, 10 Nov 2025 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776492; cv=none; b=PsiWpegs1t8ToStcaCaybQkwEFE6a1H2fKTIh7tcu9H8qu0dUpu0EdPIAL82SGweUO8AcAq/OsZlJBYPwWqQo6JmFSz5RtQCyzFYUlrLriKZFFZTbNKpYemc9ni5970ucTqR66h/b54P1QvC/kE6JNOUiS5S3rsybgL7gxn40jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776492; c=relaxed/simple;
	bh=K407W1hJmnC9HpnuRezt90XsYpFjkj7Tk89zc12RoV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEcH3U/bpHwqVRa5N1qDOYSAULd3ABOqygLyfo7vdTdeekBZAsmust1dFYWQEAADi7YJHXK2sfkCkIYnflUTGJme2BI2TFGOZAYkmROxKgGc+wXzlcs9MFJ9lwMdOmeOdaebFJtd5lK5zWRZZKK8he6LF/VYaeViS3FklKCeuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nqYx3uI5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.18.184.99] (unknown [167.220.238.131])
	by linux.microsoft.com (Postfix) with ESMTPSA id 44C8E206C172;
	Mon, 10 Nov 2025 04:08:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44C8E206C172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762776489;
	bh=E13bhBEXgPtAdpDd8xaPzdQeFho1hXGpFpdAgBmyiAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nqYx3uI5g8VAjT1w+nzNn8ty9YwIHIM22zuidhk3f9qnrF/zhAvQptf/uHocskIct
	 w2bdmGN3xCOYa+m2cOsnPrkNC61gwqFF5L69NqxtZYGIVa1AhQSqQppWJLo7YScmZ1
	 uAeg+6CtO9/hJbm2V4wfRxkiyfY9jJ8XvLuGNoY4=
Message-ID: <7403876c-dddf-449a-963f-10bbe43078a5@linux.microsoft.com>
Date: Mon, 10 Nov 2025 17:38:00 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gargaditya@microsoft.com
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20251031162611.2a981fdf@kernel.org>
 <82bcd959-571e-42ce-b341-cbfa19f9f86d@linux.microsoft.com>
 <20251105161754.4b9a1363@kernel.org>
 <bb692420-25f9-4d6e-a68b-dd83c8f4be10@linux.microsoft.com>
 <CANn89iJ8QKbwFfLUExJvB1SJCu7rVCw_drD3f=rOU84FNvaPZg@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <CANn89iJ8QKbwFfLUExJvB1SJCu7rVCw_drD3f=rOU84FNvaPZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06-11-2025 18:47, Eric Dumazet wrote:
> On Thu, Nov 6, 2025 at 5:01 AM Aditya Garg
> <gargaditya@linux.microsoft.com> wrote:
>>
>> On 06-11-2025 05:47, Jakub Kicinski wrote:
>>> On Wed, 5 Nov 2025 22:10:23 +0530 Aditya Garg wrote:
>>>>>>             if (err) {
>>>>>>                     (void)skb_dequeue_tail(&txq->pending_skbs);
>>>>>> +          mana_unmap_skb(skb, apc);
>>>>>>                     netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
>>>>>
>>>>> You have a print right here and in the callee. This condition must
>>>>> (almost) never happen in practice. It's likely fine to just drop
>>>>> the packet.
>>>>
>>>> The logs placed in callee doesn't covers all the failure scenarios,
>>>> hence I feel to have this log here with proper status. Maybe I can
>>>> remove the log in the callee?
>>>
>>> I think my point was that since there are logs (per packet!) when the
>>> condition is hit -- if it did in fact hit with any noticeable frequency
>>> your users would have complained. So handling the condition gracefully
>>> and returning BUSY is likely just unnecessary complexity in practice.
>>>
>>
>> In this, we are returning tx_busy when the error reason is -ENOSPC, for
>> all other errors, skb is dropped.
>> Is it okay requeue only for -ENOSPC cases or should we drop the skb?
> 
> I would avoid NETDEV_TX_BUSY like the plague.
> Most drivers get it wrong (including mana)
> Documentation/networking/driver.rst
> 
> Please drop the packet.
> 

Hi Eric,
Okay, Will send v3 with changes discussed.

Thanks,
Aditya

