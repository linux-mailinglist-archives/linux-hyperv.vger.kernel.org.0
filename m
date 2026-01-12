Return-Path: <linux-hyperv+bounces-8219-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13BFD12AA1
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 14:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 259FB304BCBA
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C6357A5E;
	Mon, 12 Jan 2026 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PBM75E9Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0DB1A9FB7;
	Mon, 12 Jan 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222759; cv=none; b=lSSs2YhzaQiQJpRxFyA0oKb1YpgrSy9hDPzE+yJ2kQgHgZda0Lj8EY7zXTvfD26UFHKORmJyw5G5a5wiyN2eSPnrt1In0oYdhUrxA7ccsUnxrQlIOyfCaHkpRzVpsK6XZ9fDkcwXFhFguKy6X0SIUtoqdbNJ7MosoY8sct5giC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222759; c=relaxed/simple;
	bh=iM9ySH1VudsAVsJxN3YO9yeXlcElpjQQLPymtIdEdiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/0ocw5FVBYEysZ34nXWZ8+9+BGmZC0PF708g+1HieOAXjmKk26i6yTRKmfXS2CTc/fjXOWe9138JXMOKPw4qu8rLEyuu3VOko/ohi6WK70uNTbElGh2G3krFfCnglB4zZXnGeJt04H3nzFzxICJbcB4gnD+VSPL3wKIYxkcpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PBM75E9Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id C21FB200D64E; Mon, 12 Jan 2026 04:59:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C21FB200D64E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768222757;
	bh=pj0DXsYF0cYZ/I5eNAIxHncu+iCcd64gU83LJP5fx6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBM75E9YGAxd/sHVitbxUm0dQRXqENj3bNEUdftv5R1/KNhVv+Xj3o1917WFP0h8I
	 S/fM/OORmuUDjVLcD/WIRUMpnL1sZeROZAWplhmIqd3qpkbeXRgqPFfu9UYh2NaYbJ
	 tSMwZUWh+Jq5p/6DFR8qw+GWNWk086kIenJmGiIE=
Date: Mon, 12 Jan 2026 04:59:17 -0800
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
Subject: Re: [PATCH net-next, v7] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20260112125917.GA10106@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260106230438.GA13125@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260109180209.023c50cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109180209.023c50cf@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

Fri, Jan 09, 2026 at 06:02:09PM -0800, Jakub Kicinski wrote:
> On Tue, 6 Jan 2026 15:04:38 -0800 Dipayaan Roy wrote:
> > +static void mana_per_port_queue_reset_work_handler(struct work_struct *work)
> > +{
> > +	struct mana_queue_reset_work *reset_queue_work =
> > +			container_of(work, struct mana_queue_reset_work, work);
> > +
> > +	struct mana_port_context *apc = container_of(reset_queue_work,
> > +						     struct mana_port_context,
> > +						     queue_reset_work);
> 
> > +struct mana_queue_reset_work {
> > +	/* Work structure */
> 
> Not sure what value this comment adds. Looks like something AI
> generator would add.
> 
> > +	struct work_struct work;
> > +};
> > +
> >  struct mana_port_context {
> >  	struct mana_context *ac;
> >  	struct net_device *ndev;
> > +	struct mana_queue_reset_work queue_reset_work;
> 
> Why did you wrap the work in another struct with just one member?
> It forces you to work thru two layers of container of.
> 
> Either way, container_of supports nested structs so I think something
> like:
> 
> 	struct mana_port_context *apc = container_of(work,
> 						     struct mana_port_context,
> 						     queue_reset_work.work);
> 
> should work (untested). But really, better to just delete the pointless
> nesting.
Thanks Jakub, I will remove the nesting and re-share a new patch after
testing.
> -- 
> pw-bot: cr

Regards
Dipayaan Roy

