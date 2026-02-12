Return-Path: <linux-hyperv+bounces-8789-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDPDIiqPjWl54QAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8789-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 09:28:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F337512B4FD
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 09:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A89C312E4A5
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A572D94A1;
	Thu, 12 Feb 2026 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzdMbyL4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE812D6E73
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Feb 2026 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884802; cv=pass; b=HYVgg/XIawegLFHwWoSNMbuzV0eky9qGxp9qp/yCyaVK1W1s6ATsTXr95Yh4fuyxwnLdMQy8iR7WwH5X+bza+4RKtg/y1ofkgRLPPsUq8RNWiy1gQ5h++c16riyDDGPeAKCXHTlp9jtlRWeRbQQ6rR9ac9+rDXd1o4AdF0xQ98I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884802; c=relaxed/simple;
	bh=dqTHvfKw9WIP5NuLDwaEhnZ2sZ2gsZHRYl1J+pD8xYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3Zj1LoL3PliXWVJwxlj4kxlzu0MHjPnVtKzbezODdT7V9PgwXYH8DYJ4DtJnZztpDKUpdGsFoiehOV7gyDbhIeT+mPorxs1cQkzjLOTuBpmeMITcr5BsM+Id6GyvZPg5YdYGUJimdQ3ne3gqV4yjwHngPrwAg1HaqDimujZbYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzdMbyL4; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so8148263eec.1
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Feb 2026 00:26:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770884796; cv=none;
        d=google.com; s=arc-20240605;
        b=lRcutk8KA5/DgafRUbvNb3g/yf/E1w3V8YKN1JG34KChHOwhgAHYBrK1i/J+bswmr0
         rpt70U2LyPBvl/DkfxKH8vD3TuTfXuUzlA/RVEkd7ft9Rj43lSidksE7+YiZwkCoIRcC
         4plzsM7klfzDu/WfK2asvHxJ9vKd36mA5NMpCdXEIYMuAiyH2qqJcHUdGv0gDaJ+cuLp
         8BxT1kra+SdS4Sr3whjP4+8LQd5sGIxBYoiZ2F+hqS+B0IhdEHC6IEEaxrlItrSzwyar
         RRcrhJQSzoNpfYP2EHlYC9+0c5moL0siLyS64iJrQ39IZe/NuVT0L6HuVFOH4JYkbs11
         SS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHL2XY8NIQ/NSGmpkZIDyCYzIMM61D8DDjWecMh+F3Q=;
        fh=fArGHWzBCz32aHIF3+rlSDveszQDZfSY+Iy6Hnmag2Q=;
        b=lXsQWjTxampPSZtPRNdYXHmb4HE0/tFzvThwx4d+DeZvFYLMjWHz5QfPEPve/BGtTK
         na6uRij4t/g2D0DzJKV0qCXa1bTgaXe8t1OaY2BpvjE43SdrzPRVH7/ZoW4J9gzWTTY3
         Z2g8NGp1PuL7LVFYUXBaMqhmZHXQs/eCbGZxhCVju+ukHSob8yNRLrz7hJb1CXTmp+F0
         pfglc3FQe3SlV6SATE4+ezG6PA4rHLRWEvfwvF8Y9A+2SI1m9neQCh7ZicY1QyOukgDB
         +ntg49wybRDCoLOO1zDsUT5fz1M9ZuJvj+zddC/4U3VqBmmgAjpsu0aTUyoWflsK4no7
         2tow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770884796; x=1771489596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHL2XY8NIQ/NSGmpkZIDyCYzIMM61D8DDjWecMh+F3Q=;
        b=kzdMbyL4iy8FkAdb/y221rkQRPmnnFx/PQZhCIFFXkG4c2lUTO1ekPz/OZ7q71v39x
         usaOcr1KRQSUXS67SgUWw7uYHsoEXYuFxCuSA02f6oY1JBWarHyAlJT9rns4ep69sVt0
         2BZVDcmd+pasEEemovCMz5jbjzgdodkmHGPcnJi3TZ42mltaWSdwBQYyAYThYHCNNvCw
         AS06RiyQypxb8GyGpOo9NZG7BgwR5pWzXdKrbAKbREukP8TQF4+cq8wkav1z3A2PBJOH
         voR3w8KdJBXC6ZNJCdkRNCQcuXA08VO7xq2/e4QNcliBQpW6e+BVTZ9EkgfAbqrxlO1H
         a45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770884796; x=1771489596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eHL2XY8NIQ/NSGmpkZIDyCYzIMM61D8DDjWecMh+F3Q=;
        b=kaSl6plSTVTvLGPv2PfPlvaaME+4NasXc7bF1dlqCR6gQ0DQCFY7Xw35IL5D6V1NYi
         mZ8dLSRe/AEMqAFeQUWIzyMjKPO+DHjEZDXn40+3Du7+vfW2Eb2FRXCEeJF0BxqQsGrs
         /O5Ry6LEFvBE8Cukrhu7O3DnoooaLNeDy22whTybK/qtoMMy907DrbIHvFlFrtJKO2Wr
         GZz76Nwlji2Kib57b55nmBDZr0W6hU38IlmDIhaC+8tRB/1+dsi7rMV/EghBJvbggYIS
         tPro4P3hwZ1+x1GJwEChVa7RDWWpJs8gpH0sgWSbZJorUFWq1l8Woqfgeh2rNfkED/vm
         RSkg==
