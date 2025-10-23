Return-Path: <linux-hyperv+bounces-7312-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDEEBFF416
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 07:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0706B4EACE5
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 05:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667A226D4D4;
	Thu, 23 Oct 2025 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hBTQW88t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5062580D7;
	Thu, 23 Oct 2025 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761197498; cv=none; b=Djizj0p5aSX2emo3lJC2RpLodeb25qE6orLfptkR7IhulcAY1BbZ/exhhpEUNCbYCbWD80USPlokhGLKMv/y9qj3kSu/aBFdWCHLNvRS7KVMwwhdp5awDCoU2FLhxR08HZQRngkV7Kqj8qQuE7kUNoybFvBhJd3xSii9UL0rRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761197498; c=relaxed/simple;
	bh=0318MgPvKMFUhbuNLt4YzGS6yD/H5LVrPWGi4HS3NDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho+3gaWvvfXBQ+0Wbbcs7ml3ikpiNhLohBuCNEI8X4iSosgCvt7ks4FYYnYgPRmFEiWmYOdHFnGmLIS5CWZOSuEkYKmyc6u+FvuPMduVGlA2vVWcXY5ZUo20khD4wvgIlzHLyF0GHapX7JI3Gz4H8mmWsai4wSsHjPmTYABL/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hBTQW88t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4594720145BA; Wed, 22 Oct 2025 22:31:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4594720145BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761197496;
	bh=4s7gOeLJDhiSJgwQKsvhyE8vqzIWD6iVcIQfyEzVeIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBTQW88t4GhGKp5NxOr61HzmXG/lQSkL0TiDKm943XMo28vWlw5zxxghkq89ugEtM
	 m+1Ru4TJybDv0+MsKg+Y079bFF3n/zDlA6LHjBMXHPvaZ7WmYJUgBd4986hRwxrNou
	 BUA1+qCSiUyLlsUV0inLxTfyG2kp8VdnDIK20Zns=
Date: Wed, 22 Oct 2025 22:31:36 -0700
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
Message-ID: <20251023053136.GA6431@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
After internal discussion, We are planning to fix this issue following
the below approach:

Stop rescheduling the work queue only upon detecting HWC timeout.
In this case:
1. Reset all stats to zero to avoid stale reporting.
2. Introduce a driver flag to detect the first occurrence of HWC timeout.
3. Log a warn_once during subsequent calls to mana_get_stats64 to signal
   the issue.

Thanks,
Vennela

