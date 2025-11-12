Return-Path: <linux-hyperv+bounces-7527-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B8DC5295C
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 15:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C14318991E4
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A708146A66;
	Wed, 12 Nov 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzxacDtT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D72264CB
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955724; cv=none; b=APRAMgo7LioXRtgnU6Hs45Vl8rFOOWbaufE55fGltJKizotMV04mPlvj/Yk8JQITw/jwjAj/WPu/GQ0i8E6IfZko24UxsU+ajap7EnDYa9z8g5YueWFJJO89CqYXKfmKc8MTGgGXibwWW9Xaxn9QlkXB7ZZJXV/jpMZf7JqMkGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955724; c=relaxed/simple;
	bh=mQTO3qMBrrbrec+vOaxyEQHikAOjUWJdth7psxqKQd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOBZ79HRiN+++WM7iU6verkcqbMsuphVGSOM03OYzr/V42W51dLrA+ltRJ8CiBPLcLLwf2bikKcCdAdeGsbx+iwvnJl9EfcsupRWBXJZLM+xxXyLfkp0PD3GzNID7SUMMkapvEbsS+XlEmtUxFPXL0Dpr88jTfAnEa6UUIU2GaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzxacDtT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed9c1924adso7362531cf.1
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 05:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762955721; x=1763560521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olHOzv1HDFcRoKcRPLEDHq3xryx1qVQZjsYC+KidFkM=;
        b=fzxacDtTVBYEo2ig08MTouQLS7EZwDZWtN79+J7Y3ueIH6+g2jBz3ciIGxzFFe+qPf
         cvHJeMVlJEj66XqA++SQKpwKEp2atrNZhwUnCrIYYbjSjyZe+sM5Jh3QWzmD+tAy8nyF
         ne5W0rKBRlNVylPNt4VRIVKl1MBKS4Rn1YTZF7W3dazXrzndxjQBQJ9AOcROgxAHxDH7
         go8wydTVQPpnRFX3QnTfxGNhM9XCe9A0nq5xCq9uUmqHktOnuWKAIj+cbQGxRjVyV9Ng
         jrNSUkdkChDcrf7ItxeyNY+DC+Fr7jT7f4kE1hz/VCq1aS+70H+iZofrnmgdY4fbZQwY
         Lo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955721; x=1763560521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=olHOzv1HDFcRoKcRPLEDHq3xryx1qVQZjsYC+KidFkM=;
        b=AlVnuhrFKTAm6Vm4Ne9v6XbAn3fg9Qm7YFPeSBuHRQcBw5KHSLQUVVjbP8GMZBbDZv
         w1j3bWy3dhNAXTmRskdieX0hRO+ew6YGPU6l8Dik46lJeLU8HaroWmH+EqLytKp1vdm7
         u838/hjZ+rYk9nbHtWQJzMUW90qJzjYl6c6ssW1bkk7JYmAPrHBHi8TcmQxqW2R3IMoH
         6e66vpISy2ZvTKe9Y+G0QVjrXXW8b2bzfmBQudblybGvmqk5aIqMb9ih4PZ9Ygfpp8Tf
         NILobimC/H6/497aAzvxMgsqVi/WMUvJ4QD1qtpqDTjpB0kVKUlE2D4eD2Ybb/eRYpGb
         fmgA==
X-Forwarded-Encrypted: i=1; AJvYcCVwLg53I2lAqlZg1nbWO6O9sEyXO/7MhoYlu61jUuR6RCn8A3bA+E0SRFSCsVUBIS6cNgZM9oarQdF6+xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTsB9lB6zJLuPuizM7g21kILNIj+XSjABvUezJKoLm50TNRMlR
	1GyYAr4neECYaZAOQf8vBY1njomoE/PbBPRVha6RmqicxRrmk+DVLmFSAUd5Oy0QOFyS5Yy7WHt
	dNxKPBOB8+GKORl65bTYYT1D4jZaw48IdUtWhkVmA
