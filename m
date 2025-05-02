Return-Path: <linux-hyperv+bounces-5316-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8816AA76E2
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 18:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C903D3AC0D7
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22B25D8E2;
	Fri,  2 May 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0u5/iY8j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4CxBAFYk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568525D549;
	Fri,  2 May 2025 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202487; cv=none; b=hyXxDttV2NkTNn+Dqy9LPynW5S6g2VxV52/7wYKGxX23LYOQ3eRwEK5xQBHH0nwuTHTrMl3lZxJrZKZlBNOeiftkkRwWmRyfKSYYripbNmUUDpdz4SVJgL88xqVnsYa+xGmSyC7wNXoWvLvMWSOKKgUWSmMj6mZbrHB++TSneT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202487; c=relaxed/simple;
	bh=7azbC98NK7A58e8i7mCZ++5hDTdVnnNyy/56u/mTpQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UTBl0jz5AZnBS1+4Li4MN6wQBAvylNRBEHHi/wROzLTA3ljpX8tCXy0Ge79Q1/uJxPYrQdgENmH8Gkg17/0LTt/hw9dfJFG7y1314QKkYxze6Bdi682+NCPTeIHkmigoEXZWK4y7f74QFN9ep6D597ujMxXcvNMIgzurv3tM9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0u5/iY8j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4CxBAFYk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746202483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7azbC98NK7A58e8i7mCZ++5hDTdVnnNyy/56u/mTpQ4=;
	b=0u5/iY8jokPrKCSd1P+rh1mE+RHmUHxEzPj6BI/YOl7JtCPBp7YdZnWTKIl//0mJoRLFmL
	FynP036wpX/kl9lU2IIvTI0vJRC26d1px+JJzAu+Nx0fL7ieRH0Get2sm+cWimdPrDgCwL
	xMmX6fGtvnVUjPRHYDyabzdeANa7RHY4Oevg9zfneCElJ6x/DNenl4RLTKFrcBchFX0Sx9
	XHFdAjfDY/PfSKuckfF7t/gKeuNNOrEMTsRNQZ8z331X2YCytpbVgDns74xJ6k7VvjVROp
	TB6cQyo3LlxPXM+PeN/dIe18jc6ZE7ZFfXnjg+dr/kzLuyhNiGGbzg5usWn7PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746202483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7azbC98NK7A58e8i7mCZ++5hDTdVnnNyy/56u/mTpQ4=;
	b=4CxBAFYk/h2fFXjtogsyW/wcsOc0fsOtgy5FivVxbfrEElfMBODSXYfm2wSWo2gQREYuUh
	nZ41Ewuz0+9HiWBg==
To: Roman Kisel <romank@linux.microsoft.com>, ardb@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 dimitri.sivanich@hpe.com, haiyangz@microsoft.com, hpa@zytor.com,
 imran.f.khan@oracle.com, jacob.jun.pan@linux.intel.com, jgross@suse.com,
 justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
 kys@microsoft.com, lenb@kernel.org, mingo@redhat.com, nikunj@amd.com,
 papaluri@amd.com, perry.yuan@amd.com, peterz@infradead.org,
 rafael@kernel.org, romank@linux.microsoft.com, russ.anderson@hpe.com,
 steve.wahl@hpe.com, thomas.lendacky@amd.com, tim.c.chen@linux.intel.com,
 tony.luck@intel.com, wei.liu@kernel.org, xin@zytor.com,
 yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
In-Reply-To: <20250430204720.108962-1-romank@linux.microsoft.com>
References: <20250430204720.108962-1-romank@linux.microsoft.com>
Date: Fri, 02 May 2025 18:14:41 +0200
Message-ID: <8734dnouq6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 30 2025 at 13:47, Roman Kisel wrote:
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

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

