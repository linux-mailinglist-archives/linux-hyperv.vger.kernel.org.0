Return-Path: <linux-hyperv+bounces-6742-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9CEB44A99
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 01:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268E41C8545A
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 23:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0FF2ED166;
	Thu,  4 Sep 2025 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oon6Ebtf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469572ECD14;
	Thu,  4 Sep 2025 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030270; cv=none; b=KJuRNntI3kb+VkbI7AvLJICd5kL0dFePPd4pCeFyjo4ZxB9XFdCUTp5kQIywR9Zm7ja0LsW5KJHCL7aRNh0cfp9uZirKr/nQuRT6yuQftt86RJsAyBnfXW3WP4mKJDwCiun5xgYarrQfr7h7wkAA+rGCOPiIrcsMl6lwS1jUoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030270; c=relaxed/simple;
	bh=P+DXnz/Q91LWFyoKcdy3SDCmvxkhSnhDsa8wj5qsVZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQkeyhuFSXnduXQ0DhuoRqKLBMcgf6swwFsfd9NAA750PQErWRJtS/dAGkJH6J8MlvH3gGq/vhZxJrCAkKHoJm7LsKN8znx0w3IV9cpWE7TYfLal59T6b30jfDIsSQQWdWRw/1Z+O6hcle5YulFU3EO5R/Onow/koEjf0mZa+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oon6Ebtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C758AC4CEF0;
	Thu,  4 Sep 2025 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757030270;
	bh=P+DXnz/Q91LWFyoKcdy3SDCmvxkhSnhDsa8wj5qsVZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oon6EbtfSg5qSY14zgUxJd5zQzs174FUC7b/dnL/uHkj41ZpYOn3CYn0eLrmZ0+JS
	 ac4RN2j7in8rdy5CB8SbU35MFZXvyiG98yf8SD8G1jZ2MKYDdgfvz1/FFIzE7CqOUP
	 5ow+QW+Bkw9mZ6vkDV+kuZ1toMsDE1puCuEV0b+WCbMyIqqOtLjZ7l6Va1YV5eCSBy
	 PNaJsPdShMsVI6IPIkYq5MR4xdSx0I4Y/qL3uB8azZi1dTKTA6+TNywtv9EWzaodbv
	 C7OmdbX0Jibr34cgm7N6ZCeKsnCJBnT6y3XNDMzcMSW55PULoJu96VBY/VXFkDXZzZ
	 us5nt/mB6syQQ==
Date: Thu, 4 Sep 2025 23:57:48 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Nam Cao <namcao@linutronix.de>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Marc Zyngier <maz@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] x86/hyperv: Switch to
 msi_create_parent_irq_domain()
Message-ID: <aLonfMzpIF6FZVM5@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <cover.1752868165.git.namcao@linutronix.de>
 <45df1cc0088057cbf60cb84d8e9f9ff09f12f670.1752868165.git.namcao@linutronix.de>
 <0105fb29-1d42-49cb-8146-d2dfcb600843@linux.microsoft.com>
 <87o6rqy1yk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6rqy1yk.ffs@tglx>

On Thu, Sep 04, 2025 at 11:57:39AM +0200, Thomas Gleixner wrote:
> On Wed, Sep 03 2025 at 12:40, Nuno Das Neves wrote:
> > On 7/18/2025 12:57 PM, Nam Cao wrote:
> >> Move away from the legacy MSI domain setup, switch to use
> >> msi_create_parent_irq_domain().
> >> 
> >> While doing the conversion, I noticed that hv_irq_compose_msi_msg() is
> >> doing more than it is supposed to (composing message content). The
> >> interrupt allocation bits should be moved into hv_msi_domain_alloc().
> >> However, I have no hardware to test this change, therefore I leave a TODO
> >> note.
> >> 
> >> Signed-off-by: Nam Cao <namcao@linutronix.de>
> >> ---
> >>  arch/x86/hyperv/irqdomain.c | 111 ++++++++++++++++++++++++------------
> >>  drivers/hv/Kconfig          |   1 +
> >>  2 files changed, 77 insertions(+), 35 deletions(-)
> >
> > Tested on nested root partition.
> >
> > Looks good, thanks.
> >
> > Tested-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> 
> I assume this goes through the hyper-V tree.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

No problem -- applied to hyperv-next.

Thank you Nam and Thomas.

