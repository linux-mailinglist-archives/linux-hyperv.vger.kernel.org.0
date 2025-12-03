Return-Path: <linux-hyperv+bounces-7920-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C0C9F45C
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 15:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9A4A4E0F4F
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08B230BDF;
	Wed,  3 Dec 2025 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwYCDTSo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54148229B36
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Dec 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764771698; cv=none; b=QnpsU3ICGGHFVYzTJQdcK7QfQxVEOtRmSy51OXUB0Of/Hc1uQ7p0Nl73FLrjt/r1UrZnI4rCHxBYUAPiVU2UUITCdhCh9bD2AAP18+riEEVsQ5AoxssEDvXWS2pSxXAub5p+TXrpKgjcvDJ9beSD0vXgReBJ48vAjchbV/rGYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764771698; c=relaxed/simple;
	bh=COACpifoxqXCKchepKzj6D6gGfnnSXFED2668g4g5ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldoqNoD3niN7qUhiNEd5ja6t+nXHnlyU0M0hNGVWPWMTpbtLsNnoafp38/qMM54CUsXVWXmTu6HHzj9uy4u0c9gYRNvflS4gbMwyM+Y14+qJcQgpWG6+SskYaUbV9khNa/7ZLLumCwtE6UjTb+zQyMEWZZfgjuL2T30QpWHbhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwYCDTSo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so4601757a12.2
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Dec 2025 06:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764771695; x=1765376495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAkediGLong8ghPcm/7kG2fOV0lsGi85DikKU3mizSw=;
        b=LwYCDTSo3j6fEFA49smeq2WzjJqmbtctYhQlEhYFzReq7izOjNVe3KrshWY+39WaDt
         p1XWGJusyYP9uRob74bcShbVscJOYcgIzqOHJgkhc9nW2c1ItMxFotAUl5oB19i84Yr+
         7XIqZR6T78bBUCCAGURa8MNx19I5LGjw5iUmCg81HQIE01IN4hME4oh9iOR8sM2hkTtH
         biw3TMe5J6M5giWi71XK2cY2qQScGPgeoY4HohJl/O41wyepkTfRafUi/y9bKUj67Gil
         iUwc8SGh0kw6NXdi8UktapMh//zo/seGgZnYXJleH6xAL+ej3T5/FqO7w6tj0gIx7pxu
         G4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764771695; x=1765376495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bAkediGLong8ghPcm/7kG2fOV0lsGi85DikKU3mizSw=;
        b=Sy2ocKettDY0EOjGzYR1edh2vMjWc3hTNYldCFoaBtIJlr8LktvHl3uUJidV1528Jq
         bxq4k3VCbClyevZumGXaoX2crghncHk1o6Lrxi+xcMchTEKIEbqsFBAllqzDb9Pt2Bvn
         KiZqDD9JOdDLHq4vXItH9feO6p8RBCCfIsW+b/42FYcQczwsFIkvw182MqtId21yMbS/
         7WQvIYm/ny7ep5hZtp/StdqOgu0Jp5HG9DFffaaWRwgrXtTBLAtulkEefPc8ijSI7Qht
         uby3PRuPvORfHjbSyDI4nzHGmNMU0fAzoech/tSbGUj6je4W3PIwFqhyYc2xfIkwFFg4
         NGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN16og+ReUeWngoQ40OPiHiWghyG1yDkydXnqQgl4zJw15XdkEWic0l0WoDQ2MMXsBnkWUAfgsWU2Dt8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5hLRPjrc807ATm2jFMEYFmix+l99CaJpM7TdO2xDA8tIHq76+
	1cQGUs33mhabUfPNw5PPuURlqiJCaN5lVNTLo2etP76+ABq8VnNT1d/7eykthyr0cKxslktPAls
	gIhDZXlYOx+sw8z3FaNAUpz5MBh1pVm4=
