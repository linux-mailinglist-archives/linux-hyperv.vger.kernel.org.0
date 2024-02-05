Return-Path: <linux-hyperv+bounces-1514-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B484A43B
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 20:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87A9284A18
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 19:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986613C1DF;
	Mon,  5 Feb 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pFHsMilY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7213C1C1;
	Mon,  5 Feb 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159826; cv=none; b=csRwB/gyHiBTRCa2YLshr4fVOBSEkBmDY1rmWZ98e47T05mPsWGKWrC5rdZ0/Smsb7WkwsK2/91GHmHqoFrSGIDXhdJwTNcEIXw+hrcZuVfpu43TC6Jn2GO+bLb8jaXS/gN7IPxE24VjPZC1jPUQSUS9bm8Yv9ueocsbep/QP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159826; c=relaxed/simple;
	bh=cBdQybg3QvOmh0T+8TRo03v1EOMi2jdUNh9UnbpZkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af/kgXftclJjktwUIkYSY7bHQkKjn84mDc0bR2NYlGU5w2S/BqOfgRwVEHjjpJsyIFp1dxq82aNGTO5N13BMX/udkIS6ER1s3a1tmZdRJMfVa90vFT1FvFQIQ2bBV6zcr9DIwE4pggCgEev5YEaZU9kQqrbkWo2WSPung13aXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pFHsMilY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A7FC433B1;
	Mon,  5 Feb 2024 19:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159826;
	bh=cBdQybg3QvOmh0T+8TRo03v1EOMi2jdUNh9UnbpZkXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFHsMilY/kx4AbdiN3h0RF6AC4GZML4oRcUUeXyzkmfZ8+OPBJis2igauMBoKU7xj
	 IwsUT+ee3BGLFntJCeZGR2/kAcUkk90fyOS8oNAPD8igaTL8xZTePoPX1y9pT+bDcy
	 XmsMP9Chc+tkEF01sdjdP/rN/sJEu8XHev6CC8R0=
Date: Mon, 5 Feb 2024 04:49:30 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: vmbus: make hv_bus const
Message-ID: <2024020526-playlist-december-b3f4@gregkh>
References: <20240204-bus_cleanup-hv-v1-1-521bd4140673@marliere.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-hv-v1-1-521bd4140673@marliere.net>

On Sun, Feb 04, 2024 at 01:38:02PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the hv_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

