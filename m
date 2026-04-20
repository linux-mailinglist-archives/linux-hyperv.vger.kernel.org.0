Return-Path: <linux-hyperv+bounces-10226-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGHkG8lX5mlQvAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10226-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 18:43:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D5F42FEAC
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 18:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98EBE30000AC
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EB134B661;
	Mon, 20 Apr 2026 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QC8hwokv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE383537CE;
	Mon, 20 Apr 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703257; cv=none; b=slz3T9nWIXI8HT2xbO4+cQUT0qC6XzNxtryw1xJgQ6jLD/vmYFCRzlO0n6A1+qfyNh2xmTvmDY/IB4xpiG+R5wE9m9TUrD5sp/xeAuNUmLg5cXCnmxATu7jn+qDzEbi4JGdaKkG8C0mQqfT1zb17HgCzxW8PaaUMuIkNeCANfhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703257; c=relaxed/simple;
	bh=mjc4+R4pcg1DQgMyfhnWd9sCh9WHudzbWU8nkzySyPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH7lSSUwH3Yz3VLbVVui71xUgpU+A10wmgfaChm8AdnquFjqn0F9NoacRrHfTcSTO8Gcq/NVFTjC8IhVP5zjf/1wvAfepeHKw4uU790pqiLGAa/uAMW7PRWMkZ0YnhBtsWL+9nfh8RyxRzzKZKeJGdbEfNfd7y70xaLD9rLJqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QC8hwokv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id E2A2720B6F01;
	Mon, 20 Apr 2026 09:40:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2A2720B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776703256;
	bh=o+SK4Qe/0n2sSmj2I1fzlY8TCVwBwXdS72EWcYwse8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QC8hwokv81PA1ssszB9tZsj/eEc4eaORNeAhPK0A5+tZSblJ6GTc1mGm6ud+WYl3w
	 7prd6LY1N+ZhkkDHvAVz+Mkqts2fX+M9eQinXr7+jHOA58JOXkIriOr93Wzm/c735r
	 4xH0G1fbuGEEEKm8GSVLL31Gc7JcVEGnYs/4JMHI=
Date: Mon, 20 Apr 2026 09:40:52 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] mshv: Refactor memory region management and map
 pages at creation
Message-ID: <aeZXFL6aj_JudR8l@skinsburskii.localdomain>
References: <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157920DE623A9B2C613D282D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157920DE623A9B2C613D282D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10226-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 10D5F42FEAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:07:59PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, March 30, 2026 1:04 PM
> > 
> > This series refactors the mshv memory region subsystem in preparation
> > for mapping populated pages into the hypervisor at movable region
> > creation time, rather than relying solely on demand faulting.
> > 
> > The primary motivation is to ensure that when userspace passes a
> > pre-populated mapping for a movable memory region, those pages are
> > immediately visible to the hypervisor. Previously, all movable regions
> > were created with HV_MAP_GPA_NO_ACCESS on every page regardless of
> > whether the backing pages were already present, deferring all mapping
> > to the fault handler. This added unnecessary fault overhead and
> > complicated the initial setup of child partitions with pre-populated
> > memory.
> > 
> 
> This is a nice set of changes. Independent of the new functionality
> for pre-populating, it improves the code organization and makes
> it more regular.
> 
> See a few comments on individual patches. I noticed that Sashiko
> wasn't able to review the series because it wouldn't apply. Hopefully
> your v2 will apply. From what I've seen so far of Sashiko, it finds some
> good issues. I did run the patch set through Co-Pilot, but that didn't
> have the benefit of the AI prompts that Sashiko provides.
> 

Thank you for your time.
Indeed, hopefully sashiko will be able to review the v2.

Thanks,
Stanislav

> Michael

