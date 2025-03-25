Return-Path: <linux-hyperv+bounces-4696-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC2A7088E
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 18:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFDD1892458
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 17:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB20263F49;
	Tue, 25 Mar 2025 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Roljvn0n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ECF263F41;
	Tue, 25 Mar 2025 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925183; cv=none; b=t5deDKAju96ff8cMItmQyKUNTkY/Qofydq9lF9orxZtfJNZ0TjNnzJ725ZSzZ24O98xDxS0j7k6tdAErOc2p4N0SuMbQdXdlhHdPyyLVsMJV/jo16Ld3hwoFiCLmPS8/05a6QbdM9iO4GoL6pkiAD8nYvaU+r6nkFqiuSH8lrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925183; c=relaxed/simple;
	bh=xNJb6LWYNPmCvd7VJLAhvRbFT1B8jChQZx4XS+b8cNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUTo28fgndkb8tfxUWYgNRjrs/DuAweFzW+tC/xwBBYTQNSAeYe9QPEVXGMN9BCA/2bvGr0W6P15izQbuRquYD95aosVOTubpzFxt533MCFZ4oIOyJ4MDvoi2jq97LJTaYRmpnSn/u6zdMGxRzqlhJnslSQ3p818LJop6nkJrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Roljvn0n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gQ9Qwq29lAHwOvJTHc3u4UBWAudPdoRCH3V7BiUwyHM=; b=Roljvn0nuxDScbFsPXbPUndoAm
	q95SEliNKHlDjrMy9FzaUg63J2wuEMbemf7txdkuT2J3KY1Tex8DOujgqgDIrTvlmvOS4j9AsLkeN
	d1wGYcCyTVNazW9JIi+mGBmR8kvI5OJsbBsoLmtWFj4Tvai9mI7kOpWJR6m4uxOvkLtE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tx8S8-0075SN-6L; Tue, 25 Mar 2025 18:52:40 +0100
Date: Tue, 25 Mar 2025 18:52:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	brett.creeley@amd.com, surenb@google.com,
	schakrabarti@linux.microsoft.com, kent.overstreet@linux.dev,
	shradhagupta@linux.microsoft.com, erick.archer@outlook.com,
	rosenp@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] net: mana: Implement set_link_ksettings in ethtool
 for speed
Message-ID: <adaaa2b0-c161-4d4f-8199-921002355d05@lunn.ch>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
 <fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
 <20250325170955.GB23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325170955.GB23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

> > $ethtool -s enP30832s1 speed -1
> > 
> This case is handled by the firmware, which throws an error:
> ethtool (-s): invalid value '-1' for parameter 'speed'

So how do i remove the speed limitation i previously installed? -1 is
SPEED_UNKNOWN which is what you default to.

Using TC would be more natural in this case. The user action is to
remove the TC filter and that should set it back to unlimited.

	Andrew

