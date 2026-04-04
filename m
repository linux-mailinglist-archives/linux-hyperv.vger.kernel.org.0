Return-Path: <linux-hyperv+bounces-9983-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH2jHomy0Glu/AYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9983-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 08:41:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D49EE39A275
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 08:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 836DD3008D24
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7137030BB8A;
	Sat,  4 Apr 2026 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufn4O+Cl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623E2D2483;
	Sat,  4 Apr 2026 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775284870; cv=none; b=uOIFDVNNwSahGLL0ROz9yGxyU6rBg6dAIEeHAHd67bQEprNFrrTkHgzNGQp3MrFlIa6LeHwK9Gb+UAYPcBiieOQK0ljxONkTA+3mhlSw/2www/RBgaeT5YLCquV8NG+hiq+JKBEv5soaEQp6IYMgFkXndNQsQqhgFvatdTkKSFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775284870; c=relaxed/simple;
	bh=Dwm0xqcPJtipVho/Y/zjC5rcy1eW8Q+snCmTpucmKPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgKq8qwexttAyCy/vftzNjrgSZ/7vQ3Kmt+bOng8BaxbbiUe1FL1hJYM7jHeAALNIIlR6FFsXoN7FTv0hVKRN0zh9ALpXnbOxwwsLO8qe5ihhMi88bR4IKFzcOS4LlMCI2mj1kGzI3ghwrivmSBJS927NCA1JhePPQZMq5b/aq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufn4O+Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF147C19423;
	Sat,  4 Apr 2026 06:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775284869;
	bh=Dwm0xqcPJtipVho/Y/zjC5rcy1eW8Q+snCmTpucmKPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ufn4O+Cl4wa1O42qVMBZypRlU8LeGillPkqelCEhfH7arqV2XQgz2uPKBdxKJ1agk
	 rqcoYn3zgS0CmQZNZR/r/GVOieme7FF1FHBr4qjiNBu77BhjMjjgMt/Z6ieiubswiP
	 2jVNQUR/ELK7fJ0H6XCmAwhoqmgziYInInAJQMKXpACm1/d7CFsc0EZHUAxQlRKR8b
	 bOWL7BA624pAShF2n0sAD78SLxsuvHOHFHqsW9tkATcvDNBdwfyfS0tejkjkqEZydX
	 ZHtilQr4NktKPNI0FW5JTIiDBMxWVg/UDQPDW/3TPa2gls3VAO8RtgV9k52SYENMKP
	 bfRQwJXIUalyw==
Date: Sat, 4 Apr 2026 06:41:08 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Add tracepoint for GPA intercept handling
Message-ID: <20260404064108.GE60588@liuwe-devbox-debian-v2.local>
References: <177439679671.175364.15362688285596134992.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260402-sarcastic-rottweiler-of-criticism-8330ae@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-sarcastic-rottweiler-of-criticism-8330ae@anirudhrb>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9983-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: D49EE39A275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:45:58PM +0000, Anirudh Rayabharam wrote:
> On Tue, Mar 24, 2026 at 11:59:59PM +0000, Stanislav Kinsburskii wrote:
> > Provide visibility into GPA intercept operations for debugging and
> > performance analysis of Microsoft Hypervisor guest memory management.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_main.c |    6 ++++--
> >  drivers/hv/mshv_trace.h     |   29 +++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 

This doesn't apply cleanly to hyperv-next.

Wei

