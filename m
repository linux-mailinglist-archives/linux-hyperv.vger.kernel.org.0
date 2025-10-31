Return-Path: <linux-hyperv+bounces-7388-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44A9C253CA
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 14:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B9C3BE8F7
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 13:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B2A34B428;
	Fri, 31 Oct 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZWImuyJM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F351B142D;
	Fri, 31 Oct 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916820; cv=none; b=S8UqkmMQz4jjt29aKOHu9OE/Q6sUVr4AoG6h/p2s7Z0oCO1OXbgkFuHfGhLBo96dlEDFFpJxwH9+dPRjadN19irCb0dJ0EDjx7n/OQTS/sUjUYcJgZ4W0vnjh1nfC0BceoRQ3a+8SxO2EGROpTQOlS05OYDjN3uYHQYB9OZicps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916820; c=relaxed/simple;
	bh=DawxYnhCqvS1VLds39qbkKtQE0BqAIbIQ6H60jxljHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhdWeu0uNs/infHT32At1l8T0mPMGvGl1DTbFcV4dYL7eQRoQvl3a8/yA/U7X234cnCgvt3f6/VjzT8j6upTKx8TzmgE8u3pcVhkc84IsyqWNOThGhoEdupWj/9QDMYZPub/U8vewnp7L83LMY/Bt+Nm9+82NzLSuTWz04xfJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZWImuyJM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.19] (unknown [103.212.145.71])
	by linux.microsoft.com (Postfix) with ESMTPSA id 006D4201A7D2;
	Fri, 31 Oct 2025 06:20:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 006D4201A7D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761916818;
	bh=jnAwVyIj69/F/fVSjZqV+IT6X9/j+5+6TPTp7CUgj7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZWImuyJMsrEdzFUuLTme2SU4Dt/KU4jg59orX5Ppr8PNkuptpnRvW0hpRTeBhRokh
	 MdYiGUTInWEGFJiPHbbLBV/IOs+zsLRWECBYiy+dy2ip7hf4cgBjGmAfvimQCVI38x
	 M3uftScXNcDyeR0tJHjHk2O1cy6s1rDrUJY/rdfg=
Message-ID: <347c723b-d47c-49c2-9a3b-b49d967f875b@linux.microsoft.com>
Date: Fri, 31 Oct 2025 18:50:10 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Simon Horman <horms@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gargaditya@microsoft.com
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <aQMqLN0FRmNU3_ke@horms.kernel.org>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <aQMqLN0FRmNU3_ke@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30-10-2025 14:34, Simon Horman wrote:
> On Wed, Oct 29, 2025 at 06:12:35AM -0700, Aditya Garg wrote:
>> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
>> per TX WQE. Exceeding this limit can cause TX failures.
>> Add ndo_features_check() callback to validate SKB layout before
>> transmission. For GSO SKBs that would exceed the hardware SGE limit, clear
>> NETIF_F_GSO_MASK to enforce software segmentation in the stack.
>> Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
>> exceed the SGE limit.
>>
>> Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(),
>> send other errors to free_sgl_ptr to free resources and record the tx
>> drop.
>>
>> Co-developed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
>> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
>> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> 
> ...
> 
>> @@ -289,6 +290,21 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	cq = &apc->tx_qp[txq_idx].tx_cq;
>>   	tx_stats = &txq->stats;
>>   
>> +	if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
>> +	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
>> +		/* GSO skb with Hardware SGE limit exceeded is not expected here
>> +		 * as they are handled in mana_features_check() callback
>> +		 */
> 
> Hi,
> 
> I'm curious to know if we actually need this code.
> Are there cases where the mana_features_check() doesn't
> handle things and the kernel will reach this line?
> 
>> +		if (skb_is_gso(skb))
>> +			netdev_warn_once(ndev, "GSO enabled skb exceeds max SGE limit\n");
>> +		if (skb_linearize(skb)) {
>> +			netdev_warn_once(ndev, "Failed to linearize skb with nr_frags=%d and is_gso=%d\n",
>> +					 skb_shinfo(skb)->nr_frags,
>> +					 skb_is_gso(skb));
>> +			goto tx_drop_count;
>> +		}
>> +	}
>> +
>>   	pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
>>   	pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
>>   
> 
> ...

Hi Simon,
As it was previously discussed and agreed on with Eric, this is for 
Non-GSO skbs which could have possibly nr_frags greater than hardware limit.

Quoting Eric's comment from v1 thread: 
https://lore.kernel.org/netdev/CANn89iKwHWdUaeAsdSuZUXG-W8XwyM2oppQL9spKkex0p9-Azw@mail.gmail.com/
"I think that for non GSO, the linearization attempt is fine.

Note that this is extremely unlikely for non malicious users,
and MTU being usually small (9K or less),
the allocation will be much smaller than a GSO packet."

Regards,
Aditya

