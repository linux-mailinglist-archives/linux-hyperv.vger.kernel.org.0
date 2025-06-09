Return-Path: <linux-hyperv+bounces-5813-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CDAD2362
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 18:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBDE3ACE44
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Jun 2025 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1B21772D;
	Mon,  9 Jun 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FIflxrVI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E523182BD;
	Mon,  9 Jun 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485283; cv=none; b=P2rXDfqEBmy3wHUMfV7S9AtkBTzFJmP6r9LKBQMyP8E9ZNwGL+mmQfwqsjrm0LSvxefrchj8AH+dJns5TUs3/+FzxGEfprOF2TvZQiCD9pwGI6JPiDQE0EdEhufnlOpak05kJBJBqacm3boQxl/SaxPvXtfHWkP9zDbmhqM1aSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485283; c=relaxed/simple;
	bh=bHGO7vOz2RwAtGEmIC8y9DzhoZqgiMmowHh6ZZnvP8o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWrm+sRCC6ZzTRyRG3gD7GIRBLp6phUxdeOuFNbfIK472LcDVWotNy53QfCaMfhZJYKnJmvJEHBa79TzOEeNSmrZteUFnurPmI6B0HwhfOiv/jo1mdpusKOLtM/OWb8wYTxaLKg+QUTw8IOOrsrRIhw4f2xWAn/zKpuCpAs9z/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FIflxrVI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559DtXGO022481;
	Mon, 9 Jun 2025 09:07:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=TzxfKiytMsOsQRAyd/OKddXk/
	Xu5Sq6F3ojipSUtVXY=; b=FIflxrVIXEDjTyR7ma6jqwYvm7D93aME6dUFC7kLj
	mLn3wV+kS7x3z/nmfxfHAqWXW81lNqSDHfVA/0K/5sMqw6mSXrh5gww5LKrT7MZo
	yYo4d3HxByVeV+RP27dHtJo8yV+U0XQZ+GvGf4WT0+wfbrxiFNwnC5kB5erYU3uH
	AtxziTiDyrFmoEF4w88fH4a4uCHRFfnHrnia7VZ9UL13Ni9Qy82Ffh0WrshG606M
	3YTa1aWDUDVDYAc9RVM1bIeyASldcSSzalnCD4TXz+LCDEygQWH1RKqAHdN4fPU9
	qeQhO/OF41uh/yAjTZl4loBfqve7db5ubcB97WTdfAhbQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4760x2g9u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 09:07:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 09:07:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 09:07:45 -0700
Received: from 64799e4f873a (unknown [10.28.168.138])
	by maili.marvell.com (Postfix) with SMTP id 92D663F704D;
	Mon,  9 Jun 2025 09:07:38 -0700 (PDT)
Date: Mon, 9 Jun 2025 16:07:37 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
CC: <andrew+net@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
        <longli@microsoft.com>, <kotaranov@microsoft.com>, <horms@kernel.org>,
        <mhklinux@outlook.com>, <ernis@linux.microsoft.com>,
        <dipayanroy@microsoft.com>, <schakrabarti@linux.microsoft.com>,
        <rosenp@gmail.com>, <linux-hyperv@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] net: mana: Expose additional hardware counters for drop
 and TC via ethtool.
