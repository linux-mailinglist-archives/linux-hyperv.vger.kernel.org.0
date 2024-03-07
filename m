Return-Path: <linux-hyperv+bounces-1672-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F078D875320
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C191F24042
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 15:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4712F36C;
	Thu,  7 Mar 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8kLx8Mi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3551EEEA;
	Thu,  7 Mar 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825365; cv=none; b=PjDoztD8LjPULfynK4P6U4bLGKZ0CH90mXec24V0KpTZfK8vC4hpJbC1rWi/AQc+L6cB3xC+OdtT73gz1eZ2ahgaUOnlsHWjqk9yvpyNRhACfMm6tWGnfsgahNum7bNgsXAmo9OxALJMcbTcCzwLPeRov/A0gRknlVGBJHr46+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825365; c=relaxed/simple;
	bh=GtICgG5At2x2fef2wm8+yFnCQWStlPdcwRde9Fn1+yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJelELl7ldhntJXsp5yZuyWEoXwoKoBB/75cCd7pOm0HFAMrY5YuMRwErjNpjjp+gmLHPEmG31wQmySEqvdnbKMxp4MmpPm2/+foVULQt9GBtVy82fBsUgKQUlK9vMEC5kXwCucDqTUgCtjYQ1nCI776LZ83jH7UtJChEMSn9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8kLx8Mi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEB0C43390;
	Thu,  7 Mar 2024 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709825365;
	bh=GtICgG5At2x2fef2wm8+yFnCQWStlPdcwRde9Fn1+yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a8kLx8MiH8h1vlmmCURGSFxybrvP3S4ReCz8kunS9Inv+28Aczqg+6c/CbTp88oGs
	 gA3n/kXJiIz+hUQw1e39SqX/4uzCbIpBpXHPPpNPVVbUWVzHxdem5/jqQZfCPF/Db7
	 a3womHWBzaV5jIccZCRLrmLRcOsdwQVWPYUOZpaGA/mKnGSAEnvFAE+DxluJpWu5ME
	 WKbC4STaBGJi+HAxIikS2Qj37qvW+cGpvg9gj7uZtl/+fKVTdpQoulJUz2LbawsiYm
	 pjHIafVAljrTb78Kek2yQWqX7jAi/c1M9RW3RfiNuTDmsKxXbv75yNw/iqJmcWEzaB
	 /Mu0Li3Nu+4PA==
Date: Thu, 7 Mar 2024 07:29:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, Leon Romanovsky <leon@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Michael Kelley
 <mikelley@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240307072923.6cc8a2ba@kernel.org>
In-Reply-To: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 06:52:12 -0800 Shradha Gupta wrote:
> Extend 'ethtool -S' output for mana devices to include per-CPU packet
> stats

But why? You already have per queue stats.

> Built-on: Ubuntu22
> Tested-on: Ubuntu22

I understand when people mention testing driver changes on particular
SKUs of supported devices, that adds meaningful info. I don't understand
what "built" and "tested" on a distro is supposed to tell us.
Honest question, what is the value of this?