X-Gm-Gg: ASbGnctyI+UhPYKXXaWB+60rvaaUWNxXvFjHYUHhaymX1QTXcnEGz0vx7ED66aXlKGT
	wloYe4BgFJQgU2THv+Lz1srbQ5yumgENUD6fSDQbXZ2X7005Yz2yYUYNqqJ2PPM/52Con9OLYB+
	tsH91P7aGiXW0d0Jya0M81HfdyB20qzLwwfUjgoDeEro3FyTUx0FX+nCGISjR6JQ81TbdH5WNJa
	n5o6RLgVNxkddovq2KNSXrT5zNlLaZDCvfaT/nUTC830JJ6sUr7qRPIRRe+z4iUKFs7Hki+5yR5
	cXDoG219Flx/czEujNJF8YA=
X-Google-Smtp-Source: AGHT+IEt6sqPZkoz00HVey6VqcV+g3VyIWyIt2cWFVbZKV3UmC/GtQB9KbRU19gubqaXV3FRNmeYlae68+K3/1vtE+g=
X-Received: by 2002:a05:7300:ae22:b0:2a4:6b6d:90ae with SMTP id
 5a478bee46e88-2ab92d50c74mr1194527eec.9.1764771695226; Wed, 03 Dec 2025
 06:21:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124182920.9365-1-tiala@microsoft.com> <SN6PR02MB4157DAE6D8CC6BA11CA87298D4DCA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157DAE6D8CC6BA11CA87298D4DCA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Wed, 3 Dec 2025 22:21:18 +0800
X-Gm-Features: AWmQ_blbUL6BsntzpBcR1tKCeRa3_zHbUJEKJIIjvam53bjm9KUPbPZXIM4jFAo
Message-ID: <CAMvTesCbNYHjiwaZC4EJopErZhW+vM0d87zJ54RT_AKXb-2yjw@mail.gmail.com>
Subject: Re: [RFC PATCH] Drivers: hv: Confidential VMBus exernal memory support
To: Michael Kelley <mhklinux@outlook.com>, Christoph Hellwig <hch@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>, 
	Tianyu Lan <tiala@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 1:47=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, November 24, 2025 10=
:29 AM
> >
> > In CVM(Confidential VM), system memory is encrypted
> > by default. Device drivers typically use the swiotlb
> > bounce buffer for DMA memory, which is decrypted
> > and shared between the guest and host. Confidential
> > Vmbus, however, supports a confidential channel
>

Hi Michael:
      Thanks for your review. I spent some time to do test
and still need paravisor(HCL) team to double check.

> s/Vmbus/VMBus/   [and elsewhere in this commit msg]
>

Will update.

> > that employs encrypted memory for the Vmbus ring
> > buffer and external DMA memory. The support for
> > the confidential ring buffer has already been
> > integrated.
> >
> > In CVM, device drivers usually employ the standard
> > DMA API to map DMA memory with the bounce buffer,
> > which remains transparent to the device driver.
> > For external DMA memory support,
>
> The "external memory" terminology is not at all clear in the context
> of Linux. Presumably the terminology came from Hyper-V or the
> paravisor, but I never understood what the "external" refers to. Maybe
> it is memory that is "external" with respect to the hypervisor, and there=
fore
> not shared between the hypervisor and guest? But that meaning won't be
> evident to other reviewers in the Linux kernel community. In any case, so=
me
> explanation of "external memory" is needed. And even consider changing th=
e
> field names in the code to be something that makes more sense to Linux.
>

Agree. For VMbus devices, there are two major kinds of communication
methods with
the host.

* VMbus ring buffer.
* Dynamic DMA transition

The confidential ring buffer has been upstreamed and merged into the
Linux kernel 6.18
by Roman. Additionally, the confidential DMA transition, also known as
external memory
allows the use of private/encrypted memory as DMA memory.

 > > Hyper-V specific
