Return-Path: <linux-hyperv+bounces-9813-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFTxHYJQxmk2IgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9813-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 10:40:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA14341E26
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68EF43020D57
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 09:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E125634D912;
	Fri, 27 Mar 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS8GwsVK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBBD30DEA3
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Mar 2026 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603940; cv=pass; b=B+Wq01kz4C9ntcH6pVt5xQufXUldjE3YkRMTtSdzM6zdC5yJXky3D3blD2U7VN0QfnbmiKihDvaIPJzJLgsbryZuPu0dxoipwDLZUnRj6vfqyG6E7i46wE2NLAMUSNLIJNUGCg7ghMOjZHWew0e1vDP5IoQazGoQ+BWqx2x49fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603940; c=relaxed/simple;
	bh=06LMva7nNAzRB3uoqIeOQbagXCiMFxIYnmMe8xGCgvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QztH1R2xxLigTfwnu3adm0okGY28djLdEU/JhgpeRqrdujts7jAdoiKpc7AzS9Ur7UCNQUU5YI5bVggJORdg6AO6ak1ky11NZId1sGL512Uxy6hhh3Oz6jixOnaYQ1YIia+gcAmGE/lzJmw3Zxoae/poS2MunSvf1uL4ixg/UCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS8GwsVK; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-126ea4b77adso2636498c88.1
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Mar 2026 02:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774603939; cv=none;
        d=google.com; s=arc-20240605;
        b=YhthoguYhLDsh4BsQwVfb9AL9cwNGkULsb85U3d7ZqRIZ9BUf1rMgCWZORf1Ge8bN3
         XlIlnA7xNP8ud2mRFPqp9cfCKjIt8gmXw0rSvLJ6fvm2m1IqsE0a6a6OmRZDHpA+8cLI
         QKProql+v3yEN2oHpXC0G0jkcEVCkUL0zV6bnl+GiCJGM2GmhISvTL70lXVt4OWbkTeS
         1sgJxiac4kRJ8OkTzB6xoVwtZXwx0IrVLiXHibezyh5w3KTO0bryKsvVGVAO9edDrH4+
         8CpvZSoOOpLFX3h452dqgB421chf4b1E3bTJ9Qoc2vWbZ8hdLPvQova4PdwwNDefsS8J
         B+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTj0lmErHFiNvY1kZ2HPnPSiJy+pFJAQ9CrdVdJE+0w=;
        fh=rXVAL0sbfQrZRcXHs5bpimzcK/6Za+wMqU8IsiBcdmM=;
        b=VhmoCuiwa+DuUx2EgsDIIQeIENtWx2SNXRJhq9rxsSrGyiAZ/8g8dT/kw2Yoq7XiKY
         KFPO1EVdnGPIiT5P//5GGJUv0+z72PV/iYMAFSBIncOH81NBJUPnaq6bKVR9zUYsxb/9
         uhc7WhW/vgvbIuV3cgh2gce+Um+PomoylG2exGLFo4AyOiw6VqbDDfqmzArMW9tK3QUD
         QzQEuquF8U6gvr5COLDaJwrb2roImes//OtGeIiY7ZdGE7R/zKWbI6SnvXD4xVBIDQT2
         NAi+jiBiMSeLaLOS3FGIBNycdvd7ZbH9l3A7JeRsfB2UFPt42zcjsg46aZe+7pTpRl8O
         wuhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774603939; x=1775208739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTj0lmErHFiNvY1kZ2HPnPSiJy+pFJAQ9CrdVdJE+0w=;
        b=XS8GwsVKLV9xwO0pWloMalz0PuW9sWEWcKZERjpmoEwJlSGkVkbEh5m02U0EGmRYYI
         lNI43DPHmK92PyWGAl8ua4qbwuCkB+MK/Zgz9q0oGOeGA9kKQJmgfXGdY9uPPJU4yNmA
         NAExc5F0qTlZRBN08GrUkdsra+PnF+nt5fnsgxTiVQmid8T7zGK7NuZeaEeHNsi6wqDY
         uSMyLdqv/irjCYYIvmRZhOXyh7x5dNvNEQdbnASNOONwNIdYIVQwOb2iCvUtdptdGtRQ
         fK5Dm/GWjuhQjS3vbNrmbJw+NHWqlPKTVOnssbaBTi9T8VbWdANIkvGD3OzHjrkVUFQo
         u73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603939; x=1775208739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTj0lmErHFiNvY1kZ2HPnPSiJy+pFJAQ9CrdVdJE+0w=;
        b=i2YZtxGLqqKqKTtcUbBIMAMGzAG8emrLYqF9Mdp3IR8mluzqI7utsbJPOxPP8Km2aa
         NBAYZUlk6BaO6V+JMWDCSJyWtqD8Oj6P5pDbkagc4TxnZfbjPv3iBs8UjMYvUsNDSXvo
         OqANTzKVfUbqeSFf7oLAj3u43/WC7kVb6r16R/CCzFCAQVxt5vLPZjIRsSqKrwQzriUa
         Us1+9ZPCauMezpaDp5e8qCUMJgoOxcPs1QHLDzkIkMMCoVa4+eDRtX2vWgWx2OTmtkrJ
         Xodv0ILpYw+hRGBmvYjcYRBzZJQmmYln2XrnO+KeLl8hR408GBf5PeOdwBxIMvzJf53b
         qAuw==
