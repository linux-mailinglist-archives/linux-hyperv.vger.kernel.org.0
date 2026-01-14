Return-Path: <linux-hyperv+bounces-8286-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BECFD1C9B0
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 06:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77A763015A61
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423B636BCDB;
	Wed, 14 Jan 2026 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FS0EMyxR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEBE26F2A0;
	Wed, 14 Jan 2026 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768369390; cv=none; b=EYj+Xp+FZXg+XgRTj9hcxhSDXUqbYP8ya5tADeWjggimRj6w7DJoUjFw8DVC2avJ4mrMuXdbgO5BVTJpHamYTbslP0x3j0KDtu8iNkspSXYNwL9L93GOXAAZM9Di7OQYtL4bus9GUJXxb4SftRDMpl17ECRqG28YdAywMdEoGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768369390; c=relaxed/simple;
	bh=5gneT4avDBaAjJASzdafuGD9edH37MEpKMTVuWAV0HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncHI8QTnZDzBQY7oBiLtLBLamyr0BI4lHZltwhjXWGCdt8gZ2EkUem4jfsss3RztjYzF/aze4aFyla9R8Xqk11pwYRYt2THppJJ6OgNINaLY9gW1cnDupf7EEB/9jrwmyraL2iw317i0/Tbf4irhWTJevuL0xNfFD8WDRxbrjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FS0EMyxR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id A409C20B7165; Tue, 13 Jan 2026 21:42:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A409C20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768369377;
	bh=Sr3EwguiZ7rnzBT9kyqyjdd2T+A8Jy9vBncHTZo6nPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FS0EMyxRNTk3PruKcFK0pNfOa2k5CeKaDNCSxBUwh8We9s5Wg6aEN+NZBDO77mzOq
	 r/eCIuwXXBQKQ3eg7xlqPq/GqqgGm/OPr6anyCMiL1jUxif13IkRcbnVmSsa0w8fpX
	 uXrLv1m4rcaRh9f7+Gl9X63NDO1C93unQt2F6ypA=
Date: Tue, 13 Jan 2026 21:42:57 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dipayanroy@linux.microsoft.com,
	ssengar@linux.microsoft.com, shirazsaleem@microsoft.com,
	shradhagupta@linux.microsoft.com, gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: Add MAC address to vPort logs and
 clarify error messages
Message-ID: <aWcs4WjjGOhIaP1M@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260113052458.25338-1-ernis@linux.microsoft.com>
 <aWXqMC3C4rcdKjD0@test-OptiPlex-Tower-Plus-7010>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWXqMC3C4rcdKjD0@test-OptiPlex-Tower-Plus-7010>

On Tue, Jan 13, 2026 at 12:16:08PM +0530, Hariprasad Kelam wrote:
> On 2026-01-13 at 10:54:58, Erni Sri Satya Vennela (ernis@linux.microsoft.com) wrote:
> > Add MAC address to vPort configuration success message and update error
> > message to be more specific about HWC message errors in
> > mana_send_request.
> > 
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/net/ethernet/microsoft/mana/hw_channel.c | 12 +++++++-----
> >  drivers/net/ethernet/microsoft/mana/mana_en.c    |  8 ++++----
> >  2 files changed, 11 insertions(+), 9 deletions(-)
> >
> Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
>  

Thanks for the reviews. Based on additional feedback, I will be
preparing a v2 of this patch with further changes.  
Kindly hold off on merging this version.

- Vennela