> > DMA operations are introduced, bypassing the bounce
> > buffer when the confidential external memory flag
> > is set.
>
> This commit message never explains why it is important to not do bounce
> buffering. There's the obvious but unstated reason of improving performan=
ce,
> but that's not the main reason. The main reason is a confidentiality leak=
.
> When available, Confidential VMBus would be used because it keeps the
> DMA data private (i.e., encrypted) and confidential to the guest. Bounce
> buffering copies the data to shared (i.e., decrypted) swiotlb memory, whe=
re
> it is exposed to the hypervisor. That's a confidentiality leak, and is th=
e
> primary reason the bounce buffering must be eliminated. This requirement
> was pointed out by Robin Murphy in the discussion of Roman Kisel's
> original code to eliminate the bounce buffering.
>

For CVM on Hyper-V,, there are typically two layers: VTL0 and VTL2. VTL2
plays a similar role as L1 hypervisor of normal guest in VTL0. Communicatio=
n
between these two layers can utilize private or encrypted memory directly, =
as
they both reside within the same CVM. This differs from the
communication between
the host and VTL0/VTL2, where shared or decrypted memory (bounce
buffer) is required.

For Confidential VMbus devices in CVM, the device module (emulated
device code) in
VTL2 and interacts with the normal guest in VTL0. As a result, the
Confidential VMbus
device's ring buffer and DMA transactions may use private or encrypted memo=
ry.

> Separately, I have major qualms about using an approach with Hyper-V spec=
ific
> DMA operations. As implemented here, these DMA operations bypass all
> the kernel DMA layer logic when the VMBus synthetic device indicates
> "external memory". In that case, the supplied physical address is just us=
ed
> as the DMA address and everything else is bypassed. While this actually w=
orks
> for VMBus synthetic devices because of their simple requirements, it also
> is implicitly making some assumptions. These assumptions are true today
> (as far as I know) but won't necessarily be true in the future.  The assu=
mptions
> include:
>
> * There's no vIOMMU in the guest VM. IOMMUs in CoCo VMs have their
> own issues to work out, but an implementation that bypasses any IOMMU
> logic in the DMA layer is very short-term thinking.
>
> * There are no PCI pass-thru devices in the guest.  Since the implementat=
ion
> changes the global dma_ops, the drivers for such PCI pass-thru devices wo=
uld
> use the same global dma_ops, and would fail.

For PCI pass-thru devices, it may be reused with additional changes(Co-work=
 with
Dexuan for this support)  and we may rework the current callbacks to
meet the future
requirement.

