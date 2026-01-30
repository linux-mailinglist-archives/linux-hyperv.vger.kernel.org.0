Return-Path: <linux-hyperv+bounces-8615-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH7dIZz8fGnLPgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8615-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 19:46:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE332BDEEE
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 19:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 799293017BEF
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40303859CB;
	Fri, 30 Jan 2026 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P0W+6Z6Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335A3806B8;
	Fri, 30 Jan 2026 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769798809; cv=none; b=dsyTO1OoXNcs8b9lTe0jOWSYtHY/ZxeV1rOVS1MtkELqqAXy2m43+vOTLhOeRnsgTOMQt+MzbTxoKJL6Aa5U9rZZ/OeMKuJf/J3yPrYF5dkRMEb+4hpGCUSiatrf0sfQqZhPAUuQZoG3PzFouFyCdGqdAod+P0b9t5vVBqAHsT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769798809; c=relaxed/simple;
	bh=MCJuTFwtdJbtiWhgUGieLse9wfh+Ix8BA3pOkVCwRz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqQzHl8Zu1GxSRo1iUOc3Gs+Q5lX1/DTlXYMG3NKBT2sQxgpCQQBhMDw6cEed/RRAGZq+qNBXe/NZS7ePWXOYCZIsXMZQLX0EsHDv/4K5/pdetJNbsSCH7aQxiMQtB5voFIVRVOWHL8/TmVCeT+9fh0mH+W9wDBTd4uAYLTldMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P0W+6Z6Q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 99C7F20B7167;
	Fri, 30 Jan 2026 10:46:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99C7F20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769798807;
	bh=QhKZN0HYdj1AFAiFfsOCdtMxnX+XBmxe1paCSC+0uqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P0W+6Z6QBflDy9SV5Ov1DcS8EBgXBcuuDcW/kNWtZzeVFXVnsIQqLLKtCcY2cGqDH
	 RUfQVmTp/OIAf6FCA+p6GxD5o7YTUwtKf/zGUEFFiqQA63J03fYphYgza+s6jalItG
	 Y+NicYPfyP0B3wa8t1/ZgCNVQmn/Wkg2+LVSAXyY=
Date: Fri, 30 Jan 2026 10:46:45 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXz8ldAeoWwGIxdu@skinsburskii.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
 <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
 <aXo2X4mRioTa3sBl@anirudh-surface.localdomain>
 <aXqXkhhl1xuvjm3P@skinsburskii.localdomain>
 <aXzmMInsNSvFvBF1@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXzmMInsNSvFvBF1@anirudh-surface.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8615-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: BE332BDEEE
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 05:11:12PM +0000, Anirudh Rayabharam wrote:
> On Wed, Jan 28, 2026 at 03:11:14PM -0800, Stanislav Kinsburskii wrote:
> > On Wed, Jan 28, 2026 at 04:16:31PM +0000, Anirudh Rayabharam wrote:
> > > On Mon, Jan 26, 2026 at 12:46:44PM -0800, Stanislav Kinsburskii wrote:
> > > > On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> > > > > On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > > > > > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > > > > > runtime and never withdraws them. This creates a fundamental incompatibility
> > > > > > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > > > > > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > > > > > hypervisor deposited pages.
> > > > > > 
> > > > > > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > > > > > management is implemented.
> > > > > 
> > > > > Someone might want to stop all guest VMs and do a kexec. Which is valid
> > > > > and would work without any issue for L1VH.
> > > > > 
> > > > 
> > > > No, it won't work and hypervsisor depostied pages won't be withdrawn.
> > > 
> > > All pages that were deposited in the context of a guest partition (i.e.
> > > with the guest partition ID), would be withdrawn when you kill the VMs,
> > > right? What other deposited pages would be left?
> > > 
> > 
> > The driver deposits two types of pages: one for the guests (withdrawn
> > upon gust shutdown) and the other - for the host itself (never
> > withdrawn).
> > See hv_call_create_partition, for example: it deposits pages for the
> > host partition.
> 
> Hmm.. I see. Is it not possible to reclaim this memory in module_exit?
> Also, can't we forcefully kill all running partitions in module_exit and
> then reclaim memory? Would this help with kernel consistency
> irrespective of userspace behavior?
> 

It would, but this is sloppy and cannot be a long-term solution.

It is also not reliable. We have no hook to prevent kexec. So if we fail
to kill the guest or reclaim the memory for any reason, the new kernel
may still crash.

There are two long-term solutions:
 1. Add a way to prevent kexec when there is shared state between the hypervisor and the kernel.
 2. Hand the shared kernel state over to the new kernel.

I sent a series for the first one. The second one is not ready yet.
Anything else is neither robust nor reliable, so I don’t think it makes
sense to pursue it.

Thanks,
Stanislav


> Thanks,
> Anirudh.
> 
> > 
> > Thanks,
> > Stanislav
> > 
> > > Thanks,
> > > Anirudh.
> > > 
> > > > Also, kernel consisntency must no depend on use space behavior. 
> > > > 
> > > > > Also, I don't think it is reasonable at all that someone needs to
> > > > > disable basic kernel functionality such as kexec in order to use our
> > > > > driver.
> > > > > 
> > > > 
> > > > It's a temporary measure until proper page lifecycle management is
> > > > supported in the driver.
> > > > Mutual exclusion of the driver and kexec is given and thus should be
> > > > expclitily stated in the Kconfig.
> > > > 
> > > > Thanks,
> > > > Stanislav
> > > > 
> > > > > Thanks,
> > > > > Anirudh.
> > > > > 
> > > > > > 
> > > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > > ---
> > > > > >  drivers/hv/Kconfig |    1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > > > index 7937ac0cbd0f..cfd4501db0fa 100644
> > > > > > --- a/drivers/hv/Kconfig
> > > > > > +++ b/drivers/hv/Kconfig
> > > > > > @@ -74,6 +74,7 @@ config MSHV_ROOT
> > > > > >  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> > > > > >  	# no particular order, making it impossible to reassemble larger pages
> > > > > >  	depends on PAGE_SIZE_4KB
> > > > > > +	depends on !KEXEC
> > > > > >  	select EVENTFD
> > > > > >  	select VIRT_XFER_TO_GUEST_WORK
> > > > > >  	select HMM_MIRROR
> > > > > > 
> > > > > > 

