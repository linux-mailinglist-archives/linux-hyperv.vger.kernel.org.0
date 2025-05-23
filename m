Return-Path: <linux-hyperv+bounces-5650-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E933AC2771
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 18:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856DD1C005E5
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921D296FD4;
	Fri, 23 May 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smeoKuRu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160FF221FAC;
	Fri, 23 May 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017181; cv=none; b=iWUH5tay3ybQ0fqEGIywpSk6QmqUUkQ4V8xnhP9S5k/QiJV0Rw2aDQln06oVGA4Twh4C2G/TYuicB21xnpFVpJz69RGgHQpJIOMck6tWrmEBtyFthR3FZuFUYNYz2mps4wcOolHW9G5rlf52doKUcLZlCs4En8kIH6PoP5AbpPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017181; c=relaxed/simple;
	bh=luf3+Ha4Xa5pt6ZffZvBB9i4XTf5thEHdVl0hP9DzCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMV6IhnUQRB3jCcFzyJ2+w88lpxFTRuMmM8t+nBFtx9KqUat7RSTn7T3RQj5R+fE4RK5Hs59GRrRZzPA3PQYVk7U+5OgqTlCqduoNa3ytLqx473/5OMyl1+7gOgWEnDS5VCwNenFb1s7U+8bgkYf2bj3GlbjAF0lAgmg5id9gFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smeoKuRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C31CC4CEE9;
	Fri, 23 May 2025 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748017179;
	bh=luf3+Ha4Xa5pt6ZffZvBB9i4XTf5thEHdVl0hP9DzCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smeoKuRuWvb+gS+tIXYSXhUfnnOxe3pmRgxBamojExCBZOzR1RDp3H4y3CmCvqHVY
	 2p0evLhx47tsF9/oEjZ4Fli8Eu1uC11CqVBCoSQGljQ8ADfjN4CxcFbuMzIhFlLGIB
	 vWh9Hb10v2jOlaex8bZ0mQBiat0pFiMPxFwv02drpwRzSlNwWeiZ/IGkLyC31a8Qr2
	 q4BcfDLlfPiazileqSFDyPo+TeVegwm+TTS+YnnfC6n/E31mJ3pGp1emPW/RS64Y7f
	 zBUZDEksnGRGp+7gSqNp2Tp5YOMPTv4sZy8gL5yF/RJGD7xJ8borylXS2OdebVteqR
	 4PAHWjvpJqBeg==
Date: Fri, 23 May 2025 16:19:38 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: hyperv: Update VMBus doc with new
 features and info
Message-ID: <aDCgGoJSbQaR0MEk@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520044435.7734-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520044435.7734-1-mhklinux@outlook.com>

On Mon, May 19, 2025 at 09:44:35PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Starting in the 6.15 kernel, VMBus interrupts are automatically
> assigned away from a CPU that is being taken offline. Add documentation
> describing this case.
> 
> Also add details of Hyper-V behavior when the primary channel of
> a VMBus device is closed as the result of unbinding the device's
> driver. This behavior has not changed, but it was not previously
> documented.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Queued. Thanks.

