Return-Path: <linux-hyperv+bounces-3081-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441E4987709
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0713B2998C
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155C156C40;
	Thu, 26 Sep 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuc9xgGW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C6487B0;
	Thu, 26 Sep 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366168; cv=none; b=GS/Wj2iHxWJ7OCAQEGpGl/nF7e9esDK3F2CcSIfTNpQmHkHdfVN4EhT3Do9vaudenXqt2Jk/LkUxHNDgxLcLBcvQ+yQ3wGRx7zKCg6iYv0sB9TVLdNZPtK1P8FJrdJAo1mBuSrhPgbr6X5QdlfFb1gVXCasN51wG7oAntCue/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366168; c=relaxed/simple;
	bh=W3o4UdwDGbWXfuRQZvcQVe1PaIx2GxxUblx4oLUlYbY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSAA/FbZrV5NN/MJe2yu8dod9JmbdsW9xT6hHVBoGYnKaBgEtyc/ofLDdpsDFDnBJ0p34xjbd3QGjrJyHGx3VLfrSgFvFzrWUi+sZJy3TtzbnJm4Oi52Gk4JdoJGnoJMmGbVrJ/Xpdthuz0zs43FuTHsvC9gb7ITePOivhH6xVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuc9xgGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3066EC4CEC5;
	Thu, 26 Sep 2024 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727366167;
	bh=W3o4UdwDGbWXfuRQZvcQVe1PaIx2GxxUblx4oLUlYbY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=fuc9xgGWdy0vAlJ4N779kJKQhTv+jb/6fk3eU909QV3HqmfOsxwwO162WtXtFcYzI
	 li5tNFs9tiQ+qaMvJzKztNGTX7Df5g4UprD+ZhCdS+NNtluXdO80UR22SxCksPQx9Q
	 7pwwLMlv3vUEksoQyGkHRg5QXu4hN8C9h6iIB7IPjos8BqK9Ch0S2UwW0Fu/dFadM/
	 qFprV1r2+gk7ixvRiUpikcCMERKo1G2zI9KYoyba9Lc4QN2BmyBplaIrBq0CkObGLq
	 PVMt3v0CZC0SUFvl0hleBhQdup0qQqc3IMouhrQCReCGBFt0oR0vSQZSbzCH1engxg
	 k4KPw/9SOUyRg==
Date: Thu, 26 Sep 2024 16:56:03 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Message-ID: <20240926155603.GH4029621@kernel.org>
References: <20240924234851.42348-1-jdamato@fastly.com>
 <20240924234851.42348-2-jdamato@fastly.com>
 <20240926151024.GE4029621@kernel.org>
 <ZvWA6BjwVfYXnDcA@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvWA6BjwVfYXnDcA@LQ3V64L9R2>

On Thu, Sep 26, 2024 at 08:42:32AM -0700, Joe Damato wrote:
> On Thu, Sep 26, 2024 at 04:10:24PM +0100, Simon Horman wrote:
> > On Tue, Sep 24, 2024 at 11:48:51PM +0000, Joe Damato wrote:
> > > Use netif_queue_set_napi to link queues to NAPI instances so that they
> > > can be queried with netlink.
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
> > >  drivers/net/hyperv/rndis_filter.c |  9 +++++++--
> > >  2 files changed, 17 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > > index 2b6ec979a62f..ccaa4690dba0 100644
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -712,8 +712,11 @@ void netvsc_device_remove(struct hv_device *device)
> > >  	for (i = 0; i < net_device->num_chn; i++) {
> > >  		/* See also vmbus_reset_channel_cb(). */
> > >  		/* only disable enabled NAPI channel */
> > > -		if (i < ndev->real_num_rx_queues)
> > > +		if (i < ndev->real_num_rx_queues) {
> > > +			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX, NULL);
> > > +			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX, NULL);
> > 
> > Hi Joe,
> > 
> > When you post a non-RFC version of this patch, could you consider
> > line-wrapping the above to 80 columns, as is still preferred for
> > Networking code?
> > 
> > There is an option to checkpatch that will warn you about this.
> 
> Thanks for letting me know.
> 
> I run checkpatch.pl --strict and usually it seems to let me know if
> I am over 80, but maybe there's another option I need?

At some point the default changed from 80 to 100.
So these days --max-line-length=80 is needed to detect this.

--strict is also good :)

