Return-Path: <linux-hyperv+bounces-4983-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C78A95110
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 14:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC231724E6
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F7D264A70;
	Mon, 21 Apr 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iq/IEZjF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F0B666;
	Mon, 21 Apr 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239026; cv=none; b=XDB8D15oi6ud8Ja67VsRiiPd2wF3c7wEwyZytJE2U8FrXsA9nAO7A6yiUx1lkSZjnQhIDhMTmmmLKP9JSTI23tGIarGOcqLFw61pRN3HSZA+QVHx40AIyLfYWaQSmUBwMr2zzeolBTx7D+daQvBBnYDxI3UWEGrPwj3gQhAr9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239026; c=relaxed/simple;
	bh=xUoy18CdiDXwRbZeN4HdFmHR7gr0IcLOiQofTpsxvoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLaoqZOeq2b73iTvRNykExZ98Lqk5aEKABcRM5n5tVKp4bUTqC8S0Zs1LSXOl2wgOgOiN1PWO5wGFwQV1H9iB/WT1efAndRraK+cdPT7ieRjQToIUbxsnmxwICM3UwI3W05YD4J7wdFNeDsPS3ShWseXrSoiTyoQogEFG/6jc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iq/IEZjF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NKiLvGqiMQUIQKr+UjuD8tWiHt3uwJSWt0OKD4dCah4=; b=iq/IEZjFmxmua3Fr6ALoKkqg27
	mw1tKDU6vLbPzbGtqnd2ujDZXTUoobt427h0Td38hyU0s87xDMA/GcoDI7m6y7dVBMDvHnw8NKNK1
	ABcpXENB80Fsda3wgaQwf1o377EE509n8trVH0NlM5MxudSFFeYirJXCwfClE/Lnwi7Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u6qOB-00A5Ye-QJ; Mon, 21 Apr 2025 14:36:43 +0200
Date: Mon, 21 Apr 2025 14:36:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	mhklinux@outlook.com, pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev, brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, leon@kernel.org, rosenp@gmail.com,
	paulros@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: mana: Add speed support in
 mana_get_link_ksettings
Message-ID: <c481c8a8-4e0f-4498-89f9-988673a584f6@lunn.ch>
References: <1745217220-11468-1-git-send-email-ernis@linux.microsoft.com>
 <1745217220-11468-2-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1745217220-11468-2-git-send-email-ernis@linux.microsoft.com>

On Sun, Apr 20, 2025 at 11:33:38PM -0700, Erni Sri Satya Vennela wrote:
> Add support for speed in mana ethtool get_link_ksettings
> operation. This feature is not supported by all hardware.

This needs a lot more justification. tc(1) will show you the current
HTB Qdisc setting. No other MAC driver i know of will show you Qdisc
info in ksettings. So why is mana special?

Something your said in an earlier thread might be relevant here. There
are two shaper settings involved. The Hypervisor can configure a
limit, which the VM has no control over. And then you have this second
limit the VM can set, which only has any effect if it is lower than
the hypervisor limit.

The hypervisor limit is much more like the value ksettings represents,
the media speed, which is impossible to go above, and the machine has
no control over. Reporting that limit in ksettings would seem
reasonable. But it does not appear your firmware offers that?

    Andrew

---
pw-bot: cr

