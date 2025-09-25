Return-Path: <linux-hyperv+bounces-6985-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D83B9D608
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Sep 2025 06:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DF01BC0AFD
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Sep 2025 04:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64342E6CD0;
	Thu, 25 Sep 2025 04:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jacHt1Fv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3391A9FA8;
	Thu, 25 Sep 2025 04:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758774247; cv=none; b=EuLfD0zBSi+bGKy+wKuuYCrSu7yDcg1jrIAqX80Y0CqmR1SMa6wU6qk4oYX3oEXU7TqaMiPdwuim+Bz1fwCm8+36pKS2wxNbpZ5lS1jUEScGDUk6HGr1guAgP1TwE3hk//e8ICj1NSL9WIFHi2qCP4PZAP/CFRv0tXvhG1ovrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758774247; c=relaxed/simple;
	bh=EKadyV7dkXlD+Rbxb9dG1WOIlel58j2p/jmleCbCehI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkQRLYYsk5zscgxXlxPpGuvU4Ltj6pzyjJDYKv3qJN79IelAe0V+Ar+DpgOQgoVgBeE5TiDLdGxxJWb2CCU3kVxtpfUsJJep7Kp66ZU3+bQN3P0ZMDw+rJLACU0L1jcoixgys3Ehl0998P3fHQVbpVDeQ+5q7MM4N5Kfjzm37ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jacHt1Fv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id B7128201C95F; Wed, 24 Sep 2025 21:24:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7128201C95F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758774245;
	bh=QmP1cC3/spA7Q3QMS6SW+EVwCP7k6iBZS42bm8plOgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jacHt1Fv0k4zJ7qwXnNOSTYxOzkKWQN5+wEo2VjN0hGnOmDAVWXfxYFeyA8bpdBD6
	 A6gPqzrONoaIH1jgGOvvagiwpylR8r0jcGS2OJ+ejydr+lcrg9IthVFd3HAZw+Elpf
	 WTs5TbqlhHauHsTWwPp0CR5OIpKQS3Q3l8PXV2Cw=
Date: Wed, 24 Sep 2025 21:24:05 -0700
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
Message-ID: <20250925042405.GA5594@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1757908698-16778-1-git-send-email-ernis@linux.microsoft.com>
 <1757908698-16778-3-git-send-email-ernis@linux.microsoft.com>
 <0b5b0d1d-438a-4e41-99c8-a6f61d7581b4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b5b0d1d-438a-4e41-99c8-a6f61d7581b4@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Sep 16, 2025 at 03:22:54PM +0200, Paolo Abeni wrote:
> On 9/15/25 5:58 AM, Erni Sri Satya Vennela wrote:
> > Report standard counter stats->rx_missed_errors
> > using hc_rx_discards_no_wqe from the hardware.
> > 
> > Add a dedicated workqueue to periodically run
> > mana_query_gf_stats every 2 seconds to get the latest
> > info in eth_stats and define a driver capability flag
> > to notify hardware of the periodic queries.
> > 
> > To avoid repeated failures and log flooding, the workqueue
> > is not rescheduled if mana_query_gf_stats fails.
> 
> Can the failure root cause be a "transient" one? If so, this looks like
> a dangerous strategy; is such scenario, AFAICS, stats will be broken
> until the device is removed and re-probed.
> 
> /P
Hi Paolo,
Does this patch require further discussion?

- Vennela