X-Gm-Gg: ASbGnctVysaqjrQMSMicq4TkO5zwmafh+s0WX6MCeFOIuA7J8u2Akd8QVhVi7XqtiI6
	mSCBQfI7fob+l71qaMWe+36nhM2l64BUqZXwebQJjkk8fwjGz19Rc/9qTOQN1fpGnuFaAKD6BA4
	ydcqB1pOFdcGN59LLaju3Uwj+G8QUEgtrEX8GiTWgrSIzk44RfI3kcwXqXRgty/1CoiKQsbRn9S
	YGQMUmM+yUWbZqafKtUc6oUuRZR7EhmJ8Mxl9vAm9LZ0drzCG+O3Ocq0/oB9PJnfZ5ydQp+
X-Google-Smtp-Source: AGHT+IH5mtOTw5ql/3tyCPfaJIqRYelbwEuY2GxwU9SpSn2Er1u7sqEWL7WpBlKzBs9sxmpYzFu7SfnMl4N6pUgTzCk=
X-Received: by 2002:a05:622a:54e:b0:4ec:f07c:3e73 with SMTP id
 d75a77b69052e-4eddbe1c28amr37326511cf.76.1762955720119; Wed, 12 Nov 2025
 05:55:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1762952506-23593-1-git-send-email-gargaditya@linux.microsoft.com> <1762952506-23593-2-git-send-email-gargaditya@linux.microsoft.com>
In-Reply-To: <1762952506-23593-2-git-send-email-gargaditya@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Nov 2025 05:55:07 -0800
X-Gm-Features: AWmQ_bluu1-AEflxU_3suMcewGFMw8kM6f7K2JJf4BGWU2evk1xj6w6Ga79O0hY
Message-ID: <CANn89iL-RJ84WB9W8SoZn6_UMko8sLBb_FEGjjGZTEO+9KOpAg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:11=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> per TX WQE. Exceeding this limit can cause TX failures.
> Add ndo_features_check() callback to validate SKB layout before
> transmission. For GSO SKBs that would exceed the hardware SGE limit, clea=
r
> NETIF_F_GSO_MASK to enforce software segmentation in the stack.
> Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
> exceed the SGE limit.
>
> Also, Add ethtool counter for SKBs linearized
>
> Co-developed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 37 ++++++++++++++++++-
>  .../ethernet/microsoft/mana/mana_ethtool.c    |  2 +
>  include/net/mana/gdma.h                       |  6 ++-
>  include/net/mana/mana.h                       |  1 +
>  4 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index cccd5b63cee6..67ae5421f9ee 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -11,6 +11,7 @@
>  #include <linux/mm.h>
>  #include <linux/pci.h>
>  #include <linux/export.h>
> +#include <linux/skbuff.h>
>
>  #include <net/checksum.h>
>  #include <net/ip6_checksum.h>
> @@ -329,6 +330,20 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, str=
uct net_device *ndev)
>         cq =3D &apc->tx_qp[txq_idx].tx_cq;
>         tx_stats =3D &txq->stats;
>
> +       if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
> +           skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
> +               /* GSO skb with Hardware SGE limit exceeded is not expect=
ed here
> +                * as they are handled in mana_features_check() callback
> +                */
> +               if (skb_linearize(skb)) {
> +                       netdev_warn_once(ndev, "Failed to linearize skb w=
ith nr_frags=3D%d and is_gso=3D%d\n",
> +                                        skb_shinfo(skb)->nr_frags,
> +                                        skb_is_gso(skb));
> +                       goto tx_drop_count;
> +               }
> +               apc->eth_stats.linear_pkt_tx_cnt++;
> +       }
> +
>         pkg.tx_oob.s_oob.vcq_num =3D cq->gdma_id;
>         pkg.tx_oob.s_oob.vsq_frame =3D txq->vsq_frame;
>
> @@ -442,8 +457,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, stru=
ct net_device *ndev)
>                 }
>         }
>
> -       WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
> -
>         if (pkg.wqe_req.num_sge <=3D ARRAY_SIZE(pkg.sgl_array)) {
>                 pkg.wqe_req.sgl =3D pkg.sgl_array;
>         } else {
> @@ -518,6 +531,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, str=
uct net_device *ndev)
>         return NETDEV_TX_OK;
>  }
>


