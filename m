Return-Path: <linux-hyperv+bounces-10150-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJHAKQTI3WmwjAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10150-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 06:52:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E143F588F
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 06:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D030308CF43
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACEA286D7D;
	Tue, 14 Apr 2026 04:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSPPNYP3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0799623FC41;
	Tue, 14 Apr 2026 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142238; cv=none; b=NWxTf4A2PYuOiVynzR/lIgYb/Dn5aEguzoNLhk00oBClnBQB6M1AteH9/x0iHH1fdRlXGGIntZmUK4LR0O/lQfPOdfSF4nKcF6Cp3Bslfbnuzbf6mgpjZ4b6qzOo+YPZwJbFvm3dwWtmXsj7FQq7FLxU8Wq2+1V+y3hq/8Ver6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142238; c=relaxed/simple;
	bh=U2le/fcLS26RaElYZvWjr5ivumx+pC9aPyhd/hd4SKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE6e9HfkhZ+uLZ/IPBO8Wv5lv9m+al6willDlbgkwdRrWYgJcgSibsmw/kWLxwaOKbsQKP7V+2jtUKvFh1DRu03IUSb8nHvKWTgEPJ3hjbHDVlzMGntlnekc4VNgGfagw8x8cQDSPmAnQw4DRo25n9CRY5wfRUz0H5GIL68ARNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSPPNYP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5B5C19425;
	Tue, 14 Apr 2026 04:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776142237;
	bh=U2le/fcLS26RaElYZvWjr5ivumx+pC9aPyhd/hd4SKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSPPNYP30wBJfyzFHXkoL4nIycLJ2By0UIjRi9lNvnSnhMAZ+ILPuxtmcPDFgsOXi
	 hUFDUCgq5u3HIBDzJ8v4N58egpSwKwGribDDK7iZuz+4v1zupHIXH4KOczsSRhXnAf
	 fnQGUc9fUhf2YwYfa4A3sVXNzPsw4wH6EHXcDMpZ1zeaPO+OHP/lT2kCsGwUFXHHtt
	 ojJi3BCkmN4hUuWTR1qWqS/5HqvO59tniIRyDCrTETnq1tMur6rGlaAROO4OaqH5ht
	 h0KhzcV10bUw7x2QINKUFOiOm9cOi12An/6vqSqo0KJf/1o64XpaixI2xE4NUzZpbq
	 u0/UG1qruTHJA==
Date: Tue, 14 Apr 2026 04:50:36 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Add tracepoint for GPA intercept handling
Message-ID: <20260414045036.GD2787213@liuwe-devbox-debian-v2.local>
References: <177439679671.175364.15362688285596134992.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260402-sarcastic-rottweiler-of-criticism-8330ae@anirudhrb>
 <20260404064527.GF60588@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404064527.GF60588@liuwe-devbox-debian-v2.local>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10150-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid,anirudhrb.com:email]
X-Rspamd-Queue-Id: 16E143F588F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 06:45:27AM +0000, Wei Liu wrote:
> On Thu, Apr 02, 2026 at 03:45:58PM +0000, Anirudh Rayabharam wrote:
> > On Tue, Mar 24, 2026 at 11:59:59PM +0000, Stanislav Kinsburskii wrote:
> > > Provide visibility into GPA intercept operations for debugging and
> > > performance analysis of Microsoft Hypervisor guest memory management.
> > > 
> > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > ---
> > >  drivers/hv/mshv_root_main.c |    6 ++++--
> > >  drivers/hv/mshv_trace.h     |   29 +++++++++++++++++++++++++++++
> > >  2 files changed, 33 insertions(+), 2 deletions(-)
> > 
> > Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> 
> This patch has a dependency on another bug fix. That's not listed
> anywhere. In the future, please list the dependency, or post this as
> part of a series.
> 
> The tracing support is in hyeprv-next. This patch needs to wait.
> 

Now applied.

