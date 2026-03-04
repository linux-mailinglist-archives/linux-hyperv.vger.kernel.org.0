Return-Path: <linux-hyperv+bounces-9132-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APrzFjnIp2kZjwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9132-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 06:50:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D18641FAF9B
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 06:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12421302BEA3
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 05:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9236C3659EF;
	Wed,  4 Mar 2026 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnAWyYLF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC554964F;
	Wed,  4 Mar 2026 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772603429; cv=none; b=RG+9fMIKCvtu5Ij/arrTSQyiR/lAAWVEECkDQlGCFbE8xL02rXyhT72MiGM+Fx6KCF44kbeNN1r1gACUhsR1SQfkKuljV4O/OPVfQ8Dtvs2WK13/3hsXDfJyHsagrjDZnsw9KNi/Oy97Eic4nqsZDSfIMESEwCXcqX1mwmApAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772603429; c=relaxed/simple;
	bh=n3OfpUjvT7rOEwa7/WKHKHbNYndJJKC23EthuHgtdDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtqgQyTEU67wmuS/MmHfTG6IJvqhNGGVMOumE9F4XYyaVDgD1EpFKIKbO4CuZMXO0bhUCFXbjHBvER2AmkSWiQyx+LD+WpRLtcpfh2aAtNt1aw+YwtnK1+HXYBoKNoKvASlD5cFYaxq68lI+6msrWESiAwzspzyKdHkxFRc4L+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnAWyYLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B48C19423;
	Wed,  4 Mar 2026 05:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772603429;
	bh=n3OfpUjvT7rOEwa7/WKHKHbNYndJJKC23EthuHgtdDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnAWyYLFrLCg+WGV5MeuB4q2/3MTr7z8L2D6Cv6b6jXAh2MeD3sS1VKd6nWZxkuwp
	 /qqT54tyQZG8r97b+a5DD5YR5vbGt2VpwPqGlE6MTWYeDH7RViAWOzMCMqix+msdUG
	 QR82JxVJyzi/7UVvJ3KzkGo2GVIL0FNhisocNOiYzuTrcEw7/w8gaNH9RE7jQyKuWN
	 SB+4TIha/Lil9+3UUSVVatJKNtXfMjVrO1qhs7gKN49JtoAo+uhqciLKxPwMu8V3pG
	 e7lPv4mkzdy/vLROGxNvzPLp2SNEvFvryR10kBup+FgVL755Asl7wev0INfsNZJbkj
	 5lNAq4zOulxHw==
Date: Wed, 4 Mar 2026 05:50:27 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Uros Bizjak <ubizjak@gmail.com>, Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3] x86/hyperv: Use __naked attribute to fix stackless C
 function
Message-ID: <20260304055027.GA1903516@liuwe-devbox-debian-v2.local>
References: <20260302164530.50005-2-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302164530.50005-2-ardb@kernel.org>
X-Rspamd-Queue-Id: D18641FAF9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9132-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,citrix.com,linux.microsoft.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,citrix.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 05:45:31PM +0100, Ard Biesheuvel wrote:
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
> Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com> # asm parts, not hv parts
> Reviewed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Acked-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: linux-hyperv@vger.kernel.org
> Fixes: 94212d34618c ("x86/hyperv: Implement hypervisor RAM collection into vmcore")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Applied to hyperv-fixes. Thanks Ard!

