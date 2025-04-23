Return-Path: <linux-hyperv+bounces-5049-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCA8A97B9F
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 02:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B4A3B52DC
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 00:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6181B1EB192;
	Wed, 23 Apr 2025 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsH5BVhe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C631EA7DD;
	Wed, 23 Apr 2025 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745367529; cv=none; b=qWElFDW7OkJpbLIMu1hsNjwWTVfHB9zyTV0Gpt/fLUyB+v23J6A2gB0VUSKsI5fBPXMrpBEmun1MDxx6SIhltJzUeq4so0l3NY9zHayGCw7HC3N3j+WhZq1XpRtFAEZEyAc8X47Yrs148Qo6UwO5eQhx2kqbpgnq7RpQ89BH5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745367529; c=relaxed/simple;
	bh=ZNxOHaeGy5AnoXe7j6R1daES+ngPlMQqefaZFX2wrcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZFn6kthumuBLBPjYF85V5gfy4b5rx5NMv15mgLCGQFBa3WzKRHUh0eUsK8Y1MQHe0gndIxBvXPxjTI4QSWls8ljxOvK9SU5ZOKHb6VXaAX4FpNkBLZGLIrSW/RC2YK1NoUmw2l/BlM5RkoVA1o59mCj0xyeLmlrRTzfkpfT538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsH5BVhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAFDC4CEE9;
	Wed, 23 Apr 2025 00:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745367528;
	bh=ZNxOHaeGy5AnoXe7j6R1daES+ngPlMQqefaZFX2wrcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fsH5BVheu4QuBeLXL86opbP6Rz2lAnRJUPvFbZeYbhJ0JeAhXR83jNniM9gQTJIp7
	 mOhwG/5xSgu/+9BdkJsPWn2yAEr8V1Moc6o9I0+xvd3nh/TuFRpUCJA/pv2yfD+6HF
	 QONha8mDriVwdiZE0bnzsYB7FUb5A0zm5pergUz1ny+VLmGK4hl8nj7he1POpMq3qO
	 WpBfc++/GPqiJAte7veyPM2PCsdCgW3DoxhtP07WYnaFGwJiMCvTvGI1VursA03N6G
	 Ctg/gtP6Sf7IOfOgG2WK86GlbNDY8aYhI5zDFZ7UUsjjVi5naW3xWtZ/jF1bUFwrlU
	 ANRxrdYSkMftQ==
Date: Tue, 22 Apr 2025 17:18:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, mhklinux@outlook.com,
 pasha.tatashin@soleen.com, kent.overstreet@linux.dev,
 brett.creeley@amd.com, schakrabarti@linux.microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 rosenp@gmail.com, paulros@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] net: mana: Add sched HTB offload support
Message-ID: <20250422171846.433d620d@kernel.org>
In-Reply-To: <20250422194830.GA30207@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1745217220-11468-1-git-send-email-ernis@linux.microsoft.com>
	<1745217220-11468-3-git-send-email-ernis@linux.microsoft.com>
	<20250421170349.003861f2@kernel.org>
	<20250422194830.GA30207@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 12:48:30 -0700 Erni Sri Satya Vennela wrote:
> On Mon, Apr 21, 2025 at 05:03:49PM -0700, Jakub Kicinski wrote:
> > On Sun, 20 Apr 2025 23:33:39 -0700 Erni Sri Satya Vennela wrote:  
> > > This controller can offload only one HTB leaf.  
> >   
> We selected tc-htb for our current use case because we plan to support
> multiple speed classes in the future.

Which net-shapers also support.

IIRC HTB offload requires that you dynamically allocate the Tx queues.

