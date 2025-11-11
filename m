Return-Path: <linux-hyperv+bounces-7489-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41CC4B636
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 05:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BD1A34DD08
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Nov 2025 04:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51222068A;
	Tue, 11 Nov 2025 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fK+/gHvx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4DB20ED;
	Tue, 11 Nov 2025 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833664; cv=none; b=ICve0a1wcJwTkWN9Mey2fcVB83mPsBp3t2jPN6k05zjtIzJUDqRpu1SNb6xEL97ZLr+GTLb32RNYORljVSeo2EG5meewbRhFojO6vesGvxhCDDHoM4RLGkOXt/UgKzCXxESURMoEROEz40dqoqXGna0X2wxxbCFZQPpFAn9nBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833664; c=relaxed/simple;
	bh=ggSgjAcoNf7FxKfZiKtIwpW5SQUWLlQNX1+T5IszGgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoCLXbXXaO7F/8HJWO+BKPA9jfeitz0nyq5gXmi9TLsUBsVhpffcfb7pwfLnz6szfAOBHEkqI28h1S1iXLxAgUzp95ezyFRqmsPgZiM7KvBW+0qDJD/oevp6PZB+gI3vDTOETGocQcJzYuBsxzgMwwhhyXOF2xA1I+JSUlYjJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fK+/gHvx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 0273F212AE23; Mon, 10 Nov 2025 20:01:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0273F212AE23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762833661;
	bh=fQdRoB1FdK12L43euj9oIv38cdQLrb5d46fVsXFtj1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fK+/gHvxNJu7T5HhRbJCFIlVxhYY8xIcnsSxwIL8xghRqfaf1xN1oT1cNPbvQBtwY
	 ZaB1wapQqiYTo6VNywWhtZz5unWpMQJ5LZDFZ1tj3NHlPLoQ8OoJvd2d/r449MbkxX
	 QbUUgsmDbelS+6AzKMFG2U6qHljrUsEqsKkjnlhA=
Date: Mon, 10 Nov 2025 20:01:00 -0800
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
	rosenp@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: mana: Refactor GF stats to use
 global mana_context
Message-ID: <20251111040100.GA3548@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1761734272-32055-1-git-send-email-ernis@linux.microsoft.com>
 <1761734272-32055-2-git-send-email-ernis@linux.microsoft.com>
 <20251031160632.41c1167f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031160632.41c1167f@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Oct 31, 2025 at 04:06:32PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 03:37:51 -0700 Erni Sri Satya Vennela wrote:
> > Refactor mana_query_gf_stats() to use mana_context instead of per-port,
> > enabling single query for all VFs.
> 
> What does "single query for all VFs" mean?
> All types? All within the host?

Considering the case where there are multiple ports for a single VF,
the details of the Hardware Counters (HC) requested from the hardware
is same across all ports. That is why we have moved the those stats from
mana_port_context (port) to mana_context (VF). I will reframe the commit
message for more readability.
> 
> Coincidentally I don't know what HC and GF stand for.
> Please explain things in more detail, all atypical acronyms 
> (for *Linux* networking).
> 

HC stands for Hardware Counters and MANA_QUERY_GF_STAT is a hardware
command code for GDMA tx LSO packets and bytes count. I will mention it
clearly in the next version.

> > Isolate hardware counter stats by introducing mana_ethtool_hc_stats
> > in mana_context and update the code to ensure all stats are properly
> > reported via ethtool -S <interface>, maintaining consistency with
> > previous behavior.
> 
> > -void mana_query_gf_stats(struct mana_port_context *apc)
> > +void mana_query_gf_stats(struct mana_context *ac)
> >  {
> >  	struct mana_query_gf_stat_resp resp = {};
> >  	struct mana_query_gf_stat_req req = {};
> > -	struct net_device *ndev = apc->ndev;
> > +	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> 
> reverse xmas tree, please
> 
Thanks for pointing out. I will make this change in next version.
> > +	struct device *dev = gc->dev;
> >  	int err;

