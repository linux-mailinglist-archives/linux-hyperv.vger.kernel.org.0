Return-Path: <linux-hyperv+bounces-10504-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGHnNCCN8mnKsQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10504-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 00:58:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D349B2FE
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 00:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5BB3020A4C
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 22:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B100C37C924;
	Wed, 29 Apr 2026 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdGz6Ecu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97D37AA90;
	Wed, 29 Apr 2026 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777503460; cv=none; b=fv1ruenH1Ahr7pqRRzOBUdVR5mY5xlRFhh/LGe+0kwfAGeVYLfEBMcUOVXd26VulbJls4jO5d2yF5DOGpmf+po3mIRFGcoEEGI0GEl6yRfucL78y6GHU937Xieg4r5tgi5Km+jFhy5heSj1rN/AR9GNC1nTxOggv7Uu1Dggcw7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777503460; c=relaxed/simple;
	bh=I+//j2q/h0XBW5QRBovEU4yDXrOR+VIyZTkGVCwIPiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH2RS8BowV835MD+aLhPKC0K8iONOlFg5esXXU+CO6Nx89hMwwe/V1Yw4dK62ob2oOYkD7mCVdSZCNTLubi61aLCHDNIrozOdF/UvDSYtMmHvgiKq5m9pjGm8AxmknNNmXwWQUH76DvkYAo8Z8CthB2paXPJHLm/CHIGDSlTctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdGz6Ecu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F03C2BCB3;
	Wed, 29 Apr 2026 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777503460;
	bh=I+//j2q/h0XBW5QRBovEU4yDXrOR+VIyZTkGVCwIPiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdGz6Ecu5pkXdxy80SkH+oT00EAoa8E2tUR4kr+lu1t8VDXqWh5vCL2UPsouVvtLx
	 iL7TO8BQRffd7hwhAT0Kiszd+MK8g2cgg1ZesX6xvmmBLy/KZjWkSnvIHoa4U8DDvq
	 73kgHFitwTcKF0Y8SVdwPAL1IYKgUlSXwEewi44bpOpJFbBEYaRXCa57byIwrlO5YH
	 GZdnbkXEY/KSSKk7YKKhym/HrPVkcNGkRLI7RBPjmfp1PYRSnq3w2mKPs40Zr3xTHS
	 euOS9LaXGiYbIoho/3kxfh0hu2h8DeannDvH38j0Vbt4nLZf4uhhVQePkjQmRmM2hq
	 A21UbA1Ehk6Xg==
Date: Wed, 29 Apr 2026 22:57:38 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>,
	Anirudh Rayabharam <anirudh@anirudhrb.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Hyper-V: kexec fixes for L1VH (mshv)
Message-ID: <20260429225738.GC2584450@liuwe-devbox-debian-v2.local>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
X-Rspamd-Queue-Id: 413D349B2FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10504-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,anirudhrb.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 02:38:51PM -0700, Jork Loeser wrote:
> This series fixes kexec support when Linux runs as an L1 Virtual Host
> (L1VH) under Hyper-V, using the MSHV driver to manage child VMs.
> 
> 1-2. SynIC cleanup: the MSHV driver manages its own SynIC resources
>      separately from vmbus. Add proper teardown of MSHV-owned SINTs
>      and SIRBP on kexec, scoped to only the resources MSHV owns.
>      Use hv_vmbus_exists() to decide at runtime whether VMBus owns
>      SIMP/SIEFP/SCONTROL (so MSHV must not touch them) or whether
>      MSHV must manage them itself (bare root partition without VMBus).
>      Also fix SIEFP and SIRBP address calculations to use
>      HV_HYP_PAGE_SHIFT instead of PAGE_SHIFT, which produces wrong
>      addresses on ARM64 with 64K pages.
> 
> 3.   Debugfs stats pages: unmap the VP statistics overlay pages before
>      kexec to avoid machine check exceptions when the new kernel
>      reuses those physical pages.
> 
> Changes since v3:
> - Dropped patches 1-3 (vmbus variable shadowing, stimer cleanup,
>   LP/VP skip), now merged via hyperv-next.
> - Patch 1: fix SIEFP and SIRBP memremap()/virt_to_phys() to use
>   HV_HYP_PAGE_SHIFT/HV_HYP_PAGE_SIZE instead of PAGE_SHIFT/PAGE_SIZE.
> 
> Changes since v2:
> - Rebased onto linux-next/master to adapt to the upstream SynIC
>   refactor (commit 5a674ef871fe, "mshv: refactor synic init and
>   cleanup").
> 
> Changes since v1:
> - Patch 1: account for nested root partitions where VMBus is also
>   active (not just L1VH); use a vmbus_active local variable; allocate
>   SIRBP in L1VH allocation path for when the hypervisor doesn't
>   pre-provision the page.
> 
> Jork Loeser (3):
>   mshv: limit SynIC management to MSHV-owned resources
>   mshv: clean up SynIC state on kexec for L1VH
>   mshv: unmap debugfs stats pages on kexec

Applied to hyperv-fixes. Thanks.