X-Forwarded-Encrypted: i=1; AJvYcCUDYXHMZugXixXF7yAN2RbugibHlLcHpxs+KCtkMv5THsa4GfT7C/bTr4bWjlMZX4YwuPpYAeZQQtmjwbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6JmKGCNTjxI1JMSyn3PVotTqZJaOPPYZU6qtkDxbNflTrqQX
	AueShnmwbXRj11Dd27RPPf3a67SpNoYCocjjtDN7av5IAG2niZv7wDs2IwnVEnXiq8QUGaG+BIv
	bqFGTTyKXGe53OI4BlUCKcFgDGOU2Qdo=
X-Gm-Gg: ATEYQzxuNT7WoH2MY4tzsnoDIS/qXHiLsdg4EehRrXFKHkt3ojq4M3CPoM4MSGrWnze
	ZCTAzZX3vB8/YSOLLp6Dui0GI7e5ObDssFYHCG84tQBCW1dtinRGr5kwduKJ/Qbby3pd5pXi25h
	tJUAKQCclpWqUBn2MLCMpHtS8EquuDrSJTny3CVSLk7nAa14A4nmYkt89fgJglKWP92NAgtEoyb
	V0PB2R1FkjJ1Eqb35kdX0qv5/DuRzVnI/lMffTbBLEiIjpwULpfVS5Ys2uPZtK1lw/uCEB8dFU5
	8y9Oung=
X-Received: by 2002:a05:693c:2b13:b0:2c0:ca48:3112 with SMTP id
 5a478bee46e88-2c185d2392dmr925089eec.10.1774603938602; Fri, 27 Mar 2026
 02:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325075649.248241-1-tiala@microsoft.com> <75c6dd78-bbae-4f5a-94ef-9de299720d38@linux.microsoft.com>
In-Reply-To: <75c6dd78-bbae-4f5a-94ef-9de299720d38@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 27 Mar 2026 17:32:00 +0800
X-Gm-Features: AQROBzBhr93zaAmvsFTclkLSepBZXUTqoKBV-eRXJ6Wqy7QysN56WXF-MYhEV2Q
Message-ID: <CAMvTesD2ix==vObgAC=LLxM2Jn4MnuvnjfL72Z=zfs--gq4M+Q@mail.gmail.com>
Subject: Re: [RFC PATCH V3] x86/VMBus: Confidential VMBus for dynamic DMA transfers
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, Tianyu Lan <tiala@microsoft.com>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, 
	vdso@hexbites.dev, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9813-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,samsung.com,arm.com,lists.linux.dev,vger.kernel.org,infradead.org,hexbites.dev,outlook.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltykernel@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,openvmm.dev:url]
X-Rspamd-Queue-Id: CEA14341E26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 1:05=E2=80=AFAM Easwar Hariharan
<easwar.hariharan@linux.microsoft.com> wrote:
>
> On 3/25/2026 12:56 AM, Tianyu Lan wrote:
> > Hyper-V provides Confidential VMBus to communicate between
> > device model and device guest driver via encrypted/private
> > memory in Confidential VM. The device model is in OpenHCL
> > (https://openvmm.dev/guide/user_guide/openhcl.html) that
> > plays the paravisor role.
> >
> > For a VMBus device, there are two communication methods to
> > talk with Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic
> > DMA transfer.
> >
> > The Confidential VMBus Ring buffer has been upstreamed by
> > Roman Kisel(commit 6802d8af47d1).
> >
> > The dynamic DMA transition of VMBus device normally goes
> > through DMA core and it uses SWIOTLB as bounce buffer in
> > a CoCo VM.
> >
> > The Confidential VMBus device can do DMA directly to
> > private/encrypted memory. Because the swiotlb is decrypted
> > memory, the DMA transfer must not be bounced through the
> > swiotlb, so as to preserve confidentiality. This is different
> > from the default for Linux CoCo VMs, so disable the VMBus
> > device's use of swiotlb.
> >
> > Expose swiotlb_dev_disable() from DMA Core to disable
> > bounce buffer for device.
> >
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c  | 6 +++++-
> >  include/linux/swiotlb.h | 5 +++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 3d1a58b667db..84e6971fc90f 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2184,11 +2184,15 @@ int vmbus_device_register(struct hv_device *chi=
ld_device_obj)
> >       child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask=
;
> >       dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> >
> > +     device_initialize(&child_device_obj->device);
> > +     if (child_device_obj->channel->co_external_memory)
> > +             swiotlb_dev_disable(&child_device_obj->device);
> > +
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
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 3dae0f592063..7c572570d5d9 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -169,6 +169,11 @@ static inline struct io_tlb_pool *swiotlb_find_poo=
l(struct device *dev,
> >       return NULL;
> >  }
> >
> > +static inline bool swiotlb_dev_disable(struct device *dev)
> > +{
> > +     return dev->dma_io_tlb_mem =3D=3D NULL;
>
> Is there an extra =3D here?
>
> - Easwar (he/him)

Hi Easwar:
     Thanks for your review. Nice catch. Oops. Will try other way to disabl=
e
device bounce buffer in the next version.
--=20
Thanks
Tianyu Lan

