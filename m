Return-Path: <linux-hyperv+bounces-7201-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4999BD5D24
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 21:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B6124F3072
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Oct 2025 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E129E0ED;
	Mon, 13 Oct 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwV63GUE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C51DC997;
	Mon, 13 Oct 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382016; cv=none; b=PXKdlfDntp8XhlId6rsQi3txKaCEHoKzloxyXQ7Cwiv4+ZI4wG9bQE57hgkfLxn/SJsAX6iKXl4713SdbkRHy4vp+ikpgwswdqJQ7rXEUhpdSJG/Pa0H4ldiVhithWDij8xvJv3SxY17oDWH3srAqBq06iALlN+68/7SoA+mSrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382016; c=relaxed/simple;
	bh=5EIIo7xIsDMDbg95u7VVmjUkhvw9f+hecMwLewZqkD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1aNIOmfY/JMm4Ji1X5AveRbys7n4AaWIyRNI5B92BMzSyvGt9hzVhTpO3tSQp4vsTiBle1apm2CVuAkeV6OMII5Qzp75LUNtgDsRdcvMamhgtvyxzaQHkD62frv4zYsEpkUGS8pYBGiuvCajien/LgD+vbhUk1aA8x81F0mVdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwV63GUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF04C4CEE7;
	Mon, 13 Oct 2025 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760382015;
	bh=5EIIo7xIsDMDbg95u7VVmjUkhvw9f+hecMwLewZqkD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwV63GUEFW1HEtsvKGIOzNK4qzj/TyB/NWMKYKvpqiPLyVkDlN9ogl4t1xknVvBhy
	 o3tzDmBPCoWfefJi4m+3sgWU6LGILX+Vc1QaB4LXZygEOxbxj68463xZaYo2aDAkfu
	 uB1DvEt7DFwMXRV8jlfnUccWg7xpRNjC6gVkYH1hvFvHvmMDvK6GpqBZXBZbhVYhWx
	 eJ3nXHaaB/zv4Wr5eB5eWAYM83WuTfMCLLUoDmTr6eoyQEMPdLm+cyUjM/W18cZUm5
	 CVNdHHMJsAp4L5w9Y1RvprAhrW4Ao1z+4L1cA7ooAd2GBwIbs/1/Ti/bfOK3N5NfX8
	 4/EK/jjL7hBQg==
Date: Mon, 13 Oct 2025 19:00:14 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com, anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com, skinsburskii@linux.microsoft.com,
	mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com
Subject: Re: [PATCH v5 0/5] mshv: Fixes for stats and vp state page mappings
Message-ID: <20251013190014.GA3862989@liuwe-devbox-debian-v2.local>
References: <1760133351-6643-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760133351-6643-1-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Oct 10, 2025 at 02:55:46PM -0700, Nuno Das Neves wrote:
> There are some differences in how L1VH partitions must map stats and vp
> state pages, some of which are due to differences across hypervisor
> versions. Detect and handle these cases.
> 
> Patch 1:
> Fix for the logic of when to map the vp stats page for the root scheduler.
> 
> Patch 2-3:
> Add HVCALL_GET_PARTITION_PROPERTY_EX and use it to query "vmm capabilities" on
> module init.
> 
> Patches 4-5:
> Check a feature bit in vmm capabilities, to take a new code path for mapping
> stats and vp state pages. In this case, the stats and vp state pages must be
> allocated by Linux, and a new hypercall HVCALL_MAP_VP_STATS_PAGE2 must be used
> to map the stats page.

Applied to hyperv-next. Thanks.