X-Forwarded-Encrypted: i=1; AJvYcCUYLmu5V1CTOHet4LSHh78AsZvdjKpAGjIP98dCB8PZPQZfMzURUhof1ckGMHfAxVn+klQotFHiaD/odo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWsumsqqp3FftUbyeKwf5b0Fv5ntctIPbMz0RX5TdhfXa7MOE
	VO8He0LXp4NAis/fq8Ee2kubn5/Cuhuvzb1X02ChKxEd/bugtmYAHSZ0Ea5XHB9Ebvf34SgTVyN
	KNDU7jrDloaylkdWxIfE3YsFkn3VlK5w=
X-Gm-Gg: AZuq6aJ8E5Dr4zWzB6UcPYp13AEiXIl0q0+yEFTtz0xf824qvf6vufq/KJvyHe55lOs
	vlMMkBFzXwGPDBK2+a3lIs0uLsYDjqjubPd/I1aTwX9KwhhJgxmUHE1PXJ+EkSKz993H4dQc61U
	9ZN9NTrLvWnUe9zPpxDyODED7bPmVnovQuICsBEDkgpy3gSC7/LUyjjS+X6YPEpIChBrmErNbVs
	smlj54Yri/VVOMIpKLsD9gfibwpZIr2oOdj8LecPdgUTwq0AtH8tJyED+I3RDhZ8en2/2CIG+Jx
	esdJu1xQ7B585xnoMRa9Q76/4Q==
X-Received: by 2002:a05:7300:190b:b0:2ba:99cf:e191 with SMTP id
 5a478bee46e88-2baa80491e9mr797242eec.23.1770884796345; Thu, 12 Feb 2026
 00:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210162107.2270823-1-ltykernel@gmail.com> <SN6PR02MB41577FB84EC73E48ABAC7D18D463A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41577FB84EC73E48ABAC7D18D463A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 12 Feb 2026 16:26:19 +0800
