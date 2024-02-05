Return-Path: <linux-hyperv+bounces-1530-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A074684A458
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 20:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54ED31F29D97
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65E1420A3;
	Mon,  5 Feb 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f5VfideM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255831419A1;
	Mon,  5 Feb 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159829; cv=none; b=OtAPyShwDfMc+Egkt3IYOHRImvGQ5hgSgr5pQ5YD7tipaLVjfUxovufJuyRv1Xro2NsHLEn49DpOXh7uFKp9VWlyqPPmn0HgVahe5O39n3V7//8lCdFOGUZiHNBbJDyp/M2X7LmeWwBq8pGpStBqFffXAwBQSgDUrYUb6DEqQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159829; c=relaxed/simple;
	bh=cBdQybg3QvOmh0T+8TRo03v1EOMi2jdUNh9UnbpZkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD63jPAkXpxpeCETXSJbigldD1T5ScVCASfPXkMnjwxDFL3eX19SM+eqbrCos8k0KiGTj9ngW7eIrEcD+sB7bk4MUexZ/bfqZzBjJBGAKBCTkOranZN5204ityM9cqckClSFlkfJWLFvpph02ulLG3c1OHcg4XCzMVA3ZMSBB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f5VfideM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1CDC43399;
	Mon,  5 Feb 2024 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159829;
	bh=cBdQybg3QvOmh0T+8TRo03v1EOMi2jdUNh9UnbpZkXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5VfideM77C6CjdQnZbI+AFq9tir3+pU2GvZ59q+dglfFhvNLJWQE0TjITBACmuHO
	 YXAyoLXvFq2JtrhzWhMf3ikAisGY5PBk0UQAFt1ZIXnYRCQqUVuPaBee182r9geIJe
	 LOP0P40Kf3F8gEuhpBoAy+MpYIcESVk7wQoLjiDo=
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

