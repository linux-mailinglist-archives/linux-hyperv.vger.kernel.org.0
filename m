Return-Path: <linux-hyperv+bounces-8452-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBbfG6XMcWl1MQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8452-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 08:07:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CB062667
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 08:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B07164E0BF1
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 07:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F4237FF5F;
	Thu, 22 Jan 2026 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XWS3Ophr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1213D6460;
	Thu, 22 Jan 2026 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769065632; cv=none; b=Ync3Jw3fC7bHBYJ3DofRNTj4OxbIhs17r0PWL0wcb8Ld9j5KjeKDd8o3VsWlRruS7IcAUYZ1OHwxoBkSXd57xfzm7RebtCyjqXOOFbROALsnA3Cbdt1A5jIITQQ/txMaMqM+BbCBoGbJkGLuhbnxDDW/xhxZQ3KWprDGgGqKGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769065632; c=relaxed/simple;
	bh=FNwrdcWbmoEGb63NM/oRJ409z1sUphxn/NvzFK4Ha6s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwX4QTYjRB1o3rBtQXCKirEzEbztOwt8auF2/l5GOpWtsVsyJq8xGVVq1fYazW7VYskHcfsV3XPslQYonzE5E+zPN4DxEIk99RfWzqbx7JPHbgBdl4jcH9iC2OLSy0Xe1ou3k5LCdyfs+oKnWpQSIfbt9y0cFKFrMBomQYcdT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XWS3Ophr; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M4nGrX1525197;
	Wed, 21 Jan 2026 23:06:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XK6iZTmD7wkSfikXQayesYfE+
	N7UxH40eaMy0kZ8Yrg=; b=XWS3OphrlZGjSE2Nrluw5X0YmQYcmgLn8jW3UHBqB
	GRe2Aj1Shzr9KyVmcmg/w3bB0Z+FA6xwFlkfYr7H7P72lqUsmd/7Hostu+TtoRo8
	Fv8ioO/BoP3ITrxtxP5pukYl62fDlJ7EVW57KAqXi2+E9zFNbQ1BwPau+IWkln0/
	iWFd40atttRniqhOIMB3MEWmJXS7RGlcM51Wdcn+qi9re2FH2Wc35L0FAYEwMQub
	JwT6O0QiKWOFnw6S2BGIlfFE/P+iNT6C0c+dZWk+hVJfXJr1ETnz3jNLlGEhFNlf
	VotKkHP8yeSLVCebMMtzd3cdDvKc3Y+N3OX68xJc+q0Hw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4btm3kkkm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 23:06:39 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 Jan 2026 23:06:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 21 Jan 2026 23:06:53 -0800
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 0DD303F70A9;
	Wed, 21 Jan 2026 23:06:31 -0800 (PST)
Date: Thu, 22 Jan 2026 12:36:31 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Breno Leitao <leitao@debian.org>
CC: Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna
	<sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur
	<somnath.kotur@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Igor Russkikh
	<irusskikh@marvell.com>,
        Simon Horman <horms@kernel.org>,
        "K. Y. Srinivasan"
	<kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>,
        Alexander Duyck <alexanderduyck@fb.com>, <kernel-team@meta.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Brett Creeley
	<brett.creeley@amd.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <oss-drivers@corigine.com>,
        <linux-hyperv@vger.kernel.org>, <linux-net-drivers@amd.com>
Subject: Re: [PATCH net-next 4/9] net: mana: convert to use .get_rx_ring_count
Message-ID: <20260122070631.GB1544290@kernel-ep2>
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
 <20260121-grxring_big_v4-v1-4-07655be56bcf@debian.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260121-grxring_big_v4-v1-4-07655be56bcf@debian.org>
X-Proofpoint-ORIG-GUID: uKIwITwRmMjYlCTactKF_MrE_-fcI4GX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA0NCBTYWx0ZWRfX6rlwGfZifPyj
 kFxsRGLECkSjljY6LAUTFJp1UD3/Fpmk9fsilYePWIzmPpJVSxrXCIlMojdiK/cmeD445cistiX
 FpuaqN59Xt3MNWcM+wyVPCFXPVDFDXtIOTTy5cITouvdzYiMaD3sH7rGt6zHcoYE8y+ykzsPW8w
 QeYx05Rupp6cv2Qx0JlDo7OOtqRqD4lUPCjmPaL13VJ54vvIbJeM2Q+s+//POXkzXYGNWcXuZpn
 POJseJoD2VIGwOqvjoE5jfPPVKcrR9rRqIssHvLtJFTWkwHdMwIbwJWx3YQpCyitNv0Jb6F88Bu
 hTfkWWaJWa1fLAmqEDY9nobbekiWzj2RRpxyvfxpkdD9lodgmC2t7TUYZ6rAf+R6c5IDIo5UBon
 naQ0046odnDM2skw13GNW5cjaRP22EPyPGL1TNuoYBUseZJpR2M0C/2HGtUUqWeKCDauq+6qnVa
 aLeX9dsB6DT57cq2oWQ==
X-Authority-Analysis: v=2.4 cv=Mu1fKmae c=1 sm=1 tr=0 ts=6971cc7f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xNf9USuDAAAA:8 a=M5GUcnROAAAA:8 a=Iv6O2OiJiGMJj1fiuYwA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: uKIwITwRmMjYlCTactKF_MrE_-fcI4GX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8452-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com,vger.kernel.org,corigine.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[marvell.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E0CB062667
X-Rspamd-Action: no action

On 2026-01-21 at 21:24:41, Breno Leitao (leitao@debian.org) wrote:
> Use the newly introduced .get_rx_ring_count ethtool ops callback instead
> of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().
> 
> Since ETHTOOL_GRXRINGS was the only command handled by mana_get_rxnfc(),
> remove the function entirely.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep
> ---
>  drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index 0e2f4343ac67f..f2d220b371b5d 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -282,18 +282,11 @@ static void mana_get_ethtool_stats(struct net_device *ndev,
>  	}
>  }
>  
> -static int mana_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *cmd,
> -			  u32 *rules)
> +static u32 mana_get_rx_ring_count(struct net_device *ndev)
>  {
>  	struct mana_port_context *apc = netdev_priv(ndev);
>  
> -	switch (cmd->cmd) {
> -	case ETHTOOL_GRXRINGS:
> -		cmd->data = apc->num_queues;
> -		return 0;
> -	}
> -
> -	return -EOPNOTSUPP;
> +	return apc->num_queues;
>  }
>  
>  static u32 mana_get_rxfh_key_size(struct net_device *ndev)
> @@ -520,7 +513,7 @@ const struct ethtool_ops mana_ethtool_ops = {
>  	.get_ethtool_stats	= mana_get_ethtool_stats,
>  	.get_sset_count		= mana_get_sset_count,
>  	.get_strings		= mana_get_strings,
> -	.get_rxnfc		= mana_get_rxnfc,
> +	.get_rx_ring_count	= mana_get_rx_ring_count,
>  	.get_rxfh_key_size	= mana_get_rxfh_key_size,
>  	.get_rxfh_indir_size	= mana_rss_indir_size,
>  	.get_rxfh		= mana_get_rxfh,
> 
> -- 
> 2.47.3
> 

