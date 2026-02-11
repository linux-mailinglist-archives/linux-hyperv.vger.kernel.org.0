Return-Path: <linux-hyperv+bounces-8787-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vczfCFEKjWmLyAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8787-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 00:01:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AC6128342
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 00:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB5E03039ECF
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 23:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F62A30E84B;
	Wed, 11 Feb 2026 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="J1dOAx8m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A32FFF94;
	Wed, 11 Feb 2026 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770850894; cv=pass; b=OE+s6B4JOToLkT9m3Z4/ZuGEWKe5R0IHPlsOD/ntPjmlt4QzaeALGHg3ORpusUaDWw9Z+JiJ5JmIWDEFHPO8WKAlZk19GQd+J5PRiJptqCDaR/elLe4bsXCtjkvPCbP+GqDRw8HvnOwyilfS2GccMmHi+iEGpuRtu66v2UIvIJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770850894; c=relaxed/simple;
	bh=GUl3h7KjSpNZpEq979Qr9acv+uhNIWB+2s0k6MB6TP4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cTCrSU7jjsjoPGmZAPiXWv4i7wS8z+BysdFrNCdxRLJ/Qf15kGqD+6ekMjPqSdE7VaAOiJnKFWLg0UK9bcwUmoz4rQvg+uL39MUM/UwT76FUgQ0Q1wAj7iuhMYE3eCEas8MIshrBT75nkMKsObdRd4ZxTo7uPAOn/rMcvKKMMu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=J1dOAx8m; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1770850875; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LwxA8sJafi9WFL5Q0ruLOFqdyD9oE0ts03eJlUHHir2xssUSbYW1i5KcYDzOQ0YmoyfShIZ6pZUiXNfN6f90FPie2MWS47kid9y79kyOBu9AJUcG1fFjWLsGK+jBy/lDz3SUnmKuv9gQH6OaWbYK77UxdtCEOyIQuTsIKO+Oikk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770850875; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/v4IpnBx8AesptYQpTGBnp5aGZXOHZnGRAcZx9o9l6c=; 
	b=dV2WuD179DhT7Bt+cPu6Sv1Ab2EhoUX4sHncFfxbtvuyiB7y2o5Aw9+llsTay434BVZErTnQFphMTPit1ug/JKQyPC/flzzBPW5AYG1MXn5u1ld2HHP236Ab29fGQMZ6tHtn3rkgvZc62S7jCyeeRMclP/Edob2UWmdhsWRqm/g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770850875;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:References:In-Reply-To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=/v4IpnBx8AesptYQpTGBnp5aGZXOHZnGRAcZx9o9l6c=;
	b=J1dOAx8mMywlm6cUalzSFGXFw5PHe49Lyls+bTq2Wak/46lGSr+5EdH7Zh24qNxc
	HC6HbjIVu1imlntGPe2eV4F7vEgGqCezrJeupz30k9ktGns/eHegVcsHiXsLm7Dl40T
	3BrmQCAZsjm8dlI+nQFZqkDRnJuB1RoA6cl3bW0w=
Received: by mx.zohomail.com with SMTPS id 1770850873502363.73321615779025;
	Wed, 11 Feb 2026 15:01:13 -0800 (PST)
From: <mhklkml@zohomail.com>
To: "'Jocelyn Falempe'" <jfalempe@redhat.com>,
	<mhklinux@outlook.com>,
	<drawat.floss@gmail.com>,
	<maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>,
	<tzimmermann@suse.de>,
	<airlied@gmail.com>,
	<simona@ffwll.ch>,
	<kys@microsoft.com>,
	<haiyangz@microsoft.com>,
	<wei.liu@kernel.org>,
	<decui@microsoft.com>,
	<longli@microsoft.com>,
	<ryasuoka@redhat.com>
