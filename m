Return-Path: <linux-hyperv+bounces-7883-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0841C8D7D3
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 10:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5307034D394
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 09:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7676328B6F;
	Thu, 27 Nov 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V07LPdGg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E4328262
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Nov 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235018; cv=none; b=OIMIZ025/SRvWE9FoF5WqPWebgDusOVpW95Lf38MhTUZns7csoGkSl6HcJTis6blbhnn++xLiipqdtzrNEp9V3IzDixxB0fLkfpWsiu+5XhbFcQ/1n0URW2WGfUPvQwM7qN5hQkEQs5lnlLeTnrV7sV77w0eFz9BCw058scKZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235018; c=relaxed/simple;
	bh=7Iljga/nTB2LEJluHvzg780Gna1AQQQd1e74BzwyV78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhbIgQa/Pupo6RbeeTuWgFLUPluRwCFNgyR62eNFtCI47RY5o1LAmHLoN+IyXWlLilCGoxY8KXHZbO5apDMsOgqEap/cW5zb9C0PnQtcYE6kfFAhtdlzpW0kZ7EuhK7TCrmji0U9aKbMa5r5uM3eOs0qQnAZw3TwPVRITu7L3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V07LPdGg; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc8ceb76c04so482054a12.1
        for <linux-hyperv@vger.kernel.org>; Thu, 27 Nov 2025 01:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764235015; x=1764839815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/mJuz/NN1Gpd26ttisl1RT43iY9GrzFB6RBeitjkXc=;
        b=V07LPdGg9ePTngVl70ibAAE4vw2kwsW3TLlYtzJuvi+5sKfyVecJpSMLs+ewCuO4sa
         Isqc6SmtQSRbrCr8zumoADaYUT2LN0nrwqziyevWbpLw24dLRhIDZn8VP6DtIyK9i9hM
         sXdlZ4My47w2bLPQ4ZjeBHfvBsnLbywLNNl1DFI22tdWepHuIRrk2mAeogLsq+9roRxF
         mEt4Secu4kMT/nMg5EGYr3Ik+//uMedFCCZ9ACPBmMFIkK4BsYgjykuv3mCbIH28v8D6
         +mP1DjVeUm/n4EnssyrTglJQtDyrVysjXVglZlWkSi/FUjExXjCwkiNxLXeYt236iMbs
         wNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235015; x=1764839815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/mJuz/NN1Gpd26ttisl1RT43iY9GrzFB6RBeitjkXc=;
        b=HnZt8zXZQ043CQigJwcmcO4fiWCwwY0bkJOAvIbX4anuwWZigT75vmQwTdZuoxSy4I
         FyYAn7jAUAMpqlFQ+Vt569EzW6qgn6eIlkahdUgdAOIMVNwDEQqGELvECMvZla4vUwsB
         4T45g9e6Z/twwwCWJoSCdQFB4yDLKPvzo28KICE+UlT2slP2GA3oadhq9tgAVUJXaLAk
         HNCyBPKu1A8E0yKBD00y8m7lnlfngWtBHtAqdnAlcbnuZ8BVW1rbaXxW96XSRgFhSIkV
         XPKkYBf+QNXE+K6l5r7qlBdCGro5peUrgBhCMn4f4OJkOHPZzcog3BvdseafmJEAsJXP
         43aw==
X-Forwarded-Encrypted: i=1; AJvYcCUTg6N9yoxfnaU+pagpkVabMrWhG5z4WlUGAvABZR4UiPhltyq6h4iFp8kJlczSywn/rlffq6WQJMxcI0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3R8XDuYB0AM+N1wLrbRs3rQDDZ6FqjspPpJO01DUTAjDtMDHp
	eOJg5gSbsdSUg7ms/wx50jb4+Xs5JnH5S8xeGjQSw7Mhfdxid7AT1MR1AiIyDf3GjxWQkeeOn/T
	aKdgRe2yskUCxbj4Nr+EzFBphxok1/rE=
