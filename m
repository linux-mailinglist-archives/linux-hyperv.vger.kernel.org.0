Return-Path: <linux-hyperv+bounces-1525-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4558584A44E
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 20:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01862282023
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 19:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D5113E21F;
	Mon,  5 Feb 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tFz6pWME"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5575213DBA2;
	Mon,  5 Feb 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159828; cv=none; b=nVxYf4VZb4lWAQGEH4yWZOxWoBZyQe2n7gDUCebs+J6JpnIfW81iAHS/tE8WHh6umCf5mJoyo5JU+W8mDRVxzUNGE2B1bY5QslXqtaFDkn0fCtlDibFqR/9ysQrVOvY7Vq19d3lPyBFhLJ0E3QQD22OFQV2HTXY41zTzwsbC5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159828; c=relaxed/simple;
	bh=cBdQybg3QvOmh0T+8TRo03v1EOMi2jdUNh9UnbpZkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6+oFfS5Zoq3GP7QEyC3tpyvYQNKpQ4M6jRdN87I6ud5hVsxUum4pdrqxWDB11ufQs5vrJ5dfCCYUlZA+uFIuIDILnusq5NY1Y8eFKxQmDNpYvOWBLXCbihM9ZuCoCY1h+EL0xi4WH7s6oRRX7+lTcWhwMPrvIMwRBDt7Lj4q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tFz6pWME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4B9C433A6;
	Mon,  5 Feb 2024 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159828;
	bh=cBdQybg3QvOmh0T+8TRo03v1EOMi2jdUNh9UnbpZkXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFz6pWMEFpVM6yfWekiM+FiDrxSUYi9hy1a7rv06AGRf4Ej9tC8Sh8nHH+KirWoMn
	 lv8ELdhSMTZDPHgVv51IJcreAECuoD5Zt0Cp1HhSbXPjAryEpAa5TFa8uoY19IN7mi
	 +TLCArTsinYDp9Hy3pEbrtnYY7xvzJuelhaMvv3o=
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

