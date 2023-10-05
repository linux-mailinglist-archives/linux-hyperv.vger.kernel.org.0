Return-Path: <linux-hyperv+bounces-474-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5FD7B9C7F
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Oct 2023 12:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A3069281317
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Oct 2023 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C20125B6;
	Thu,  5 Oct 2023 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HHqX91Ju"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88B6FDF;
	Thu,  5 Oct 2023 10:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFFCC2BCFE;
	Thu,  5 Oct 2023 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696501633;
	bh=4fxCXTLyJSEnYgLs6b+JCuhTnShTf/CIKp0OZexQrj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHqX91JuhSpBSMK2o5ESJ0CBb18LLzCffYRKge9Capj2sJtPUdKCWOaxUiEofWFwy
	 YXYbGFcxtC72+SdtbwVaoy04zAaGLRi5fcM2EwOsKJDm8EESrPXXCLBrKNo9yC3Sf6
	 J/H2XeTyxw7J+SIcHLdbKmLBsKxTOxNeiNxlLrWI=
Date: Thu, 5 Oct 2023 12:27:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	haiyangz@microsoft.com, decui@microsoft.com,
	apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
	ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
	stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <2023100517-rogue-gopher-e70f@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> +/* Define connection identifier type. */
> +union hv_connection_id {
> +	__u32 asu32;
> +	struct {
> +		__u32 id:24;
> +		__u32 reserved:8;

Meta-commment, I don't see anywhere you are properly checking that all
of the "reserved" areas of these structures are actually set to 0 when
they are sent to you.  If you don't do that, then they are not really
reserved at all and can never be used in the future, so properly check
them please.

thanks,

greg k-h

