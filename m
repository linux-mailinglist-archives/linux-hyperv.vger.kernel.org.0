Return-Path: <linux-hyperv+bounces-4972-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAD7A93B62
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C76A169F9A
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B121764B;
	Fri, 18 Apr 2025 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ga/b4ojU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A15213E9E;
	Fri, 18 Apr 2025 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995206; cv=none; b=Zmayoz5ch/IQkbSwdwiwx+Ab0/6/Jc+bKajP/eBrPVgAVx9yQea3CqydptyqyYzs/wAKuClkxcfAemWHeUlJ5SUtJcOrhrxqlA2FjxUAncLHQ6wqRo/mAnSY0UIxELreCEfQp0+G3cJwZQmn4NkGEECH7Gp9wkLat1ugy8sv+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995206; c=relaxed/simple;
	bh=exTIgXjJdCABXxTkzYn/2Ovpwzs3X3ewU7W/+ycUNHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=demjfjy8b5Rv0LTHJ+U+mFthzhTDyA/rmiD+vCdkHV/wMXvx4s1rUNKUp4EuPJJB2w8viC2H0ceo6kGGqMR+lwZbaheteVKw7RTLY+FpwgSjNDw3/3IiD0HW7DTAfGh0OOvlfLxhRihY5g0SVQ4klK/oGVFLDRxDPsuRUUqKXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ga/b4ojU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id DC7A120BCAD3; Fri, 18 Apr 2025 09:53:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC7A120BCAD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744995204;
	bh=yUVkC+qkj2B+tc0UOA8AEbtaoBN1fnZq0f+cJiGEOqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ga/b4ojUwKlgLisp7ry7fLE4qbXrfFnFq1WdsA1Jq6KefCewpc345ZxQFrdKiNrB5
	 npKlAqo5OZvlE/62hdE2U1E9j6hQikRB/MSLUURl1xK2rwQzEcHCyskWvzkkpNYI0N
	 zxzPmcwgMI1fO1QTcDRVQ6NmdV6PTc2S52rmSe6U=
Date: Fri, 18 Apr 2025 09:53:24 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, kent.overstreet@linux.dev, brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, rosenp@gmail.com,
	paulros@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] net: mana: Add sched HTB offload support
Message-ID: <20250418165324.GA29127@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
 <1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
 <20250417081053.5b563a92@hermes.local>
 <20250417194727.GB10777@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250417170052.76e52039@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417170052.76e52039@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Apr 17, 2025 at 05:00:52PM -0700, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 12:47:27 -0700 Erni Sri Satya Vennela wrote:
> > > A single leaf is just Token Bucket Filter (TBF).
> > > Are you just trying to support some vendor config?  
> > TBF does not support hardware offloading.
> 
> Did you take a look at net_shapers? Will it not let you set a global
> config the way you intend?
Yes, Jakub. I have reviewed net-shapers and noted that it is not
integrated into the kernel like tc. I mean there isn't a standard,
general-purpose command for net-shaper in Linux. It is used by other
tools or potentially device-specific drivers that want to leverage the
NIC's hardware shaping capabilities.

To configure shaping with net-shapers, users would need to execute a
command similar to:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml
--do set --json '{"ifindex":'$IFINDEX', 
		  "shaper": {"handle": 
			    {"scope": "node", "id":'$NODEID' },
		  "bw-max": 2000000}}'

Ref: https://lore.kernel.org/all/cover.1722357745.git.pabeni@redhat.com/

Given the simplicity of code implementation and ease of use for users in
writing commands, I opted for tc-htb.

