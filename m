Return-Path: <linux-hyperv+bounces-10163-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBh7CJVo3mmxDgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10163-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 18:17:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8723FC715
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F40D309B993
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7943ECBE4;
	Tue, 14 Apr 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="DqmWXejn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EE3EAC68;
	Tue, 14 Apr 2026 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183100; cv=pass; b=SV967tKAEVquGFc75al5Omxvz38jX6B+8ma25SQ9y9G+T+qHv5pkUgljFAgaA8a6voYKq1sa4UjEJjep2rtltRpYPugiQOAFtrhmUldQpadp+z15N86UjVga9BfZwUyoHliuBZym2joUYmZadBash4h+zc8EDTekSVhKA1lTmhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183100; c=relaxed/simple;
	bh=FXbH0gisekBLyyhjqVWQ/wyFWQ7wW2jGvYJrrHmFBus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkDggKNVzUojp/36SOmCC3RowTfS1aR/fL/N4exa/BSz9Bdrp+6QgUaxZwYt/lVRcSIKtG4XulKJijt7zrNU3wGETz4DCHhO4ACtVvADP/Gw23MBhAgmgl01pz1nuqeZ0q9d98vks2EE0JMCmc2FhV/8tHBcIXsG3lS7RLz43cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=DqmWXejn; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1776183090; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j1pJfLNuY1Bx4nWYyZgN17uTX7qn5nUOTuVdFJs40IBonAIiUK4mbJQofqqH4CMNgtsMjId+IgPvf+asHAzO/sC9YSJ54Wk3of6wq2VPjFojb0HhleSsp9vc/pL9fwCiRYHu4/Z5xgKxdU5zQo6hxIeFbG1/ZFyIi0IvYqC0BzQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776183090; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FXbH0gisekBLyyhjqVWQ/wyFWQ7wW2jGvYJrrHmFBus=; 
	b=Ya3BYi7mICpGIBDvxAPKoap0ykLPRyTC4xXU8t6T4iD/EqrYc8wIg5vLDvuj+JZoVJ4sCsRw1drkXp+CaRweNJIcCBEgVwqJLF+XXCzIxRkN7mgv+yIE2UXfoFrFCXPWGI2R2C/uAfAS2q3yoAU1k6oju847MewQxELxtfosnyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776183090;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=FXbH0gisekBLyyhjqVWQ/wyFWQ7wW2jGvYJrrHmFBus=;
	b=DqmWXejnlJ8q7dwH4MnWRJUhkaD5c485+V23toQ0JUVVUr56kVRPWeFHudUX5VkS
	VHYi+5D5tRHEHfMFAUrhwokvjXPVy7TCrDhWVXCFKS23yNaVq3VSh1ec/asIt+Ln82C
	L9R6DriKeQ5OSPhnkAzGnT3noup3rRHKIX7A1tzw=
Received: by mx.zohomail.com with SMTPS id 1776183088084347.1662515709852;
	Tue, 14 Apr 2026 09:11:28 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:11:22 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] mshv: Reduce memory consumption for unpinned
 regions
Message-ID: <20260414-broad-abstract-anaconda-1c4ab1@anirudhrb>
References: <177574802240.19719.4873018419452139691.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177574802240.19719.4873018419452139691.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10163-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D8723FC715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 03:23:59PM +0000, Stanislav Kinsburskii wrote:
> This series reduces memory consumption for unpinned regions by avoiding
> PFN array allocation. A 1GB unpinned region currently wastes 2MB for an
> unused PFN array that HMM-managed regions don't need.

This series has a dependency on "mshv: Refactor memory region management
and map pages at creation" right?

Anirudh.


