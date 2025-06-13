Return-Path: <linux-hyperv+bounces-5893-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E8AD88FA
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 12:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2700E3A231B
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949FA2D0283;
	Fri, 13 Jun 2025 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c+8hRoK/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3210E2DA77C;
	Fri, 13 Jun 2025 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809533; cv=none; b=SuybMGeF9IxqrTrYd4TVjI+3SVtqbzkGcdqQGumb9iQK22PWbm22Bbq08iRJXFbKqcWw/CKehtxNt2RjH06Hli0D3W4ip9cOhB6tprDgrJtm0DBZgRb83QO7gMSKMfWRPub00aGtRO7T2Q03++UEibmPJN8S6TkcR9IdVLbXmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809533; c=relaxed/simple;
	bh=RIRZzZgUWVrR2mMxKzbxRCWGhM59XIUzyjz4rJYDNyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKMZupcLGKREL9DJGtrOkWW72xqKR3B1kC7HRKmit2DQQ66DfNUPlz0INiSx4HeWicmyxb2W8uqiBug+aE8ann1xwI6kvKQYfXTuYs+cpHYytX8WApt3Z0ZDGP+svQtsrfQzsbrwhWZWKbQ3AeeuZkJ4z0sPJ/I5j4TOd5VkGkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c+8hRoK/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id BB3B8201C76D; Fri, 13 Jun 2025 03:12:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB3B8201C76D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749809531;
	bh=tezciobQ9ZNV1mFHszlpXD4UW+kRz9/XZRey1omT/HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+8hRoK/9Kt+znXrTryH7KH21fYg+C11I2nsdeZrpNGaJnL2Ct61sLutG5GvrIdFV
	 lSUJBX7kW8inSTM3GwElL06ATlZyYKhfqeXZeLl7beYY5OU2BPALDcWI6YWXVpX3tc
	 lN+etYM9UlMKcuFToyOHvuOf7odanUnmxK0Qcbbw=
Date: Fri, 13 Jun 2025 03:12:11 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kotaranov@microsoft.com, longli@microsoft.com, horms@kernel.org,
	shirazsaleem@microsoft.com, leon@kernel.org,
	shradhagupta@linux.microsoft.com, schakrabarti@linux.microsoft.com,
	rosenp@gmail.com, sdf@fomichev.me, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: mana: Handle unsupported HWC commands
Message-ID: <20250613101211.GB23310@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749631576-2517-1-git-send-email-ernis@linux.microsoft.com>
 <1749631576-2517-5-git-send-email-ernis@linux.microsoft.com>
 <20250611113539.GB4690@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611113539.GB4690@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jun 11, 2025 at 04:35:39AM -0700, Dipayaan Roy wrote:
> On Wed, Jun 11, 2025 at 01:46:16AM -0700, Erni Sri Satya Vennela wrote:
> > If any of the HWC commands are not recognized by the
> > underlying hardware, the hardware returns the response
> > header status of -1. Log the information using
> > netdev_info_once to avoid multiple error logs in dmesg.
> > 
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> >  drivers/net/ethernet/microsoft/mana/hw_channel.c |  4 ++++
> >  drivers/net/ethernet/microsoft/mana/mana_en.c    | 11 +++++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > index a8c4d8db75a5..70c3b57b1e75 100644
> > --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> > @@ -890,6 +890,10 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
> >  	}
> >  
> >  	if (ctx->status_code && ctx->status_code != GDMA_STATUS_MORE_ENTRIES) {
> > +		if (ctx->status_code == -1) {
> Minor comment: instead of == -1 could use some macro like GDMA_STATUS_CMD_UNSUPPORTED, rest LGTM.
Thankyou Dipayaan.
I'll define this macro and us it for the next version.
> 
> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

