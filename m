Return-Path: <linux-hyperv+bounces-1469-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC21F83B95F
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jan 2024 07:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DDB288C21
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jan 2024 06:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5FE107B4;
	Thu, 25 Jan 2024 06:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LZYmUyD/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC742F5B;
	Thu, 25 Jan 2024 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162722; cv=none; b=mXtxFmkVflRKTVfnx9fiHffbpQ6scWpo2/RVEYVrjllt28BKk5u2cb8gbzQfFLWfoYDMzepY4TdSvfzmSKNKsaGkaExsngmQzUqpbCorwbsW96rjfuJB+P49h9SoJzmNeNb6vtP5HUlikAtkYvuHT6JlQpWWzneT9C5elQQIoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162722; c=relaxed/simple;
	bh=4L5cy68zw1y5ZaEgCda7FONQG0IR652ez3fTRjMPQns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE2hxl5sPNhZIW1CilZ/Tnz7ygLeHewwbXogn0jQtnS4KPE0cLItiOZp6XnH+DXhG+KaejBwLV3ZixT7e1Wa6sBJpLzrx7e3HRNKSJvnxphvOWpNtGCM8h7e0V+vcHIy1kyyFTZJWHBbny6BiNFYv8MJCHLi+oZIbCr+V6dEBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LZYmUyD/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 5E6DC20E5692; Wed, 24 Jan 2024 22:05:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E6DC20E5692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706162715;
	bh=oGF/VEHXbOpOF8A0nCHSWQLAFr7a7YIbDrLsRmK56M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZYmUyD/AEsyLc4uQvRpsNfkjJD1BZmLVehAq9YS4wQzJlXJSJRVgY/7OFDCtlTlx
	 6HzaC1Mp9IFJAAHgv2PfGfEIBIkAEptjfW0AEFvOfS8NR6DxmZwqurPLoHdKXA20PR
	 18EBRT1zXFMHGZqpRTXADPh867FvWBXfRrJ8X8Ac=
Date: Wed, 24 Jan 2024 22:05:15 -0800
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, longli@microsoft.com, yury.norov@gmail.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	schakrabarti@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH 4/4 V2 net-next] net: mana: Assigning IRQ affinity on HT
 cores
Message-ID: <20240125060515.GA18142@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1705939259-2859-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1705939259-2859-5-git-send-email-schakrabarti@linux.microsoft.com>
 <20240123170332.20dd8a6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123170332.20dd8a6b@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 23, 2024 at 05:03:32PM -0800, Jakub Kicinski wrote:
> On Mon, 22 Jan 2024 08:00:59 -0800 Souradeep Chakrabarti wrote:
> > IRQ   node-num    core-num   CPU        performance(%)
> > 1      0 | 0       0 | 0     0 | 0-1     0
> > 2      0 | 0       0 | 1     1 | 2-3     3
> > 3      0 | 0       1 | 2     2 | 4-5     10
> > 4      0 | 0       1 | 3     3 | 6-7     15
> > 5      0 | 0       2 | 4     4 | 8-9     15
> > ---
> > ---
> 
> Please don't use --- as a line, indent it or use ... because git am
> uses --- as a commit message separator. The commit message will get
> cut off at the first one of those if we try to apply this.
> -- 
Thanks for pointing, will fix it in next version.
- Souradeep
> pw-bot: cr

