Return-Path: <linux-hyperv+bounces-3890-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98607A303DA
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 07:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2593A6BB6
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 06:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16B61EA7D0;
	Tue, 11 Feb 2025 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s8oe5aJc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBB01E9B12;
	Tue, 11 Feb 2025 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739256600; cv=none; b=kaQzISHk8o5hPDvPEmQQn6RKjKa+t9WKCZXOY2NMreIhYT+55ps6Pc0e9jTzA9I4BAnlwWm2jIQFeJkObRGuF3EJdl2lUIW1Y8lUBNNhpoO51qMDlzbOdma7PYtk0UUE0LHghU1fSyQ903UZQnmxVcQ5mlEYAs/YnPaImxRPK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739256600; c=relaxed/simple;
	bh=/72hblTAr0ml+v4ncYL24QnW3hc34oy4og4/RR+FOMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8/tYvi9Ai2K22wT4XomxfP+7yp0odiVlvLD4M5wNJAM4UU5gFkl9uvBhKzZJ6iGN0yu7LE7s39sGBShbaWMc7Qvvkfpr1Kc6pkhtUV8fUrOuZUZKdrc6oPe+ezCBVi36/itWCVQhYGdPedI2alhBkyZ4uTwLN8JjPHM2m2gDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s8oe5aJc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 46D8B2107A99; Mon, 10 Feb 2025 22:49:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46D8B2107A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739256593;
	bh=BS9tA2SNyXv7FIdpYEaWS+oZRZ0ThGbQVd0wOfdmQsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8oe5aJcB4/HLlM7JrcXOBPm3lkZjNiLQcm9vXVXZ00Qz9zGY1vDe9xPaflZ9ider
	 TyebF2YMfEywsCIq/oeJxFu0k5LDdgA6ezTJbaEYv1KvgZj3e/Gl5nX3l4mSzVIPGp
	 8szFKJhTCE5L8oQ0iyzZK35oaXpxVWK5eYUcsz+E=
Date: Mon, 10 Feb 2025 22:49:53 -0800
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
Message-ID: <20250211064953.GA26170@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739162392-6356-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1739162428-6679-1-git-send-email-shradhagupta@linux.microsoft.com>
 <CANn89iJ3cT6BWLmFpdkxn6EeeLTM7rF0pwWGArq1gG8pk8orsg@mail.gmail.com>
 <20250210175753.GA17857@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250210175931.GA18891@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CANn89i+ovDB+qLBV3DEx5eB4vDZq=X+rWUZgR7qHjDLc4=UN2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+ovDB+qLBV3DEx5eB4vDZq=X+rWUZgR7qHjDLc4=UN2w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 10, 2025 at 07:02:04PM +0100, Eric Dumazet wrote:
> On Mon, Feb 10, 2025 at 6:59???PM Shradha Gupta
> <shradhagupta@linux.microsoft.com> wrote:
> >
> > On Mon, Feb 10, 2025 at 09:57:53AM -0800, Shradha Gupta wrote:
> > > On Mon, Feb 10, 2025 at 04:55:54PM +0100, Eric Dumazet wrote:
> > > > On Mon, Feb 10, 2025 at 5:40???AM Shradha Gupta
> > > > <shradhagupta@linux.microsoft.com> wrote:
> > > > >
> > > > > Allow the max aggregated pkt size to go up-to GSO_MAX_SIZE for MANA NIC.
> > > > > This patch only increases the max allowable gso/gro pkt size for MANA
> > > > > devices and does not change the defaults.
> > > > > Following are the perf benefits by increasing the pkt aggregate size from
> > > > > legacy gso_max_size value(64K) to newer one(up-to 511K)
> > > > >
> > > > > for i in {1..10}; do netperf -t TCP_RR  -H 10.0.0.5 -p50000 -- -r80000,80000
> > > > > -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT|tail -1; done
> > > >
> > > > Was this tested with IPv6 ?
> > >
> > > Hi Eric,
> > > yes, sanity and functional testing where performed(manually) and passed on azure
> > > VMs with IPv6.
> > Forgot to mention that the tests were performed on both IPv4 and IPv6
> > and these numbers are from IPv4 testing
> 
> Where is the IPv6 jumbo header removed ?
I think this is missed in this patchset. In our IPv6 tests, patch sanity was
performed without changing the default values.
I will add this support, thorughly test IPv6 and send out another
version with complete IPv6 support and numbers.

Thanks for the pointers Eric.

Regards,
Shradha Gupta.

