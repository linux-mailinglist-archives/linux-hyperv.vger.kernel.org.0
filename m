Return-Path: <linux-hyperv+bounces-6907-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED7AB800D7
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 16:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5978C32519B
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 05:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA3262FD8;
	Wed, 17 Sep 2025 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KOt+W++K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE228682;
	Wed, 17 Sep 2025 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088437; cv=none; b=TBoGezDv+anFTFN8NExAeqDhSUGZpY9s/5TuJ61JeP7FJCWlXoEy2ifL5KINBi6BpymyKHAuDLjABH5nhHQkeGJ7QHR3a4MgR5sWw7SZJEjVjLDck0vIqL6699mB+LdrZB479W2FPxq6TwdQlFdSnqH7sF1TaQDAPI0MB3sAers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088437; c=relaxed/simple;
	bh=CCX37D9Qr7GX+74n8qfAy6TluFo/LtQaDdLKVHdQLCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/m69hti5RIqeiEm78HHuH2J2T6DphkpAsFObQFQ9M5r6SHoerIKqjxK1eY08PrOtOGjMiGNAjTUIR/YrxzBCqnWD1JRhFm8WgQXd9EY13duQtuaxNsdSq7ktW4UTZYWkmRrzUUQOUJD7oDvPhzmI10RDMLmxUcoAt7KlmGMteQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KOt+W++K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id EABAA2018E4F; Tue, 16 Sep 2025 22:53:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EABAA2018E4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758088435;
	bh=YHQ3EH9SyJ8VRyn828fVbYcfbFUAxPm7FMoa/3X+BBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOt+W++Kvq53kIom1S9t1ix7U8JW3wuLQCKLEP5i81uWmacMI/IjJfhT21C2px9F3
	 VP0+8MAsCRyaYR7eRFTNv7QaClkEOmjh/d/02JFidqnIFNC7PC+xws+2g4uyeumHg6
	 Zq7SMFdQrQPJSUwS72GuTxy+JGuEsMPjVxTagfx0=
Date: Tue, 16 Sep 2025 22:53:55 -0700
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
Message-ID: <20250917055355.GA31577@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
We are working on using the stats query as a health check for the
hardware and its channel. Even if it fails once, the VF needs to
be reset, similar to a probe. The hardware team also confirmed that even
a one-time or temporary failure needs a VF reset.

- Vennela

> /P

