Return-Path: <linux-hyperv+bounces-4648-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23384A6A780
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 14:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC89A16B785
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5321D00E;
	Thu, 20 Mar 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5VD7rya8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D71388;
	Thu, 20 Mar 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478231; cv=none; b=U7G2rpscPD8kOefAn/Kk00w2o+BaPyxoAXNbr8PhsJpZs5Wjt2y6jwL7J/gGE+WbpqkqcyLQ7DDJKrretkqtY6o6LbFzUEDU9h7rH0eOhpTQt+gT2h0cGax5hSR6mVTV/J1ouvtRoPq/xr2bBbGp/mualqMTRan4ETmvVGA9nV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478231; c=relaxed/simple;
	bh=b4cTidJvouqptWZq5fAiNydMxKtEIOLp8tYqG4ChrVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL1dN3eW251SgCr3drQyNlv5ndUg7MctFVV1UuYSFmjVEOB8TP3+FTTV3MJsTUI/kHfvwYgCxV2P45JXA++W0TK0Bgbeq8lW9wHHo1gynRo7tE/HCHgSGAwORX4gnCPyzTs8qSIA00jsH8gSw8SBjjj1q2m12oDqWY8c2jrFCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5VD7rya8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NgVqHdjA9pYmontvEBdSsrxCMOmEBCXPf7WJM2DVg2A=; b=5VD7rya8JapCJWxbWY8JHVYOdA
	6EKxRp59hA52a1F0YFeo6w3hkxULTWVLGeBtJd0QXcsnNwueMl3vW2nYq3KTeKUd8euZx5/gKuAaw
	bk/UvOO+6PYkMnzx7j0RpqXdn6wop4WIjogMTkgCfUGCCOkKOwhD7PmY3HXVGk/R3/Qo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvGBK-006Tux-Tv; Thu, 20 Mar 2025 14:43:34 +0100
Date: Thu, 20 Mar 2025 14:43:34 +0100
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
Message-ID: <fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>

On Thu, Mar 20, 2025 at 05:22:20AM -0700, Erni Sri Satya Vennela wrote:
> Add support for ethtool_set_link_ksettings for mana.
> Set speed information of the port using ethtool. This
> feature is not supported by all hardware.
> 
> Before the change:
> $ethtool -s enP30832s1 speed 100
> >netlink error: Operation not supported
> $ethtool enP30832s1
> >Settings for enP30832s1:
>         Supported ports: [  ]
>         Supported link modes:   Not reported

Since there are no link modes, what does this speed actually mean?

> After the change:
> $ethtool -s enP30832s1 speed 100

Is 

$ethtool -s enP30832s1 speed 42

permitted? 

or

$ethtool -s enP30832s1 speed -1

	Andrew

