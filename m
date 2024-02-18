Return-Path: <linux-hyperv+bounces-1566-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6DE8595EA
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 10:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEACF2823EE
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAD612B91;
	Sun, 18 Feb 2024 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1W0xJWvn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0412B79;
	Sun, 18 Feb 2024 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708247492; cv=none; b=rtrUKpKw1+dV2Fu7cXFN5ge2kyJGwP7npaaYZlgDmAw85QdMr9NDbNPf8MMnzECWMIR1hMOu54UvVXT1wY2/Z8XItN1rWj6kWJMuJjb0gl9RGChAm83xTl29pkdTF/hJlJaj0aFmgeCyog1wD9MkgTQt8Rkif43BimvecJgFnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708247492; c=relaxed/simple;
	bh=WvunbyX8u7ls+Mm+iOFgVrbxEsHcwKpdT0M+JmRUQxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRPAvBEyDOpt7lWzZTTqtiqp3AmyCkhM8+jFGarf5MoXNdOo1TERWYsxNeGfw1TP2RjXXA54Xdq4ZDbSsKYxb0w6TI5GjjqZ25pOGwwpq74fyOEUUbBPhLNoIAfRS5z7cQAvxHR8UCbhm2riWxL6C+hzP3cK6xwMrqdZVTKGXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1W0xJWvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5A6C433C7;
	Sun, 18 Feb 2024 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708247491;
	bh=WvunbyX8u7ls+Mm+iOFgVrbxEsHcwKpdT0M+JmRUQxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1W0xJWvns6yY2mu7AKOZdR3HuPy3LiEKeiRpAZNRJcJxFWrlMXNLGQFPMDNE26chZ
	 VGWwSNf4eHpqUvatYDWmWtrcB0RJJB5DIzXSeLxq1Hkes3KMOiCwScYrsM4zuGVIRo
	 lTPudQ42voWsZUB17eD67GdDnSWqscYcJrFBi+k0=
Date: Sun, 18 Feb 2024 10:11:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 1/6] Drivers: hv: vmbus: Add utility function for
 querying ring size
Message-ID: <2024021859-provided-hamburger-8b43@gregkh>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-2-git-send-email-ssengar@linux.microsoft.com>
 <2024021858-cubicle-irregular-d402@gregkh>
 <20240218080306.GA26112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218080306.GA26112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Sun, Feb 18, 2024 at 12:03:06AM -0800, Saurabh Singh Sengar wrote:
> On Sun, Feb 18, 2024 at 08:11:58AM +0100, Greg KH wrote:
> > On Sat, Feb 17, 2024 at 10:03:35AM -0800, Saurabh Sengar wrote:
> > > Add a function to query for the preferred ring buffer size of VMBus
> > > device.
> > 
> > That says what you did, but not why you did it.
> 
> I thought subsequent patch will make it clear, but I can add more
> info in cover letter. I will enhance this commit as well.

Each patch should stand on its own, as it will be on its own when
committed, right?

I don't know anything is happening "next", nor what any of this means
here, which is required.

Again, what would _you_ want to see if you had to review this?

Along those lines, why not get some internal review, and signed-off-by
first, before asking us to review this for you?  You all know this area
the best, and have lots of experience with reviews, right?

thanks,

greg k-h

