Return-Path: <linux-hyperv+bounces-11263-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LeABpx7F2qqGggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11263-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:17:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C285EAE15
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 01:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 402C93007A69
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 23:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BABE3264D0;
	Wed, 27 May 2026 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeLfEwA5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B912CDA5;
	Wed, 27 May 2026 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923862; cv=none; b=PFciLm+e+SBs/Ek3uJbcEH336YvHeKtvnoJ6XOwP0bKLtZ2O253FSA6Qz/3W/qsoxgSPZRFognCqDX4C66U3vQ4eKSlakqBGqzoDSGeZrTeMg/Ff9Cb56uiBQq+NZ7Hc+O9L9y6jDCRh+I5pUg/u+W/HLhnVWWGBw7zqtqJtyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923862; c=relaxed/simple;
	bh=CZ9SgH4iIizukUaWigKStqHzQdgwqPBo1duJe5NLhCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZK7hdy58ugxgaGMMayP0+ndHE71PhORiqs4AHq5AHQxrbAzGDkWKikh9D4fmz6jRA2zRl3ecl0icBNQfO4HYoQUbHYOzj3iCEwa0SvRR3jTvWHPJvYN0GZbD8DyqYjfqQXbY3TnMuZw6t4av9RXEo5zGhtMyVPLW+5cq5b9Is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeLfEwA5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105B71F000E9;
	Wed, 27 May 2026 23:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779923861;
	bh=Zb9tzaSppYJ5lTPKCwIdw1KJepg0Vogvwm6Ghu1mYEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LeLfEwA5nWeC4m+SCGm/zRgM6ylE45Ou+venRsXpn0lmrJ+sx1NGE1v/VNzVzLz/j
	 pnp3XuaAoI8xj4h3aIHivij8/NEiNKFSNKjJ9OTwaqRAvJhDvetxlXGiVx7naMDn9a
	 PnV9IxQ4QQfyVVQyApyV3mtKxtB4W5s6dNznqF+E1FTGLrEJ+B3O72HAzgqw4s3rye
	 ub8aaQhac7jIyz46BEaTxq7astDzfcjep9T44RgXUlOiH7GNxVENDaHRsJfe1nQGNR
	 uQSuTXKPO5ConikzW0fjRg/E8an5vxq2KLiU4ZCOL2b5bVOIwfIaHCGifYCZitREoY
	 Dv69BGLsD+fkw==
Date: Wed, 27 May 2026 16:17:39 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Jork Loeser <jloeser@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>
Subject: Re: [PATCH v3 3/6] x86/hyperv: Skip LP/VP creation on kexec
Message-ID: <20260527231739.GH3518940@liuwe-devbox-debian-v2.local>
References: <20260408013645.286723-1-jloeser@linux.microsoft.com>
 <20260408013645.286723-4-jloeser@linux.microsoft.com>
 <SN6PR02MB41578A8F9A225227FB5E79E6D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41578A8F9A225227FB5E79E6D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11263-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linux.microsoft.com,vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 20C285EAE15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 04, 2026 at 03:09:21PM +0000, Michael Kelley wrote:
> From: Jork Loeser <jloeser@linux.microsoft.com> Sent: Tuesday, April 7, 2026 6:37 PM
> > 
> > After a kexec the logical processors and virtual processors already
> > exist in the hypervisor because they were created by the previous
> > kernel. Attempting to add them again causes either a BUG_ON or
> > corrupted VP state leading to MCEs in the new kernel.
> > 
> > Add hv_lp_exists() to probe whether an LP is already present by
> > calling HVCALL_GET_LOGICAL_PROCESSOR_RUN_TIME. When it succeeds the
> > LP exists and we skip the add-LP and create-VP loops entirely.
> > 
> > Also add hv_call_notify_all_processors_started() which informs the
> > hypervisor that all processors are online. This is required after
> > adding LPs (fresh boot) and is a no-op on kexec since we skip that
> > path.
> 
> Adding hv_call_notify_all_processors_started() seems like it should be
> a separate patch. And this paragraph in the commit message leaves me
> with questions:  Is it really "required"?  If it is, how does the existing
> upstream code ever work? Does the change need to be backported
> to stable kernels? If it isn't *really* required, what are the implications
> of not doing it?

It is complicated. If I remember correctly, we realized this call was
absolutely needed if SEV-SNP host side support is enabled. If that
support is not enabled, then things continue to work. I think it is the
right thing to do to always make this call.

We don't need to backport this yet.

Wei

