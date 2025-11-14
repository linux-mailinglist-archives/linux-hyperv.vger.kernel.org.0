Return-Path: <linux-hyperv+bounces-7596-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF9C5F4D9
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 21:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEC73ADEA5
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Nov 2025 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0E2FB99B;
	Fri, 14 Nov 2025 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XTM1Wogw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607EC2FB99A;
	Fri, 14 Nov 2025 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153910; cv=none; b=D0PD+s6Ay3BmbloKy4U9wtrL2tjRgKwLJvA4bm2QKj4HGMxzLzhMQEqLl4MkgfLFk4HMGP2KW9XEwS6jwzT03+j/FIQZQdBS99a9Q4BO+TUeJHPjWOPMSfJVz5MtFmofNu3mfApHZ9MA0J6BDUlROgd5UtB6MnlfG3JqLJ8Z4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153910; c=relaxed/simple;
	bh=NU8I6DFBBDxSVvP0Y1JJZ4FZjERpbk7xEGubtlerNL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlgEutXfv6BCXOneol7zbDr5buce6rMugWnte/CQMhUA3d860lJr2Z3bFByH7zl+0PHHsjLr7XwkK4hoadOO5hNn3sMUglBVl3j7LEvH+Lg3A8GPgKnpNRYN3eiw3kdVYXVZwkPKVXIsxrmmm9JqUrozs5MBwK3SWVnOMEPr2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XTM1Wogw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.200.7] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 65761201AE5A;
	Fri, 14 Nov 2025 12:58:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65761201AE5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763153901;
	bh=hXU5XnfCF/cwE4/J20YkIzYBKcMQJTB9H9fJo5UCttM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XTM1Wogwg1tNwyDj0aOA0i2Bh6FmczbUmImLlDtPjLdf4eXncF2OVIk9slIMF6ga2
	 fK8YS735k+PuWOGUiJPYC1l/qTYOspzEToDFiCoF5Zlq1G6/BahDITQSVGIGx85YMl
	 QO3wL87A0LffXqD7tIiFaPWp9ipgCUfBTQaX3Fy4=
Message-ID: <18ee6a8b-21fd-49c6-964a-2eb1b0b61c1d@linux.microsoft.com>
Date: Sat, 15 Nov 2025 02:28:11 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Eric Dumazet <edumazet@google.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, leon@kernel.org,
 mlevitsk@redhat.com, yury.norov@gmail.com, sbhatta@marvell.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 gargaditya@microsoft.com
References: <1762952506-23593-1-git-send-email-gargaditya@linux.microsoft.com>
 <1762952506-23593-2-git-send-email-gargaditya@linux.microsoft.com>
 <CANn89iL-RJ84WB9W8SoZn6_UMko8sLBb_FEGjjGZTEO+9KOpAg@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <CANn89iL-RJ84WB9W8SoZn6_UMko8sLBb_FEGjjGZTEO+9KOpAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12-11-2025 19:25, Eric Dumazet wrote:
