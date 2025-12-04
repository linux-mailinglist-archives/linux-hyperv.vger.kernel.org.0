Return-Path: <linux-hyperv+bounces-7961-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCFDCA3756
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Dec 2025 12:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79970304077D
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Dec 2025 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854A2F2603;
	Thu,  4 Dec 2025 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE2D3ncJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5BA185B48
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Dec 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764848135; cv=none; b=oaQF2xD/bhCQT28xNGcF0IPsBWpqVVYzhBbsqQp0xcb40Q56D/iTjZ+vvHBsVdoSy1lj4AVZShHWXTSMMN+D8kGpVLNzNA9Qyt023/dwKjuYrP35mhAmRYLFCNtbbES20jeMyzRi4ale2wnLoxNKS677KcXB5nJc5OVL8pRzsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764848135; c=relaxed/simple;
	bh=EMpcWrGGQwTXgeTLemTtgVh+nkLljKRqYaXSkt9phIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ft3ZmtDCSuYKPHF8SmLUfenFAWktMhXo9XAxSRoPFquZyPNLRM1h4cfYewIfVSzXhDOL3rm9cxzL15FjSMYzMmlSj2uB7YYVbsxl+GzPnWNSUvicMdlwoBl+GEzmX2hIECuFXXjaUmmPG6ssI2wQlY3dqvji6ZgMVgCB1rWQPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE2D3ncJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b98983bae80so794275a12.0
        for <linux-hyperv@vger.kernel.org>; Thu, 04 Dec 2025 03:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764848133; x=1765452933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETT37Ok2evrsGxBi30r3TjGdteYNKEZEEnmPEtqgVI0=;
        b=PE2D3ncJV3tDWM16hEM36qhahSKK6R2Gkagm6k3hjOGKV5y25gqac4GVLikwceHpOA
         4LMiKmzTgb2LWosfamRLPJCEXXoXjEtlt4kusk3Wh0u6n8Q9ZkLLjaxlL18dQ2B8nFr6
         RRJVIqMANEYwwBR/eU78j0qL5maP3T9eO7PD/u4rWPDfk8ff70YsIWpTWrVGCeNfhsyB
         a6+cvFSApAwMkSIegm15DM1rQ+E4H51RMQp1UwYoTWdMaDrutTt2/efmltKtLq86aSZu
         6+DC/1FK4trLWVERg9Tkm2rxq1vWt5d7cLI8KG4Eqm1he8zMgpjFMFBWY++ntUA/Bgzr
         zMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764848133; x=1765452933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETT37Ok2evrsGxBi30r3TjGdteYNKEZEEnmPEtqgVI0=;
        b=CqSePjH4S5sn86VuHobCslE4ndgPvSYc7NN1/GaP0JxUVLAnFrQ1d4P2lsuyBn6yPd
         zNCgfRF1R9yw+SHTw4e2Uss1aJn5jIu1C+IGT00gQc1XJehOpcmc9EOWyiGcoEMlC+1a
         Hta1M0btZcD/NS+h6wPI69g9Eg10Z3wU+WA8VrCP6jBLEj4sFqQvaE1tdU09A+e5PClM
         DjHkq5/EWV46zBoPhlCfjYFptBJyXOBECwEn8By6ggDcmnxLNA35G8zNW00GqcBKhq/X
         ipCKniKeNJH+DHJhjZfkPaET7RoaPg6FHjGEfVIOagKv23iTByO/3Bi3YprBqU1Yd2+m
         dzGA==
X-Forwarded-Encrypted: i=1; AJvYcCUkIeQhoA5br0sqFtqfLMEoQOUDIo5N6BFUa//JNqvpT93HlzN9TUGU3ZdL4++osupQSNxfTplpnpTfErk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0Tu+kpYXu0VI7UU5wCWVQpaBqJHVyh/gcqzwTTkxMgO3WjV0
	KgrpvTySjmoFxBk6YUh5sxPrWAGNocjJyZVphIy2kdSwyzKbeCUO2WFqmTYbw36+S+YwLD7V96k
	GawpC5p+LGvSjMT+0evZCFHoNU/Er1Eg=
X-Gm-Gg: ASbGncvrHCaPGEEGV0AJu0YaQ7ynp5d5XAt2gWsiHJ88BBDehgz3YOAbLQtbTz4TJnO
	pKJaA5VZRmMPww9sodQE+YHIFZSxu2+Mlpe7+ekFNFqi5U+cKD/26zPAPLyG58WXYQOf+AJqps/
	xf58b9c8XcdAEVXmVKqa+lGY4qRSyyB0OdxuoueSjT5Q+o4DB+QxGo04UY9+UiXfPPqVZq9uxMv
	CohgyQQYwXZIKlYLVJOZaD8pFEHkNsgRZ9J1qsH6N7fCZrVQasgph/f/OIRQyu2xDxYsvShtrYs
	2pBQw1yDurvJ
X-Google-Smtp-Source: AGHT+IE/MHWwLB1TRSsJutMU8M0edDfRdxiVaFety8T6LMGUASyTd4pqnNsqOGrJr1VEowCUhJGMFkUbbWxR4bt3EHI=
X-Received: by 2002:a05:693c:2d86:b0:2a4:664e:a5af with SMTP id
 5a478bee46e88-2ab92e88ab7mr5301129eec.28.1764848132964; Thu, 04 Dec 2025
 03:35:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124182920.9365-1-tiala@microsoft.com> <SN6PR02MB4157DAE6D8CC6BA11CA87298D4DCA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMvTesCbNYHjiwaZC4EJopErZhW+vM0d87zJ54RT_AKXb-2yjw@mail.gmail.com> <SN6PR02MB4157FB57619785BAA50B3586D4A6A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157FB57619785BAA50B3586D4A6A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 4 Dec 2025 19:35:16 +0800
