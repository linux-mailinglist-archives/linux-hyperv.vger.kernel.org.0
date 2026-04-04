Return-Path: <linux-hyperv+bounces-9981-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAQmNX6r0Gn6+gYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9981-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 08:11:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DD739A187
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 08:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A1B3007E3C
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 06:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C735E921;
	Sat,  4 Apr 2026 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo6GC2Nz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F472C21E8;
	Sat,  4 Apr 2026 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775283067; cv=none; b=Hu/5SsHC9oghmGLxb5ycSxiGDIUT9R9a60xYZxJ6qWG1HAh3bvuD0aNfaGTuygkFJUQ933QS1n/qzSej3b5a5AJ1JrGjlczkevjsStSaqd3BbOb7vqqO/Vc2DYRshAvdlUbWV/U28ljIEFnaSo7W7SFsk+vS+h8tKdoEnIDwMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775283067; c=relaxed/simple;
	bh=ZtzFClOB+Kj6ezVFI7LgGkgYWZlEzzMhdc7YAFHzGqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u631AlyzxnPzUWP2UDEYepL41tLWyr08yZRfGJQ+ObKZYCeXzDmL/s/4FU2R7S+u57TSANWy/jjV0eMjeuPKgR/iS+ZA+XPcXI47ux4SPIny3/iu7Kuq4524pCiYl8xxiEO/bm4Sb4rlRTCAwTRoGGLVu5u6OpoO/rb42yEMMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo6GC2Nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD913C19423;
	Sat,  4 Apr 2026 06:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775283067;
	bh=ZtzFClOB+Kj6ezVFI7LgGkgYWZlEzzMhdc7YAFHzGqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vo6GC2Nz4+3PeA5uxcsZ/iYTvu9WTQFm/TdY1pLLupX5BSzX48LKxjLhnkrdlBKrR
	 cahJeZUYKSIldD3qakqdE9desRKUMUBNVmigUKNOjbVznJY74BFIE6vEip5e5sy3Yl
	 s1o/vw1lZm4AXhxeEZl5GxcizBnzOeXFHEG4pR194b5dHN4MQf9qRGlHjA59ueOzWh
	 22aGgrJm7Jor5bV4ZJ95quHndlnEmtvm9+8DgnLQLe+D6BIEzcnPBzUrJxL+ztoK/D
	 uzS2BPlInQ8831HrblCw+Dur4sPS3uBC3uDCRhvtHBqG1HFkRon2bNMTRJ3MNEegPx
	 8N7EPpU8k/dzA==
Date: Sat, 4 Apr 2026 06:11:05 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, maz@kernel.org, bigeasy@linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 2/2] Drivers: hv: Move add_interrupt_randomness() to
 hypervisor callback sysvec
Message-ID: <20260404061105.GC60588@liuwe-devbox-debian-v2.local>
References: <20260402202400.1707-1-mhklkml@zohomail.com>
 <20260402202400.1707-3-mhklkml@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402202400.1707-3-mhklkml@zohomail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9981-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 39DD739A187
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:24:00PM -0700, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The Hyper-V ISRs, for normal guests and when running in the
> hypervisor root patition, are calling add_interrupt_randomness() as a
> primary source of entropy. The call is currently in the ISRs as a common
> place to handle both x86/x64 and arm64. On x86/x64, hypervisor interrupts
> come through a custom sysvec entry, and do not go through a generic
> interrupt handler. On arm64, hypervisor interrupts come through an
> emulated GICv3. GICv3 uses the generic handler handle_percpu_devid_irq(),
> which does not do add_interrupt_randomness() -- unlike its counterpart
> handle_percpu_irq(). But handle_percpu_devid_irq() is now updated to do
> the add_interrupt_randomness(). So add_interrupt_randomness() is now
> needed only in Hyper-V's x86/x64 custom sysvec path.
> 
> Move add_interrupt_randomness() from the Hyper-V ISRs into the Hyper-V
> x86/x64 custom sysvec path, matching the existing STIMER0 sysvec path.
> With this change, add_interrupt_randomness() is no longer called from any
> device drivers, which is appropriate.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

