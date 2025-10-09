Return-Path: <linux-hyperv+bounces-7177-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A038BCB13A
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Oct 2025 00:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D703A678A
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Oct 2025 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF408286405;
	Thu,  9 Oct 2025 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LgtJHO/L"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B690285CBC;
	Thu,  9 Oct 2025 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760048779; cv=none; b=LOazrgPmSBrGsRGsWB3Dz87k3eTAnn6dDPwvm9RdtNiBk1phOy+/rJebHfEVbCWzQYg3YMw9tBOaqLdoJK6akgURDOZINMPwGnSi4t5pc3mpoJubPRrg6xFbRxLjlomapoNaXsp8IWFvmS8+XzmZpkP/e32lu1bjFd3E06+Ox7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760048779; c=relaxed/simple;
	bh=qaf2qvbNG3xgkasgQKuyYK8PEMZ9f8tNNu7DLbm9w5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue7UZwgmNF7itd6KG26mpDZ1uHS+kYmz4cWXDF/xVIe97W1hEfzaIt5sByjyh+eQm/48p8szIqBAUrtKBjWpKfAQBG9ucci8PK9L4tFFpvkaksG/L6QVi3vvXN/gTxMRDIDWXvZ8qPCYne9XQCEuNLKF8UKufCKEQQQ/hVGE1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LgtJHO/L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3C0B72038B73;
	Thu,  9 Oct 2025 15:26:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C0B72038B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760048777;
	bh=mazmiWb8e/xD90iLZlCJ3KQJqnRkHcjZOWD8ITBL4ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LgtJHO/LtI2EKwnPqU5ljp4KqzDz3fE0JbTaWAFRRVb0PkF58MZSWfWx/htITLjmv
	 tsQvXhuPD1OXCql/KhEOjDNPMtVK1HvwHLekcU4/u7YCvBv6AYnqnJ/vevunsdD1qd
	 Y6xz9+y6h7AwUMcWHO1P7mAeS2iOR79AaO+9UI54=
Date: Thu, 9 Oct 2025 15:26:14 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, anbelski@linux.microsoft.com
Subject: Re: [PATCH 0/2] Add support for clean shutdown with MSHV
Message-ID: <aOg2hiWM4PZ8D1S5@skinsburskii.localdomain>
References: <20251009160501.6356-1-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009160501.6356-1-prapal@linux.microsoft.com>

On Thu, Oct 09, 2025 at 10:58:49AM -0500, Praveen K Paladugu wrote:
> Add support for clean shutdown of the root partition when running on MSHV
> hypervisor.
> 
> Praveen K Paladugu (2):
>   hyperv: Add definitions for MSHV sleep state configuration
>   hyperv: Enable clean shutdown for root partition with MSHV
> 

There is no need to split this logic to two patches: the first one
doesn't make sense without the second one, so it would be better to
squash them.

Thanks,
Stanislav

>  arch/x86/hyperv/hv_init.c      |   7 ++
>  drivers/hv/hv_common.c         | 118 +++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |   1 +
>  include/hyperv/hvgdk_mini.h    |   4 +-
>  include/hyperv/hvhdk_mini.h    |  33 +++++++++
>  5 files changed, 162 insertions(+), 1 deletion(-)
> 
> -- 
> 2.51.0
> 

