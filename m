Return-Path: <linux-hyperv+bounces-1523-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECDB84A47B
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 20:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47E8B2A9B2
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 19:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8313DB92;
	Mon,  5 Feb 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iUByRt31"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612A13D51A;
	Mon,  5 Feb 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159828; cv=none; b=At2A5yf6OmpTLq+4vBCYmkbDffqMHcSFEKfotErMVTWxZe3eLxAKMmhasVSUq+5uVj5xEhvg+cbw6Tyk/7j7qf52lDXtwI99RIX1IunzLPPRBKih9souSfqgJelo0g9lxKs/zBxXHffMjDwR1oBYGfXurRQz4DgOQsL/vyJtdJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159828; c=relaxed/simple;
	bh=cBdQybg3QvOmh0T+8TRo03v1EOMi2jdUNh9UnbpZkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6+oFfS5Zoq3GP7QEyC3tpyvYQNKpQ4M6jRdN87I6ud5hVsxUum4pdrqxWDB11ufQs5vrJ5dfCCYUlZA+uFIuIDILnusq5NY1Y8eFKxQmDNpYvOWBLXCbihM9ZuCoCY1h+EL0xi4WH7s6oRRX7+lTcWhwMPrvIMwRBDt7Lj4q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iUByRt31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9226DC4160D;
	Mon,  5 Feb 2024 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159827;
	bh=cBdQybg3QvOmh0T+8TRo03v1EOMi2jdUNh9UnbpZkXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUByRt31n51fJHxU3mAs/bDSQVv10LyZrfSXoh2eK9SHcAatNf95Ir37c5abF0ftS
	 Pytpr0GGu9GqJpERiVwraj05pn4E4CCNk5cSnqvjScIvRyrSYftRbjR7Y9wrHRV+mv
	 dHI6ilO8OGDJXj1Dm3iNx3SKp+E4Fymt4TXmVzZA=
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