Message-ID: <aEcGyUepZMLydsux@64799e4f873a>
References: <20250609100103.GA7102@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250609100103.GA7102@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Proofpoint-GUID: q3ukxHEhbYP12uG64zKQ8xxIbRTo3ZmG
X-Authority-Analysis: v=2.4 cv=dd2A3WXe c=1 sm=1 tr=0 ts=684706d3 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=yMhMjlubAAAA:8 a=M5GUcnROAAAA:8 a=kj1g1qYaxY35xbrHA0gA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: q3ukxHEhbYP12uG64zKQ8xxIbRTo3ZmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEyMCBTYWx0ZWRfX/veOys0qsqBA iAj1eg9SNExSHCFrB6Fo3Er4Pb/V83T31UNe30Lx9e6cuiXQlY47NWBc0GMrzt1IbonmMvEoUSy 0Zy1/jPoRtkfukHWw7iuLK/kOwmKWhbODQ/4TEA04VDGklIu2SJhg9cFv1+QhcS2NMTXxeHilRX
 u7Be9kVJEV8JbrGXMgIu2s3lT8EcyeOrW1z3j6YwcR3EUbSEHb6cE5mtAqNQEbl4fzC2OogC9h4 AJY9bDUA4u0C3D53uh3W/Nn+u4eyIiUzDSsCWuCdZsJVfSMZ4cbuJn4Uk22aoeOEJOxg35n5Cyc CA2narPXu/sdjq229S75UBYdfJCe6lUfpFpNwEuq9eSammJMX3KlnbZQQjkatOc+eo+7tn6enyU
 +qc178wEtQJL/C48OSnreT1YHq20vSuV9MayGvaflVsxpVvtmNuEfG0CblcCUi90Hb6cloHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01

On 2025-06-09 at 10:01:03, Dipayaan Roy (dipayanroy@linux.microsoft.com) wrote:
> Add support for reporting additional hardware counters for drop and
> TC using the ethtool -S interface.
> 
> These counters include:
> 
> - Aggregate Rx/Tx drop counters
> - Per-TC Rx/Tx packet counters
> - Per-TC Rx/Tx byte counters
> - Per-TC Rx/Tx pause frame counters
> 
> The counters are exposed using ethtool_ops->get_ethtool_stats and
> ethtool_ops->get_strings. This feature/counters are not available
> to all versions of hardware.
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

LGTM.

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

