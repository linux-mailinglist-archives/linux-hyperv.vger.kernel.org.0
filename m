Return-Path: <linux-hyperv+bounces-5364-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E30AAB98E
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 08:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42BA1C41C66
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 06:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CF429B20C;
	Tue,  6 May 2025 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaYjW1m7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA9B35B017;
	Tue,  6 May 2025 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746500317; cv=none; b=V5xhzDRJp/IxhRJiztxGcR88bxzFB4X4gFWSUB1yP7yDdZ0OBehOKK5q7F6PWmHrVje4alOhwO6lF3sHqhKts+OlMjtrhTULQ4gyhxqO6igOZzi+TD7uEG0enNLImVVi5jNTiYdkRqHzImWpwILnCpHR5tkfhMW7r+yci44xwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746500317; c=relaxed/simple;
	bh=CCzSdOBwie2ZNo75Z5iSzVA/mZ0i0F05XJr3JbJx6vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVN8AL9z6vsAupGAiCYEhTy/BeTqcGuxLMTZTPD6kIgwnHDIxYkzvng8ipeIkUtA2naUlmLLUSeZ/9XKl736bmNVB7lg0EpiKNu/EeJL8CYGBJbRSlSwwqvD2NqzMw+nXk98JENLtzm+QyBZN55gVMgpFOtS/2q1OAtTEYmwszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaYjW1m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091A7C4CEE4;
	Tue,  6 May 2025 02:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746500316;
	bh=CCzSdOBwie2ZNo75Z5iSzVA/mZ0i0F05XJr3JbJx6vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KaYjW1m7K1brMSosvYek+b/rORURh0clVL30n8ST2xGORIuWEIBv3nmPtuH17emGH
	 pbG8zFG/6p/6hVM9j9NCRDxzfheu41pQ2gxwv6YyGALZqRhEk0mpR5efBe5GAzIz+7
	 lu/uVabdogYsb1Kl2D4dtwmzrsPUM4sc9azx915lEbV+U09Mz3c+n3QJjWv9Rq/xEB
	 Ne239h/peqvsU+lExT4NjkGKDD6HiwnmLT4WE3U6OYihe1qONzF4Kval11Owx63n26
	 XwhKFPgrDRFnAVkfPQ+42gaxlcYoghbA/0fUIdQgY0hdgfeayAY3DP9NUCaRLiakyO
	 lh91bjCyTHppQ==
Date: Tue, 6 May 2025 02:58:34 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, dimitri.sivanich@hpe.com,
	haiyangz@microsoft.com, hpa@zytor.com, imran.f.khan@oracle.com,
	jacob.jun.pan@linux.intel.com, jgross@suse.com,
	justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
	kys@microsoft.com, lenb@kernel.org, mingo@redhat.com,
	nikunj@amd.com, papaluri@amd.com, perry.yuan@amd.com,
	peterz@infradead.org, rafael@kernel.org, russ.anderson@hpe.com,
	steve.wahl@hpe.com, tglx@linutronix.de, thomas.lendacky@amd.com,
	tim.c.chen@linux.intel.com, tony.luck@intel.com, wei.liu@kernel.org,
	xin@zytor.com, yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
Message-ID: <aBl62kTEAnR790KF@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250430204720.108962-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430204720.108962-1-romank@linux.microsoft.com>

On Wed, Apr 30, 2025 at 01:47:20PM -0700, Roman Kisel wrote:
> When starting APs, confidential guests and paravisor guests
> need to know the CPU number, and the pattern of using the linear
> search has emerged in several places. With N processors that leads
> to the O(N^2) time complexity.
> 
> Provide the CPU number in the AP wake up callback so that one can
> get the CPU number in constant time.
> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Queued to hyperv-next. Thanks.

