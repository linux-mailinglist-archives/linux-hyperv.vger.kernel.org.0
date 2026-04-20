Return-Path: <linux-hyperv+bounces-10227-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJiwKCVv5mmBwAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10227-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 20:23:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0953432C48
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 20:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D81B130BA3A8
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABE5379EF6;
	Mon, 20 Apr 2026 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M3gZQCLA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429AF379EE5;
	Mon, 20 Apr 2026 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704094; cv=none; b=XxHgOiijmk6mgny4mchBhVhRxroJF35T5hjOJrbZod8bj6Bpqek3NaAcD14A9eNcAG+UWT/bR0E29xZRazcJQXUWJ+7sFQgfJpOEEW6WoWdhWqh41xb0JfjD2J1aHkE1yoA/W/KqkTFvZYy8jiksALlHbsk7+Uicb4rsZ3gpg9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704094; c=relaxed/simple;
	bh=ORCL07x/Xnari8BPQ4huM5RLtSnOzNJBU0mgbyPpFmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgoyAcrNpB9D515/jsvSvaRsbhqEHAFyrqaqztVefA8ILi5nph5jj573U/02nEJ8wUtAKSDXPqg46txRoSLPdTK9wudpTravnymrrQ0fP9FO9W/jwZv081hh0ax/OrQPsy5Abxf35z5cp/AOneSw/TkL8HpzZ2E/82kye9CyuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M3gZQCLA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id B1BFE20B6F01;
	Mon, 20 Apr 2026 09:54:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1BFE20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776704093;
	bh=2LI/Zt5ETHkxP8KH80YsPKpfmviO7OAGQ/qdIZQ96pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3gZQCLAIwTxV/rKWkwautIHOpx1CKteuGXoIsn+ry460HGua3XeLGsrHzdpeundk
	 dYcA04lANoRx5bcZPBWXUCmKqMnRdIgBZ+hP1iEk17ZGxk6LxAEj8BqcGCadaJn909
	 kbhfMIszccRoFgkwJWZGdYoAHs0VFJIlZUl6xCbs=
Date: Mon, 20 Apr 2026 09:54:49 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] mshv: Reduce memory consumption for unpinned
 regions
Message-ID: <aeZaWVa0S4qtUOsE@skinsburskii.localdomain>
References: <177574802240.19719.4873018419452139691.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260414-broad-abstract-anaconda-1c4ab1@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-broad-abstract-anaconda-1c4ab1@anirudhrb>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10227-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: F0953432C48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 04:11:22PM +0000, Anirudh Rayabharam wrote:
> On Thu, Apr 09, 2026 at 03:23:59PM +0000, Stanislav Kinsburskii wrote:
> > This series reduces memory consumption for unpinned regions by avoiding
> > PFN array allocation. A 1GB unpinned region currently wastes 2MB for an
> > unused PFN array that HMM-managed regions don't need.
> 
> This series has a dependency on "mshv: Refactor memory region management
> and map pages at creation" right?
> 

Yes, it does.

Thanks,
Stanislav

> Anirudh.
> 

