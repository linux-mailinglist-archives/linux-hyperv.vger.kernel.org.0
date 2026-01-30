Return-Path: <linux-hyperv+bounces-8609-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEDuHODtfGmdPQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8609-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:44:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A0BD68A
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECC8B3035029
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F337881F;
	Fri, 30 Jan 2026 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="P9y0NaQ9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385778C9C;
	Fri, 30 Jan 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794727; cv=pass; b=mkcO1jQkDdL0hV8KRLVdFYFpukU0t4ztu/++H/59+ynRqO/jQSHDFfsebrWQUIwYNqJaFR1kFX462/gNN9CI69xYAFx8X1mGW1BG4tDQfput7io1iLzVYE1HF9xKVwbMNSmtx0SJ99KgCXzkq1/Cbr3IRkpzOORQ1ull//lkP3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794727; c=relaxed/simple;
	bh=I0L4NAJiC9NpLALFqIezX2iAvdTJvDTxwwRvGBbnJ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5VJjdSK6ICQiptRMd8Yr92we2q406wjOtTc52EkH3LKah3TLRltORT3UtZBckOr3mG3Sabxq7h3S/LRFa0nq0ePudKYrZV8VWjs2iSLKHTacOjWKUqOUuy7ubjPSJkDwGwojlqMCDMjDF3A1yGpLZDAcs8CgesTfJaOptJp1XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=P9y0NaQ9; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769794652; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZTVs6WcGwSxnOlDsvA/rUaLknoNEeaDRGWtSf9cbbEwcqxSH31gfo5wAOik4NuntGCEp5dB3uQa0R+96r+RtPZcoX+jtV90LhQD7D2jTR70JHDFqPKHnZ+YQqTYKAkNGyR0oWaTFJH6TmhbwISq3PgeGohqhiRiVV9IdNpteocA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769794652; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TYw/cigXzxXUxtsLmCDQwXXi5KokRYF5utUQe2DhPTA=; 
	b=k6XCSET0IE36j53j4YOcf6fsVyix+3Wb/5QiCIeDr9h1G66CzAgdM0/JrSVTJAIjeMIaWOFZfg5BBkgVsEZSWBmmFAN58PW9rZIjQaszKz47zuGwkfoWWgcVYSkHRV7Cw0yWNVAyELwnCfNiqqAG4tk40u+G6IzixIyCLQn4goM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769794652;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=TYw/cigXzxXUxtsLmCDQwXXi5KokRYF5utUQe2DhPTA=;
	b=P9y0NaQ9RBzhOXXs4Gufi+lVJcGiQFe0UU22ErihaF9U1pDnSX60o6XMhDoWKCp4
	/uc4eGj855PjjGnSJmISQCfM+gEY3HMdoF8pT0v6SYIQ9xPTIJN/hWxAf3gYFlF3sd3
	rCBwnFF7tcsdwXgQpsOhyLtKUTb8mmL/f9Cs60aY=
Received: by mx.zohomail.com with SMTPS id 1769794649957871.3026206804187;
	Fri, 30 Jan 2026 09:37:29 -0800 (PST)
Date: Fri, 30 Jan 2026 17:37:24 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mshv: Add support for integrated scheduler
Message-ID: <aXzsVN3SnNXIDPMV@anirudh-surface.localdomain>
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
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8609-lists,linux-hyperv=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anirudhrb.com:dkim,anirudh-surface.localdomain:mid]
X-Rspamd-Queue-Id: CF5A0BD68A
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

While that commit wasn't individually sent upstream but all the code
from that commit did land upstream probably bundled with other commits
when the mshv driver was introduced. So the reboot notifier is indeed
currently used for resetting the synic correctly during kexec reboot.

Thanks,
Anirudh.

> 
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
> Michael

