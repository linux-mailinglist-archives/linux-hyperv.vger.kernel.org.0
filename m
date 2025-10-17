Return-Path: <linux-hyperv+bounces-7262-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0A3BEBEB8
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Oct 2025 00:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2161519A742F
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 22:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C142D5C83;
	Fri, 17 Oct 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoI/z3Bx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD1223710;
	Fri, 17 Oct 2025 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739995; cv=none; b=cqvvt4GP+FXGt90kgT3NXkS2xvZdPt8Goeeo8ETD5cdGTWyL0d3uXi2hH0n+oqzy/JmynQPR8oKxE/rGOQhYjrwOV5vrJTIXH42+qGJFZTzvKIES8HUJx09xbHyuztHhgL3/sxBNDVSe/vZqltT0F4Aw80p2um33Yc8WDC0YzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739995; c=relaxed/simple;
	bh=gIU73v5rOdsZO3fUZRbgPFMdeQuP2GhMZkte/VOxXjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkataiOmOsDbMaYFBRnUkEvfZ7MlQBq5uVn0jukujS1qt6NqqE/fmfYFwPbI6qOddtDdN7gasSD9eSnGXtUuxXg10N1jVjs7RKsNeupXIX7YPeL2c+RvigvdE0TSbTuFWBmbGfDBPmm4tqxaqvI7PUEKvLuoJ82rdG1nRcfMW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoI/z3Bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DF6C4CEE7;
	Fri, 17 Oct 2025 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760739995;
	bh=gIU73v5rOdsZO3fUZRbgPFMdeQuP2GhMZkte/VOxXjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoI/z3BxlTF/aZmtNbmfn/Pp5XeGqGLXAsIV4c3ScQCTX2ApkdcQSJ3i2OKTQrwMN
	 EUUBmBniqDf8JDkVuG/DaVpqy2VKLsg+O3lEaNEhwHcuqFSO9UMvlzVg4NJ8YMYga2
	 8VSFBLvWqboHGiIFVPM2FJ9WJ+RzRqTW7bhJ3y7KFeaN1rBH2snL/X2M2O+TfVYR4F
	 bSWPRChxdsD+SCYCgz5I0vUnsxlrcarqK91MnXUVt/9lMF38IqdqxnPhIYEFJokq6J
	 +BcHIIqwIQPD2D1POuA5KOPPCQy3Azr2mbuO6sIJ6vYSuIZrWUsxbYcpHNCTT3uojK
	 FgKzntPQ7757w==
Date: Fri, 17 Oct 2025 22:26:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, arnd@arndb.de,
	mrathor@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v2] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Message-ID: <20251017222633.GA632885@liuwe-devbox-debian-v2.local>
References: <1760727497-21158-1-git-send-email-nunodasneves@linux.microsoft.com>
 <20251017220655.GA614927@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017220655.GA614927@liuwe-devbox-debian-v2.local>

On Fri, Oct 17, 2025 at 10:06:55PM +0000, Wei Liu wrote:
> On Fri, Oct 17, 2025 at 11:58:17AM -0700, Nuno Das Neves wrote:
> > When the MSHV_ROOT_HVCALL ioctl is executing a hypercall, and gets
> > HV_STATUS_INSUFFICIENT_MEMORY, it deposits memory and then returns
> > -EAGAIN to userspace. The expectation is that the VMM will retry.
> > 
> > However, some VMM code in the wild doesn't do this and simply fails.
> > Rather than force the VMM to retry, change the ioctl to deposit
> > memory on demand and immediately retry the hypercall as is done with
> > all the other hypercall helper functions.
> > 
> > In addition to making the ioctl easier to use, removing the need for
> > multiple syscalls improves performance.
> > 
> > There is a complication: unlike the other hypercall helper functions,
> > in MSHV_ROOT_HVCALL the input is opaque to the kernel. This is
> > problematic for rep hypercalls, because the next part of the input
> > list can't be copied on each loop after depositing pages (this was
> > the original reason for returning -EAGAIN in this case).
> > 
> > Introduce hv_do_rep_hypercall_ex(), which adds a 'rep_start'
> > parameter. This solves the issue, allowing the deposit loop in
> > MSHV_ROOT_HVCALL to restart a rep hypercall after depositing pages
> > partway through.
> > 
> > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> 
> In v1 you said you will add a "Fixes" tag. Where is it?

I added this:

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")

Let me know if that's not correct.

Wei