X-Gm-Features: AWmQ_blU30QGLug8m7DiXQZ-kSvKchskuNzClEBRXP-OaTdHiiqHokRUZi1EUWU
Message-ID: <CAMvTesB7shuS8HYifEN37bHPR0mWx9c4ZWNH8_cJwXOywa93zQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Drivers: hv: Confidential VMBus exernal memory support
To: Michael Kelley <mhklinux@outlook.com>
Cc: Christoph Hellwig <hch@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>, 
	Tianyu Lan <tiala@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 11:35=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, December 3, 2025 =
6:21 AM
> >
> > On Sat, Nov 29, 2025 at 1:47=E2=80=AFAM Michael Kelley <mhklinux@outloo=
k.com> wrote:
> > >
> > > From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, November 24, 202=
5 10:29 AM
>
> [snip]
>
> > >
> > > Here's my idea for an alternate approach.  The goal is to allow use o=
f the
> > > swiotlb to be disabled on a per-device basis. A device is initialized=
 for swiotlb
> > > usage by swiotlb_dev_init(), which sets dev->dma_io_tlb_mem to point =
to the
> > > default swiotlb memory.  For VMBus devices, the calling sequence is
> > > vmbus_device_register() -> device_register() -> device_initialize() -=
>
> > > swiotlb_dev_init(). But if vmbus_device_register() could override the
> > > dev->dma_io_tlb_mem value and put it back to NULL, swiotlb operations
> > > would be disabled on the device. Furthermore, is_swiotlb_force_bounce=
()
> > > would return "false", and the normal DMA functions would not force th=
e
> > > use of bounce buffers. The entire code change looks like this:
> > >
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -2133,11 +2133,15 @@ int vmbus_device_register(struct hv_device *c=
hild_device_obj)
> > >         child_device_obj->device.dma_mask =3D &child_device_obj->dma_=
mask;
> > >         dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> > >
> > > +       device_initialize(&child_device_obj->device);
> > > +       if (child_device_obj->channel->co_external_memory)
> > > +               child_device_obj->device.dma_io_tlb_mem =3D NULL;
> > > +
> > >         /*
> > >          * Register with the LDM. This will kick off the driver/devic=
e
> > >          * binding...which will eventually call vmbus_match() and vmb=
us_probe()
> > >          */
> > > -       ret =3D device_register(&child_device_obj->device);
> > > +       ret =3D device_add(&child_device_obj->device);
> > >         if (ret) {
> > >                 pr_err("Unable to register child device\n");
> > >                 put_device(&child_device_obj->device);
> > >
> > > I've only compile tested the above since I don't have an environment =
where
> > > I can test Confidential VMBus. You would need to verify whether my th=
inking
> > > is correct and this produces the intended result.
> >
> > Thanks Michael. I tested it and it seems to hit an issue. Will double c=
heck.with
> > HCL/paravisor team.
> >
> >  We considered such a change before. From Roman's previous patch, it se=
ems to
> > need to change phys_to_dma() and force_dma_unencrypted().
>
> In a Hyper-V SEV-SNP VM with a paravisor, I assert that phys_to_dma() and
> __phys_to_dma() do the same thing.  phys_to_dma() calls dma_addr_encrypte=
d(),
> which does __sme_set().  But in a Hyper-V VM using vTOM, sme_me_mask is
> always 0, so dma_addr_encrypted() is a no-op.  dma_addr_unencrypted() and
> dma_addr_canonical() are also no-ops. See include/linux/mem_encrypt.h. So
> in a Hyper-V SEV-SNP VM, the DMA layer doesn't change anything related to
> encryption when translating between a physical address and a DMA address.
> Same thing is true for a Hyper-V TDX VM with paravisor.
>
> force_dma_unencrypted() will indeed return "true", and it is used in
> phys_to_dma_direct(). But both return paths in phys_to_dma_direct() retur=
n the
> same result because of dma_addr_unencrypted() and dma_addr_encrypted()
> being no-ops. Other uses of force_dma_unencrypted() are only in the
> dma_alloc_*() paths, but dma_alloc_*() isn't used by VMBus devices becaus=
e
> the device control structures are in the ring buffer, which as you have n=
oted, is
> already handled separately. So for the moment, I don't think the return v=
alue
> from force_dma_unencrypted() matters.
>
> So I'm guessing something else unexpected is happening such that just dis=
abling
> the swiotlb on a per-device basis doesn't work. Assuming that Roman's ori=
ginal
> patch actually worked, I'm trying to figure out how my idea is different =
in a way
> that has a material effect on things. And if your patch works by going di=
rectly to
> __phys_to_dma(), it should also work when using phys_to_dma() instead.
>

I agree with your analysis and your proposal is much simpler. The
issue I hit was a lot
of user space tasks were blocked after FIO test of several minutes. I
also reproduced
with DMA ops patch after longer test and so need to double check
whether we missed
something or it's caused by other issue. If it's related with
private/shared address used
in the normal guest, we may debug in the paravisor.

--=20
Thanks
Tianyu Lan

