Return-Path: <linux-hyperv+bounces-7258-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAEBBEBE26
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Oct 2025 00:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6657F4E3B99
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F12D3EC7;
	Fri, 17 Oct 2025 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4eeOI3+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D82C21F0;
	Fri, 17 Oct 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739009; cv=none; b=bOKMEkXlkcSSEm6/BiJys2TH+G5jBq/M5Ectic0JlbpFHzV6UnW0eYqaYvagRR2lYfgKMK/dGLRpft3QwbGbEyrpaiue5hmVpjovi0KGtNaDjYgxGZqwi1NErxzwcnQRS1xWX/75xAespiL8zBb97p20Yy4OLZ+vLSKYOCNTEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739009; c=relaxed/simple;
	bh=x1z347hMxixZcSBEbBjk9C/HpdFUHWI0+Gy1yWvmKXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGnY/hri5oRV/RAsupSbMrYBVUnd3X4HIb1EbjEJfswQGyadQ4OZgJ1PxjIIFllhIKvibH0NC2Y8JojbkpDBk9D+3YG02zaTavtmk8bZTDNqVYscWuNqLk98i7yJsgWeY+XsvFGSBVaORl9v9JpIop3aBBY8gGtn+kc2JKkEPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4eeOI3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FD4C4CEE7;
	Fri, 17 Oct 2025 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760739007;
	bh=x1z347hMxixZcSBEbBjk9C/HpdFUHWI0+Gy1yWvmKXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4eeOI3+X/mGlQVsVMVkmdFUflM5mP2guyML6aVLY3EBQEFCCWu8Ov9JztYn2tVEB
	 Sg6cR9qiMX9ME/mN5jdEO+SyCzx3754nU8GRv1gktL3WcW0Zcc8gMRca/bfR6UHtWj
	 HSYYQswg9H/ogP7Q16l6TV/bZtI6Hx6SdI8GKBstnS7O6KcJeOp+KzQrYtFmOf+w6K
	 7eba0JFMiBAA9FeK8xcWj8w6L9drrjvcFHYpM8Nh9oigsw4mC0OFJ9KWwDZZl30NOV
	 2BmwcUJVrvykMquaUiMD6fHExrIV1Cyb5yhSkuE0qvdBSCwG2ansPRqB6POQoAeac/
	 ZgmTEMGGm/AjQ==
Date: Fri, 17 Oct 2025 22:10:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: longli@linux.microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [PATCH] Hyper-V: add myself as maintainer
Message-ID: <20251017221006.GB614927@liuwe-devbox-debian-v2.local>
References: <1760738294-32142-1-git-send-email-longli@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760738294-32142-1-git-send-email-longli@linux.microsoft.com>

On Fri, Oct 17, 2025 at 02:58:14PM -0700, longli@linux.microsoft.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> Also include MANA RDMA driver in the Hyper-V maintained list.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

I changed the subject to "MAINTAINERS: Add Long Li as a Hyper-V maintainer".

Applied to hyperv-next.

Wei

