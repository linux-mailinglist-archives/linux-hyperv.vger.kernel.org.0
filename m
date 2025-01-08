Return-Path: <linux-hyperv+bounces-3606-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FC4A05489
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 08:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A611886F77
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B881AAA29;
	Wed,  8 Jan 2025 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/nv7uFt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103619F42D;
	Wed,  8 Jan 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321368; cv=none; b=QFdmHfRmFxgIOW7A9u8Ax4Am0XSbUvaEnFcda5xbMOV0zytkCYuzrWdd069+sBfNv38bfW+MxfRWDX+OdLMQYYpHQoSQ3pm43peLG9kWs3LwyRcfs6FH0pFNLMU9V4/milTljcARt5Vtvh925fwyvElCmPEgpYxLoTVLlV5jmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321368; c=relaxed/simple;
	bh=3zW77v+zYcqSvvFeVS1BbC5KgqJx5D4SpFT9oHMjHJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzAj78c0g2ZRkeI5vz33SNl7yWj1Uhyne7LTs23TqT3IwGlvGiUiXLijYmPfx4/rijqdmpyXKOHHKsm3gDXYlSK2BHEZzvehvhOY1kyrboUWNeZT1wExgPNriwYkX4EG9sgq0ADpzXWMl2/OsBmO7+jkPLcSDbG3Gsoo+yZ0FiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/nv7uFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93302C4CEE0;
	Wed,  8 Jan 2025 07:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736321367;
	bh=3zW77v+zYcqSvvFeVS1BbC5KgqJx5D4SpFT9oHMjHJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/nv7uFtIoImM04z6huWt5LWVajIaWQEw3zkZ5WlUdtAFzObxewCttXetKzKxo8YT
	 uLNFmKBEAAVAoAnVLFG1hfoeomzXMQH+lGukH++VEGNQeOQwo+9ZpyKZ97ugW+GmEp
	 tujenAWqZrvG2Lx2dJbHJnX0FDyx6d2SRm9lQnwN8t0HRfThoh2tqn4lxv1BY6FSCu
	 nudbw8zcwKs3cIq1lWJ02fr3U8AP2ar4oqbzHAN1qqBzrIt83BX48KTFUjwd8I1wFu
	 AMwBUvogQfmJf5OeACfDkGu9pf/POCg5pnbfjOnQQ2+CYkn/KQ/ZXfE0O/3Jaa2mqu
	 L95aPgpKs+pzw==
Date: Wed, 8 Jan 2025 07:29:26 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Starks <jostarks@microsoft.com>, jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v5 0/2] Drivers: hv: vmbus: Wait for boot-time offers and
 log missing offers if any
Message-ID: <Z34pVsUkhJL87war@liuwe-devbox-debian-v2>
References: <20250102130712.1661-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102130712.1661-1-namjain@linux.microsoft.com>

On Thu, Jan 02, 2025 at 01:07:09PM +0000, Naman Jain wrote:
> John Starks (1):
>   Drivers: hv: vmbus: Log on missing offers if any
> 
> Naman Jain (1):
>   Drivers: hv: vmbus: Wait for boot-time offers during boot and resume

Applied to hyperv-next. Thanks!

