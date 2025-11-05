Return-Path: <linux-hyperv+bounces-7409-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF0C36CE9
	for <lists+linux-hyperv@lfdr.de>; Wed, 05 Nov 2025 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B22189CDE8
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Nov 2025 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358633B96A;
	Wed,  5 Nov 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HL2yqFo5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81AC33B6F1;
	Wed,  5 Nov 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361193; cv=none; b=Pdqe/hGPboNCnrcCWY9up1q5dhJBT6j/B0RTLHnFs3MCKRU8Z73jZwKOMC/PiWzu7pWmJ+MXuUjqepeHQBstwYmLA2C3QFvvIi7Irao87bBOcvKnqV4Ki1pyVllXSHvPXjz0BSZHeIsKo+hj5rGIlEBHn0hCm2OoEiadbEoFuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361193; c=relaxed/simple;
	bh=MfA4DnoDlZZsja0zpAnheKwfORvl0d2lCWWC/hUeGUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsTlmBgKJPjNNNwi7462/axAEPMHmlFz26MwSW6WFroGO5N6WpyR7jtOL7quByVhZV/PJSrWLyuhvskHinoqwQjSzXNapNcZXnhe9lazMwhUZFCwdl4QmJjIDji/JjZgg2vH8Q2ahcW3Mt3MCkeK48w8P/S7lrhS156L3yASIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HL2yqFo5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.19] (unknown [103.212.145.25])
	by linux.microsoft.com (Postfix) with ESMTPSA id C3DF1201C94E;
	Wed,  5 Nov 2025 08:40:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3DF1201C94E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762360832;
	bh=iqYVFbQgaJqdvK417PuHyWdZtZ0sLBzSqfzt5NDhSmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HL2yqFo5jX2P3TNsJPKShuTlng5aKhlhS74BIsjIfYxh0RVXpEqxQGPyIK675eJTX
	 gCvBbZCfOoHlpI4V8cyRNjZa0HAl6fOLh+DDQvznM5eAUnFu9xAXgSTzrCGjWoOUBg
	 LvoHZnHcvL4hCSPNyELU2nzx3MFzAIlAETb1w1WE=
Message-ID: <82bcd959-571e-42ce-b341-cbfa19f9f86d@linux.microsoft.com>
Date: Wed, 5 Nov 2025 22:10:23 +0530
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
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20251031162611.2a981fdf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01-11-2025 04:56, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 06:12:35 -0700 Aditya Garg wrote:
>> @@ -289,6 +290,21 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	cq = &apc->tx_qp[txq_idx].tx_cq;
>>   	tx_stats = &txq->stats;
>>   
>> +	if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
>> +	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
>> +		/* GSO skb with Hardware SGE limit exceeded is not expected here
>> +		 * as they are handled in mana_features_check() callback
>> +		 */
>> +		if (skb_is_gso(skb))
>> +			netdev_warn_once(ndev, "GSO enabled skb exceeds max SGE limit\n");
> 
> This could be the same question Simon asked but why do you think you
> need this line? Sure you need to linearize non-GSO but why do you care
> to warn specifically about GSO?! Looks like defensive programming or
> testing leftover..
> 
Hi Jakub,
Agreed, The GSO specific warning is redundant. I'll drop it in next 
revision.
>> +		if (skb_linearize(skb)) {
>> +			netdev_warn_once(ndev, "Failed to linearize skb with nr_frags=%d and is_gso=%d\n",
>> +					 skb_shinfo(skb)->nr_frags,
>> +					 skb_is_gso(skb));
> 
> .. in practice including is_gso() here as you do is probably enough for
> debug
> 
Ok
>> +			goto tx_drop_count;
>> +		}
>> +	}
>> +
>>   	pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
>>   	pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
>>   
>> @@ -402,8 +418,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   		}
>>   	}
>>   
>> -	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
>> -
>>   	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
>>   		pkg.wqe_req.sgl = pkg.sgl_array;
>>   	} else {
>> @@ -438,9 +452,13 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   
>>   	if (err) {
>>   		(void)skb_dequeue_tail(&txq->pending_skbs);
>> +		mana_unmap_skb(skb, apc);
>>   		netdev_warn(ndev, "Failed to post TX OOB: %d\n", err);
> 
> You have a print right here and in the callee. This condition must
> (almost) never happen in practice. It's likely fine to just drop
> the packet.
> The logs placed in callee doesn't covers all the failure scenarios, 
hence I feel to have this log here with proper status. Maybe I can 
remove the log in the callee?

> Either way -- this should be a separate patch.
> 
Are you suggesting a separate patch altogether or two patch in the same 
series?

Based on your suggestion i can work on v3.
Regards,
Aditya

>> -		err = NETDEV_TX_BUSY;
>> -		goto tx_busy;
>> +		if (err == -ENOSPC) {
>> +			err = NETDEV_TX_BUSY;
>> +			goto tx_busy;
>> +		}
>> +		goto free_sgl_ptr;
>>   	}
>>   
>>   	err = NETDEV_TX_OK;
>> @@ -478,6 +496,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	return NETDEV_TX_OK;
>>   }


