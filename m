Return-Path: <linux-hyperv+bounces-7137-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A47BC58AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Oct 2025 17:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27C9E4FA7B1
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E522F3612;
	Wed,  8 Oct 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RxpKTFHX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C324C2ECE96;
	Wed,  8 Oct 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936582; cv=none; b=Od48FcspQsgundhqnvjQfYJ5zd4h6El+BTwgRU1ERsq+Gd0ppI/1Z6zvJZXIr89kEmQpux7I5PF+UrC0uXgw0YE8s+3E+zkp7WIGJJpJOlx1y1ASJoKwvj0YtEW8jHhQiwLWSM72tdQkXYOvxAHfYnMD39Qzqam5++Qy5sbSQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936582; c=relaxed/simple;
	bh=qht7upbZcN8Fp3kBFgjhtYFX7m/ywbptenojVx6vypA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLsmuMpqVSAZZl4NF46cmVx0gHhlNC/NAvgZs4zhnqQUM83QTO+WxLk7Ur8zGUnibwvjw1gj0voBmXrKqfz4AHum0JbkZhjQDrw+F6HTlmnVgUcUoPNdT/NkfyVjj3QIOgOMTaG2nUIudxqtW3OHEV/RmyZFg/ya4/UaLXIXTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RxpKTFHX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.18.189.204] (unknown [167.220.238.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A3D82038B69;
	Wed,  8 Oct 2025 08:16:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A3D82038B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759936573;
	bh=5TpYtkIM3vm8SzLYGq6t368MueIPPKh5A747g7RJJ0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RxpKTFHXFhVvEfRgr19RhxzXiDCrYzYhGBJokLgnbduQD3cxckwoNxv9ZFW1avHy7
	 Cblr5iHoIFLvpXkvprGZmChticXo+37TJB/N0wzRll3bMIiopL1rNZ+bti6JHCl+td
	 IcZMcV0y8ALXfV3AybyU2JJ53jjg04i+rNqpIOz0=
Message-ID: <9d886861-2e1f-4ea8-9f2c-604243bd751b@linux.microsoft.com>
Date: Wed, 8 Oct 2025 20:46:05 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
To: Eric Dumazet <edumazet@google.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gargaditya@microsoft.com,
 ssengar@linux.microsoft.com
References: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CANn89iJwkbxC5HvSKmk807K-3HY+YR1kt-LhcYwnoFLAaeVVow@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <CANn89iJwkbxC5HvSKmk807K-3HY+YR1kt-LhcYwnoFLAaeVVow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03-10-2025 21:45, Eric Dumazet wrote:
> On Fri, Oct 3, 2025 at 8:47 AM Aditya Garg
> <gargaditya@linux.microsoft.com> wrote:
>>
>> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
>> per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds this
>> limit, the driver drops the skb. Add a check in mana_start_xmit() to
>> detect such cases and linearize the SKB before transmission.
>>
>> Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(),
>> send other errors to free_sgl_ptr to free resources and record the tx
>> drop.
>>
>> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
>> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
>> ---
>>   drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++++----
>>   include/net/mana/gdma.h                       |  8 +++++-
>>   include/net/mana/mana.h                       |  1 +
>>   3 files changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
>> index f4fc86f20213..22605753ca84 100644
>> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
>> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
>> @@ -20,6 +20,7 @@
>>
>>   #include <net/mana/mana.h>
>>   #include <net/mana/mana_auxiliary.h>
>> +#include <linux/skbuff.h>
>>
>>   static DEFINE_IDA(mana_adev_ida);
>>
>> @@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>          cq = &apc->tx_qp[txq_idx].tx_cq;
>>          tx_stats = &txq->stats;
>>
>> +       BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES != MANA_MAX_TX_WQE_SGL_ENTRIES);
>> +       #if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
>> +               if (skb_shinfo(skb)->nr_frags + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES) {
>> +                       netdev_info_once(ndev,
>> +                                        "nr_frags %d exceeds max supported sge limit. Attempting skb_linearize\n",
>> +                                        skb_shinfo(skb)->nr_frags);
>> +                       if (skb_linearize(skb)) {
> 
> This will fail in many cases.
> 
> This sort of check is better done in ndo_features_check()
> 
> Most probably this would occur for GSO packets, so can ask a software
> segmentation
> to avoid this big and risky kmalloc() by all means.
> 
> Look at idpf_features_check()  which has something similar.

Hi Eric,
Thank you for your review. I understand your concerns regarding the use 
of skb_linearize() in the xmit path, as it can fail under memory 
pressure and introduces additional overhead in the transmit path. Based 
on your input, I will work on a v2 that will move the SGE limit check to 
the ndo_features_check() path and for GSO skbs exceding the hw limit 
will disable the NETIF_F_GSO_MASK to enforce software segmentation in 
kernel before the call to xmit.
Also for non GSO skb exceeding the SGE hw limit should we go for using 
skb_linearize only then or would you suggest some other approach here?

Regards,
Aditya

