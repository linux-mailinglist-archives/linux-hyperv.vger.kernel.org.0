Return-Path: <linux-hyperv+bounces-4965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B82A92BED
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 21:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5DA4A1F9F
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48D11FC7C5;
	Thu, 17 Apr 2025 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RePszaRd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90333C8F0;
	Thu, 17 Apr 2025 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744919248; cv=none; b=ApxXcUc6iJrOBQW6RoEggfF/sDglDBYS9LXtMJO14CWMgYGjAhVU1h8nR7DiySgkan3LfwVGtAEC0XYVicFCWvGdDr3q2q+TkvjX+0x4T18DxXm2wyojEr2vapJaTHg3NdYIbXAwDHY2uoDMEng1Oeukb6Xx/bbfEqkXK8rmiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744919248; c=relaxed/simple;
	bh=3P8gzAwUXlTXkzdurilibP1a2gN/qWNYV3zAaFpv2t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpKbgbUQaMA4+PjjliQoj0iHN+JfpE5+uwfAOk/9YWf18mF1dIsza6o4/CFqw0cLxCKNME52I6uK+dtwLvhWt2aCE++AFmYnL4cVesDREoJtLm5wb18EE0ctahWrtaj07STb5QHjN6Atj94eeo1Sk18RBOOlnRPKCvFKMquyUoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RePszaRd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 1C1BA2052514; Thu, 17 Apr 2025 12:47:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C1BA2052514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744919247;
	bh=anpRTFPVePx+7q+NdbCbSDz22pkecDHw3TLk//jq8V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RePszaRdR0yW4PNAbcu2bZDvmuN921LzHwwQux1hbd6LwG4LSBcuOieUezSi5yPsE
	 57srL7Br8ksaS0MQdAngJj83kZq+O6p+yRCwcBVct5+V0dRswm4VVeo9viyXwfq6uw
	 0Lt1qv77zoK8PgP8j5HB6rMnzuhbusZpHlSZPqK8=
Date: Thu, 17 Apr 2025 12:47:27 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	kent.overstreet@linux.dev, brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, rosenp@gmail.com,
	paulros@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] net: mana: Add sched HTB offload support
Message-ID: <20250417194727.GB10777@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
 <1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
 <20250417081053.5b563a92@hermes.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417081053.5b563a92@hermes.local>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Apr 17, 2025 at 08:10:53AM -0700, Stephen Hemminger wrote:
> On Thu, 17 Apr 2025 00:57:09 -0700
> Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:
> 
> > Introduce support for HTB qdisc offload in the mana ethernet
> > controller. This controller can offload only one HTB leaf.
> > The HTB leaf supports clamping the bandwidth for egress traffic.
> > It uses the function mana_set_bw_clamp(), which internally calls
> > a HWC command to the hardware to set the speed.
> 
> A single leaf is just Token Bucket Filter (TBF).
> Are you just trying to support some vendor config?
TBF does not support hardware offloading.
Out of the qdiscs that support hardware offloading, I have chosen HTB
which can help set bandwidth for the MANA NIC.

