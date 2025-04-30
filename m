Return-Path: <linux-hyperv+bounces-5267-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF369AA5782
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 23:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0333AAD7C
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 21:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2635621D3DD;
	Wed, 30 Apr 2025 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEIyXiN9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B91CAA62;
	Wed, 30 Apr 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746049016; cv=none; b=stjS1UBFoKFd5fmSgRaDMz4pH/EWWaBBQH6nxU8MRQpEE+2tRrnvfMNqw1o7N8pR8BmccUobmiQ1UGR1jFGTCEr4JJOtv7fv9wDuloZdoFVAzUfDfeKRaWwpdXFl3TCcSbejCNxsyNZnHLxtEvTX9+JxwCfcM3VLfjIdDbP9bls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746049016; c=relaxed/simple;
	bh=i3LQ4xghUfiRhkGVDl0dJEme9VzY6nhKIHiIrhFzLY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esx9gK/nxsx5q4y0wbMWQa4wptWAYUjNq/aL4F+24zO++auQ/fLfE089aOUFOH9Bv8aJSV7lqCIfdpBr0/Byzov3xmLPsVLd+u5oFcXXCRNdpQVIGJ3+4gcVIJiAI5wX2xwWAVGE975FwqIAd854QpNbMrwdYuf5AIDB2PmcfOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEIyXiN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5DDC4CEE9;
	Wed, 30 Apr 2025 21:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746049015;
	bh=i3LQ4xghUfiRhkGVDl0dJEme9VzY6nhKIHiIrhFzLY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEIyXiN9mat+0DT0+qnPEsDqs6AM2XcuFP6PN9puaay9kG9IXD0ND7N4JjcGw6tMA
	 gHn7sEmii2I6vnwk6WPxFaumytrq+aR/2dUN1koj27G8uzau9RolMDn5NSNIHvvY3R
	 QmlgYD652S2MibZWMXQrCfU8ZCcfp3uOcXqM6Eq9ZuH5myY5p4sZjbjR1WBHh+5R3y
	 uaJ/XwPv+ce6HV89UI6O27DyhyGLT2XA6aeb8JCk0iny1i29mkAtV7tx8fay/NmfCL
	 HLhxjdgAuYu0cNk6kZ92CfnyvQfCvf3mtgTbbwuCMJDv2e/5VnON7SgiGC7c3YqEky
	 LJqS6dnNwtgag==
Date: Wed, 30 Apr 2025 14:36:52 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] PCI: hv: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <202504301436.1412C521A4@keescook>
References: <aAu8qsMQlbgH82iN@kspp>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAu8qsMQlbgH82iN@kspp>

On Fri, Apr 25, 2025 at 10:47:38AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for a few on-stack definitions
> of a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/pci/controller/pci-hyperv.c:3809:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/pci/controller/pci-hyperv.c:2831:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/pci/controller/pci-hyperv.c:2468:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/pci/controller/pci-hyperv.c:1830:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/pci/controller/pci-hyperv.c:1593:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/pci/controller/pci-hyperv.c:1504:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/pci/controller/pci-hyperv.c:1424:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

These all look like good conversions to me. Thanks!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

