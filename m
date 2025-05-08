Return-Path: <linux-hyperv+bounces-5438-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31A7AB0333
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 20:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B402F504EE2
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841042874FD;
	Thu,  8 May 2025 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3AVRFZ0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC02874E0;
	Thu,  8 May 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730110; cv=none; b=GFRHweLBoGy+KVDNIJq8NOCkW2SNoNpW8+gZSnyOZ2NL+MkNmw9PAa3oet1CL+L0VHpudylF2zkMXuCorhyFIxefs5oSTHln1xTFH0BsKN4zHaEm3EJUJt/7Ndiia7JZ5Y/AyfdDwxd30X71Id3WEl/iiPDTkZo3ioOJEb16Gqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730110; c=relaxed/simple;
	bh=oRr/DvmE+Rdgz4q1zFdC2iw7yUAYJM6s4Xt8+UL+g84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaBaQ/XUi1TC9RG+Xm/Z/iydnhO0BfXpijgvIW5NJ6c9ZZtC68VDDHucBSYdaszvqi0J4dlBqqlCAATLa+XaQCnCXlze3xfK8T9Kvmdjge9v12Nn2bHovR4f9RO4P/RWYeEWj6z4Qbe+C5qIj3yVvZ7t7B96vBdrnhg9uqrFIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3AVRFZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23FCC4CEE7;
	Thu,  8 May 2025 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746730109;
	bh=oRr/DvmE+Rdgz4q1zFdC2iw7yUAYJM6s4Xt8+UL+g84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3AVRFZ0iZjowz2/QXYof4vLEyATCxasXlkJJfOXeEKyTFWH39QuvNd2LMn2mp1U1
	 8RH7FE6WN4zytgMlhvBvW2ztjcwTs/YAHB5t1WlT2IhlHljyJu2p8OoFGruq+oj09D
	 M86JnW696RJLKwmaKP2YpZeRcbzlNvnKrP7yJcPqkcfDfpGaj9ohCxZjQoqv6pTYdo
	 F3amegnif54ahkDCg25+4ic0B8jbco3FV8PhAIGeXpC46WrMVuUVsrDr3huYIq3L/X
	 BA50sopi2aFq26RhPpbpSEd6y+5i4aerQr9CVTDzs/nGSkkrkMbjlM0qucigjBATqs
	 sgWpC93F1uAvw==
Date: Thu, 8 May 2025 18:48:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch v3 0/5] Fix uio_hv_generic on systems with >4k page sizes
Message-ID: <aBz8fBWQKfH04g2u@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>

On Mon, May 05, 2025 at 05:56:32PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> UIO framework requires the device memory aligned to page boundary.
> Hyper-V may allocate some memory that is Hyper-V page aligned (4k)
> but not system page aligned.
> 
> Fix this by having Hyper-V always allocate those pages on system page
> boundary and expose them to user-mode.
> 
> Change in v2:
> Added two more patches to the series:
> "uio_hv_generic: Adjust ring size according to system page alignment"
> "Drivers: hv: Remove hv_free/alloc_* helpers"
> 
> Added more details in the commit message of
> "uio_hv_generic: Use correct size for interrupt and monitor pages"
> 
> Change in v3:
> Rearranged the patch on removing hv_alloc/free* helpers
> Added "Drivers: hv: Use kzalloc for panic page allocation"
> Fixed typos.
> 
> Long Li (5):
>   Drivers: hv: Allocate interrupt and monitor pages aligned to system
>     page boundary
>   uio_hv_generic: Use correct size for interrupt and monitor pages
>   uio_hv_generic: Align ring size to system page

These patches to UIO look like small bug fixes to me.

Greg, let me know if you care enough to review them.

Given the patches surround these bug fixes, I propose to let me take
them via the Hyper-V tree.

Thanks,
Wei.

>   Drivers: hv: Use kzalloc for panic page allocation
>   Drivers: hv: Remove hv_alloc/free_* helpers
> 
>  drivers/hv/connection.c        | 23 ++++++++++++-----
>  drivers/hv/hv_common.c         | 45 +++-------------------------------
>  drivers/uio/uio_hv_generic.c   |  7 ++++--
>  include/asm-generic/mshyperv.h |  4 ---
>  4 files changed, 25 insertions(+), 54 deletions(-)
> 
> -- 
> 2.34.1
> 

