Return-Path: <linux-hyperv+bounces-8451-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNoBEE3McWl1MQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8451-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 08:05:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1256264F
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 08:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8CDC505C35
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC85D477E4A;
	Thu, 22 Jan 2026 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NID9OANI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09D352C2D;
	Thu, 22 Jan 2026 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769065498; cv=none; b=AKGTZcCMwjnTxG58gZP5UWBocARpSP1tfCPRZAtv07PLJxAbPucDerPgf8k9I+EljpTLjIQaB5G7EnUl1m81LfDI1Iy5uHJGiqSHKSJvEcdVOB7ScV7d8zaxlyj91CzB2FU2Qd7ZucCPdnIcsSR/UVqMtz+5rqvrikPkGuQcUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769065498; c=relaxed/simple;
	bh=mxWYjMvpv/wLkUPpeVzRTXdp3zZyx554hqJjM61m+aI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syeL0FMAfn+lzfXosBtoeO/VJ/C1KCOFJaFxnMhiAOUgrWOkCpH7mQGG6Dgx5qyre0yOC3DiwZnCAedInL1xA3FyEt7RUyifb5wiaQuXb78jRPOleD5om1Tyee+nFT6m+8h/fZ8N2iuot4AW32QOwb3JaLvrlLq5mSrqlPKNIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NID9OANI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M6cHpI2555708;
	Wed, 21 Jan 2026 23:04:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=G2G5UQOOMy2sNF5++HpTO/hw0
	Waajb+7TIE8btadPvg=; b=NID9OANII6WvjemNSTEcXm3OGmhmS0KKZ6JithNmm
	jnGvykbOOO3s9gcP4i0H98k1qu3WCgrwmrafY+CvT8r6W5MqJ4w0JXbeIEh+TbZT
	IzlaDLRbNqR4lOibA9qlnuvrt6D4JXJzsD2Ug/JdfMbLaEGHC5lkkBU0xpw5uWB9
	K69q5ZStR/8kNkGiHdNIwZbpkzo11cFG9iHG1xFLrqbN/E6yRaqAzUS16FtMV+J6
	SJMLO3cLfK7t55Ld04RggO+L1/xGP84WFTgp6q5ERBh+rvs3V3MYVx75craD7T08
	NpNWPTWHDDEUojaXMSRDdIwefgHO2XDNDLaA/1uyUsWoQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4btm3kkkf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 23:04:11 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 Jan 2026 23:04:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 21 Jan 2026 23:04:10 -0800
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 9B2333F70A9;
	Wed, 21 Jan 2026 23:04:04 -0800 (PST)
Date: Thu, 22 Jan 2026 12:33:58 +0530
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
Subject: Re: [PATCH net-next 3/9] net: nfp: convert to use .get_rx_ring_count
Message-ID: <20260122070358.GA1544290@kernel-ep2>
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
 <20260121-grxring_big_v4-v1-3-07655be56bcf@debian.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260121-grxring_big_v4-v1-3-07655be56bcf@debian.org>
X-Proofpoint-ORIG-GUID: bA8yem6tnK4udOtG5se1FIZju3_EMhBu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA0NCBTYWx0ZWRfX2N95TYxkuBVc
 j5DrkIpzr6ImwuctufBJxLcn5PfANGHIvf2SM9Wevk3eJoKASrGoOnWN9Mm0ziAqJdG8VNjQLIR
 +Lla4wmNBOWSN/USuBZDEO7qeDK8ynNP77ivyI1Jotq8OqYksDFV4r/bpwupkDr3Kq2B5FBBCka
 RRqUd3SdwJ1zmtom0JbcK+ZW3RXsdTdbQDR0lWzVf7JGlR5Y2uGd+wAOqIyitt1jgYNdzoAjv7u
 HqCQiiqmqPyer+6LGJphMkXP1DI5eG1iVaoUSSIVg+49mY/x3llzmpMdC//RJu+teFj3tvuhofj
 FInWeorYOaiBqmWcRJ3UqVMCBxtYU2GS4KP0rsNFqfalDOOacIoEvg9Ko87yuAhg51neEG+L1Th
 QnSVyEY/OjKnIbhHxgVet9v3bQzecHvRartjTE+hW0GFSHbrTIVwQDtmpX8UOx28PrQ8LbjWlB7
 zAXsEhEQ7raLUBZ5vgQ==
X-Authority-Analysis: v=2.4 cv=Mu1fKmae c=1 sm=1 tr=0 ts=6971cbeb cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xNf9USuDAAAA:8 a=M5GUcnROAAAA:8 a=Ch7P9ck2AVfqCBIX_IQA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: bA8yem6tnK4udOtG5se1FIZju3_EMhBu
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
	TAGGED_FROM(0.00)[bounces-8451-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DD1256264F
X-Rspamd-Action: no action

On 2026-01-21 at 21:24:40, Breno Leitao (leitao@debian.org) wrote:
> Use the newly introduced .get_rx_ring_count ethtool ops callback instead
> of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> index 16c828dd5c1a3..e88b1c4732a57 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
> @@ -1435,15 +1435,19 @@ static int nfp_net_get_fs_loc(struct nfp_net *nn, u32 *rule_locs)
>  	return 0;
>  }
>  
> +static u32 nfp_net_get_rx_ring_count(struct net_device *netdev)
> +{
> +	struct nfp_net *nn = netdev_priv(netdev);
> +
> +	return nn->dp.num_rx_rings;
> +}
> +
>  static int nfp_net_get_rxnfc(struct net_device *netdev,
>  			     struct ethtool_rxnfc *cmd, u32 *rule_locs)
>  {
>  	struct nfp_net *nn = netdev_priv(netdev);
>  
>  	switch (cmd->cmd) {
> -	case ETHTOOL_GRXRINGS:
> -		cmd->data = nn->dp.num_rx_rings;
> -		return 0;
>  	case ETHTOOL_GRXCLSRLCNT:
>  		cmd->rule_cnt = nn->fs.count;
>  		return 0;
> @@ -2501,6 +2505,7 @@ static const struct ethtool_ops nfp_net_ethtool_ops = {
>  	.get_sset_count		= nfp_net_get_sset_count,
>  	.get_rxnfc		= nfp_net_get_rxnfc,
>  	.set_rxnfc		= nfp_net_set_rxnfc,
> +	.get_rx_ring_count	= nfp_net_get_rx_ring_count,
>  	.get_rxfh_indir_size	= nfp_net_get_rxfh_indir_size,
>  	.get_rxfh_key_size	= nfp_net_get_rxfh_key_size,
>  	.get_rxfh		= nfp_net_get_rxfh,
> 
> -- 
> 2.47.3
> 

