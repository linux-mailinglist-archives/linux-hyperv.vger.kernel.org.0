Return-Path: <linux-hyperv+bounces-7138-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C641BC58C2
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Oct 2025 17:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 169E54E9C5F
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A4A2EC55A;
	Wed,  8 Oct 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cRE4yWPx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882828506F;
	Wed,  8 Oct 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936729; cv=none; b=JXJO3M0pwuzUuqdBqdzPorwAYAd6/LH8Tl+5/iTD0gv4FokdG2Cgn1gfv3FsKgNUDuvN7C9v6qNd8oaBs/Jj9X0eU59d1QlVALJW29OnM2XUSg/w/36j13BsbFLwiNnHY2Xk6onJDMZ96HPd61A6tdQ2X6T3cUXcmy+2KybkGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936729; c=relaxed/simple;
	bh=uYdd1cJNrwkerjzqUD+g59Cot3lDElNM8v19Vkfd2UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Skb+HGCoXvWY9/YetCUpH6P3OEzQlhkBRd958UPJpZ0/3LRBL7nnhcruXWSKZM1GYnyn+d2gPSO/RpenKYlP0kaPZPiEs+ifzjSU4WHRf/yOJdTYGYDTN6fd1QaQk0UxCNdWRxS4lT4uIGHB1T3Jy9lyZHjTtNcn3YhLU96QNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cRE4yWPx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.18.189.204] (unknown [167.220.238.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0DA9A2038B68;
	Wed,  8 Oct 2025 08:18:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DA9A2038B68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759936727;
	bh=Zh3BpEo3cN0VRqm6zzMVbzcQ40hr+WLn8hByczasF68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cRE4yWPxdnXNU8H/p6uNQW9re7wBEh2pEHZoChxxXuFKYqlBZ0anfI+leSbtKASBy
	 +Wq7h97nmpjEqv3iHy7yXP9R90yJBvXhnaZuRHtiEC2nPG67GxVEf3/fMDs4mFoSmZ
	 qWcg12Kb/6okN3CG6cDPE0o9sABk9YmQU2R8xjnQ=
Message-ID: <6802c26f-b2c4-4bfa-9008-45bc839b7205@linux.microsoft.com>
Date: Wed, 8 Oct 2025 20:48:39 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
To: Simon Horman <horms@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com,
 shradhagupta@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 gargaditya@microsoft.com, ssengar@linux.microsoft.com
References: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20251004093805.GB3060232@horms.kernel.org>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20251004093805.GB3060232@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04-10-2025 15:08, Simon Horman wrote:
> On Fri, Oct 03, 2025 at 08:47:24AM -0700, Aditya Garg wrote:
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
>>   	cq = &apc->tx_qp[txq_idx].tx_cq;
>>   	tx_stats = &txq->stats;
>>   
>> +	BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES != MANA_MAX_TX_WQE_SGL_ENTRIES);
>> +	#if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
> 
> Hi Aditya,
> 
> I see that Eric has made a more substantial review of this patch,
> so please follow his advice.
> 
> But I wanted to add something to keep in mind for the future: I if the #if
> / #else used here can be replaced by a simple if() statement, then that
> would be preferable.  The advantage being that it improves compile
> coverage.  And, as these are all constants, I would expect the compiler to
> optimise away any unused code.

Hi Simon,
I will take care of yours and Eric's comment in v2 of this patch.
Regards,
Aditya


