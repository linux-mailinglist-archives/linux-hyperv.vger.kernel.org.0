Return-Path: <linux-hyperv+bounces-8169-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6DCFB4F0
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 00:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F3E83019BDD
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jan 2026 22:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B22F3C12;
	Tue,  6 Jan 2026 22:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Z4wmsdPY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301812D8391;
	Tue,  6 Jan 2026 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740392; cv=none; b=uqPcxpzWjuF65HSwCmQ0VOGy1r6D6+6Uv+QYa8UwXwWPUxX37RzaOhjs+/bpgXFKZW2xxV3IzLppfPozqaUS/1o5xb0lOC9UalEqjickA1eGsNrtiTp3ojO4Hjj74zHrP1TRRu+r3elKdLD8qoxvYCOYke6PXXaiy4dZOWNJnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740392; c=relaxed/simple;
	bh=U1H58QHhYdfGZ/Cu86pwVcLw4VPdnqlWJEDMxCAsft4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLsP27luQ/1ZeoTpufNTJSPfIfG5lXaYxBeciaOAInh0RKixdxs6v4XwCOHzjfG2sqnVLwblXG7D9JLJps4xTFZSiRzx8/O9tLmyFwaLASRqvompc/Up6XZqzCpmGkJyqIlo1TrP1aCpbxW3arOmB+QXNklDZllI86y/s8jUABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Z4wmsdPY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id AEACF2016FF9; Tue,  6 Jan 2026 14:59:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEACF2016FF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767740390;
	bh=THRVLoMZK7f2n4jbmsl/5riM7a1XGnPXbfvmvkCgp/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4wmsdPYMuj158pKn2D+GiXE0xpuI81rmoG3Lhuz15PJTyGn3hnAGw+BS2iRUvGJn
	 ARWEDLYY9A4cz75hS/WT6UfddNNDKAza/igvC6MprCvw+xixTb/1jE94l74rchmZ+c
	 U2aOgkbHUTf3JGbpt81PvdPD++h9NYyIFRVncnuI=
Date: Tue, 6 Jan 2026 14:59:50 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: Re: [PATCH net-next, v6] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20260106225950.GA11626@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260103045705.GA3757@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260105173056.7c2c9d0a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105173056.7c2c9d0a@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jan 05, 2026 at 05:30:56PM -0800, Jakub Kicinski wrote:
> On Fri, 2 Jan 2026 20:57:05 -0800 Dipayaan Roy wrote:
> > +		apc = netdev_priv(ndev);
> > +		disable_work_sync(&apc->queue_reset_work.work);
> 
> AI code review points out:
> 
>   In mana_remove(), disable_work_sync() is called for each port's
>   queue_reset_work. However, when resuming=true, mana_probe() creates a new
>   workqueue but does not call mana_probe_port() (which contains INIT_WORK),
>   and there is no enable_work() call for queue_reset_work in the resume path.
> 
>   The existing link_change_work handles this correctly: it is disabled in
>   mana_remove() and re-enabled with enable_work(&ac->link_change_work) in
>   mana_probe() when resuming=true.
> 
>   Should enable_work(&apc->queue_reset_work.work) be called for each port in
>   the resuming path of mana_probe(), similar to how link_change_work is
>   handled? Otherwise TX timeout recovery appears to remain disabled after a
>   suspend/resume cycle.
> -- 
> pw-bot: cr

Thanks Jakub for pointing this out. I will send out a new version.

Regards
Dipayaan Roy

