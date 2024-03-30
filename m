Return-Path: <linux-hyperv+bounces-1877-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F155C89296E
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Mar 2024 06:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372C1283817
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Mar 2024 05:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FFD8827;
	Sat, 30 Mar 2024 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fGoORLSH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC418881F;
	Sat, 30 Mar 2024 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711775378; cv=none; b=J2To2Lhq85ZFojmngbf9Rd2Mj5ms+UidEaAhID5Cls5jfirY140/4ZcQBVSb9MCI8BR7lpsuHlvIKNporBK++aQ1G2FYDH8uw9Gsh/HMDWLDhcRwhwHgGawg5QumxaRy4MdTjBwlzYu4ZsZ2Q4Eu8YyRyCKhgMeXX2DzA2pRxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711775378; c=relaxed/simple;
	bh=zzAqp9Ee+PZWq3o6G8bBQOO7w1V18fOd0hRGiHxocjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvLrsm3253zO6lsnivfHwU5sz8s2E3/pRW3gCaOm7HRHnCOLHyXFnBXOYtRwJc2VOgjAuRDEPBw59BxyRkUawJpau/Aad/loPZkWw3xUM2eYVmxSSyTGnIWixZAQGbARWucOMD953Yq4pyulziZbSx0BTh1EdaCGyIt9lPgtlQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fGoORLSH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 45AFB20E702E; Fri, 29 Mar 2024 22:09:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45AFB20E702E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711775376;
	bh=zzAqp9Ee+PZWq3o6G8bBQOO7w1V18fOd0hRGiHxocjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGoORLSH0PfgHwBBc+y1Rs7/mSMc2FA+Uy+DfDUipLxf21MpyO8vsL8zpktekHrWN
	 ppDuDxQskgRcqF+pU81UrwDP0tDlbwzZ2BbhDfywpA5cXSbz9uWy6FSStRCglfM4sQ
	 RkBaks1XhMCntEJHDGxWc8AEziXZepKpJoJIQrk8=
Date: Fri, 29 Mar 2024 22:09:36 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Aditya Nagesh <adityanagesh@linux.microsoft.com>
Cc: adityanagesh@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: Fix Issues reported by checkpatch.pl script
Message-ID: <20240330050936.GA11602@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1711432061-30952-1-git-send-email-adityanagesh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711432061-30952-1-git-send-email-adityanagesh@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

no mention of checkptach.pl in subject line please

- Saurabh

