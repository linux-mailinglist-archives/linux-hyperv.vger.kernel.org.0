Return-Path: <linux-hyperv+bounces-5363-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BB3AABA2C
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 09:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043E63BACD4
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF7829AB03;
	Tue,  6 May 2025 04:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIZV/0JR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743A2E6882;
	Tue,  6 May 2025 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746500245; cv=none; b=kegKu3ZCIoshtZWSCnroj6+btWbJKqOVgi5D3VSi3RaMEdpwYuXTqhsTDr+nphozC3iLDe3c9R49gj0tK1i8cR1oA3J+5c8DDncxsBf0mR5zKMvUOcZaNr9jtKPqeHDzlwqP6ENo+FRIAkpafceb7xOs9APn2dyBmylxF3cg3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746500245; c=relaxed/simple;
	bh=25+JJqPEmz/bA/aRMxkJF89rXhOiXRbvpMTWX2doLLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbyVGBsE/dDtVJ8ooDft52xyMVsVw3lM/j8Fn/2nB1GgBK4qnZMJIJnKMQZ4U5sHhV18xihw5+e0wnPeWJHY/ufsqmrERWQl/Ti0vJ1mN6mjK6NFonCcD4/HkeVgKFI+q/MuxU4YpHgrt0/lNKXsbg0bqxHvNA7tLm5rPg9PtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIZV/0JR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E57BC4CEE4;
	Tue,  6 May 2025 02:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746500244;
	bh=25+JJqPEmz/bA/aRMxkJF89rXhOiXRbvpMTWX2doLLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIZV/0JRgvpM/XRwMSM0321GckXfyNDzcf4DOG4n0VIbGIBL2Q9eCwKUH2baqVvip
	 zQaXqDoTTnOSJ20yPEFCjU2eWuy7uAjJ03zl6DIlr3smfwsuN/D+Nt7ZwOb+zVB9xO
	 JqhsICja1Y2AOQLf7tyI9kIK1V+sEKnV+TvXWXKRmGorE63f9YXcb2O94+/s8Le1Uy
	 6+FuNgsSu1Q4iivvmDnlvb8gU1phz/xHqIoYV3aT3u2kTY7PXZhq6W+Sz26hXnraEH
	 dJIHpgoGwtTGwJY8xlwuqCKCKUmZTrbPcfpn2MQyjb7ziGjTCy5UydZlNJqIoNJkVS
	 wYyKTkPaCJk6w==
Date: Tue, 6 May 2025 02:57:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Wei Liu <wei.liu@kernel.org>, Roman Kisel <romank@linux.microsoft.com>,
	ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, dimitri.sivanich@hpe.com,
	haiyangz@microsoft.com, hpa@zytor.com, imran.f.khan@oracle.com,
	jacob.jun.pan@linux.intel.com, jgross@suse.com,
	justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
	kys@microsoft.com, lenb@kernel.org, mingo@redhat.com,
	nikunj@amd.com, papaluri@amd.com, perry.yuan@amd.com,
	peterz@infradead.org, rafael@kernel.org, russ.anderson@hpe.com,
	steve.wahl@hpe.com, tglx@linutronix.de, thomas.lendacky@amd.com,
	tim.c.chen@linux.intel.com, tony.luck@intel.com, xin@zytor.com,
	yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
Message-ID: <aBl6kiJkx2NAUMx4@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250430204720.108962-1-romank@linux.microsoft.com>
 <aBUByjvfjLsPU_5f@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <41778d44-19dc-4212-a981-d5a82eaf9577@linux.microsoft.com>
 <aBj895aOnhgsIiwO@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
 <8bb6418f-0131-4a75-aabe-c753841d116a@intel.com>
 <aBl5hhE2mY5ygq8l@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBl5hhE2mY5ygq8l@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>

On Tue, May 06, 2025 at 02:52:54AM +0000, Wei Liu wrote:
> On Mon, May 05, 2025 at 11:12:10AM -0700, Dave Hansen wrote:
> > On 5/5/25 11:01, Wei Liu wrote:
> > > You don't need to do that for this patch. Please point me to Thomas'
> > > reply to the previous version and I can add the missing tag to patch
> > > while I queue it.
> > 
> > It's right here:
> > 
> > 	https://lore.kernel.org/all/8734dnouq6.ffs@tglx/
> 
> Thanks for the pointer. This is appreciated.

Oh, it is right there in this same exact thread. I'm dumb.

Wei.