>
> The code also has some other problems that I point out further down.
>
> In any case, an approach with Hyper-V specific DMA operations seems like
> a very temporary fix (hack?) at best. Further down, I'll proposed at alte=
rnate
> approach that preserves all the existing DMA layer functionality.
>
> > These DMA operations might also be reused
> > for TDISP devices in the future, which also support
> > DMA operations with encrypted memory.
> >
> > The DMA operations used are global architecture
> > DMA operations (for details, see get_arch_dma_ops()
> > and get_dma_ops()), and there is no need to set up
> > for each device individually.
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 90 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 89 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 0dc4692b411a..ca31231b2c32 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -39,6 +39,9 @@
> >  #include <clocksource/hyperv_timer.h>
> >  #include <asm/mshyperv.h>
> >  #include "hyperv_vmbus.h"
> > +#include "../../kernel/dma/direct.h"
> > +
> > +extern const struct dma_map_ops *dma_ops;
> >
> >  struct vmbus_dynid {
> >       struct list_head node;
> > @@ -1429,6 +1432,88 @@ static int vmbus_alloc_synic_and_connect(void)
> >       return -ENOMEM;
> >  }
> >
> > +
> > +static bool hyperv_private_memory_dma(struct device *dev)
> > +{
> > +     struct hv_device *hv_dev =3D device_to_hv_device(dev);
>
> device_to_hv_device() works only when "dev" is for a VMBus device. As not=
ed above,
> if a CoCo VM were ever to have a PCI pass-thru device doing DMA, "dev" wo=
uld
> be some PCI device, and device_to_hv_device() would return garbage.

Yes, Nice catch. PCI device support is not included in this patch and
still on the way
and post this with ConfidentialVMbus device for review first.

>
> > +
> > +     if (hv_dev && hv_dev->channel && hv_dev->channel->co_external_mem=
ory)
> > +             return true;
> > +     else
> > +             return false;
> > +}
> > +
> > +static dma_addr_t hyperv_dma_map_page(struct device *dev, struct page =
*page,
> > +             unsigned long offset, size_t size,
> > +             enum dma_data_direction dir,
> > +             unsigned long attrs)
> > +{
> > +     phys_addr_t phys =3D page_to_phys(page) + offset;
> > +
> > +     if (hyperv_private_memory_dma(dev))
> > +             return __phys_to_dma(dev, phys);
> > +     else
> > +             return dma_direct_map_phys(dev, phys, size, dir, attrs);
>
> This code won't build when the VMBus driver is built as a module.
> dma_direct_map_phys() is in inline function that references several other
> DMA functions that aren't exported because they aren't intended to be
> used by drivers. Same problems occur with dma_direct_unmap_phys()
> and similar functions used below.

Yes, Nice catch! We may add a function to register dma ops in the built-in =
file
and call it in the VMbus driver.

>
> > +}
> > +
> > +static void hyperv_dma_unmap_page(struct device *dev, dma_addr_t dma_h=
andle,
> > +             size_t size, enum dma_data_direction dir, unsigned long a=
ttrs)
> > +{
> > +     if (!hyperv_private_memory_dma(dev))
> > +             dma_direct_unmap_phys(dev, dma_handle, size, dir, attrs);
> > +}
> > +
> > +static int hyperv_dma_map_sg(struct device *dev, struct scatterlist *s=
gl,
> > +             int nelems, enum dma_data_direction dir,
> > +             unsigned long attrs)
> > +{
> > +     struct scatterlist *sg;
> > +     dma_addr_t dma_addr;
> > +     int i;
> > +
> > +     if (hyperv_private_memory_dma(dev)) {
> > +             for_each_sg(sgl, sg, nelems, i) {
> > +                     dma_addr =3D __phys_to_dma(dev, sg_phys(sg));
> > +                     sg_dma_address(sg) =3D dma_addr;
> > +                     sg_dma_len(sg) =3D sg->length;
> > +             }
> > +
> > +             return nelems;
> > +     } else {
> > +             return dma_direct_map_sg(dev, sgl, nelems, dir, attrs);
> > +     }
> > +}
> > +
> > +static void hyperv_dma_unmap_sg(struct device *dev, struct scatterlist=
 *sgl,
> > +             int nelems, enum dma_data_direction dir, unsigned long at=
trs)
> > +{
> > +     if (!hyperv_private_memory_dma(dev))
> > +             dma_direct_unmap_sg(dev, sgl, nelems, dir, attrs);
> > +}
> > +
> > +static int hyperv_dma_supported(struct device *dev, u64 mask)
> > +{
> > +     dev->coherent_dma_mask =3D mask;
> > +     return 1;
> > +}
> > +
> > +static size_t hyperv_dma_max_mapping_size(struct device *dev)
> > +{
> > +     if (hyperv_private_memory_dma(dev))
> > +             return SIZE_MAX;
> > +     else
> > +             return swiotlb_max_mapping_size(dev);
> > +}
> > +
> > +const struct dma_map_ops hyperv_dma_ops =3D {
> > +     .map_page               =3D hyperv_dma_map_page,
> > +     .unmap_page             =3D hyperv_dma_unmap_page,
> > +     .map_sg                 =3D hyperv_dma_map_sg,
> > +     .unmap_sg               =3D hyperv_dma_unmap_sg,
> > +     .dma_supported          =3D hyperv_dma_supported,
> > +     .max_mapping_size       =3D hyperv_dma_max_mapping_size,
> > +};
> > +
> >  /*
> >   * vmbus_bus_init -Main vmbus driver initialization routine.
> >   *
> > @@ -1479,8 +1564,11 @@ static int vmbus_bus_init(void)
> >        * doing that on each VP while initializing SynIC's wastes time.
> >        */
> >       is_confidential =3D ms_hyperv.confidential_vmbus_available;
> > -     if (is_confidential)
> > +     if (is_confidential) {
> > +             dma_ops =3D &hyperv_dma_ops;
>
> arm64 doesn't have the global variable dma_ops, so this patch
> won't build on arm64, even if Confidential VMBus isn't yet available
> for arm64.

Yes, there should be a stub function for both ARM and x86 to implement it..

>
> >               pr_info("Establishing connection to the confidential VMBu=
s\n");
> > +     }
> > +
> >       hv_para_set_sint_proxy(!is_confidential);
> >       ret =3D vmbus_alloc_synic_and_connect();
> >       if (ret)
> > --
> > 2.50.1
> >
>
> Here's my idea for an alternate approach.  The goal is to allow use of th=
e
> swiotlb to be disabled on a per-device basis. A device is initialized for=
 swiotlb
> usage by swiotlb_dev_init(), which sets dev->dma_io_tlb_mem to point to t=
he
> default swiotlb memory.  For VMBus devices, the calling sequence is
> vmbus_device_register() -> device_register() -> device_initialize() ->
> swiotlb_dev_init(). But if vmbus_device_register() could override the
> dev->dma_io_tlb_mem value and put it back to NULL, swiotlb operations
> would be disabled on the device. Furthermore, is_swiotlb_force_bounce()
> would return "false", and the normal DMA functions would not force the
> use of bounce buffers. The entire code change looks like this:
>
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2133,11 +2133,15 @@ int vmbus_device_register(struct hv_device *child=
_device_obj)
>         child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask=
;
>         dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
>
> +       device_initialize(&child_device_obj->device);
> +       if (child_device_obj->channel->co_external_memory)
> +               child_device_obj->device.dma_io_tlb_mem =3D NULL;
> +
>         /*
>          * Register with the LDM. This will kick off the driver/device
>          * binding...which will eventually call vmbus_match() and vmbus_p=
robe()
>          */
> -       ret =3D device_register(&child_device_obj->device);
> +       ret =3D device_add(&child_device_obj->device);
>         if (ret) {
>                 pr_err("Unable to register child device\n");
>                 put_device(&child_device_obj->device);
>
> I've only compile tested the above since I don't have an environment wher=
e
> I can test Confidential VMBus. You would need to verify whether my thinki=
ng
> is correct and this produces the intended result.

Thanks Michael. I tested it and it seems to hit an issue. Will double check=
.with
HCL/paravisor team.

 We considered such a change before. From Roman's previous patch, it seems =
to
need to change phys_to_dma() and force_dma_unencrypted()..

>
> Directly setting dma_io_tlb_mem to NULL isn't great. It would be better
> to add an exported function swiotlb_dev_disable() to swiotlb code that se=
ts
> dma_io_tlb_mem to NULL, but you get the idea.
>
> Other reviewers may still see this approach as a bit of a hack, but it's =
a lot
> less of a hack than introducing Hyper-V specific DMA functions.
> swiotlb_dev_disable() is conceptually needed for TDISP devices, as TDISP
> devices must similarly protect confidentiality by not allowing use of the=
 swiotlb.
> So adding swiotlb_dev_disable() is a step in the right direction, even if=
 the
> eventual TDISP code does it slightly differently. Doing the disable on a
> per-device basis is also the right thing in the long run.
>

Agree. Include Christoph and Robin here.

Now, we have three options to disable swiotlb bounce buffer to per-device.
1) Add platform DMA ops and check platform condition(e.g, Confidential
VMbus or TDISP
   device) in platform callback before calling stand DMA API which may
use a bounce buffer.

2)  Directly setting dma_io_tlb_mem to NULL in the device/bus level
driver. It seems not
    enough for Confidential VM which may use high bit of address to
identify encrypted
    or decrypted.(Detail please see Roman's previous patch)
https://lore.kernel.org/linux-hyperv/20250409000835.285105-6-romank@linux.m=
icrosoft.com/
https://lore.kernel.org/linux-hyperv/20250409000835.285105-7-romank@linux.m=
icrosoft.com/

3) Add a new stand swiotlb function to disable the use of bounce
buffer for the device.

--
Thanks
Tianyu Lan

