Return-Path: <linux-hyperv+bounces-9044-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF0gBMsOomniygQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9044-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 22:38:19 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD1D1BE390
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 22:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA9A3028000
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 21:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7535B478E31;
	Fri, 27 Feb 2026 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW2bS5na"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D111E00B4;
	Fri, 27 Feb 2026 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228255; cv=none; b=Hk1GH8aH1GBuRYia/E9tjW7r79AktCW2KRo8PUEmSO8wV3QofN2dmPQoyb0zxFwzs7RqPlq+Pcc5Hi+pgPQby2PHB5WSO4u4aBwSWYxW30rvv9pjgIvwtsaDxXrevgvo1R+/4ruqcZgt0d6DGcLCjbsJ6Vs/i5ose4Sz7WVri+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228255; c=relaxed/simple;
	bh=r9Sg7xTfjq2gEX3/0CVF0anqfcyOhcWEqYw9kqqFzFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ed+Y36WMMjFmpSxqDf0INsWMM8WmMecTqb5JN8MJF86qfA6z7ytPC+0AJ/+EdTfEofPEwUsQb2P3z563nDVD910wFtucHYopXKOLNAME7j8jeuJvP2pbKzC2M5lDMUckPITjYCEHINcpF3ro3FsduJzChexZkI2gM+d+jsKvor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW2bS5na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4783C116C6;
	Fri, 27 Feb 2026 21:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772228255;
	bh=r9Sg7xTfjq2gEX3/0CVF0anqfcyOhcWEqYw9kqqFzFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZW2bS5naQ/VGOt9gGVxsq/bdmhCQXYziH79Cbp2XE1p+vCJZ1LLOtZdxFqQbjN+qG
	 CpfiUiuoLd3AZp+1RdI1OlfJjkIe5tpIQ+nyYp6aADgsw7WKjkreXoolizBMXPOOTn
	 rxa5E6Ftd6sYhlqmodZfqd/GFckRmHc0PO4YbHARzNfxbFXV6XpOs/15vnd0rpKCCa
	 X+0p5smXb5ZfyLnko3mWv8/F7Ohhi5bq/o4ToVuCdyBvgu2NZ9AAiySb3sAbhGSGhV
	 TQxQnV7e6guFxntWYV6wKpJImiLEDNAEZG3fj4WXeXQ9TLIa4cRxB7R1fW/tovmaok
	 lu23k+pmlyYJQ==
Date: Fri, 27 Feb 2026 21:37:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>, ardb@kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	dave.hansen@linux.intel.com, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Message-ID: <20260227213733.GA976651@liuwe-devbox-debian-v2.local>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
 <38cdec03-889e-43dd-9dad-e621aba9dc8d@app.fastmail.com>
 <f8199494-0c42-5eb0-f99e-cc6f6e304d40@linux.microsoft.com>
 <eb1c44d7-2664-4269-8824-e90e5a8494b2@app.fastmail.com>
 <6a601546-a26f-79f6-a3b0-be145dfa7781@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a601546-a26f-79f6-a3b0-be145dfa7781@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9044-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 7CD1D1BE390
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 12:05:13PM -0800, Mukesh R wrote:
[...]
> > 
> > So? But does it means to 'be in asmlinkage' in your interpretation? Did you check what 'asmlinkage' actually evaluates to?
> > 
> > I am not asking you to justify why this broken code works in practice, I am asking you to fix it.
> 
> 
> STOP bossing me! I am not your servant nor your slave. And you are not the
> only genius around here.
> 
> Now, many people looked at this code before it was merged and no one really
> thought any self respecting compiler in modern times would create an issue
> here. Still, I see the remote possibility of that happening. All you had
> to do was to show your concern and suggest using __naked here (which looks
> like we all missed, or maybe it came after the code was written), and it
> would have been addressed. This is x64 specific code for very special case
> of hyperv or kernel-on-hyperv crashing.
> 
> In future if you choose to correspond, watch your tone!

Mukesh, there is no need to be so emotional and defensive.

I don't think anyone, no matter how good he or she is, knows all the
intricacies in the kernel. We're lucky to have other people look at our
code and point out potential issues. Regardless of your opinion on the
discussion, we should be thankful for the time and effort people put
into even sending an email, let alone a patch.

Let's keep the discussion civil and constructive, and focus on the
technical aspects of the code.

Ard, I want to let you know that I appreciate you raising this issue
with us.

Thanks,
Wei

