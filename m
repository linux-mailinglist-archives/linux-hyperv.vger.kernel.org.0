Return-Path: <linux-hyperv+bounces-7967-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E63CA6159
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 05:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BB05302429D
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 04:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE66829E114;
	Fri,  5 Dec 2025 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ7qsIx5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBB295DBD
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Dec 2025 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764907825; cv=none; b=V9fn/C1VrJXXLl6lpZjK0uh8A2ntRXj44iYCAFJpPVbYGZ+XBYliGs4QqAbO3y3S49ZYdGXuPJwpXBxjRNoKYEJ8B+av6zaVlM6UdHCizb057a2M1O29FLgLgSFcijAgi+xV57N7PvJWtpzGwN1KVNvyIsmoFkRIKaf88SsQAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764907825; c=relaxed/simple;
	bh=crHoEXn0Tawd+hLmjNWcJGDUp4mWnUabRxCOC3z6lJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoi53BsGfnlObN1QZh6HQcWoh4WtEPAckZeh7McyAf+ekkqOCIQZM8jY8w9uYU87M5zYFF+W433MM/G7DeXmdj0gHeV1ryQdJGF9/X+LKrHm5MmtjHEEai25gExePKlzanLqCb0xyIXfuEOmklitQEVzjfX0Se9SBc+/v2U+cNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ7qsIx5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso975966a12.3
        for <linux-hyperv@vger.kernel.org>; Thu, 04 Dec 2025 20:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764907823; x=1765512623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDTMhx8tnw7o4a0+SKsnxD0PuyKTwqUSve3AvjlmyNw=;
        b=LQ7qsIx5vng7EOchXGVctoFQdvMktIyJrKOxwJZIeymG2LVmtPOR0pi8oIDu1dbNHB
         OeTXXlvOyukVMWHypC0zD3B8jwSP1SYmc16lMscA+Lq5rUCDHwdUMAcFt/3YO09SfaWU
         T7M/a2jb0cf+52yuzB755xkQXH/Z/J5XzIf8b+0hhBTxr6aXP7ZTQMBC0O6TUngQ1+CE
         L6yuXfAMd4oAHQG1dHHToPLDRUcNAp6nLxYqHN1Fp5xisX8C06cw9FwoiCd8DJfofyrL
         kFOKzYYIvr2mcX0FAIamphnfvtBgP/+lXu+XqALUzUI2nUJzVCgOFdRBl2rys1Nv+uvu
         6q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764907823; x=1765512623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDTMhx8tnw7o4a0+SKsnxD0PuyKTwqUSve3AvjlmyNw=;
        b=c98hB5U89P8LoI5U3nSJBr7bsBT4kJTtQdwCBBdMeRmcGF2J/JwA/QPvgXQR201Hut
         YDHKrbag/t9yV8L1NMHCVcwO6iakHXTu0bAWnZ3bZ+nFO8z9Z5VlkrLkBLYSZDYdvB6K
         2bi8oBomFe8jvYnvQzKgnyIzZIV+A2OqSku3JiR4gIFTL8RzzW+bp52jYK9PZ1ZhEp0z
         tbHc0P9M1aOojSPdbymbOOl/sP+/k8GPrErkx4Gu/urypC8VfzlZeBDMxEn1WrgM4pmQ
         TPNkCLFH7erfEurr3Z+Ue13CwEcyyHo48w/MM+9LwJDw/nfpOFpezrbJmqRa69VDA/6V
         SH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmw6fL0C/OzuHFowlcjLFjIUkcs+nzM+yDv7jrnkwkt2QTNVJYLaHL16D3Qw2d/tlYtZjrajVymAjVnz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYl2o1KxJzcmYerFb1M0P7YcacAmt3pkK4Nd76VHDw2lubgBNo
	rToKaBtoKqp+mRuq+aPsca6mrtwJFHojI0rvXGj0sUhObhfb+TuNdut8o7JiHiY3yN9D6w0E1WH
	fns1vy7SOMXmHKOtY/n6WBkA+naNSzns=
