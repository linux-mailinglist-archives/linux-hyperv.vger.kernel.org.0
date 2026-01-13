Return-Path: <linux-hyperv+bounces-8239-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32579D16250
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 02:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32B23301EA31
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 01:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D19D26CE2C;
	Tue, 13 Jan 2026 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3Eua3hx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C423EA90;
	Tue, 13 Jan 2026 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768267308; cv=none; b=auXtid194nHyVbv/vCleCNK6F+s2BYR2In4pL33YDJdHdPpqkHHz6qAQxp/2HKMKbTJqkpXkArVVaDKMZLSreB8lJSHvi0u4o4NaCp79ePMzQ0jzXbKhjZJRDHHa/mGRj/Sm+Bvh3rWAWMDU/n6V2xYz6btGe5i9IGUX6Lncyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768267308; c=relaxed/simple;
	bh=SAvQgfZ3g0imNFz3RoHhZxQwiYs2ZbrGTmH7ZJbUlM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYzSAR8TTP5sP5aOb+zXg8q3hivaAziiPQ38VUzWTrbqqOcfR5qyiR4Utb72tDvhWDdrIy4eCCbaj9JT6vhJSvkKfNhpzvx7yOZHYD/c1JfVwBHwF/VTh2xGUuCLFqEk6iAyrNhSl9sQpM46lFzi+4LU5hl5HiLpx22k/QpqamE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3Eua3hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB08C116D0;
	Tue, 13 Jan 2026 01:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768267308;
	bh=SAvQgfZ3g0imNFz3RoHhZxQwiYs2ZbrGTmH7ZJbUlM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a3Eua3hxdTh3Se9uPtpgJAW+DFPwbJZWVPBEUksLrl63oqvSRGvI+EmSZOzqApwMo
	 ugYv/pPUwbObzvOHNTnI0wpsRk1ZJo1e1dv4I4cGKij6yaeeYZKxEJ3RA5thr89FFo
	 lc7w4nLdV5/Yy0r9OILkMgb/yBKaMTAf4iB7zzrO1MU4ab1lRQGHvfcmj4wFBqDN52
	 gtY6pkjNNkEYiRzufiLSlGsoLf/mi4G/imdhE/8fkxBXsjIWbNAnbZmBlwrZ1y1+qO
	 LLSIMhASUr/q5uaAPj/dGMN8H/PLnGpCcqxp8yE2LtuLmJIJn4kK/GZdCduZKfv7A/
	 02OUaS8o3kgNQ==
Date: Mon, 12 Jan 2026 17:21:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Erni
 Sri Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, Aditya Garg
 <gargaditya@linux.microsoft.com>, Dipayaan Roy
 <dipayanroy@linux.microsoft.com>, Shiraz Saleem
 <shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Message-ID: <20260112172146.04b4a70f@kernel.org>
In-Reply-To: <SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 21:01:59 +0000 Haiyang Zhang wrote:
> > > Our NIC can have up to 4 RX packets on 1 CQE. To support this feature,
> > > check and process the type CQE_RX_COALESCED_4. The default setting is
> > > disabled, to avoid possible regression on latency.
> > >
> > > And add ethtool handler to switch this feature. To turn it on, run:
> > >   ethtool -C <nic> rx-frames 4
> > > To turn it off:
> > >   ethtool -C <nic> rx-frames 1  
> > 
> > Exposing just rx frame count, and only two values is quite unusual.
> > Please explain in more detail the coalescing logic of the device.  
> Our NIC device only supports coalescing on RX. And when it's disabled each
> RX CQE indicates 1 RX packet; when enabled each RX CQE indicates up to 4 packets.

I get that. What is the logic for combining 4 packets into a single
completion? How does it work? Your commit message mentions "regression
on latency" - what is the bound on that regression?

