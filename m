Return-Path: <linux-hyperv+bounces-10076-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEDOKhQP1mmxAwgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10076-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 10:17:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC523B8E1D
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 544C5304D241
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4439D6D9;
	Wed,  8 Apr 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O690T2qb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519F37CD24;
	Wed,  8 Apr 2026 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635928; cv=none; b=R6zhpJYmnN1ufYZ2Qgs2iVPbSAVRMZgokaWfFXb46HUJq/1XlU/DLNUvu9DGbYL4ACChfAM6kFJYG0WbbemzCKbKkEAPLzRkpy3UE2jIA0O4NrYCaTc9neyqpCWDsf7c/40F/BMknxnCpjHIwgshWxRWX5k5nsSyjbVcDmf/+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635928; c=relaxed/simple;
	bh=EJuqV1+fInOk87kbbNNnIrWbCrELIglJ42EeOqSe/rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg+Bw8iTYS8QPumwVrZWc7+esHaA9U4fzXzBIZz8QsgTdUPLKBQxbYjfX77mRKnkKPijsvFox5VylpQcpj3fFjWO0i21nZeq1T/oVHXiyE2xU1s7z7z0YTo8XPK0H/kTe6EfgDIFBaBDRQIK+2ZVKQKBUZQE6V/Ke207munJlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O690T2qb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id F1BF020B710C; Wed,  8 Apr 2026 01:12:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1BF020B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775635920;
	bh=nOosIgFEeprE3iORS4lijVt8tQ0t0+4fZlDJtMeza1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O690T2qbTJm/FfkmAws/zZyCKkSLPge4P9CB1bMPZOHXFoQTVSe0EqebWfhR1cqyg
	 4AtAOOSRn3YwuW/XbSjyN/vQyKmG8hsfBCb1lYK5NVAvklgFbykavd4NrIXxGlb0Fv
	 TstxOU3U9xIG0xX5naCsLUb0006d57wTJyhNfbTo=
Date: Wed, 8 Apr 2026 01:12:00 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
	yury.norov@gmail.com, kees@kernel.org, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/3] net: mana: Use pci_name() for debugfs
 directory naming
Message-ID: <adYN0F/vtpZ2AQwz@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260402182704.2474739-1-ernis@linux.microsoft.com>
 <20260402182704.2474739-2-ernis@linux.microsoft.com>
 <20260404090514.GS113102@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404090514.GS113102@horms.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10076-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EC523B8E1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 10:05:14AM +0100, Simon Horman wrote:
> On Thu, Apr 02, 2026 at 11:26:55AM -0700, Erni Sri Satya Vennela wrote:
> > Use pci_name(pdev) for the per-device debugfs directory instead of
> > hardcoded "0" for PFs and pci_slot_name(pdev->slot) for VFs. The
> > previous approach had two issues:
> > 
> > 1. pci_slot_name() dereferences pdev->slot, which can be NULL for VFs
> >    in environments like generic VFIO passthrough or nested KVM,
> >    causing a NULL pointer dereference.
> > 
> > 2. Multiple PFs would all use "0", and VFs across different PCI
> >    domains or buses could share the same slot name, leading to
> >    -EEXIST errors from debugfs_create_dir().
> > 
> > pci_name(pdev) returns the unique BDF address, is always valid, and
> > is unique across the system.
> > 
> > Fixes: 6607c17c6c5e ("net: mana: Enable debugfs files for MANA device")
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> 
> Hi Erni,
> 
> Possibly the code differs between net and net-next.
> But if this is fixing a bug in code present in net - as per the cited
> commit - then I think it should be a patch that targets net.
> With some strategy for merging that change into net-next
> if conflicts are expected.

Thankyou for the clarity Simon.
I will send a separate patchset for net tree with the fixes.

- Vennela

