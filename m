Return-Path: <linux-hyperv+bounces-8305-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE4CD22B3C
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 08:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BCDE30915C8
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jan 2026 07:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226363254B1;
	Thu, 15 Jan 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daj5//Iy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BD325492;
	Thu, 15 Jan 2026 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768460512; cv=none; b=kogHQudGqaJvwSr2p1yz/z1fS/ofaddsucq6qB4rt8kqvJV/IlArgWF0D9HhOCdoFHQkg/OEu/WMvqx1p3WZSHjPTrEIDZs/QG+7Ey5B9kqZez73M6GhEsW43LFVxhkUYs2S6BXSDGwDhdd96EmQl6TLzHW8bQKbuzF9B+nMr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768460512; c=relaxed/simple;
	bh=jIXnJCbBS9XgkTALoJxcyQ4qQdTjTBXVlAe4FG5f/Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esYidWhubSncOmhWgjgHzpfL9H8L5HquliIu0kcYh2Q+u3/vsTNIFKu6iREvpUzmwd2mx0Lk7NxtMWWBWA+f/Ts7qvjgUiGGHTx5giWaGM4Ae+ROVxXV82aX3M01MleUjS6/iyHS0bCeprNC54sS4ttIQZ+BTWtODrrdIBKLZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daj5//Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBA8C116D0;
	Thu, 15 Jan 2026 07:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768460511;
	bh=jIXnJCbBS9XgkTALoJxcyQ4qQdTjTBXVlAe4FG5f/Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daj5//IyOdGfEK+FV9UxJyQgtAFlODHOD1e5wkuFtJRU5i80/Fb7VltQDVaWxDUnY
	 9G/S7T+GU5uy15Z7Ol7oqtgFLjblxmAX+xlpZZguSsq0PZIiHNDBJCJnXSR6hLVnLY
	 KUP/HsYV0O3xPGSDM3nCD0U1Avh2BvjoR+D86S7miP8otpTJX3ZDzkxw1wa9W6bXqt
	 fTn9mZ6xIVuxwWNQeHo1MawnlaAgHzSvRStVFrshKhZoG7QdW9UticXtrJhmlbIw5C
	 UkK3L7HKNZkEsj1kUh8VqZrMu+9pwcNB5dI6mOQvcmxdV1HlPzOaV130msw8Iq+KwL
	 OXUKhx7yyxNYQ==
Date: Thu, 15 Jan 2026 07:01:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, dan.carpenter@linaro.org
Subject: Re: [PATCH v2 1/1] Drivers: hv: Always do Hyper-V panic notification
 in hv_kmsg_dump()
Message-ID: <20260115070150.GB3557088@liuwe-devbox-debian-v2.local>
References: <20251231201447.1399-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231201447.1399-1-mhklinux@outlook.com>

On Wed, Dec 31, 2025 at 12:14:47PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> hv_kmsg_dump() currently skips the panic notification entirely if it
> doesn't get any message bytes to pass to Hyper-V due to an error from
> kmsg_dump_get_buffer(). Skipping the notification is undesirable because
> it leaves the Hyper-V host uncertain about the state of a panic'ed guest.
> 
> Fix this by always doing the panic notification, even if bytes_written
> is zero. Also ensure that bytes_written is initialized, which fixes a
> kernel test robot warning. The warning is actually bogus because
> kmsg_dump_get_buffer() happens to set bytes_written even if it fails, and
> in the kernel test robot's CONFIG_PRINTK not set case, hv_kmsg_dump() is
> never called. But do the initialization for robustness and to quiet the
> static checker.
> 
> Fixes: 9c318a1d9b50 ("Drivers: hv: move panic report code from vmbus to hv early init code")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/202512172103.OcUspn1Z-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied. Thanks.

