Return-Path: <linux-hyperv+bounces-2750-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4E494B563
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 05:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924ED1F22427
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 03:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F82A1D7;
	Thu,  8 Aug 2024 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BS4ykAC/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC6CA6F;
	Thu,  8 Aug 2024 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087139; cv=none; b=lVbSOifnbJaJ34Og+ao7VttARgLDl3BRnW1H2tlXe5vzR5HsLCuZv5J9OnhZTXSmcEEj04cUXSQ0tCkJGx+okowD/bYu7y0LTMjAeI+y2vdopd1nRwD/GPOv1lDHaW0w9G2TJVqm61Vm9taelmGdiz9IfeZ8a/5WkgGWLQZfJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087139; c=relaxed/simple;
	bh=VVR+xEtsgA7xj816NAm5owc3atP8G1fTSEBkGMayaR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXX0wO+Dmm+j3Pco6/+8EHaBX8T288NgYqGTRvzJyv1mk+NQODWjueHSYVkQ4RyRysH7jkbrQYtMFMs6RSI6KVAZsdTqwSlTbiT7yeIE1hyCn6Q5b3r0pk+S+0jD6VTl6Poe2D23eXwncMKNVdGAGEe6xe/fER4OuElmKtU2dOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BS4ykAC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B36C32781;
	Thu,  8 Aug 2024 03:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087139;
	bh=VVR+xEtsgA7xj816NAm5owc3atP8G1fTSEBkGMayaR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BS4ykAC/Y4nza/CoFDs74AMtAxKcxtjAR92RS3nukMWmWdqymlWlOjLnuZ0Cr+B3/
	 +GIIkS66/58n9rcU3U77a8lC93af/0QdTzlemtkMvCodoq04Tb6megb1eNs78eqk+Q
	 9N7RoMMg6/kQx//eq7xYYbCrVuCkx5mOmSMjZBES3EwKOIuh7ajiTWRgSbI+fIBg0X
	 5wC1RPHwpst4Jqd1MrSSyHyEJkgqgYnDOky2KByeDwyNLQMJ3oryBe7q7EiKOvKKsT
	 EgE84IuUayR08jrLumr/NA+DHN6EzkXjeEaIeWwU3WNUPwe/p0ZGVrSsmen+TJbv8v
	 93RDiFKm6PRMw==
Date: Wed, 7 Aug 2024 20:18:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ernis@microsoft.com
Subject: Re: [PATCH] net: netvsc: Increase default VMBus channel from 8 to
 16
Message-ID: <20240807201857.445f9f95@kernel.org>
In-Reply-To: <1722923751-27296-1-git-send-email-ernis@linux.microsoft.com>
References: <1722923751-27296-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 22:55:51 -0700 Erni Sri Satya Vennela wrote:
> Performance tests showed significant improvement in throughput:
> - 0.54% for 16 vCPUs
> - 1.51% for 32 vCPUs
> - 0.72% for 48 vCPUs
> - 5.57% for 64 vCPUs
> - 9.14% for 96 vCPUs

Could you please switch to netif_get_num_default_rss_queues() ?
It used to return hard coded 8, but now it returns #physical cores / 2.
That's based on broad experience with Meta's workloads. Some workloads
need more some needs fewer, but broadly half of physical cores is
a good guess for 90%+
Assuming you have thread siblings in those vCPUs above it should
match what you want, too.
-- 
pw-bot: cr