Cc: <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260209070201.1492-1-mhklinux@outlook.com> <20260209070201.1492-2-mhklinux@outlook.com> <a5372b72-8dc0-4f2d-ad5c-086f3e75ee81@redhat.com>
In-Reply-To: <a5372b72-8dc0-4f2d-ad5c-086f3e75ee81@redhat.com>
Subject: RE: [PATCH 2/2] drm/hyperv: During panic do VMBus unload after frame buffer is flushed
Date: Wed, 11 Feb 2026 15:01:09 -0800
Message-ID: <002601dc9baa$517d8b40$f478a1c0$@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJO9nqM+3PSL28VGf9uaee72s+bfQD8X2UsAcZTyQS0g09e4A==
Feedback-ID: rr080112276f0bff552fa972c91e69bbc60000e8c5825fb1e45bc2f26668e518962c583bee303c4ddbc88c1f:zu080112270d1c11740cd942b4e357bf9c000070af211c092d8af91d7479311df3c99054c758bc409412f527:rf08011226531496a33a4b9bfb5b113bd40000f39f2acda6414885ed869a26970cd68ab6a548dd3bef5a06:ZohoMail
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,outlook.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8787-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[zohomail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,zohomail.com:mid,zohomail.com:dkim]
X-Rspamd-Queue-Id: 60AC6128342
X-Rspamd-Action: no action

From: Jocelyn Falempe <jfalempe@redhat.com> Sent: Wednesday, February 11, 2026 1:54 PM
> 
> On 09/02/2026 08:02, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > In a VM, Linux panic information (reason for the panic, stack trace,
> > etc.) may be written to a serial console and/or a virtual frame buffer
> > for a graphics console. The latter may need to be flushed back to the
> > host hypervisor for display.
> >
> > The current Hyper-V DRM driver for the frame buffer does the flushing
> > *after* the VMBus connection has been unloaded, such that panic messages
> > are not displayed on the graphics console. A user with a Hyper-V graphics
> > console is left with just a hung empty screen after a panic. The enhanced
> > control that DRM provides over the panic display in the graphics console
> > is similarly non-functional.
> >
> > Commit 3671f3777758 ("drm/hyperv: Add support for drm_panic") added
> > the Hyper-V DRM driver support to flush the virtual frame buffer. It
> > provided necessary functionality but did not handle the sequencing
> > problem with VMBus unload.
> >
> > Fix the full problem by using VMBus functions to suppress the VMBus
> > unload that is normally done by the VMBus driver in the panic path. Then
> > after the frame buffer has been flushed, do the VMBus unload so that a
> > kdump kernel can start cleanly. As expected, CONFIG_DRM_PANIC must be
> > selected for these changes to have effect. As a side benefit, the
> > enhanced features of the DRM panic path are also functional.
> 
> Thanks for properly fixing this issue with DRM Panic on hyperv.
> 
> I've a small comment below.
> 
> With that fixed:
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> The first patch looks good too, I can review it if no other step up, as
> I'm not familiar with hyperv.
> 
> >
> > Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >   drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++++
> >   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 15 ++++++++-------
> >   2 files changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > index 06b5d96e6eaf..79e51643be67 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> > @@ -150,6 +150,9 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
> >   		goto err_free_mmio;
> >   	}
> >
> > +	/* If DRM panic path is stubbed out VMBus code must do the unload */
> > +	if (IS_ENABLED(CONFIG_DRM_PANIC) && IS_ENABLED(CONFIG_PRINTK))
> 
> I think drm_panic should still work without printk.
> The "user" panic screen would be unaffected, but the "kmsg" screen might
> be blank, and the "qr_code" would generate an empty qr code.
> (Actually I never tried to build a kernel without printk).

Yeah, I had never built such a kernel either until recently when the kernel
test robot flagged an error in Hyper-V code when CONFIG_PRINTK is not set. :-) 

But for this patch, the issue is that drm_panic() never gets called if CONFIG_PRINTK
isn't set. In that case, kmsg_dump_register() is a stub that returns an error.  So
drm_panic_register() never registers the callback to drm_panic(). And if
drm_panic() isn't going to run, responsibility for doing the VMBus unload
must remain with the VMBus code. It's hard to actually test this case because
of depending on printk() for debugging output, so double-check my
thinking.

Michael

> 
> > +		vmbus_set_skip_unload(true);
> >   	drm_client_setup(dev, NULL);
> >
> >   	return 0;


