Return-Path: <linux-hyperv+bounces-7210-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D48BD8772
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 11:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221FB425451
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 09:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39B02EA15B;
	Tue, 14 Oct 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oIWKabGz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322EE1EEA5F;
	Tue, 14 Oct 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434609; cv=none; b=jWTCmg9iQJ0lpMSUy6Mad5wVbzC889tt0AX6QBX59pYs4eScP02BEn2av6GEQLOfEIpCGEQW0tW0RSjjtmBFYOiuhk38T8b1qLThkdp3pHxKWLs8DNBFKFteRaj3xXmdeSrOcRDQWe21m3ztiSqD1Ni4z9v3Ty2ZHKasT3lWDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434609; c=relaxed/simple;
	bh=24O7h9rWvGgMsxnQdLUpRveoy5h5ZoeLDz3NEuTqhuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mlv1rpJ+UOSSWRNddnVp3rf+jjR+FgwredysM2LX0zdNNbws0ARC1HofJ3Lavu2dOdrViTse0jrJTXeHc8v/PCrpUdwJc0WscQgicDkqoH9kkY5MO7pSx2p8m8J2NkXypUA3i3scUNzX04BlMbIwuKRYyXkI0UuHZeVNHAdSflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oIWKabGz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 06F062065942; Tue, 14 Oct 2025 02:36:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06F062065942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760434602;
	bh=MBwTdbe27mXHcMuoOw/1Z42oFxN4IxBUhBsCMtRHFJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIWKabGzgzgoo6GcAJ3IK0DlsX/lXitrE1Kb+zXmVONcIATdcTbddbUgRM85tTbe8
	 gtBFJtJyvciTY72IxQ5jN+tR/w4qDCEQXDb/lu40n3VHqJa6IWMfOFzXfKJJYFqyhs
	 3neFN0pX2gpk48EIG99VTQldJTXn0hTGAmKXeXYI=
Date: Tue, 14 Oct 2025 02:36:41 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, longli@microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com, rosenp@gmail.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/2] net: mana: Add standard counter rx_missed_errors
Message-ID: <20251014093641.GA28893@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1757908698-16778-1-git-send-email-ernis@linux.microsoft.com>
 <1757908698-16778-3-git-send-email-ernis@linux.microsoft.com>
 <0b5b0d1d-438a-4e41-99c8-a6f61d7581b4@redhat.com>
 <20250925042405.GA5594@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925042405.GA5594@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Sep 24, 2025 at 09:24:05PM -0700, Erni Sri Satya Vennela wrote:
> On Tue, Sep 16, 2025 at 03:22:54PM +0200, Paolo Abeni wrote:
> > On 9/15/25 5:58 AM, Erni Sri Satya Vennela wrote:
> > > Report standard counter stats->rx_missed_errors
> > > using hc_rx_discards_no_wqe from the hardware.
> > > 
> > > Add a dedicated workqueue to periodically run
> > > mana_query_gf_stats every 2 seconds to get the latest
> > > info in eth_stats and define a driver capability flag
> > > to notify hardware of the periodic queries.
> > > 
> > > To avoid repeated failures and log flooding, the workqueue
> > > is not rescheduled if mana_query_gf_stats fails.
> > 
> > Can the failure root cause be a "transient" one? If so, this looks like
> > a dangerous strategy; is such scenario, AFAICS, stats will be broken
> > until the device is removed and re-probed.
> > 
> > /P
Hi Paolo,
I wanted to follow up on the clarification I shared regarding my
patch. Please let me know if there's anything further needed from my
side.

- Vennela

