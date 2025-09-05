Return-Path: <linux-hyperv+bounces-6760-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B876BB463D6
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 21:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000671B26C28
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E227FD49;
	Fri,  5 Sep 2025 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LznPtiEo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9C13D539;
	Fri,  5 Sep 2025 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101409; cv=none; b=ulbyT+HPL5/JDK2z+rBOwep8MN4MEBiju78ThFma+S0m3Wncc70dQ/yhPzl6UOwJDT6uK8s7S+SxecyIy8HLENQtRlbFVJ03XCgYhfnWXurLcNODoUEbxxq/GNNrYwYn2PFNXgYHRjIcLrsJFMuvE660bVmkSry60qvIhhhHFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101409; c=relaxed/simple;
	bh=kUaZsgdrtAzBGC136r2KuvOF39F0qv0wX3HzXCLvRcE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iiZ4AorYzzDlA4IAv6Gn2OHYZ3f5hnGmhgpAc/b+UlJEZpn7PzmlzU1KFmrM3OYl8vVOYaZU+LQNg1jiIU0L0Fr9Vie8R+Zh1DaCcGHpWZaTwCFoQxZgoM+hHh+Ao3F1dtdG9AVZGtCtNZ5NZ7e3C4hGIg1d8eB1fbuSKS8aHFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LznPtiEo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.45] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5266620171D9;
	Fri,  5 Sep 2025 12:43:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5266620171D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757101407;
	bh=NVMtVuNxtVKJCWkS9b6Jkw0XCRDxNqbhriGSsDCTEFM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LznPtiEo9Jr/SFWfcIipsBZN6TQaO/96yJ8Maseyc1UppCwyb6ajhUiklJLErHRhq
	 Ewqdv7v+h2DmK1XLDcgxs26xHq0E9rvFHUYjOgIX8uG+9nl1dXw3gSrxxlF4IX13UG
	 Sg6ASei/Jt7HjP9MfxcWauzq1QMXydmMwV9thzBs=
Message-ID: <c2b2f131-5e7d-4313-bddd-a12fb73d5b06@linux.microsoft.com>
Date: Fri, 5 Sep 2025 12:43:26 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH 1/6] mshv: Only map vp->vp_stats_pages if on root
 scheduler
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-2-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1756428230-3599-2-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2025 5:43 PM, Nuno Das Neves wrote:
> This mapping is only used for checking if the dispatch thread is
> blocked. This is only relevant for the root scheduler, so check the
> scheduler type to determine whether to map/unmap these pages, instead of
> the current check, which is incorrect.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

<snip>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

