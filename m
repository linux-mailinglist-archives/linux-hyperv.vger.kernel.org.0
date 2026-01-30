Return-Path: <linux-hyperv+bounces-8601-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAqVAmbTfGlbOwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8601-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 16:51:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B27FBC38C
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 16:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F92303FAC2
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 15:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C53933A9D3;
	Fri, 30 Jan 2026 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lw8UUKrM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C1D328B69;
	Fri, 30 Jan 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788146; cv=none; b=TUIQq/9PnopK7ijW30zzHs/EyobVlxTsbKUcjLaXMviqZIni96djmMlLxxdVwd1pda9wi9G6Hen1txtoxyujOF8ptO5o9B2yWmZNHskt57qbBUrocVPG9E4c1o///Mu7DIs13+3DMgZe3zIjCtcNGz/uno+O+XufYsnUbzVGZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788146; c=relaxed/simple;
	bh=uetvXCW4ckYYfuIokCe7rnB4KZ2lB2VJmb6U10W2p1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2IjOCDETpVdgXMDLAtCca9zR7bujwzvUFuXFzjcxXjEx6O4x9sCfpyeosSOLSEd9RMRPJG+CR5zlfHX50nxMdm5SvIVSIqLygLqKsB3TLTfEhDNoswHzS/AOSyf7rGBtIm7VvkQ+Zh7E4xs62aAMUmP2B6vxx4YooZ5DAc3VG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lw8UUKrM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D26D820B7167;
	Fri, 30 Jan 2026 07:49:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D26D820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769788145;
	bh=Y7rFLVQtwnTXgFLRjNly1o4YEBvUgqVnKy+WWXvEVlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lw8UUKrMvESW5yxCtL5HulkskLUEgWuLfXvHFvBKxht4LKiZ/SflKtwksOeNzACca
	 0J9s75tJ5QbIVYuNdmJrnlnqxuP7hE+b9meO+GcM9Xe/HOvsfbvO5MWTwHaAiiOU7U
	 9jUDZjpV9Ybu5VAsc+DVGRljKRSgT4LvQYX7dEfI=
Date: Fri, 30 Jan 2026 07:49:05 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mshv: Add support for integrated scheduler
Message-ID: <aXzS8VPmfInQVort@skinsburskii.localdomain>
References: <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176903495970.166619.12888807009225201668.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415767BB59E00442812F47B5D49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aXuwes2HNf4Og8lW@skinsburskii.localdomain>
 <SN6PR02MB4157EE41697ABC1002750297D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157EE41697ABC1002750297D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8601-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 5B27FBC38C
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 01:24:34AM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, January 29, 2026 11:10 AM
> > 
> > On Thu, Jan 29, 2026 at 05:47:02PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Wednesday, January 21, 2026 2:36 PM
> > 
> > <snip>
> > 
> > > >  static int __init mshv_root_partition_init(struct device *dev)
> > > >  {
> > > >  	int err;
> > > >
> > > > -	err = root_scheduler_init(dev);
> > > > -	if (err)
> > > > -		return err;
> > > > -
> > > >  	err = register_reboot_notifier(&mshv_reboot_nb);
> > > >  	if (err)
> > > > -		goto root_sched_deinit;
> > > > +		return err;
> > > >
> > > >  	return 0;
> > >
> > > This code is now:
> > >
> > > 	if (err)
> > > 		return err;
> > > 	return 0;
> > >
> > > which can be simplified to just:
> > >
> > > 	return err;
> > >
> > > Or drop the local variable 'err' and simplify the entire function to:
> > >
> > > 	return register_reboot_notifier(&mshv_reboot_nb);
> > >
> > > There's a tangential question here: Why is this reboot notifier
> > > needed in the first place? All it does is remove the cpuhp state
> > > that allocates/frees the per-cpu root_scheduler_input and
> > > root_scheduler_output pages. Removing the state will free
> > > the pages, but if Linux is rebooting, why bother?
> > >
> > 
> > This was originally done to support kexec.
> > Here is the original commit message:
> > 
> >     mshv: perform synic cleanup during kexec
> > 
> >     Register a reboot notifier that performs synic cleanup when a kexec
> >     is in progress.
> > 
> >     One notable issue this commit fixes is one where after a kexec, virtio
> >     devices are not functional. Linux root partition receives MMIO doorbell
> >     events in the ring buffer in the SIRB synic page. The hypervisor maintains
> >     a head pointer where it writes new events into the ring buffer. The root
> >     partition maintains a tail pointer to read events from the buffer.
> > 
> >     Upon kexec reboot, all root data structures are re-initialized and thus the
> >     tail pointer gets reset to zero. The hypervisor on the other hand still
> >     retains the pre-kexec head pointer which could be non-zero. This means that
> >     when the hypervisor writes new events to the ring buffer, the root
> >     partition looks at the wrong place and doesn't find any events. So, future
> >     doorbell events never get delivered. As a result, virtqueue kicks never get
> >     delivered to the host.
> > 
> >     When the SIRB page is disabled the hypervisor resets the head pointer.
> 
> FWIW, I don't see that commit message anywhere in a public source code
> tree. The calls to register/unregister_reboot_notifier() were in the original
> introduction of mshv_root_main.c in upstream commit 621191d709b14.
> Evidently the code described by that commit message was not submitted
> upstream. And of course, the kexec() topic is now being revisited ....
> 
> So to clarify: Do you expect that in the future the reboot notifier will be
> used for something that really is required for resetting hypervisor state
> in the case of a kexec reboot?
> 

Yes, for now it's the best we have.
This code can be dropped later if we get a better way to handle kexec.

> > 
> > > > -root_sched_deinit:
> > > > -	root_scheduler_deinit();
> > > > -	return err;
> > > >  }
> > > >
> > > > -static void mshv_init_vmm_caps(struct device *dev)
> > > > +static int mshv_init_vmm_caps(struct device *dev)
> > > >  {
> > > > -	/*
> > > > -	 * This can only fail here if HVCALL_GET_PARTITION_PROPERTY_EX or
> > > > -	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES are not supported. In that
> > > > -	 * case it's valid to proceed as if all vmm_caps are disabled (zero).
> > > > -	 */
> > > > -	if (hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > > > -					      HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > > > -					      0, &mshv_root.vmm_caps,
> > > > -					      sizeof(mshv_root.vmm_caps)))
> > > > -		dev_warn(dev, "Unable to get VMM capabilities\n");
> > > > +	int ret;
> > > > +
> > > > +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > > > +					 	HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > > > +						0, &mshv_root.vmm_caps,
> > > > +						sizeof(mshv_root.vmm_caps));
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > >
> > > This is a functional change that isn't mentioned in the commit message.
> > > Why is it now appropriate to fail instead of treating the VMM capabilities
> > > as all disabled? Presumably there are older versions of the hypervisor that
> > > don't support the requirements described in the original comment, but
> > > perhaps they are no longer relevant?
> > >
> > 
> > To fail is now the only option for the L1VH partition. It must discover
> > the scheduler type. Without this information, the partition cannot
> > operate. The core scheduler logic will not work with an integrated
> > scheduler, and vice versa.
> > 
> > And yes, older hypervisor versions do not support L1VH.
> 
> That makes sense. Your change in v2 of the patch handles this
> nicely. For the non-L1VH case, the v2 behavior is the same as before in
> that the init path won't error out on older hypervisors that don't
> support the requirements described in the original comment. That's
> the case I am concerned about.
> 

Yes. Thank you for the review and feedback!

Stanislav
> Michael

