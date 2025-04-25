Return-Path: <linux-hyperv+bounces-5105-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DFAA9BE8C
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 08:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F84C467968
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C10522CBD8;
	Fri, 25 Apr 2025 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qlwB+0M2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14427228C99;
	Fri, 25 Apr 2025 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562213; cv=none; b=Cgq+aFHEeNq4a3IAdj1uSef1GmYZ9GhDaJv1Dm2Q9WoLEokxPQEfRPMOfM1mzw9ICoqfUebKwhpHH0eiDyd6eZh90pU+JYHs5vJV+wnpqOjUIwgDjwSwEPY2swiLy7gm35MEadGloDUx5Gmhvqfc4VZy22uOkzfLpA9AD2ElXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562213; c=relaxed/simple;
	bh=QPDGTxFftCHPShU566oWvkBvuos91+NRaQwQRMGkZSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwoJqDiNQYyPcUE6qGKtc2fa87ZS4q/pivGzkK1uOdiY4aMl8fJByfg8o4QSI6PckTvUGmSOebXHaBRIzct7oM59dRLvINA7c3Q6wxYf1USQIfyGCPL1wYPME6FkNHthrxt+mEt4zkJQQ5f0dhp+/mbXL+Jb1l5FDSse4A3GhDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qlwB+0M2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 7DFD72020941; Thu, 24 Apr 2025 23:23:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DFD72020941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745562205;
	bh=0ZyJIAePbWouwnT8HJWmkxXWwAJF6mz5d+QFGVvq6as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlwB+0M2w2wroMEcyM8sosAZs4qzf3go9Er6zX85Gb83d4l8dO7sGyp51ErdB5rZr
	 4YSfSYPRYJp5EyYM+gZ5r/xRufsdo72QAUou8LQ/FcFidbzqsjZx4OCk7tnIA6RHFR
	 3OmMgJKSIYQLVnL7dAkgQOzNEZ/B1jUJfXAvb8Wk=
Date: Thu, 24 Apr 2025 23:23:25 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, longli@microsoft.com, kotaranov@microsoft.com,
	kent.overstreet@linux.dev, brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, rosenp@gmail.com,
	paulros@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] net: mana: Add sched HTB offload support
Message-ID: <20250425062325.GA21110@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
 <1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
 <20250417081053.5b563a92@hermes.local>
 <20250417194727.GB10777@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250417170052.76e52039@kernel.org>
 <20250418165324.GA29127@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250424093816.GD3042781@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424093816.GD3042781@horms.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Apr 24, 2025 at 10:38:16AM +0100, Simon Horman wrote:
> On Fri, Apr 18, 2025 at 09:53:24AM -0700, Erni Sri Satya Vennela wrote:
> > On Thu, Apr 17, 2025 at 05:00:52PM -0700, Jakub Kicinski wrote:
> > > On Thu, 17 Apr 2025 12:47:27 -0700 Erni Sri Satya Vennela wrote:
> > > > > A single leaf is just Token Bucket Filter (TBF).
> > > > > Are you just trying to support some vendor config?  
> > > > TBF does not support hardware offloading.
> > > 
> > > Did you take a look at net_shapers? Will it not let you set a global
> > > config the way you intend?
> > Yes, Jakub. I have reviewed net-shapers and noted that it is not
> > integrated into the kernel like tc. I mean there isn't a standard,
> > general-purpose command for net-shaper in Linux. It is used by other
> > tools or potentially device-specific drivers that want to leverage the
> > NIC's hardware shaping capabilities.
> > 
> > To configure shaping with net-shapers, users would need to execute a
> > command similar to:
> > 
> > ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml
> > --do set --json '{"ifindex":'$IFINDEX', 
> > 		  "shaper": {"handle": 
> > 			    {"scope": "node", "id":'$NODEID' },
> > 		  "bw-max": 2000000}}'
> > 
> > Ref: https://lore.kernel.org/all/cover.1722357745.git.pabeni@redhat.com/
> > 
> > Given the simplicity of code implementation and ease of use for users in
> > writing commands, I opted for tc-htb.
> 
> Hi Erni,
> 
> As someone who was involved with the design of net-shapers, I think it is
> reasonable to instead use the Kernel API which appears to have been
> designed specifically for this purpose: to control HW TX rate limiting.
> 
> If tooling isn't intuitive or otherwise doesn't meet user's needs
> then that is something that can be addressed. But it's not a Kernel issue.

Thank you, Simon and Jakub, for helping me understand the advantages of
using net-shapers over tc-htb. I will work on it and send the next
version using net-shapers in a few weeks, as I will be on leave for 
the next two weeks.

- Vennela

