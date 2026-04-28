Return-Path: <linux-hyperv+bounces-10438-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHBsFG/s8GmBbAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10438-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:20:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A11EE489CF1
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 788DB30AB706
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4C37BE8E;
	Tue, 28 Apr 2026 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF31cphd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4DF33B6CB;
	Tue, 28 Apr 2026 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396493; cv=none; b=k4zGoMFvtN1ps6FsNa6D/+A0BG6Wm7dvmsqiiRBNKOXFN2Cbvem2JPXAWDUxbaxeVH3SnJ682xdj7jSriuLrkI2fBiFsFnnZgrzhDyNrF5+OIwEodd/nmEmdJ4cbfKuLSaxm6gBJ8AQEmUPjCktoLeP62OrZWDnTfOh7LKN5tXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396493; c=relaxed/simple;
	bh=3uuX0XDhlhTuPyUxc/w5DZ1CSgQcFFHcMMffW6FQY0w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UrKziTqm7HLZoySuh95e1bJc9dAVP8LmI9HCla2MxNtHW+repp/++4fuN0gauKyl6OPxVWqGgzConjn5mq2v5v+e2G8iS8V5YzjtJPFyxfX6vo8iM+amWqNbQADgvXKsI4n5z97ANb87vadxwBNqmpwgkJ3ROPP1vIA4+tb0lq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF31cphd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A67C2BCB5;
	Tue, 28 Apr 2026 17:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777396493;
	bh=3uuX0XDhlhTuPyUxc/w5DZ1CSgQcFFHcMMffW6FQY0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jF31cphd6owD9TwXL5puFcPWiOAitqI7ubaQlC11OCNKQkTcKk+C2AddgMaiUrQg+
	 yYWrQrrFagaBAbBqBpTSOSUQlankZuqmWWQYbLbQ9n8ESVPkbHX+yF22w9Z51lRP7b
	 Cdm7QHYiWepIdk4IjyF4vx8CtNOcof2DPJGwOTR5RQnKVSMaLWbJCRxk/eUobDFPjI
	 hvefyj5K1u6il85bKJrOCh7pJyo6q3U+PUgterMtOmRzrw5v+6N2zRmCY/+eKIx3L2
	 KP0cmsY6/OIpd5f/18pq3ChFJAXfy0u+9I8GR1lAYTFXlN08pmXsQ/Umcsb18jlPCO
	 7XKz9GLystIAg==
Date: Tue, 28 Apr 2026 12:14:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V1 08/13] PCI: hv: rename hv_compose_msi_msg to
 hv_vmbus_compose_msi_msg
Message-ID: <20260428171451.GA233136@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f41598-ee90-eb2f-1877-da6d1687322e@linux.microsoft.com>
X-Rspamd-Queue-Id: A11EE489CF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10438-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 07:22:12PM -0700, Mukesh R wrote:
> On 4/27/26 09:31, Bjorn Helgaas wrote:
> > On Tue, Apr 21, 2026 at 07:32:34PM -0700, Mukesh R wrote:
> > > Main change here is to rename hv_compose_msi_msg to
> > > hv_vmbus_compose_msi_msg as we introduce hv_compose_msi_msg in upcoming
> > > patches that builds MSI messages for both VMBus and non-VMBus cases. VMBus
> > > is not used on baremetal root partition for example. While at it, replace
> > > spaces with tabs and fix some formatting involving excessive line wraps.
> > 
> > Would be better to do the whitespace changes in their own patch,
> > although several of them should just be dropped (see below).

> > > - * facilities.  For instance, the configuration space of a function exposed
> > > + * facilities.	For instance, the configuration space of a function exposed
> > 
> > Oops, this hunk made it worse.  Definitely don't want a tab there.

> > > -		 * The vector we select here is a dummy value.  The correct
> > > +		 * The vector we select here is a dummy value.	The correct
> > 
> > Another tab that should be a space.  Actually, you should just drop
> > this hunk; the rest of the comment has two spaces after periods, so
> > this should too.
> 
> well, most of our files does global replace 8 spaces with tabs, so
> everywhere comments are well indented. Since, checkpatch doesn't complain
> about tabs on comment lines, may I assue it is not a strict requirement
> and more a nit or personal preference?

I guess I didn't make it clear.  I'm not complaining about leading
tabs; I'm pointing out that the comments should not have embedded tabs
in the middle between a period and the first word of the next
sentence.

Here's what it looks like with "git show | cat -T":

  - * facilities.  For instance, the configuration space of a function exposed
  + * facilities.^IFor instance, the configuration space of a function exposed
                 ^^

  -^I^I * The vector we select here is a dummy value.  The correct
  +^I^I * The vector we select here is a dummy value.^IThe correct
                                                     ^^

  -^I^I * freed while we dereference the ring buffer pointer.  Test
  +^I^I * freed while we dereference the ring buffer pointer.^ITest
                                                             ^^

  -^I * to be overlapped by those children.  Set the flag on this claim
  +^I * to be overlapped by those children.^ISet the flag on this claim
                                           ^^

None of these hunks should be here.  Maybe some automation gone wrong?

In any case, every hunk of a patch that does "rename
hv_compose_msi_msg to hv_vmbus_compose_msi_msg" should contain those
names.  Any whitespace changes should be in their own patch so they
don't make it hard to review the rename.