X-Gm-Features: AZwV_Qj1250DiWzLCMeKZQzJOpyK59u5iX9m-Xa-DtGtNyl4wD7akjCHdf8ILRY
Message-ID: <CAMvTesDY00gbd60StLnawQKv5zUzK9PikQdM0njP5nS0dLgR+Q@mail.gmail.com>
Subject: Re: [RFC PATCH V2] x86/VMBus: Confidential VMBus for dynamic DMA
 buffer transition
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, Tianyu Lan <tiala@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@infradead.org" <hch@infradead.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8789-lists,linux-hyperv=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltykernel@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvmm.dev:url,outlook.com:email]
X-Rspamd-Queue-Id: F337512B4FD
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 2:00=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, February 10, 2026 8=
:21 AM
> >
> > Hyper-V provides Confidential VMBus to communicate between
> > device model and device guest driver via encrypted/private
> > memory in Confidential VM. The device model is in OpenHCL
> > (https://openvmm.dev/guide/user_guide/openhcl.html) that
> > plays the paravisor rule.
> >
> > For a VMBUS device, there are two communication methods to
>
> s/VMBUS/VMBus/
>
> > talk with Host/Hypervisor. 1) VMBus Ring buffer 2) dynamic
> > DMA transition.
>
> I'm not sure what "dynamic DMA transition" is. Maybe just
> "DMA transfers"?  Also, do the same substitution further
> down in this commit message.
>
> > The Confidential VMBus Ring buffer has been
> > upstreamed by Roman Kisel(commit 6802d8af).
>
> It's customary to use 12 character commit IDs, which would be
> 6802d8af47d1 in this case.
>
> >
> > The dynamic DMA transition of VMBus device normally goes
> > through DMA core and it uses SWIOTLB as bounce buffer in
> > CVM
>
> "CVM" is Microsoft-speak. The Linux terminology is "a CoCo VM".
>
> > to communicate with Host/Hypervisor. The Confidential
> > VMBus device may use private/encrypted memory to do DMA
> > and so the device swiotlb(bounce buffer) isn't necessary.
>
> The phrase "isn't necessary" does not capture the real issue
> here. Saying "isn't necessary" makes it sound like this patch is
> just avoids unnecessary work, so that it is a performance
> improvement. But that's not the case.
>
> The real issue is that swiotlb memory is decrypted. So bouncing
> through the swiotlb exposes to the host what is supposed to be
> confidential data passed on the Confidential VMBus. Disabling
> the swiotlb bouncing in this case is a hard requirement to preserve
> confidentially.
>
> So I would reword the sentences as something like this:
>
> The Confidential VMBus device can do DMA directly to
> private/encrypted memory. Because the swiotlb is decrypted
> memory, the DMA transfer must not be bounced through the
> swiotlb, so as to preserve confidentiality. This is different from
> the default for Linux CoCo VMs, so disable the VMBus device's
> use of swiotlb.
>
> > To disable device's swiotlb, set device->dma_io_tlb_mem
> > to NULL in VMBus driver and is_swiotlb_force_bounce()
> > always returns false.
> >
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> > Change since v1:
> >        Use device.dma_io_tlb_mem to disable device bounce buffer
> >
> >  drivers/hv/vmbus_drv.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index a53af6fe81a6..58dab8cc3fcb 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2133,11 +2133,15 @@ int vmbus_device_register(struct hv_device *chi=
ld_device_obj)
> >       child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask=
;
> >       dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> >
> > +     device_initialize(&child_device_obj->device);
> > +     if (child_device_obj->channel->co_external_memory)
> > +             child_device_obj->device.dma_io_tlb_mem =3D NULL;
> > +
>
> Doing this as part of the VMBus bus driver makes sense. While directly
> setting device.dma_io_tlb_mem to NULL should work, it would be better
> to add a function to the swiotlb code to do this, and then call that func=
tion
> here, passing the device as an argument. The need to disable swiotlb on a
> device will likely arise in similar contexts (such as TDISP), and it woul=
d be
> better to have a swiotlb function for that purpose. This use case may be
> a bit ahead of the TDISP work, and having a swiotlb function in place wil=
l
> help ensure that duplicate mechanisms aren't created as everything
> comes together.
>
> See my earlier comments in [1] about the key point in the commit message,
> and about adding a swiotlb_dev_disable() function to the swiotlb code.
>
> Michael

Hi Michael:
     Thanks for your review. Will add swiotlb_dev_disable() in the next ver=
sion.

>
> [1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157DAE6D8CC6BA11CA8729=
8D4DCA@SN6PR02MB4157.namprd02.prod.outlook.com/
>
> >       /*
> >        * Register with the LDM. This will kick off the driver/device
> >        * binding...which will eventually call vmbus_match() and vmbus_p=
robe()
> >        */
> > -     ret =3D device_register(&child_device_obj->device);
> > +     ret =3D device_add(&child_device_obj->device);
> >       if (ret) {
> >               pr_err("Unable to register child device\n");
> >               put_device(&child_device_obj->device);
> > --
> > 2.50.1



--=20
Thanks
Tianyu Lan