> ---
>  .../net/ethernet/microsoft/mana/hw_channel.c  |   6 +-
>  drivers/net/ethernet/microsoft/mana/mana_en.c |  87 +++++++++++-
>  .../ethernet/microsoft/mana/mana_ethtool.c    |  76 +++++++++-
>  include/net/mana/mana.h                       | 131 ++++++++++++++++++
>  4 files changed, 292 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 1ba49602089b..feb3b74700ed 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2021, Microsoft Corporation. */
>  
>  #include <net/mana/gdma.h>
> +#include <net/mana/mana.h>
>  #include <net/mana/hw_channel.h>
>  #include <linux/vmalloc.h>
>  
> @@ -871,8 +872,9 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  	}
>  
>  	if (ctx->status_code && ctx->status_code != GDMA_STATUS_MORE_ENTRIES) {
> -		dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
> -			ctx->status_code);
> +		if (req_msg->req.msg_type != MANA_QUERY_PHY_STAT)
> +			dev_err(hwc->dev, "HWC: Failed hw_channel req: 0x%x\n",
> +				ctx->status_code);
>  		err = -EPROTO;
>  		goto out;
>  	}
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9c58d9e0bbb5..d2b6e3f09ec2 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -774,8 +774,9 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
>  	err = mana_gd_send_request(gc, in_len, in_buf, out_len,
>  				   out_buf);
>  	if (err || resp->status) {
> -		dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
> -			err, resp->status);
> +		if (req->req.msg_type != MANA_QUERY_PHY_STAT)
> +			dev_err(dev, "Failed to send mana message: %d, 0x%x\n",
> +				err, resp->status);
>  		return err ? err : -EPROTO;
>  	}
>  
> @@ -2611,6 +2612,88 @@ void mana_query_gf_stats(struct mana_port_context *apc)
>  	apc->eth_stats.hc_tx_err_gdma = resp.tx_err_gdma;
>  }
>  
> +void mana_query_phy_stats(struct mana_port_context *apc)
> +{
> +	struct mana_query_phy_stat_resp resp = {};
> +	struct mana_query_phy_stat_req req = {};
> +	struct net_device *ndev = apc->ndev;
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_PHY_STAT,
> +			     sizeof(req), sizeof(resp));
> +	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
> +				sizeof(resp));
> +	if (err)
> +		return;
> +
> +	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_PHY_STAT,
> +				   sizeof(resp));
> +	if (err || resp.hdr.status) {
> +		netdev_err(ndev,
> +			   "Failed to query PHY stats: %d, resp:0x%x\n",
> +				err, resp.hdr.status);
> +		return;
> +	}
> +
> +	/* Aggregate drop counters */
> +	apc->phy_stats.rx_pkt_drop_phy = resp.rx_pkt_drop_phy;
> +	apc->phy_stats.tx_pkt_drop_phy = resp.tx_pkt_drop_phy;
> +
> +	/* Per TC traffic Counters */
> +	apc->phy_stats.rx_pkt_tc0_phy = resp.rx_pkt_tc0_phy;
> +	apc->phy_stats.tx_pkt_tc0_phy = resp.tx_pkt_tc0_phy;
> +	apc->phy_stats.rx_pkt_tc1_phy = resp.rx_pkt_tc1_phy;
> +	apc->phy_stats.tx_pkt_tc1_phy = resp.tx_pkt_tc1_phy;
> +	apc->phy_stats.rx_pkt_tc2_phy = resp.rx_pkt_tc2_phy;
> +	apc->phy_stats.tx_pkt_tc2_phy = resp.tx_pkt_tc2_phy;
> +	apc->phy_stats.rx_pkt_tc3_phy = resp.rx_pkt_tc3_phy;
> +	apc->phy_stats.tx_pkt_tc3_phy = resp.tx_pkt_tc3_phy;
> +	apc->phy_stats.rx_pkt_tc4_phy = resp.rx_pkt_tc4_phy;
> +	apc->phy_stats.tx_pkt_tc4_phy = resp.tx_pkt_tc4_phy;
> +	apc->phy_stats.rx_pkt_tc5_phy = resp.rx_pkt_tc5_phy;
> +	apc->phy_stats.tx_pkt_tc5_phy = resp.tx_pkt_tc5_phy;
> +	apc->phy_stats.rx_pkt_tc6_phy = resp.rx_pkt_tc6_phy;
> +	apc->phy_stats.tx_pkt_tc6_phy = resp.tx_pkt_tc6_phy;
> +	apc->phy_stats.rx_pkt_tc7_phy = resp.rx_pkt_tc7_phy;
> +	apc->phy_stats.tx_pkt_tc7_phy = resp.tx_pkt_tc7_phy;
> +
> +	/* Per TC byte Counters */
> +	apc->phy_stats.rx_byte_tc0_phy = resp.rx_byte_tc0_phy;
> +	apc->phy_stats.tx_byte_tc0_phy = resp.tx_byte_tc0_phy;
> +	apc->phy_stats.rx_byte_tc1_phy = resp.rx_byte_tc1_phy;
> +	apc->phy_stats.tx_byte_tc1_phy = resp.tx_byte_tc1_phy;
> +	apc->phy_stats.rx_byte_tc2_phy = resp.rx_byte_tc2_phy;
> +	apc->phy_stats.tx_byte_tc2_phy = resp.tx_byte_tc2_phy;
> +	apc->phy_stats.rx_byte_tc3_phy = resp.rx_byte_tc3_phy;
> +	apc->phy_stats.tx_byte_tc3_phy = resp.tx_byte_tc3_phy;
> +	apc->phy_stats.rx_byte_tc4_phy = resp.rx_byte_tc4_phy;
> +	apc->phy_stats.tx_byte_tc4_phy = resp.tx_byte_tc4_phy;
> +	apc->phy_stats.rx_byte_tc5_phy = resp.rx_byte_tc5_phy;
> +	apc->phy_stats.tx_byte_tc5_phy = resp.tx_byte_tc5_phy;
> +	apc->phy_stats.rx_byte_tc6_phy = resp.rx_byte_tc6_phy;
> +	apc->phy_stats.tx_byte_tc6_phy = resp.tx_byte_tc6_phy;
> +	apc->phy_stats.rx_byte_tc7_phy = resp.rx_byte_tc7_phy;
> +	apc->phy_stats.tx_byte_tc7_phy = resp.tx_byte_tc7_phy;
> +
> +	/* Per TC pause Counters */
> +	apc->phy_stats.rx_pause_tc0_phy = resp.rx_pause_tc0_phy;
> +	apc->phy_stats.tx_pause_tc0_phy = resp.tx_pause_tc0_phy;
> +	apc->phy_stats.rx_pause_tc1_phy = resp.rx_pause_tc1_phy;
> +	apc->phy_stats.tx_pause_tc1_phy = resp.tx_pause_tc1_phy;
> +	apc->phy_stats.rx_pause_tc2_phy = resp.rx_pause_tc2_phy;
> +	apc->phy_stats.tx_pause_tc2_phy = resp.tx_pause_tc2_phy;
> +	apc->phy_stats.rx_pause_tc3_phy = resp.rx_pause_tc3_phy;
> +	apc->phy_stats.tx_pause_tc3_phy = resp.tx_pause_tc3_phy;
> +	apc->phy_stats.rx_pause_tc4_phy = resp.rx_pause_tc4_phy;
> +	apc->phy_stats.tx_pause_tc4_phy = resp.tx_pause_tc4_phy;
> +	apc->phy_stats.rx_pause_tc5_phy = resp.rx_pause_tc5_phy;
> +	apc->phy_stats.tx_pause_tc5_phy = resp.tx_pause_tc5_phy;
> +	apc->phy_stats.rx_pause_tc6_phy = resp.rx_pause_tc6_phy;
> +	apc->phy_stats.tx_pause_tc6_phy = resp.tx_pause_tc6_phy;
> +	apc->phy_stats.rx_pause_tc7_phy = resp.rx_pause_tc7_phy;
> +	apc->phy_stats.tx_pause_tc7_phy = resp.tx_pause_tc7_phy;
> +}
> +
>  static int mana_init_port(struct net_device *ndev)
>  {
>  	struct mana_port_context *apc = netdev_priv(ndev);
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index c419626073f5..4fb3a04994a2 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -7,10 +7,12 @@
>  
>  #include <net/mana/mana.h>
>  
> -static const struct {
> +struct mana_stats_desc {
>  	char name[ETH_GSTRING_LEN];
>  	u16 offset;
> -} mana_eth_stats[] = {
> +};
> +
> +static const struct mana_stats_desc mana_eth_stats[] = {
>  	{"stop_queue", offsetof(struct mana_ethtool_stats, stop_queue)},
>  	{"wake_queue", offsetof(struct mana_ethtool_stats, wake_queue)},
>  	{"hc_rx_discards_no_wqe", offsetof(struct mana_ethtool_stats,
> @@ -75,6 +77,59 @@ static const struct {
>  					rx_cqe_unknown_type)},
>  };
>  
> +static const struct mana_stats_desc mana_phy_stats[] = {
> +	{ "hc_rx_pkt_drop_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_drop_phy) },
> +	{ "hc_tx_pkt_drop_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_drop_phy) },
> +	{ "hc_tc0_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc0_phy) },
> +	{ "hc_tc0_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc0_phy) },
> +	{ "hc_tc0_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc0_phy) },
> +	{ "hc_tc0_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc0_phy) },
> +	{ "hc_tc1_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc1_phy) },
> +	{ "hc_tc1_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc1_phy) },
> +	{ "hc_tc1_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc1_phy) },
> +	{ "hc_tc1_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc1_phy) },
> +	{ "hc_tc2_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc2_phy) },
> +	{ "hc_tc2_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc2_phy) },
> +	{ "hc_tc2_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc2_phy) },
> +	{ "hc_tc2_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc2_phy) },
> +	{ "hc_tc3_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc3_phy) },
> +	{ "hc_tc3_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc3_phy) },
> +	{ "hc_tc3_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc3_phy) },
> +	{ "hc_tc3_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc3_phy) },
> +	{ "hc_tc4_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc4_phy) },
> +	{ "hc_tc4_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc4_phy) },
> +	{ "hc_tc4_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc4_phy) },
> +	{ "hc_tc4_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc4_phy) },
> +	{ "hc_tc5_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc5_phy) },
> +	{ "hc_tc5_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc5_phy) },
> +	{ "hc_tc5_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc5_phy) },
> +	{ "hc_tc5_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc5_phy) },
> +	{ "hc_tc6_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc6_phy) },
> +	{ "hc_tc6_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc6_phy) },
> +	{ "hc_tc6_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc6_phy) },
> +	{ "hc_tc6_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc6_phy) },
> +	{ "hc_tc7_rx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, rx_pkt_tc7_phy) },
> +	{ "hc_tc7_rx_byte_phy", offsetof(struct mana_ethtool_phy_stats, rx_byte_tc7_phy) },
> +	{ "hc_tc7_tx_pkt_phy", offsetof(struct mana_ethtool_phy_stats, tx_pkt_tc7_phy) },
> +	{ "hc_tc7_tx_byte_phy", offsetof(struct mana_ethtool_phy_stats, tx_byte_tc7_phy) },
> +	{ "hc_tc0_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc0_phy) },
> +	{ "hc_tc0_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc0_phy) },
> +	{ "hc_tc1_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc1_phy) },
> +	{ "hc_tc1_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc1_phy) },
> +	{ "hc_tc2_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc2_phy) },
> +	{ "hc_tc2_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc2_phy) },
> +	{ "hc_tc3_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc3_phy) },
> +	{ "hc_tc3_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc3_phy) },
> +	{ "hc_tc4_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc4_phy) },
> +	{ "hc_tc4_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc4_phy) },
> +	{ "hc_tc5_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc5_phy) },
> +	{ "hc_tc5_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc5_phy) },
> +	{ "hc_tc6_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc6_phy) },
> +	{ "hc_tc6_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc6_phy) },
> +	{ "hc_tc7_rx_pause_phy", offsetof(struct mana_ethtool_phy_stats, rx_pause_tc7_phy) },
> +	{ "hc_tc7_tx_pause_phy", offsetof(struct mana_ethtool_phy_stats, tx_pause_tc7_phy) },
> +};
> +
>  static int mana_get_sset_count(struct net_device *ndev, int stringset)
>  {
>  	struct mana_port_context *apc = netdev_priv(ndev);
> @@ -83,8 +138,8 @@ static int mana_get_sset_count(struct net_device *ndev, int stringset)
>  	if (stringset != ETH_SS_STATS)
>  		return -EINVAL;
>  
> -	return ARRAY_SIZE(mana_eth_stats) + num_queues *
> -				(MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
> +	return ARRAY_SIZE(mana_eth_stats) + ARRAY_SIZE(mana_phy_stats) +
> +			num_queues * (MANA_STATS_RX_COUNT + MANA_STATS_TX_COUNT);
>  }
>  
>  static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
> @@ -99,6 +154,9 @@ static void mana_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
>  	for (i = 0; i < ARRAY_SIZE(mana_eth_stats); i++)
>  		ethtool_puts(&data, mana_eth_stats[i].name);
>  
> +	for (i = 0; i < ARRAY_SIZE(mana_phy_stats); i++)
> +		ethtool_puts(&data, mana_phy_stats[i].name);
> +
>  	for (i = 0; i < num_queues; i++) {
>  		ethtool_sprintf(&data, "rx_%d_packets", i);
>  		ethtool_sprintf(&data, "rx_%d_bytes", i);
> @@ -128,6 +186,7 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
>  	struct mana_port_context *apc = netdev_priv(ndev);
>  	unsigned int num_queues = apc->num_queues;
>  	void *eth_stats = &apc->eth_stats;
> +	void *phy_stats = &apc->phy_stats;
>  	struct mana_stats_rx *rx_stats;
>  	struct mana_stats_tx *tx_stats;
>  	unsigned int start;
> @@ -151,9 +210,18 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
>  	/* we call mana function to update stats from GDMA */
>  	mana_query_gf_stats(apc);
>  
> +	/* We call this mana function to get the phy stats from GDMA and includes
> +	 * aggregate tx/rx drop counters, Per-TC(Traffic Channel) tx/rx and pause
> +	 * counters.
> +	 */
> +	mana_query_phy_stats(apc);
> +
>  	for (q = 0; q < ARRAY_SIZE(mana_eth_stats); q++)
>  		data[i++] = *(u64 *)(eth_stats + mana_eth_stats[q].offset);
>  
> +	for (q = 0; q < ARRAY_SIZE(mana_phy_stats); q++)
> +		data[i++] = *(u64 *)(phy_stats + mana_phy_stats[q].offset);
> +
>  	for (q = 0; q < num_queues; q++) {
>  		rx_stats = &apc->rxqs[q]->stats;
>  
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 38238c1d00bf..be6d5e878321 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -404,6 +404,65 @@ struct mana_ethtool_stats {
>  	u64 rx_cqe_unknown_type;
>  };
>  
> +struct mana_ethtool_phy_stats {
> +	/* Drop Counters */
> +	u64 rx_pkt_drop_phy;
> +	u64 tx_pkt_drop_phy;
> +
> +	/* Per TC traffic Counters */
> +	u64 rx_pkt_tc0_phy;
> +	u64 tx_pkt_tc0_phy;
> +	u64 rx_pkt_tc1_phy;
> +	u64 tx_pkt_tc1_phy;
> +	u64 rx_pkt_tc2_phy;
> +	u64 tx_pkt_tc2_phy;
> +	u64 rx_pkt_tc3_phy;
> +	u64 tx_pkt_tc3_phy;
> +	u64 rx_pkt_tc4_phy;
> +	u64 tx_pkt_tc4_phy;
> +	u64 rx_pkt_tc5_phy;
> +	u64 tx_pkt_tc5_phy;
> +	u64 rx_pkt_tc6_phy;
> +	u64 tx_pkt_tc6_phy;
> +	u64 rx_pkt_tc7_phy;
> +	u64 tx_pkt_tc7_phy;
> +
> +	u64 rx_byte_tc0_phy;
> +	u64 tx_byte_tc0_phy;
> +	u64 rx_byte_tc1_phy;
> +	u64 tx_byte_tc1_phy;
> +	u64 rx_byte_tc2_phy;
> +	u64 tx_byte_tc2_phy;
> +	u64 rx_byte_tc3_phy;
> +	u64 tx_byte_tc3_phy;
> +	u64 rx_byte_tc4_phy;
> +	u64 tx_byte_tc4_phy;
> +	u64 rx_byte_tc5_phy;
> +	u64 tx_byte_tc5_phy;
> +	u64 rx_byte_tc6_phy;
> +	u64 tx_byte_tc6_phy;
> +	u64 rx_byte_tc7_phy;
> +	u64 tx_byte_tc7_phy;
> +
> +	/* Per TC pause Counters */
> +	u64 rx_pause_tc0_phy;
> +	u64 tx_pause_tc0_phy;
> +	u64 rx_pause_tc1_phy;
> +	u64 tx_pause_tc1_phy;
> +	u64 rx_pause_tc2_phy;
> +	u64 tx_pause_tc2_phy;
> +	u64 rx_pause_tc3_phy;
> +	u64 tx_pause_tc3_phy;
> +	u64 rx_pause_tc4_phy;
> +	u64 tx_pause_tc4_phy;
> +	u64 rx_pause_tc5_phy;
> +	u64 tx_pause_tc5_phy;
> +	u64 rx_pause_tc6_phy;
> +	u64 tx_pause_tc6_phy;
> +	u64 rx_pause_tc7_phy;
> +	u64 tx_pause_tc7_phy;
> +};
> +
>  struct mana_context {
>  	struct gdma_dev *gdma_dev;
>  
> @@ -474,6 +533,8 @@ struct mana_port_context {
>  
>  	struct mana_ethtool_stats eth_stats;
>  
> +	struct mana_ethtool_phy_stats phy_stats;
> +
>  	/* Debugfs */
>  	struct dentry *mana_port_debugfs;
>  };
> @@ -498,6 +559,7 @@ struct bpf_prog *mana_xdp_get(struct mana_port_context *apc);
>  void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
>  int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
>  void mana_query_gf_stats(struct mana_port_context *apc);
> +void mana_query_phy_stats(struct mana_port_context *apc);
>  int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
>  void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
>  
> @@ -524,6 +586,7 @@ enum mana_command_code {
>  	MANA_FENCE_RQ		= 0x20006,
>  	MANA_CONFIG_VPORT_RX	= 0x20007,
>  	MANA_QUERY_VPORT_CONFIG	= 0x20008,
> +	MANA_QUERY_PHY_STAT     = 0x2000c,
>  
>  	/* Privileged commands for the PF mode */
>  	MANA_REGISTER_FILTER	= 0x28000,
> @@ -686,6 +749,74 @@ struct mana_query_gf_stat_resp {
>  	u64 tx_err_gdma;
>  }; /* HW DATA */
>  
> +/* Query phy stats */
> +struct mana_query_phy_stat_req {
> +	struct gdma_req_hdr hdr;
> +	u64 req_stats;
> +}; /* HW DATA */
> +
> +struct mana_query_phy_stat_resp {
> +	struct gdma_resp_hdr hdr;
> +	u64 reported_stats;
> +
> +	/* Aggregate Drop Counters */
> +	u64 rx_pkt_drop_phy;
> +	u64 tx_pkt_drop_phy;
> +
> +	/* Per TC(Traffic class) traffic Counters */
> +	u64 rx_pkt_tc0_phy;
> +	u64 tx_pkt_tc0_phy;
> +	u64 rx_pkt_tc1_phy;
> +	u64 tx_pkt_tc1_phy;
> +	u64 rx_pkt_tc2_phy;
> +	u64 tx_pkt_tc2_phy;
> +	u64 rx_pkt_tc3_phy;
> +	u64 tx_pkt_tc3_phy;
> +	u64 rx_pkt_tc4_phy;
> +	u64 tx_pkt_tc4_phy;
> +	u64 rx_pkt_tc5_phy;
> +	u64 tx_pkt_tc5_phy;
> +	u64 rx_pkt_tc6_phy;
> +	u64 tx_pkt_tc6_phy;
> +	u64 rx_pkt_tc7_phy;
> +	u64 tx_pkt_tc7_phy;
> +
> +	u64 rx_byte_tc0_phy;
> +	u64 tx_byte_tc0_phy;
> +	u64 rx_byte_tc1_phy;
> +	u64 tx_byte_tc1_phy;
> +	u64 rx_byte_tc2_phy;
> +	u64 tx_byte_tc2_phy;
> +	u64 rx_byte_tc3_phy;
> +	u64 tx_byte_tc3_phy;
> +	u64 rx_byte_tc4_phy;
> +	u64 tx_byte_tc4_phy;
> +	u64 rx_byte_tc5_phy;
> +	u64 tx_byte_tc5_phy;
> +	u64 rx_byte_tc6_phy;
> +	u64 tx_byte_tc6_phy;
> +	u64 rx_byte_tc7_phy;
> +	u64 tx_byte_tc7_phy;
> +
> +	/* Per TC(Traffic Class) pause Counters */
> +	u64 rx_pause_tc0_phy;
> +	u64 tx_pause_tc0_phy;
> +	u64 rx_pause_tc1_phy;
> +	u64 tx_pause_tc1_phy;
> +	u64 rx_pause_tc2_phy;
> +	u64 tx_pause_tc2_phy;
> +	u64 rx_pause_tc3_phy;
> +	u64 tx_pause_tc3_phy;
> +	u64 rx_pause_tc4_phy;
> +	u64 tx_pause_tc4_phy;
> +	u64 rx_pause_tc5_phy;
> +	u64 tx_pause_tc5_phy;
> +	u64 rx_pause_tc6_phy;
> +	u64 tx_pause_tc6_phy;
> +	u64 rx_pause_tc7_phy;
> +	u64 tx_pause_tc7_phy;
> +}; /* HW DATA */
> +
>  /* Configure vPort Rx Steering */
>  struct mana_cfg_rx_steer_req_v2 {
>  	struct gdma_req_hdr hdr;
> -- 
> 2.43.0
> 

