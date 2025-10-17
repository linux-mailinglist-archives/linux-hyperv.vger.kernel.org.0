Return-Path: <linux-hyperv+bounces-7249-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2245BEB1A2
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 19:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA68B19C6942
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 17:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4C3081D1;
	Fri, 17 Oct 2025 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mcZxpF2N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A81307AD0;
	Fri, 17 Oct 2025 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722883; cv=none; b=UB/1RbfStKHCGcIlv91fk/aZUfgu5NLMDlB7DgOFe545bpFk+NaPi27aliBBe5eBBNLRvTtceel9Gi4cKOiU8Ty3E1hx/klxK9jz2KVZjyGuFmCIgqErJbgOEDvvz0dKNpV7xjylfVd8wNL5XbuHCxaQgByrm8kFHdvgxNjKUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722883; c=relaxed/simple;
	bh=PRfVQxJjy6Vjp+xyCypyGyhNOHUhx/dYPG4ShHWopEk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ht1N+pMWLEZTGq0CwFFqBRgLSwkOQUXENLiFRtB/Iyq6BwPQXtb+PqfxOh7RVLvu9TnZnSwCHLFfDXi3b0CR73c9izQKMtgEAXBRcQAlo+gC/O/i+RyMjsMig5VtGvPSbdnYjXCfCmss51Rg4FCiY3EKU/zlDZPqhzfxY/DVnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mcZxpF2N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.19] (unknown [103.212.145.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id A03B9201724E;
	Fri, 17 Oct 2025 10:41:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A03B9201724E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760722881;
	bh=Vj1gk3aMFO+P9nUqeopKE4AuncD7z4KeVlwI818/kuQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=mcZxpF2N174Av/F08Hahi5sOnNi4wbANuLMTrs8jeuc7aGqKcDFhDpjSjqKb/Cuta
	 K8Oi1Yc9cgeAM45PzaA1ouFsjnbdCIc/eG2aVfLh1CKIvY71FNf3rxs6E+1OiGQ+pA
	 Jx9qOYEy9pHXZKqfKMxFYpTW8gYTkP4Vp5G49D+w=
Message-ID: <1d3ac973-7bc7-4abe-9fe2-6b17dbba223b@linux.microsoft.com>
Date: Fri, 17 Oct 2025 23:11:11 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
From: Aditya Garg <gargaditya@linux.microsoft.com>
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
 <9d886861-2e1f-4ea8-9f2c-604243bd751b@linux.microsoft.com>
 <CANn89iKwHWdUaeAsdSuZUXG-W8XwyM2oppQL9spKkex0p9-Azw@mail.gmail.com>
 <7bc327ba-0050-4d9e-86b6-1b7427a96f53@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <7bc327ba-0050-4d9e-86b6-1b7427a96f53@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08-10-2025 20:58, Aditya Garg wrote:
> On 08-10-2025 20:51, Eric Dumazet wrote:
>> On Wed, Oct 8, 2025 at 8:16 AM Aditya Garg
>> <gargaditya@linux.microsoft.com> wrote:
>>>
>>> On 03-10-2025 21:45, Eric Dumazet wrote:
>>>> On Fri, Oct 3, 2025 at 8:47 AM Aditya Garg
>>>> <gargaditya@linux.microsoft.com> wrote:
>>>>>
>>>>> The MANA hardware supports a maximum of 30 scatter-gather entries 
>>>>> (SGEs)
>>>>> per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds 
>>>>> this
>>>>> limit, the driver drops the skb. Add a check in mana_start_xmit() to
>>>>> detect such cases and linearize the SKB before transmission.
>>>>>
>>>>> Return NETDEV_TX_BUSY only for -ENOSPC from 
>>>>> mana_gd_post_work_request(),
>>>>> send other errors to free_sgl_ptr to free resources and record the tx
>>>>> drop.
>>>>>
>>>>> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
>>>>> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
>>>>> ---
>>>>>    drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++ 
>>>>> ++----
>>>>>    include/net/mana/gdma.h                       |  8 +++++-
>>>>>    include/net/mana/mana.h                       |  1 +
>>>>>    3 files changed, 29 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/ 
>>>>> drivers/net/ethernet/microsoft/mana/mana_en.c
>>>>> index f4fc86f20213..22605753ca84 100644
>>>>> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
>>>>> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
>>>>> @@ -20,6 +20,7 @@
>>>>>
>>>>>    #include <net/mana/mana.h>
>>>>>    #include <net/mana/mana_auxiliary.h>
>>>>> +#include <linux/skbuff.h>
>>>>>
>>>>>    static DEFINE_IDA(mana_adev_ida);
>>>>>
>>>>> @@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff 
>>>>> *skb, struct net_device *ndev)
>>>>>           cq = &apc->tx_qp[txq_idx].tx_cq;
>>>>>           tx_stats = &txq->stats;
>>>>>
>>>>> +       BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES != 
>>>>> MANA_MAX_TX_WQE_SGL_ENTRIES);
>>>>> +       #if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
>>>>> +               if (skb_shinfo(skb)->nr_frags + 2 > 
>>>>> MANA_MAX_TX_WQE_SGL_ENTRIES) {
>>>>> +                       netdev_info_once(ndev,
>>>>> +                                        "nr_frags %d exceeds max 
>>>>> supported sge limit. Attempting skb_linearize\n",
>>>>> +                                        skb_shinfo(skb)->nr_frags);
>>>>> +                       if (skb_linearize(skb)) {
>>>>
>>>> This will fail in many cases.
>>>>
>>>> This sort of check is better done in ndo_features_check()
>>>>
>>>> Most probably this would occur for GSO packets, so can ask a software
>>>> segmentation
>>>> to avoid this big and risky kmalloc() by all means.
>>>>
>>>> Look at idpf_features_check()  which has something similar.
>>>
>>> Hi Eric,
>>> Thank you for your review. I understand your concerns regarding the use
>>> of skb_linearize() in the xmit path, as it can fail under memory
>>> pressure and introduces additional overhead in the transmit path. Based
>>> on your input, I will work on a v2 that will move the SGE limit check to
>>> the ndo_features_check() path and for GSO skbs exceding the hw limit
>>> will disable the NETIF_F_GSO_MASK to enforce software segmentation in
>>> kernel before the call to xmit.
>>> Also for non GSO skb exceeding the SGE hw limit should we go for using
>>> skb_linearize only then or would you suggest some other approach here?
>>
>> I think that for non GSO, the linearization attempt is fine.
>>
>> Note that this is extremely unlikely for non malicious users,
>> and MTU being usually small (9K or less),
>> the allocation will be much smaller than a GSO packet.
> 
> Okay. Will send a v2
Hi Eric,
I tested the code by disabling GSO in ndo_features_check when the number 
of SGEs exceeds the hardware limit, using iperf for a single TCP 
connection with zerocopy enabled. I noticed a significant difference in 
throughput compared to when we linearize the skbs.
For reference, the throughput is 35.6 Gbits/sec when using 
skb_linearize, but drops to 6.75 Gbits/sec when disabling GSO per skb.

Hence, We propose to  linearizing skbs until the first failure occurs. 
After that, we switch to a fail-safe mode by disabling GSO for SKBs with 
  sge > hw limit using the ndo_feature_check implementation, while 
continuing to apply  skb_linearize() for non-GSO packets that exceed the 
hardware limit. This ensures we remain on the optimal performance path 
initially, and only transition to the fail-safe path after encountering 
a failure.
Regards,
Aditya