#if MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES

> +static netdev_features_t mana_features_check(struct sk_buff *skb,
> +                                            struct net_device *ndev,
> +                                            netdev_features_t features)
> +{
> +       if (MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES &&
> +           skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
> +               /* Exceeds HW SGE limit.
> +                * GSO case:
> +                *   Disable GSO so the stack will software-segment the s=
kb
> +                *   into smaller skbs that fit the SGE budget.
> +                * Non-GSO case:
> +                *   The xmit path will attempt skb_linearize() as a fall=
back.
> +                */
> +               if (skb_is_gso(skb))

No need to test skb_is_gso(skb), you can clear bits, this will be a
NOP if the packet is non GSO anyway.

> +                       features &=3D ~NETIF_F_GSO_MASK;
> +       }
> +       return features;
> +}

#endif

> +
>  static void mana_get_stats64(struct net_device *ndev,
>                              struct rtnl_link_stats64 *st)
>  {
> @@ -878,6 +910,7 @@ static const struct net_device_ops mana_devops =3D {
>         .ndo_open               =3D mana_open,
>         .ndo_stop               =3D mana_close,
>         .ndo_select_queue       =3D mana_select_queue,
> +       .ndo_features_check     =3D mana_features_check,

Note that if your mana_features_check() is a nop if MAX_SKB_FRAGS is
small enough,
you could set a non NULL .ndo_features_check based on a preprocessor condit=
ion

#if MAX_SKB_FRAGS + 2 > MAX_TX_WQE_SGL_ENTRIES
    .ndo_features_check =3D ....
#endif

This would avoid an expensive indirect call when possible.


>         .ndo_start_xmit         =3D mana_start_xmit,
>         .ndo_validate_addr      =3D eth_validate_addr,
>         .ndo_get_stats64        =3D mana_get_stats64,
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index a1afa75a9463..fa5e1a2f06a9 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -71,6 +71,8 @@ static const struct mana_stats_desc mana_eth_stats[] =
=3D {
>         {"tx_cq_err", offsetof(struct mana_ethtool_stats, tx_cqe_err)},
>         {"tx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
>                                         tx_cqe_unknown_type)},
> +       {"linear_pkt_tx_cnt", offsetof(struct mana_ethtool_stats,
> +                                       linear_pkt_tx_cnt)},
>         {"rx_coalesced_err", offsetof(struct mana_ethtool_stats,
>                                         rx_coalesced_err)},
>         {"rx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index 637f42485dba..84614ebe0f4c 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -592,6 +592,9 @@ enum {
>  #define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
>  #define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
>
> +/* Driver supports linearizing the skb when num_sge exceeds hardware lim=
it */
> +#define GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE BIT(20)
> +
>  #define GDMA_DRV_CAP_FLAGS1 \
>         (GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
>          GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
> @@ -601,7 +604,8 @@ enum {
>          GDMA_DRV_CAP_FLAG_1_DYNAMIC_IRQ_ALLOC_SUPPORT | \
>          GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE | \
>          GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE | \
> -        GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE)
> +        GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE | \
> +        GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE)
>
>  #define GDMA_DRV_CAP_FLAGS2 0
>
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 8906901535f5..50a532fb30d6 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -404,6 +404,7 @@ struct mana_ethtool_stats {
>         u64 hc_tx_err_gdma;
>         u64 tx_cqe_err;
>         u64 tx_cqe_unknown_type;
> +       u64 linear_pkt_tx_cnt;
>         u64 rx_coalesced_err;
>         u64 rx_cqe_unknown_type;
>  };
> --
> 2.43.0
>

