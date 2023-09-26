Return-Path: <linux-hyperv+bounces-274-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F71A7AE4BE
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Sep 2023 06:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D1B0E2812D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Sep 2023 04:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7311116;
	Tue, 26 Sep 2023 04:52:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9D1104;
	Tue, 26 Sep 2023 04:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B255CC433C8;
	Tue, 26 Sep 2023 04:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1695703969;
	bh=iGK9D3ZNtj+5ANQTbtas8J/bXpKtY1WHDqCBdj2Av4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLgtvJyF861iGKa4EHORO573v2aAToqpZePuQMDajTxqmvCLikWKkE2c0n+6XbKbx
	 qM8XZH3qkZOfDsne4xtW8l6LDB0d7g594/IeRt4Ed1WirTJMW8uO4hXslyZXpNJZ9C
	 1xm9TgUlfgSYHgWCafxidm53sCZfxcTmsvQlDpAU=
Date: Tue, 26 Sep 2023 06:52:46 +0200
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
Subject: Re: [PATCH v3 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023092630-masculine-clinic-19b6@gregkh>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023092342-staunch-chafe-1598@gregkh>
 <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e235025e-abfa-4b31-8b83-416ec8ec4f72@linux.microsoft.com>

On Mon, Sep 25, 2023 at 05:07:24PM -0700, Nuno Das Neves wrote:
> On 9/23/2023 12:58 AM, Greg KH wrote:
> > Also, drivers should never call pr_*() calls, always use the proper
> > dev_*() calls instead.
> > 
> 
> We only use struct device in one place in this driver, I think that is the
> only place it makes sense to use dev_*() over pr_*() calls.

Then the driver needs to be fixed to use struct device properly so that
you do have access to it when you want to print messages.  That's a
valid reason to pass around your device structure when needed.

thanks,

greg k-h

