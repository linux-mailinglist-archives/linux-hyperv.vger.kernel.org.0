Return-Path: <linux-hyperv+bounces-4801-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 005E8A7D3A3
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Apr 2025 07:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BFB7A3BCD
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Apr 2025 05:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E95224258;
	Mon,  7 Apr 2025 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNvARVZf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769C20F093;
	Mon,  7 Apr 2025 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744004528; cv=none; b=KbQ8Yd/Ft6o8++8mArzqUIibRNFcy/Mtd+WUHXadn3GzFx2mj6I2I5PBn27UCD+LWXQx3nTkiIGTAsWSkkP/ZcQnshzyYmRdh1KFB3UPGSDEeAqyvTEwSXr7O8CUPu6+Ii10oc2NZNJ+VpyN99fUeE4LQM6GsPGph3HwGU+pItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744004528; c=relaxed/simple;
	bh=RSwbvv0qIoQs2um0mScuvh6q7YNXBwU2GFXsViG6ArE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEmLzrOq9FmmEvl7scs4rLTGuEHngVoXqRVPW91TNeBSBWg6PYVSkIV5TGPFPdbbB8WjXojPKKo0yuNADUXyjn+LKnRpOfm3+lO931L4yvh5YqMPTTvjCdRxa+enNDmEWhP0HL1W1PXZC2ljmklLCWxvmkb+VAXFwJ5YUaUz+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNvARVZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55810C4CEDD;
	Mon,  7 Apr 2025 05:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744004526;
	bh=RSwbvv0qIoQs2um0mScuvh6q7YNXBwU2GFXsViG6ArE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNvARVZfDl4Qp5M4TFI3QuCkCW625zxVf6M/X/Yt+GA5GsQIWYmBDV7P2DNxv0gXg
	 iEkXIU5phghDFDFkZ+k61fGEwFUoJXNE2qHqnplt6T9IaUQqP2uKLYuoR3qzUaZoQT
	 5tocNEU/UmxvemN3QH2baaChtBbHKZJv0mtfvM8AZ5sh/zkA1QAjZblY8m4/WXctb4
	 X0y7otVzDtMXxeajkwwqvV9H0NkG76W5HzLgXx/PYflgG+ZtW+7b9t7IVTfev50uMf
	 p7LO05/LHyZB+EWA2hUTWwMrJV38Tj7ZhHJFI1OZD94MNTFPrJ0/lGzCoUYpn5f6Ff
	 RZ2bmSxrtpYZA==
Date: Mon, 7 Apr 2025 05:42:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	mhklinux@outlook.com, decui@microsoft.com
Subject: Re: [PATCH] Drivers: hv: Fix bad pointer dereference in
 hv_get_partition_id
Message-ID: <Z_NlrCgFmErcp-8U@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <1743528737-20310-1-git-send-email-nunodasneves@linux.microsoft.com>
 <b7102dfb-86e4-4a85-8444-de18258473f2@linux.microsoft.com>
 <Z_NheILh0exTxoo1@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_NheILh0exTxoo1@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>

On Mon, Apr 07, 2025 at 05:24:08AM +0000, Wei Liu wrote:
> On Thu, Apr 03, 2025 at 01:54:37PM +0530, Naman Jain wrote:
> > 
> > 
> > On 4/1/2025 11:02 PM, Nuno Das Neves wrote:
> > > 'output' is already a pointer to the output argument, it should be
> > > passed directly to hv_do_hypercall() without the '&' operator.
> > > 
> > > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > > ---
> > > This patch is a fixup for:
> > > e96204e5e96e hyperv: Move hv_current_partition_id to arch-generic code
> > 
> > You can add Fixes: tag, so that it gets ported to previous kernel, in case,
> > it does not make it to 6.14.
> 
> This does not need to be ported to older kernels because the bug was
> never released.

To be clear that was just a passing comment. I'm not against adding a
Fixes tag. I've done that while applying this patch.

Thanks,
Wei.

