Return-Path: <linux-hyperv+bounces-4210-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39836A4D3FB
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 07:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4A73AAA67
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 06:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7C1F4703;
	Tue,  4 Mar 2025 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ShSP2F4X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5FE1EF390;
	Tue,  4 Mar 2025 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070404; cv=none; b=Jxh4DbnNDgtIN/P9DrtGMaGr7l706/IpVE/bHDTjeXyGaTet9jiOcgEIEk/k9/x3HlRyIAOdShXMGqo37UQPC/PoQ2DvV3zBfWTM8iH9MwFcddaUW5M5QhTvZinsES9jPe1uUihx+XrxtN23wU+Rfm3B88er0LhFZWn5ekqX6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070404; c=relaxed/simple;
	bh=L6Kn7/pcyX4sixRSMwjPYfWPrrukaks09cKCzVtg2Ko=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS2xMXRETjDVsmxC0KsHXKZnId+YfcWLOghFYe12Yufuj24wxqm7LNzzogCOR5DUgb4DmwxvGe8qp5jeOXtvjXvpFjU98fF+u8fOZ5B+cdo3Tamd6FWpD4g48Wb4zH99tWKVQiXkDcgd3W1HTOkabWB21F5v4b+KUU/6S6FkpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ShSP2F4X; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523MkFcv014013;
	Mon, 3 Mar 2025 22:39:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=IN6vN4UD4bD2YhMl6yv2TFyow
	tG7VQ1DGZOuXkEAjjU=; b=ShSP2F4XfOkh487S+Hmq8lcGVdoa8yjC2EMxoZFJJ
	OVCFNeTUrL6RrZ7azqzNHctZUNBtgfK9YH60x1UCYsWPFYP1WS4v2GvY+hv3TthA
	xFlGiNB0HgilTFwgLFlrdgDctYdh1vn2chEIWu78i6XHhBxM0xQ58zu3nSiynXZ+
	He5qaARmyLiHcGWU0xMMQCU9k//L7sUpKZ3KgiRfUQIP4TKn8sJpMy+17uD0IIl8
	70CuRvWhWF1A8MK2Wo+P6gBr06EvbctFmIypXfwYwW2Et4cq6g0QLjpFkEM8zHrD
	RvnMbfTj4jZwlrSTydkIRiNjuwTPU3IgVXlJ1c3EG/M6g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 454qcfc89y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 22:39:47 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Mar 2025 22:39:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Mar 2025 22:39:45 -0800
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 042693F707B;
	Mon,  3 Mar 2025 22:39:41 -0800 (PST)
Date: Tue, 4 Mar 2025 12:09:40 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <longli@linuxonhyperv.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Konstantin Taranov <kotaranov@microsoft.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hyperv@vger.kernel.org>, Long Li
	<longli@microsoft.com>
Subject: Re: [Patch rdma-next] RDMA/mana_ib: handle net event for pointing to
 the current netdev
Message-ID: <20250304063940.GA2702870@maili.marvell.com>
References: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
X-Authority-Analysis: v=2.4 cv=VaMNPEp9 c=1 sm=1 tr=0 ts=67c6a033 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=KPitI-3vFcalBia9:21 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=Odnh0R2cAAAA:8 a=yMhMjlubAAAA:8 a=WLnx8VTwFErqAH7yV0kA:9
 a=CjuIK1q_8ugA:10 a=lNAA6UHySJB7qmBR1x20:22
X-Proofpoint-ORIG-GUID: TP3-lmfRf75I-umk3i7iCl3RY8Wv3Jv6
X-Proofpoint-GUID: TP3-lmfRf75I-umk3i7iCl3RY8Wv3Jv6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_03,2025-03-03_04,2024-11-22_01

On 2025-03-01 at 04:11:59, longli@linuxonhyperv.com (longli@linuxonhyperv.com) wrote:
> From: Long Li <longli@microsoft.com>
>
> When running under Hyper-V, the master device to the RDMA device is always
> bonded to this RDMA device if it's present in the kernel. This is not
> user-configurable.
>
> The master device can be unbind/bind from the kernel. During those events,
> the RDMA device should set to the current netdev to relect the change of
> master device from those events.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c  | 35 ++++++++++++++++++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h |  1 +
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index 3416a85f8738..3e4f069c2258 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -51,6 +51,37 @@ static const struct ib_device_ops mana_ib_dev_ops = {
>  			   ib_ind_table),
>  };
>
> +static int mana_ib_netdev_event(struct notifier_block *this,
> +				unsigned long event, void *ptr)
> +{
> +	struct mana_ib_dev *dev = container_of(this, struct mana_ib_dev, nb);
> +	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
> +	struct gdma_context *gc = dev->gdma_dev->gdma_context;
> +	struct mana_context *mc = gc->mana.driver_data;
> +	struct net_device *ndev;
> +
> +	if (event_dev != mc->ports[0])
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_CHANGEUPPER:
> +		rcu_read_lock();
> +		ndev = mana_get_primary_netdev_rcu(mc, 0);
> +		rcu_read_unlock();
...
> +
> +		/*
> +		 * RDMA core will setup GID based on updated netdev.
> +		 * It's not possible to race with the core as rtnl lock is being
> +		 * held.
> +		 */
> +		ib_device_set_netdev(&dev->ib_dev, ndev, 1);
rcu_read_unlock() should be here, right ?
> +
> +		return NOTIFY_OK;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}
> +
>

