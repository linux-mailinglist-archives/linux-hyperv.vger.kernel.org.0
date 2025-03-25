Return-Path: <linux-hyperv+bounces-4695-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264D4A707C0
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 18:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8573188D7EF
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7B25F989;
	Tue, 25 Mar 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K2GMMy/U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94792E339B;
	Tue, 25 Mar 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922597; cv=none; b=beWo5YcPV/NCNzbmNXrQ+O1W44wK1B3ZTjWz6ciPuAywcbxyudy1JbsCiNN+7IQW6ckufH1AdQNgl4HDO9fQYSrJ2o50Kw0OD/sPIDCH8+ChjJd4DqWf092thX2RknjGSN2Z74z3QKzMKCKFYJoImEyGVAzUr0hJNSlznJg3tE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922597; c=relaxed/simple;
	bh=v/k0ISaq5RYlyl5YrvYc26UUUVRy7HHPNAzlq4Z3UXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnEs4ihOFhy8zsdSrk5g7HKOfHsbUzyLe3ZKvG5DCfnM8qjg+G9PudXFdCGGbjAWi+ORLXioUikdZL9Ma1bqEuHTL2hWbiSYAn1tYNrmJmx76cpy8CimGlw/CRzG2SOwDpU0UbWvCjJ4zgY8ybjE5HcB/9rlEgt1Pna4aeI5Qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K2GMMy/U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 5BDD2203659C; Tue, 25 Mar 2025 10:09:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BDD2203659C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742922595;
	bh=TKSCvK+Z+E2nBTbRXLRveMgjlIDGsBl82/XulX1hncc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2GMMy/UlrBv+TZS3YWLozHje4h1h/PWk7hVSmmEMncBMrMAVK/ksD0z8g6bFQhg8
	 zL+AvcdBh6YlR8ONiLtalFp8+qReHMizRK/ai6qPTykrijRYgcYr5PyEMbR5SkBbRV
	 souOcTxF4XlP2qKiyxP4g2tbu/ZcVa354i/yuEsI=
Date: Tue, 25 Mar 2025 10:09:55 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20250325170955.GB23398@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
 <1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
 <fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb6b544f-f683-4307-8adf-82d37540c556@lunn.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Mar 20, 2025 at 02:43:34PM +0100, Andrew Lunn wrote:
> On Thu, Mar 20, 2025 at 05:22:20AM -0700, Erni Sri Satya Vennela wrote:
> > Add support for ethtool_set_link_ksettings for mana.
> > Set speed information of the port using ethtool. This
> > feature is not supported by all hardware.
> > 
> > Before the change:
> > $ethtool -s enP30832s1 speed 100
> > >netlink error: Operation not supported
> > $ethtool enP30832s1
> > >Settings for enP30832s1:
> >         Supported ports: [  ]
> >         Supported link modes:   Not reported
> 
> Since there are no link modes, what does this speed actually mean?
> 
Initially we planned to support for speed incrementally by 1Mbps, but
after internal discussion with the host team, we will be supporting 
only speed which is multiples of 100. The HWC commands 
MANA_QUERY_LINK_CONFIG and MANA_SET_BW_CLAMP help us to get and
set the speed in the hardware respectively.
> > After the change:
> > $ethtool -s enP30832s1 speed 100
> 
> Is 
> 
> $ethtool -s enP30832s1 speed 42
> 
> permitted? 
> 
The user will be allowed to set the speed which are multiples 
of 100. And the minimum allowed bandwidth is 100Mbps. I will be making
this change in the next version of this patch.
> or
> 
> $ethtool -s enP30832s1 speed -1
> 
This case is handled by the firmware, which throws an error:
ethtool (-s): invalid value '-1' for parameter 'speed'
> 	Andrew