X-Gm-Gg: ASbGncsM7/A2s32OLdpNfXCnqSEVaSgINRUfek2OZ9+12jEMPQgnCNe03HWxwoJs7Pj
	JVGeYpe6BXjApzZDnm+ddGQKUvq5N6WZXamQzXLNqoivHjQK5bBlEsRw4iGDb7+NomS/ukfQh2M
	KWwQapr/N69k9hZijvTQks/pGCEGuQG6z3z5xKKaGQJj3JS9QJGSZL/mkeTSNHYUJhSqiCvAY0F
	mbRwJIdZ1U75aSBwqQfkURIUtrieCIpdTG0pyp+OzICr9xih/dG41jhjHXnHr1GW461OIcGcKR+
	OKY7VGZDTmg8
X-Google-Smtp-Source: AGHT+IHBFaX9JsenJbUYIsQXMoDn5UnM7XKVVM3AVwFyHyWH5AkWkkCa5WbrTKyJIM1U+58mXwPgFvDuQ/Y3JZiKSxU=
X-Received: by 2002:a05:693c:609a:b0:2a4:69ec:ff0 with SMTP id
 5a478bee46e88-2ab92e64ab2mr5642428eec.27.1764907823552; Thu, 04 Dec 2025
 20:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124182920.9365-1-tiala@microsoft.com> <SN6PR02MB4157DAE6D8CC6BA11CA87298D4DCA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMvTesCbNYHjiwaZC4EJopErZhW+vM0d87zJ54RT_AKXb-2yjw@mail.gmail.com>
 <SN6PR02MB4157FB57619785BAA50B3586D4A6A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMvTesB7shuS8HYifEN37bHPR0mWx9c4ZWNH8_cJwXOywa93zQ@mail.gmail.com>
In-Reply-To: <CAMvTesB7shuS8HYifEN37bHPR0mWx9c4ZWNH8_cJwXOywa93zQ@mail.gmail.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 5 Dec 2025 12:10:06 +0800
X-Gm-Features: AQt7F2pa-yeJDkYXGuq5JWkB4WeMevpDzVazCKQwE-RQfx8e-SvGbfrkjSdxp-4
Message-ID: <CAMvTesC4c_CgyYJufi3_iqz4vznP8A34vRm38Uj7b8ux0L4YMw@mail.gmail.com>
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

On Thu, Dec 4, 2025 at 7:35=E2=80=AFPM Tianyu Lan <ltykernel@gmail.com> wro=
te:
>
> On Thu, Dec 4, 2025 at 11:35=E2=80=AFAM Michael Kelley <mhklinux@outlook.=
com> wrote:
> >
> > From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, December 3, 202=
5 6:21 AM
> > >
> > > On Sat, Nov 29, 2025 at 1:47=E2=80=AFAM Michael Kelley <mhklinux@outl=
ook.com> wrote:
> > > >
> > > > From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, November 24, 2=
025 10:29 AM
> >
> > [snip]
> >
> > > >
> > > > Here's my idea for an alternate approach.  The goal is to allow use=
 of the
> > > > swiotlb to be disabled on a per-device basis. A device is initializ=
ed for swiotlb
> > > > usage by swiotlb_dev_init(), which sets dev->dma_io_tlb_mem to poin=
t to the
> > > > default swiotlb memory.  For VMBus devices, the calling sequence is
> > > > vmbus_device_register() -> device_register() -> device_initialize()=
 ->
