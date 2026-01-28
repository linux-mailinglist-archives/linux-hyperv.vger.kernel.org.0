Return-Path: <linux-hyperv+bounces-8578-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIdCHJqXemku8QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8578-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 00:11:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BDFA9DBA
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 00:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 653473003713
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 23:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657932FDC40;
	Wed, 28 Jan 2026 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dd4iyr3z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ACE227BA4;
	Wed, 28 Jan 2026 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769641877; cv=none; b=Y0e7TrwDHFZtmwdRlhq2W2X4s0/Yr/6itNPRWGjxcaVUjf6a7PM3JBfEZ6JLJeEFt8AEynxUQA7Rl0s5TYu8TF2O42GTwop9kqP5hYtO/TVA4gOWmJOdNZGJ99Am6AnQ6MOwE9yX+/asLqfYdHERLNCCiSTYY74FRPe8d2GUXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769641877; c=relaxed/simple;
	bh=gOfO6SYAB/BDfyZyd2lwLZKP/aE30SssEV3MWfwMvpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv1iuf6RSrJCLxPX6yntES3CLl8m7/udDTWBAGe0z7ch3dknLCela6fZnGl71UMmOEP7YFI0d+ic5xUHpXtqzDbGxoUdEn55BGV41qzZK7JMxKd1HMFZ6+P+rxH+qoOdImoQaCVNUdghFTU8KFohE4PMU8FMEdFXbCXxZDE3Ork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dd4iyr3z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id A49B720B7165;
	Wed, 28 Jan 2026 15:11:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A49B720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769641875;
	bh=K4HJ2HlGBD5YpRzjI2B6ynmOUjFeg4Du2pUoYuUBUCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dd4iyr3z0QhfD7rA4HQJLDrBFwa5jrJ68/gkVygMkxyPZWRKaaiJU9C9QhjNKHTZH
	 YG4UbYLWz8KI1JFWJx2TFP8Uy9k+/2lB66AwigOyP6bA7vpsMbIDadv1Y2MdIz9gDY
	 Qj+2xjwqAqRwBo4Z2UbRM3EaOysIq1+u42yEmTwo=
Date: Wed, 28 Jan 2026 15:11:14 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXqXkhhl1xuvjm3P@skinsburskii.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
 <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
 <aXo2X4mRioTa3sBl@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXo2X4mRioTa3sBl@anirudh-surface.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8578-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: A2BDFA9DBA
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:16:31PM +0000, Anirudh Rayabharam wrote:
> On Mon, Jan 26, 2026 at 12:46:44PM -0800, Stanislav Kinsburskii wrote:
> > On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> > > On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > hypervisor deposited pages.
> > > > 
> > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > management is implemented.
> > > 
> > > Someone might want to stop all guest VMs and do a kexec. Which is valid
> > > and would work without any issue for L1VH.
> > > 
> > 
> > No, it won't work and hypervsisor depostied pages won't be withdrawn.
> 
> All pages that were deposited in the context of a guest partition (i.e.
> with the guest partition ID), would be withdrawn when you kill the VMs,
> right? What other deposited pages would be left?
> 

The driver deposits two types of pages: one for the guests (withdrawn
upon gust shutdown) and the other - for the host itself (never
withdrawn).
See hv_call_create_partition, for example: it deposits pages for the
host partition.

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 
> > Also, kernel consisntency must no depend on use space behavior. 
> > 
> > > Also, I don't think it is reasonable at all that someone needs to
> > > disable basic kernel functionality such as kexec in order to use our
> > > driver.
> > > 
> > 
> > It's a temporary measure until proper page lifecycle management is
> > supported in the driver.
> > Mutual exclusion of the driver and kexec is given and thus should be
> > expclitily stated in the Kconfig.
> > 
> > Thanks,
> > Stanislav
> > 
> > > Thanks,
> > > Anirudh.
> > > 
> > > > 
> > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > ---
> > > >  drivers/hv/Kconfig |    1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > --- a/drivers/hv/Kconfig
> > > > +++ b/drivers/hv/Kconfig
> > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > >  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > >  	# no particular order, making it impossible to reassemble larger pages
> > > >  	depends on PAGE_SIZE_4KB
> > > > +	depends on !KEXEC
> > > >  	select EVENTFD
> > > >  	select VIRT_XFER_TO_GUEST_WORK
> > > >  	select HMM_MIRROR
> > > > 
> > > > 

