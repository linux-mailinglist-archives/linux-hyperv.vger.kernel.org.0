Return-Path: <linux-hyperv+bounces-8051-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110DCCD5B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Dec 2025 20:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7884F30330BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Dec 2025 19:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355B72E0400;
	Thu, 18 Dec 2025 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEEk1oej"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4002C08B1;
	Thu, 18 Dec 2025 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766085325; cv=none; b=YQIOnkbjyexi7OtNLpQeTXWGKzWAvzyOw1uIyaDspEZsvK2k5JSKuUQ+N6RG2jowHoJMjnSkv024m3B9LSsbT1APz98PIWC72sehzfYmr5j+WY/3kNkf1O08RbysKXQDCkcYGaZeoT/3gnEHqAwPujclyhcaQSUbtBQQgArkAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766085325; c=relaxed/simple;
	bh=ecrfCsyUunDIDivMHuD/sH/gmH9y0r8gk7ee8jsNyjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqGXcI+DvPg3GF++n5lapgmgyXOdj+TWL3RMOVgfQy+5+oUzewuTcfD83El/dzwGdaMGDFeiY90JQQLTz0V2YT7EhJbglBuC1CoUG23DmV/RIxDn/bi3OyDhJbJGnBysmIWm25TtIYCwxspZPr6hwmE71gAawU7IXAitpbY4QsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEEk1oej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5717FC4CEFB;
	Thu, 18 Dec 2025 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766085324;
	bh=ecrfCsyUunDIDivMHuD/sH/gmH9y0r8gk7ee8jsNyjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEEk1oejdUvALSb6kveQ3znbhn8tBk9y7W06N5/MYov/kJ6Kuedhz2sNZjPqNN59L
	 f6vHiuUyR0wAqhat1tQMg2+HPcOAE4RLxkRUvr+hT8snTrqBTKkfvX/4MqL8Hf5mUD
	 HWjc0czSfjLTswYb+lkgRQ83zL1LgeTxk+AFVhHVkQkDFG/CHwrNx/rLt2DKAp2c8P
	 nfUZn4ahIFpa17FO7JwDQiAQ5IkTGXb0qxk8hXIfWpZO6vEzL6TK0geGZRNuC63Bjf
	 8zMqjsoNWxAnwTLRb0K31U2P3cqgYHb48UG5ACON7ZXW/348+75rg+gI8D5uT7m71s
	 XaEwGZI33J4aQ==
Date: Thu, 18 Dec 2025 19:15:23 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Stansialv Kinsburskii <skinsburskii@linux.miscrosoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Anatol Belski <anbelski@linux.microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sean Christopherson <seanjc@google.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: hide x86-specific functions on arm64
Message-ID: <20251218191523.GB1749918@liuwe-devbox-debian-v2.local>
References: <20251216213619.115259-1-arnd@kernel.org>
 <20251216222129.GA1300707@liuwe-devbox-debian-v2.local>
 <aUH9GGzROHfbP6pj@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUH9GGzROHfbP6pj@skinsburskii.localdomain>

On Tue, Dec 16, 2025 at 04:45:12PM -0800, Stanislav Kinsburskii wrote:
> On Tue, Dec 16, 2025 at 10:21:29PM +0000, Wei Liu wrote:
> > On Tue, Dec 16, 2025 at 10:36:12PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > The hv_sleep_notifiers_register() and hv_machine_power_off() functions are
> > > only called and declared on x86, but cause a warning on arm64:
> > > 
> > > drivers/hv/mshv_common.c:210:6: error: no previous prototype for 'hv_sleep_notifiers_register' [-Werror=missing-prototypes]
> > >   210 | void hv_sleep_notifiers_register(void)
> > >       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/hv/mshv_common.c:224:6: error: no previous prototype for 'hv_machine_power_off' [-Werror=missing-prototypes]
> > >   224 | void hv_machine_power_off(void)
> > >       |      ^~~~~~~~~~~~~~~~~~~~
> > > 
> > > Hide both inside of an #ifdef block.
> > > 
> > > Fixes: f0be2600ac55 ("mshv: Use reboot notifier to configure sleep state")
> > > Fixes: 615a6e7d83f9 ("mshv: Cleanly shutdown root partition with MSHV")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Thanks Arnd. I have a queued up a patch which make available the
> > declarations to arm64. Let me think about whether to use your patch
> > instead.
> > 
> > Anyway, this issue will be fixed one way or the other once I send a PR
> > to Linus.
> > 
> 
> The whole idea of mshv_common.c is to have common code for all archs.
> It would be nice to keep this file as it is.

The path forward is either to move these functions to an x86-specific
file or to make arm64 work the same way. I'm not too sure about the
latter yet given the port is yet to be done. For the time being, I am
going to drop my own patch and take Arnd's patch. We can figure out
which of the two approaches to take later.

Wei


