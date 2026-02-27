Return-Path: <linux-hyperv+bounces-9045-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNn/NrMRommxywQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9045-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 22:50:43 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 442C21BE4AF
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 22:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8FEE30A5415
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3BF36D50B;
	Fri, 27 Feb 2026 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsSt0mNJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D928726D;
	Fri, 27 Feb 2026 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229021; cv=none; b=c4LUL6igSXEsESn7RyAB07mFOLGCmctsrOWaRwkF/KOB91rQxn8OcjlJOWnl604WeGwVFf7PUbONrI6Xl0RVmGdxYfhlZk3uRYiHAlKLjumUVAw2xOA0NIeWNqMv61kfWFgnrucKQdg7FnyqbyzjGgkYntv+pAb7jTdqxaxKajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229021; c=relaxed/simple;
	bh=NIe3uwFB3ZDCcUT+N2V9tHPzuFm+qj6ja4upwPZjqPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT9h6naKifFUJUt2WTnskJHtfL9qOZuLYenGJ5lCbUZEOZ1flfyHnXo+zcJQg1yOLghfW0RA1KTMl2J/Wyzy+8YK5XGHeJeSfOkFvmVDtWUHIiPACrEzoJwXqiNPo2Hf/dvpYuGjWvIgVLdEPuiH8t5RgsIdqtNtQVrYuV1MkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsSt0mNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97935C116C6;
	Fri, 27 Feb 2026 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772229020;
	bh=NIe3uwFB3ZDCcUT+N2V9tHPzuFm+qj6ja4upwPZjqPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsSt0mNJ5m5gLXm0JiSiVjlkv2teNisip5hU/vLMw6tg6U240Gswe0MKHD9xVLJUM
	 krvnpaBWhUEUaMyBPj3LZ7e1cY7DWhZ9VqoehGLohg6bzvfZAcUPXDi2N/VaMJ8gJt
	 flmj9gbsQ3GptDKtdE+5yOhKICYr4IlT3mEYR8suXeKRU/Lmoeo1UMOnnlRwohudkI
	 JeojyyLzPR6q4Ee4/YiQcYwdnwhC3b2hCw1xFUeG9Ty6UqPpjAXWfm1e63hB4XlXoz
	 UbyeXI5dJU+5Fx12CNFQwk9qxMYDvz4goXRRgAklH7iDrHRmKclRck1LbjmWC3dIzT
	 Lr+zsX02toSdg==
Date: Fri, 27 Feb 2026 21:50:19 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [RFT PATCH] x86/hyperv: Use __naked attribute to fix stackless C
 function
Message-ID: <20260227215019.GB976651@liuwe-devbox-debian-v2.local>
References: <20260226095056.46410-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226095056.46410-2-ardb+git@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9045-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.microsoft.com,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv,git];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 442C21BE4AF
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:50:57AM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> hv_crash_c_entry() is a C function that is entered without a stack,
> and this is only allowed for functions that have the __naked attribute,
> which informs the compiler that it must not emit the usual prologue and
> epilogue or emit any other kind of instrumentation that relies on a
> stack frame.
> 
> So split up the function, and set the __naked attribute on the initial
> part that sets up the stack, GDT, IDT and other pieces that are needed
> for ordinary C execution. Given that function calls are not permitted
> either, use the existing long return coded in an asm() block to call the
> second part of the function, which is an ordinary function that is
> permitted to call other functions as usual.
> 
> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection into vmcore")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Ard, thank you for the patch.

For avoidance of doubt, I expect another version to be sent. We will
review and test the new version on our side.

Wei