X-Gm-Gg: ASbGnctkEFgLYdTfZs8bV2SVSKYD5duaA2BmiBNtZoNoy59gJBMHy2MT8QyKOtlB3IG
	KY0ldjH2Go5ss2KppI9NN7R89KBWxPdVvw9IbmIfUcVISQzb/538hUKJzfNgk32MbnHrROh3umr
	GQWRm581D8E0UQDlCjmQNhnWZbFRYlUSoHwJkKfY6rtG6Uq6CeID91EQ7e1JYeXV7TDrnYiEmIX
	2+1MMORbpFJB+lwP9oBzTNX13k1eqbdjX+NSibo79W/u3JYJX++2KIR1fT/6Yj/eQRokyltoFBf
	FKoaSHadhEKC
X-Google-Smtp-Source: AGHT+IFuUrQSoc9xHbyjE2qE5+Teb7GBdmDMPCByB7/vfcSyI30HduowMQSe9gwfjsVnamnBuhe5sGS/TcZBA6QRn18=
X-Received: by 2002:a05:7300:7a19:b0:2a4:3593:c7d8 with SMTP id
 5a478bee46e88-2a7195cbaa7mr11507555eec.24.1764235015132; Thu, 27 Nov 2025
 01:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124182920.9365-1-tiala@microsoft.com> <20251127051559.60238-1-vdso@hexbites.dev>
In-Reply-To: <20251127051559.60238-1-vdso@hexbites.dev>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 27 Nov 2025 17:16:38 +0800
X-Gm-Features: AWmQ_bneJGEko68Gy1ZeQ2Zido-zy-rtrEGqtyVscd2H_i-Km_PZlXQu0sYHdC8
Message-ID: <CAMvTesCyXOgHiz_UrGApWYUZdS31dEdcZznRRtjo8Czx6iz_WA@mail.gmail.com>
Subject: Re: [RFC PATCH] Drivers: hv: Confidential VMBus exernal memory support
To: vdso@hexbites.dev
Cc: decui@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	longli@microsoft.com, tiala@microsoft.com, wei.liu@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 1:16=E2=80=AFPM <vdso@hexbites.dev> wrote:
>
> From: Roman Kisel <vdso@hexbites.dev>
>
> Tianyu Lan wrote:
>
> > In CVM(Confidential VM), system memory is encrypted
> > by default. Device drivers typically use the swiotlb
> > bounce buffer for DMA memory, which is decrypted
> > and shared between the guest and host. Confidential
> > Vmbus, however, supports a confidential channel
> > that employs encrypted memory for the Vmbus ring
> > buffer and external DMA memory. The support for
> > the confidential ring buffer has already been
> > integrated.
> >
> > In CVM, device drivers usually employ the standard
> > DMA API to map DMA memory with the bounce buffer,
> > which remains transparent to the device driver.
> > For external DMA memory support, Hyper-V specific
> > DMA operations are introduced, bypassing the bounce
> > buffer when the confidential external memory flag
> > is set. These DMA operations might also be reused
> > for TDISP devices in the future, which also support
> > DMA operations with encrypted memory.
> >
> > The DMA operations used are global architecture
> > DMA operations (for details, see get_arch_dma_ops()
> > and get_dma_ops()), and there is no need to set up
> > for each device individually.
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>
> Tinayu,
>
> Looks great to me!
>
> Reviewed-by: Roman Kisel <vdso@hexbites.dev>
>
> P.S. For the inclined reader, here is how the old, only for
> storage and not satisfactory in other ways my attempt to solve this:
>
> https://lore.kernel.org/linux-hyperv/20250409000835.285105-6-romank@linux=
.microsoft.com/
> https://lore.kernel.org/linux-hyperv/20250409000835.285105-7-romank@linux=
.microsoft.com/
>
> Maybe it'd be a good idea to CC folks who provided feedback back then.
>
Hi Roman:
       Thanks for your review. I will follow your suggestion.

Thanks

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
> >               pr_info("Establishing connection to the confidential VMBu=
s\n");
> > +     }
> > +
> >       hv_para_set_sint_proxy(!is_confidential);
> >       ret =3D vmbus_alloc_synic_and_connect();
> >       if (ret)
> > --
> > 2.50.1



--=20
Thanks
Tianyu Lan