> > > > swiotlb_dev_init(). But if vmbus_device_register() could override t=
he
> > > > dev->dma_io_tlb_mem value and put it back to NULL, swiotlb operatio=
ns
> > > > would be disabled on the device. Furthermore, is_swiotlb_force_boun=
ce()
> > > > would return "false", and the normal DMA functions would not force =
the
> > > > use of bounce buffers. The entire code change looks like this:
> > > >
> > > > --- a/drivers/hv/vmbus_drv.c
> > > > +++ b/drivers/hv/vmbus_drv.c
> > > > @@ -2133,11 +2133,15 @@ int vmbus_device_register(struct hv_device =
*child_device_obj)
> > > >         child_device_obj->device.dma_mask =3D &child_device_obj->dm=
a_mask;
> > > >         dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> > > >
> > > > +       device_initialize(&child_device_obj->device);
> > > > +       if (child_device_obj->channel->co_external_memory)
> > > > +               child_device_obj->device.dma_io_tlb_mem =3D NULL;
> > > > +
> > > >         /*
> > > >          * Register with the LDM. This will kick off the driver/dev=
ice
> > > >          * binding...which will eventually call vmbus_match() and v=
mbus_probe()
> > > >          */
> > > > -       ret =3D device_register(&child_device_obj->device);
> > > > +       ret =3D device_add(&child_device_obj->device);
> > > >         if (ret) {
> > > >                 pr_err("Unable to register child device\n");
> > > >                 put_device(&child_device_obj->device);
> > > >
> > > > I've only compile tested the above since I don't have an environmen=
t where
> > > > I can test Confidential VMBus. You would need to verify whether my =
thinking
> > > > is correct and this produces the intended result.
> > >
> > > Thanks Michael. I tested it and it seems to hit an issue. Will double=
 check.with
> > > HCL/paravisor team.
> > >
> > >  We considered such a change before. From Roman's previous patch, it =
seems to
> > > need to change phys_to_dma() and force_dma_unencrypted().
> >
> > In a Hyper-V SEV-SNP VM with a paravisor, I assert that phys_to_dma() a=
nd
> > __phys_to_dma() do the same thing.  phys_to_dma() calls dma_addr_encryp=
ted(),
> > which does __sme_set().  But in a Hyper-V VM using vTOM, sme_me_mask is
> > always 0, so dma_addr_encrypted() is a no-op.  dma_addr_unencrypted() a=
nd
> > dma_addr_canonical() are also no-ops. See include/linux/mem_encrypt.h. =
So
> > in a Hyper-V SEV-SNP VM, the DMA layer doesn't change anything related =
to
> > encryption when translating between a physical address and a DMA addres=
s.
> > Same thing is true for a Hyper-V TDX VM with paravisor.
> >
> > force_dma_unencrypted() will indeed return "true", and it is used in
> > phys_to_dma_direct(). But both return paths in phys_to_dma_direct() ret=
urn the
> > same result because of dma_addr_unencrypted() and dma_addr_encrypted()
> > being no-ops. Other uses of force_dma_unencrypted() are only in the
> > dma_alloc_*() paths, but dma_alloc_*() isn't used by VMBus devices beca=
use
> > the device control structures are in the ring buffer, which as you have=
 noted, is
> > already handled separately. So for the moment, I don't think the return=
 value
> > from force_dma_unencrypted() matters.
> >

dma_alloc_*() is used by PCI device driver(e.g, Mana NIC
driver) and If we need to support TDisp device, the change
in the force_dma_unencrypted() is still necessary and dma
address to TDisp device should be encrypted memory with
sme_me_mask.

From this point, Hyper-V specific dma ops may resolve this
without change in the DMA core code. Otherwise, we still
need to add a callback or other flag inside for platforms to
check whether it should return encrypted/decrypted address
to drivers.

> > So I'm guessing something else unexpected is happening such that just d=
isabling
> > the swiotlb on a per-device basis doesn't work. Assuming that Roman's o=
riginal
> > patch actually worked, I'm trying to figure out how my idea is differen=
t in a way
> > that has a material effect on things. And if your patch works by going =
directly to
> > __phys_to_dma(), it should also work when using phys_to_dma() instead.
> >

The issue I met should not be related with bounce buffer disabling.
I don't find any failure to map dma memory with bounce buffer.
For disabling per-device swiotlb, it looks like work to set dma_io_
tlb_mem to be NULL and it makes is_swiotlb_force_bounce()
returns false.

--
Thanks
Tianyu Lan

