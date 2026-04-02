Return-Path: <linux-hyperv+bounces-9938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OGjDfvdzmkFrAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9938-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 23:22:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8145A38E545
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 23:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22FE530166C5
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 21:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E463B19C5;
	Thu,  2 Apr 2026 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MJm7ZWF2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8D3019BA;
	Thu,  2 Apr 2026 21:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164904; cv=none; b=KzZz4Cy764T69s8Sds0ErBqOFxjz6vMVPSz7FtjFeGcf07Sq3Z2VoBsGHpT110qfMEmTkyW2OpLCuMQ3YBmn83ustFqhXZGMeZkienoWotsP3Tzvg0p7ShRU4RThBtM0iH2ILmvhGvVYqKSEKaFxVr7DCzD0a1Cw5odTvUiMWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164904; c=relaxed/simple;
	bh=/0QlZ1KJ8KtpkaHezOpz0mL7NZKgFv0+qUIs4suo3fc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bn18REzk4RsbZAx8EcQ/bPEn/rxxADBTiR+zd99wpM8wSs0hqbidK8FKFqxQ6RPiftQldu1pDrwjtukMq76N5136s+fq1S3RYB1pJQ9VuoHYvFYSKsLyHcAF0l5hlTV4xhfF3jthUDzQ8etlJ0fcUpch4XjDRdyh0bMYlBJQQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MJm7ZWF2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 3AEB220B710C; Thu,  2 Apr 2026 14:21:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AEB220B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775164903;
	bh=DCte7zD15GsIRiLEzfiNxmJRz0MxjBwdUaxhRx6/YLE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MJm7ZWF2jVVehi4Jtk2Mf2dGMhWQAxeqBG1hwtztOKzewQSK1gbBvnUJYtBhTLQ5q
	 QRMAbypTAd/85cpmi4TqfbQNdzX+MH0H0bXo4jYUWAIZ4K/h1la2nlUO7zr5DBDmrV
	 Cu47FpGIujhO9S8lsUYZ4ct2jtAoD/4cPvp+2dFU=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 38B0530705A4;
	Thu,  2 Apr 2026 14:21:43 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:21:43 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
    "K . Y . Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
    Roman Kisel <romank@linux.microsoft.com>, 
    Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] mshv: limit SynIC management to MSHV-owned
 resources
In-Reply-To: <20260402-sturdy-chirpy-cat-78baeb@anirudhrb>
Message-ID: <b9681d7-6166-e7cf-feb-b924c583cdf@linux.microsoft.com>
References: <20260327201920.2100427-1-jloeser@linux.microsoft.com> <20260327201920.2100427-5-jloeser@linux.microsoft.com> <20260402-sturdy-chirpy-cat-78baeb@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-9938-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8145A38E545
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026, Anirudh Rayabharam wrote:

> Maybe it's time to extract all the synic management stuff to a separate
> file to act like synic "driver" which facilitates synic access to
> mutiple users i.e. mshv & vmbus.

Yes, such a refactor maybe warranted. This series is about getting 
kexec to work on L1VH, and so such refactor would be ill-placed here.

Best,
Jork

