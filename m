Return-Path: <linux-hyperv+bounces-3880-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B0A2F63A
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 18:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9811881A83
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736DF255E59;
	Mon, 10 Feb 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bgp1w5ri"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189F025B683;
	Mon, 10 Feb 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210373; cv=none; b=uSL9tNYN1qpHCM1TjZsFicRQRRopZNdISXWxf2HWMWZyXai1paBjUWE0qQ/C23SjCZmPpEbUXMPbVXVox6g4xkXkGzk56QfUcg1juM8v9YCv+CpzUKGtIoqIb0D/NyGegG6Dlld5ETCRUn+aKj55dogSltuUkzWmS7ob+Ou/euw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210373; c=relaxed/simple;
	bh=r+nZwoc8DznFjgy/dTbOCqlQ7KMSfy+0N+izBrPJHCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAzOILimWR1R61WjaiVJulH6rlX6LEQQ3/8IjEUakyniHO0wVl4P9NFsxnnJnkHMb/ExBX18DcM1Loh8yxe3LomfEJxy0Jim+BPDOLEN+tOEUYISmTisDpyp+1ZiUK6MuurT48SqylylpJ7tfeIW3VrIGkx6LOKmFnOGtv9ae+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Bgp1w5ri; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id B33C42053680; Mon, 10 Feb 2025 09:59:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B33C42053680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739210371;
	bh=7oxVU9z7LmtD31jnoqMb1VBGVzB/peaBuGcPzFmyIKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bgp1w5riQmFzhWcIc2AZ6XzukiyUoghwjljDoOb7G1RElHuLaE2CUYsYL9MHGT5ay
	 Xs3Eq0NMaY3DKgcTk29sSN1RwRHoiPtzPO79ybW6lDr1J1Zz3LwCvf0exrD8kth4fI
	 yMmutd/vCgWReiNksZ7UEZKAW+iuiTu0iWUZ8pEw=
Date: Mon, 10 Feb 2025 09:59:31 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2 net-next 1/2] net: mana: Allow tso_max_size to go
 up-to GSO_MAX_SIZE
Message-ID: <20250210175931.GA18891@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739162392-6356-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1739162428-6679-1-git-send-email-shradhagupta@linux.microsoft.com>
 <CANn89iJ3cT6BWLmFpdkxn6EeeLTM7rF0pwWGArq1gG8pk8orsg@mail.gmail.com>
 <20250210175753.GA17857@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210175753.GA17857@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 10, 2025 at 09:57:53AM -0800, Shradha Gupta wrote:
> On Mon, Feb 10, 2025 at 04:55:54PM +0100, Eric Dumazet wrote:
> > On Mon, Feb 10, 2025 at 5:40???AM Shradha Gupta
> > <shradhagupta@linux.microsoft.com> wrote:
> > >
> > > Allow the max aggregated pkt size to go up-to GSO_MAX_SIZE for MANA NIC.
> > > This patch only increases the max allowable gso/gro pkt size for MANA
> > > devices and does not change the defaults.
> > > Following are the perf benefits by increasing the pkt aggregate size from
> > > legacy gso_max_size value(64K) to newer one(up-to 511K)
> > >
> > > for i in {1..10}; do netperf -t TCP_RR  -H 10.0.0.5 -p50000 -- -r80000,80000
> > > -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT|tail -1; done
> > 
> > Was this tested with IPv6 ?
> 
> Hi Eric,
> yes, sanity and functional testing where performed(manually) and passed on azure
> VMs with IPv6.
Forgot to mention that the tests were performed on both IPv4 and IPv6
and these numbers are from IPv4 testing

regards,
Shradha.