> On Wed, Nov 12, 2025 at 5:11 AM Aditya Garg
> <gargaditya@linux.microsoft.com> wrote:
>>
>> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
>> per TX WQE. Exceeding this limit can cause TX failures.
>> Add ndo_features_check() callback to validate SKB layout before
>> transmission. For GSO SKBs that would exceed the hardware SGE limit, clear
>> NETIF_F_GSO_MASK to enforce software segmentation in the stack.
>> Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
>> exceed the SGE limit.
>>
>> Also, Add ethtool counter for SKBs linearized
>>
>> Co-developed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
>> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
>> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
>> ---
>>   drivers/net/ethernet/microsoft/mana/mana_en.c | 37 ++++++++++++++++++-
>>   .../ethernet/microsoft/mana/mana_ethtool.c    |  2 +
>>   include/net/mana/gdma.h                       |  6 ++-
>>   include/net/mana/mana.h                       |  1 +
>>   4 files changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
>> index cccd5b63cee6..67ae5421f9ee 100644
>> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
>> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/mm.h>
>>   #include <linux/pci.h>
>>   #include <linux/export.h>
>> +#include <linux/skbuff.h>
>>
>>   #include <net/checksum.h>
>>   #include <net/ip6_checksum.h>
>> @@ -329,6 +330,20 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>          cq = &apc->tx_qp[txq_idx].tx_cq;
>>          tx_stats = &txq->stats;
>>
>> +       if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
>> +           skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
>> +               /* GSO skb with Hardware SGE limit exceeded is not expected here
>> +                * as they are handled in mana_features_check() callback
>> +                */
>> +               if (skb_linearize(skb)) {
>> +                       netdev_warn_once(ndev, "Failed to linearize skb with nr_frags=%d and is_gso=%d\n",
>> +                                        skb_shinfo(skb)->nr_frags,
>> +                                        skb_is_gso(skb));
>> +                       goto tx_drop_count;
>> +               }
>> +               apc->eth_stats.linear_pkt_tx_cnt++;
>> +       }
>> +
>>          pkg.tx_oob.s_oob.vcq_num = cq->gdma_id;
>>          pkg.tx_oob.s_oob.vsq_frame = txq->vsq_frame;
>>
>> @@ -442,8 +457,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>                  }
>>          }
>>
>> -       WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
>> -
>>          if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
>>                  pkg.wqe_req.sgl = pkg.sgl_array;
>>          } else {
>> @@ -518,6 +531,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>          return NETDEV_TX_OK;
>>   }
>>
> 
> 
> #if MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES
> 
>> +static netdev_features_t mana_features_check(struct sk_buff *skb,
>> +                                            struct net_device *ndev,
>> +                                            netdev_features_t features)
>> +{
>> +       if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
>> +           skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
>> +               /* Exceeds HW SGE limit.
>> +                * GSO case:
>> +                *   Disable GSO so the stack will software-segment the skb
>> +                *   into smaller skbs that fit the SGE budget.
>> +                * Non-GSO case:
>> +                *   The xmit path will attempt skb_linearize() as a fallback.
>> +                */
>> +               if (skb_is_gso(skb))
> 
> No need to test skb_is_gso(skb), you can clear bits, this will be a
> NOP if the packet is non GSO anyway.
> 
>> +                       features &= ~NETIF_F_GSO_MASK;
>> +       }
>> +       return features;
>> +}
> 
> #endif
> 
>> +
>>   static void mana_get_stats64(struct net_device *ndev,
>>                               struct rtnl_link_stats64 *st)
>>   {
>> @@ -878,6 +910,7 @@ static const struct net_device_ops mana_devops = {
>>          .ndo_open               = mana_open,
>>          .ndo_stop               = mana_close,
>>          .ndo_select_queue       = mana_select_queue,
>> +       .ndo_features_check     = mana_features_check,
> 
> Note that if your mana_features_check() is a nop if MAX_SKB_FRAGS is
> small enough,
> you could set a non NULL .ndo_features_check based on a preprocessor condition
> 
> #if MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES
>      .ndo_features_check = ....
> #endif
> 
> This would avoid an expensive indirect call when possible.
> 
> 
>>          .ndo_start_xmit         = mana_start_xmit,
>>          .ndo_validate_addr      = eth_validate_addr,
>>          .ndo_get_stats64        = mana_get_stats64,
>> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
>> index a1afa75a9463..fa5e1a2f06a9 100644
>> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
>> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
>> @@ -71,6 +71,8 @@ static const struct mana_stats_desc mana_eth_stats[] = {
>>          {"tx_cq_err", offsetof(struct mana_ethtool_stats, tx_cqe_err)},
>>          {"tx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
>>                                          tx_cqe_unknown_type)},
>> +       {"linear_pkt_tx_cnt", offsetof(struct mana_ethtool_stats,
>> +                                       linear_pkt_tx_cnt)},
>>          {"rx_coalesced_err", offsetof(struct mana_ethtool_stats,
>>                                          rx_coalesced_err)},
>>          {"rx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
>> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
>> index 637f42485dba..84614ebe0f4c 100644
>> --- a/include/net/mana/gdma.h
>> +++ b/include/net/mana/gdma.h
>> @@ -592,6 +592,9 @@ enum {
>>   #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
>>   #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
>>
>> +/* Driver supports linearizing the skb when num_sge exceeds hardware limit */
>> +#define GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE BIT(20)
>> +
>>   #define GDMA_DRV_CAP_FLAGS1 \
>>          (GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>>           GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
>> @@ -601,7 +604,8 @@ enum {
>>           GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
>>           GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
>>           GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
>> -        GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE)
>> +        GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE | \
>> +        GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE)
>>
>>   #define GDMA_DRV_CAP_FLAGS2 0
>>
>> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
>> index 8906901535f5..50a532fb30d6 100644
>> --- a/include/net/mana/mana.h
>> +++ b/include/net/mana/mana.h
>> @@ -404,6 +404,7 @@ struct mana_ethtool_stats {
>>          u64 hc_tx_err_gdma;
>>          u64 tx_cqe_err;
>>          u64 tx_cqe_unknown_type;
>> +       u64 linear_pkt_tx_cnt;
>>          u64 rx_coalesced_err;
>>          u64 rx_cqe_unknown_type;
>>   };
>> --
>> 2.43.0
>>

Thanks for the review Eric. I will incorporate these changes in next 
revision.

Regards,
Aditya

