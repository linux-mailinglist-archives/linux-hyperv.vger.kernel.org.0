Return-Path: <linux-hyperv+bounces-8357-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B95BD38FE6
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Jan 2026 17:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45F2C3008C7A
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Jan 2026 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1486F244667;
	Sat, 17 Jan 2026 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phohAdOa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4218240611;
	Sat, 17 Jan 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768669133; cv=none; b=XIOnGWZxPYIfe0Ofi14wF1J1IIgI6RFVyRsg29g0cKXswMqsQOYeTip33jsoGBS6PJahHI8to7qSIu7xPykOi94wOlED4YL/gYBU8YWqsvW5Mjm4pVQAyqMRC6MvR1ed4G3FMMxcbTk0hS8bkHD/O0qxNN/q3MPQRSZmmWoFTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768669133; c=relaxed/simple;
	bh=2V+SrPaqid13wZThPiFAFYUGKtXziQbinsdZuW+lgxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgLsdqcXyhtZkAHT7Uc58LUhXWSoSU+vDhYUxh8Thn3RyWKaJaQzrwZd6LnmJvQ1c9l+II4AS8HIyDJBshoi0NO9l9JMS9Uuya15nLxmKohgMmX1oJixu4RnFCUU5/JAt9bQMej1MIMLA6cxHRYWGcx7yKJ5uOM51CzEspGGifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phohAdOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD10C4CEF7;
	Sat, 17 Jan 2026 16:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768669132;
	bh=2V+SrPaqid13wZThPiFAFYUGKtXziQbinsdZuW+lgxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=phohAdOa3aFyFs5dki+bktY8OZpOxaBT79MGsjJDr9U6Ar1CXIue6O5bMHjX2k/km
	 nXpbEsFWsYxxDd5oxLtNaAHEqDT06zvw7D5NHnuJpOzjFmoMeyd7exhluugjTGp1yG
	 qBcjkLQ3bsy1klblk4PjeBoqEqX3lSFjPThb+NHRQ5nr/va0hemcmquf0KxzkBW/x0
	 0tzErCnmkanjDlRYJ2Tv2MP5HJ5q06bcD41tWRpeKnDZPRdYVUHudP86A61pJ9XSqb
	 7QmIJZBfQn/WOI+S2FQv3hFpWq8KrVk0Y5wCiZfhRR4Tg2Bl6wfORStCj8HtKsc5m6
	 tgWa75sPCk1nQ==
Date: Sat, 17 Jan 2026 08:58:50 -0800
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
Message-ID: <20260117085850.0ece5765@kernel.org>
In-Reply-To: <SA3PR21MB3867B98BBA96FF3BA7F42F3FCA8DA@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
	<20260109175610.0eb69acb@kernel.org>
	<SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260112172146.04b4a70f@kernel.org>
	<SA3PR21MB3867B36A9565AB01B0114D3ACA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<SA3PR21MB3867A54AA709CEE59F610943CA8EA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260113170948.1d6fbdaf@kernel.org>
	<SA3PR21MB38676C98AA702F212CE391E2CA8FA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260114185450.58db5a6d@kernel.org>
	<SA3PR21MB38673CA4DDE618A5D9C4FA99CA8CA@SA3PR21MB3867.namprd21.prod.outlook.com>
	<20260115181434.4494fe9f@kernel.org>
	<SA3PR21MB3867B98BBA96FF3BA7F42F3FCA8DA@SA3PR21MB3867.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 16:44:33 +0000 Haiyang Zhang wrote:
> > You need to add a new param to the uAPI.   
> 
> Since this feature is not common to other NICs, can we use an 
> ethtool private flag instead?

It's extremely common. Descriptor writeback at the granularity of one
packet would kill PCIe performance. We just don't have uAPI so NICs
either don't expose the knob or "reuse" another coalescing param.

> When the flag is set, the CQE coalescing will be enabled and put 
> up to 4 pkts in a CQE.
> 
> > Please add both size and
> > timeout. Expose the timeout as read only if your device doesn't support
> > controlling it per queue.  
> 
> Does the "size" mean the max pks per CQE (1 or 4)?

The definition of "size" is always a little funny when it comes to
coalescing and ringparam. In Tx does one frame mean one wire frame
or one TSO superframe? I wouldn't worry about the exact meaning of 
size too much. Important thing is that user knows what making this 
param smaller or larger will do. 

> The timeout value is not even exposed to driver, and subject to change 
> in the future. Also the HW mechanism is proprietary... So, can we not 
> "expose" the timeout value in "ethtool -c" outputs, because it's not 
> available at driver level?

Add it to the FW API and have FW send the current value to the driver?
You were concerned (in the commit msg) that there's a latency cost,
which is fair but I think for 99% of users 2usec is absolutely 
not detectable (it takes longer for the CPU to wake). So I think it'd
be very valuable to the user to understand the order of magnitude of
latency we're talking about here.

