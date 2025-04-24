Return-Path: <linux-hyperv+bounces-5089-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0079A9A8B1
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 11:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373E97B4A88
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Apr 2025 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B023D2B2;
	Thu, 24 Apr 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mbl2UA5Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF0D23D29D;
	Thu, 24 Apr 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487503; cv=none; b=aB/GreKzkXBvZBZPhzKMKCU0RrBqb5YaHc1K9+VftJN8TvhJ1hI9pi91A/Uio8AkYUg0cnSZ9BD6uAEnoO1ntsSY7XN68mbbsNDU2Y0gszMMl41jNYrT+515EayPydyS5Z2oowgUByb8fcfHkU+Nrtru4YfpWOI5ndtOAZxONGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487503; c=relaxed/simple;
	bh=JID61eSxQsJgBmkqNJZMZpjUO6Kl5+UYlI+ISdEz/PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfKaAJmZfK2nGqEyIQj1D+rQfBnPNNebFhaq++/awhruXoi7FbOzT6KUcVUvfcF1jM5o3YyYAj4tVQECs0l5MpShDksMlvuBp24J8It4/l+mHs81CK8XBg1bJFI2ovsr28mXTE/gnGbET7TWRrWFxpmGlfen+vPam0J4rRBAqEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mbl2UA5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DC1C4CEEB;
	Thu, 24 Apr 2025 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745487502;
	bh=JID61eSxQsJgBmkqNJZMZpjUO6Kl5+UYlI+ISdEz/PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mbl2UA5Zy8sM2dQjwd3BZF/dMugS44M8jxov0KzeVUi167r5mEMqwQZ+soCWkbhhZ
	 ulfJtzY9d59Tymo6ay43VtiSdKIy1kBhDVTW3SfMWPfab7B3D0rUlnzgOpxUvBNYoC
	 h9Z0TpGherjzv9luL5nF79Ra6VU2aiJLY0TsiuUZSVNL2iXnQhYCmLSV3r9eRGlsFr
	 RxU1KJxDb9T2yy23KT1R8vpOh0aiL2Llf6XSy5mNZy80SGn/ADcjlUnyQ/TvJNDDxB
	 VkyEwWWMn/RAGbkJcF+/GZCwS2TXTRj7suXByiJv8ya8/GMpyH8O7M0LS2aqBv1+4r
	 xEQBY8zpB7jgA==
Date: Thu, 24 Apr 2025 10:38:16 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
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
Message-ID: <20250424093816.GD3042781@horms.kernel.org>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
 <1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
 <20250417081053.5b563a92@hermes.local>
 <20250417194727.GB10777@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250417170052.76e52039@kernel.org>
 <20250418165324.GA29127@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418165324.GA29127@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Fri, Apr 18, 2025 at 09:53:24AM -0700, Erni Sri Satya Vennela wrote:
> On Thu, Apr 17, 2025 at 05:00:52PM -0700, Jakub Kicinski wrote:
> > On Thu, 17 Apr 2025 12:47:27 -0700 Erni Sri Satya Vennela wrote:
> > > > A single leaf is just Token Bucket Filter (TBF).
> > > > Are you just trying to support some vendor config?  
> > > TBF does not support hardware offloading.
> > 
> > Did you take a look at net_shapers? Will it not let you set a global
> > config the way you intend?
> Yes, Jakub. I have reviewed net-shapers and noted that it is not
> integrated into the kernel like tc. I mean there isn't a standard,
> general-purpose command for net-shaper in Linux. It is used by other
> tools or potentially device-specific drivers that want to leverage the
> NIC's hardware shaping capabilities.
> 
> To configure shaping with net-shapers, users would need to execute a
> command similar to:
> 
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml
> --do set --json '{"ifindex":'$IFINDEX', 
> 		  "shaper": {"handle": 
> 			    {"scope": "node", "id":'$NODEID' },
> 		  "bw-max": 2000000}}'
> 
> Ref: https://lore.kernel.org/all/cover.1722357745.git.pabeni@redhat.com/
> 
> Given the simplicity of code implementation and ease of use for users in
> writing commands, I opted for tc-htb.

Hi Erni,

As someone who was involved with the design of net-shapers, I think it is
reasonable to instead use the Kernel API which appears to have been
designed specifically for this purpose: to control HW TX rate limiting.

If tooling isn't intuitive or otherwise doesn't meet user's needs
then that is something that can be addressed. But it's not a Kernel issue.

