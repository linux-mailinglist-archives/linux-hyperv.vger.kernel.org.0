Return-Path: <linux-hyperv+bounces-3840-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D4A28BCB
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2025 14:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A1E168B4E
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Feb 2025 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A3613C918;
	Wed,  5 Feb 2025 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YQqD7g3N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6632613B58D;
	Wed,  5 Feb 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762522; cv=none; b=hAowrKE411dJ2YNi0O8XFg0m3YL11fc/QGraTdqnyGJvXebv8TzxmfSLJXq0wKhASs63NdcIpdclTmbSv7PtC87yRUC12UQbGWsuSJRhF++NWNpAEUOZq/vVsWLSNJwXeNq5wDf5DqbOsnnLaV9xfeweXd5e31J0hhFdB6pW5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762522; c=relaxed/simple;
	bh=x0uKn8wMyAb9SDuoxu7F3G4LgZnhEbeanY3QXIO+sl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPcWw5pCFNTS4dwvfV1LL4XusAUKcF57KeHzfGiyAaT+i+1dx8ExWeM9pFXlpdueJJcFTJfTLQLAM2lEnAePkvMEPqAAFy6Jsf2fP5Mm6k336VhA2HhlSWwKNpmgd98dv8gx6/6dyWOBNwJHmpuXkjh0QRfoMuSiWDXPz+vaY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YQqD7g3N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E3183203F598; Wed,  5 Feb 2025 05:35:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3183203F598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738762520;
	bh=jVw8xA/AHJAZWRrWRfJt/MtAW127xSrQhfv4yL27ynk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQqD7g3NakUq7ZsTI0obKPIGNaaC2DJSo2V8NnfPOFsWwdRSgjCH9Qcww0T5cvez1
	 JGbUdiKYWTcZMPytcNPgLDHrkuwPs73y4oX9zLqH2LCHLYLb7ehb5IeYhdPMIdWZit
	 pDkY4FZfbt27h6QBPVF3YUHslWmDrqyal9rhOE4M=
Date: Wed, 5 Feb 2025 05:35:20 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH 2/2] hv_netvsc: Use VF's tso_max_size value when data
 path is VF
Message-ID: <20250205133520.GA16428@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1738729257-25510-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1738729316-25922-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250204215643.41d3f00f@hermes.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204215643.41d3f00f@hermes.local>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 04, 2025 at 09:56:43PM -0800, Stephen Hemminger wrote:
> On Tue,  4 Feb 2025 20:21:55 -0800
> Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:
> 
> > On Azure, increasing VF's TCP segment size to up-to GSO_MAX_SIZE
> > is not possible without allowing the same for netvsc NIC
> > (as the NICs are bonded together). For bonded NICs, the min of the max
> > segment size of the members is propagated in the stack.
> > 
> > Therefore, we use netif_set_tso_max_size() to set max segment size
> > to VF's segment size for netvsc too, when the data path is switched over
> > to the VF
> > Tested on azure env with Accelerated Networking enabled and disabled.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Since datapath can change at anytime (ie hot remove of VF).
> How does TCP stack react to GSO max size changing underneath it.
> Is it like a path MTU change where some packets are lost until
> TCP retries and has to rediscover?

Hi Stephen,
Upon removal of the VF, a change in the MAX segment size (calculated as
min of the new list of participants in the bond) is triggered. This
causes the subsequent skb allocations for the nic for the xmit path to be
under this limit.
During this process, if an SKB with the older seg size (i.e with longer
length) ends up in netvsc stack, the netvsc transport, later silently
segments it in the size that the hardware supports (netvsc_dev->netvsc_gso_max_size)

regards,
Shradha.

