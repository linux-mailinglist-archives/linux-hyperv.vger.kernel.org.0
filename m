Return-Path: <linux-hyperv+bounces-4693-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83856A7073F
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 17:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DEA1658EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433C25DD0C;
	Tue, 25 Mar 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ke2EYGto"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E625DCFA;
	Tue, 25 Mar 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921015; cv=none; b=L8l4h3SlGEpnlpshRBVG510EREMQT0EkCYt+IfvsiK667jGeXkqcc74akYpvx5Sxdq5rcFLI0VPv+JY3N9USsqtJxOiAJH2nHVkERhrrHe8R/3oxRNT9o3EbNANBqn6nCAq3T4C0ziIEeKjG7UnitQq/mbPoXAT9FNqCvJM+Pa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921015; c=relaxed/simple;
	bh=drMQDkgJmMbLDEmO3efWQL4mfA24GQIsptNGl51WiYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQoDwleDkSFuzYaEdFQjXKg4j5vIbQ/hsAPXEqE1a4v7ENWN/SR962lSW1WvyfZVDs+5JIYtc4ERkTaJE03kFfsdRkKa45mb5u2BKJ33yMEK9wrrgE30FnK8V+BvGLGrgyRVh6AZ6vFgMQePFv3C6sDab4g8vL+pYRBHtFpu+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ke2EYGto; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5OahHluwUaYB0aciGU0SrFW4AnlsngHJ7Cwk3N7UL/0=; b=ke2EYGtoThSJpmkggihm8mOUMR
	bU/dq43rafiwb8Su+ZBsA3suIQQvmQzOLmqjGkCukrZQbtez1c6ndU75o7nIFo2iRdk2hU37q4Q15
	NVLhAsKOk3pqw+sGtLMKmLVLDUnDRrXScQZDHHFyeSrTsxOx6QVcD5xL3FvZaPrHrvYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tx7Mx-00754F-Ms; Tue, 25 Mar 2025 17:43:15 +0100
Date: Tue, 25 Mar 2025 17:43:15 +0100
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
Subject: Re: [PATCH 1/3] net: mana: Add speed support in
 mana_get_link_ksettings
Message-ID: <dcfd3551-acfc-4de3-b5c1-cf8a18730ad0@lunn.ch>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-2-git-send-email-ernis@linux.microsoft.com>
 <f4e84b99-53b5-455d-bad2-ef638cafdeae@lunn.ch>
 <20250324174339.GA29274@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <909eae34-02ac-4acd-8f0e-1194f0049a21@lunn.ch>
 <20250325162527.GA23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325162527.GA23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

> The QoS control is at the hardware/firmware level and applies to the
> egress rate.

egress relative to the VM? So what the VM sends to the hypervisor.
There is no restriction the other way, hypervisor to the VM?

That is not what link modes do. 10Mbps is the limit in both
directions.

> > Also, if i understand correctly MANA is a virtual device and this is
> > the VM side of it. If this is used for bandwidth limitation, why is
> > the VM controlling this, not the hypervisor? What is the security
> > model?
> > 
> In certain cluster and hardware versions, Azure allows this API to
> restrict the bandwidth limit to a lesser value than what was configured
> by the Azure control plane. The device will not allow a higher limit
> than what was configured through the Azure control plane to be set by
> the VM through this API.

So all this information needs adding to the commit message. When you
are using an API in a strange way, you have to expect questions to be
asked, and you can save a lot of time by answering those questions in
the commit message, before they are even asked.

So, i think this is the wrong API.

Please implement it as a TC offload. I'm not an TC expert, but htb
might work.

	Andrew

