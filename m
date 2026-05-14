Return-Path: <linux-hyperv+bounces-10882-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BpxIwYzBWonTQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10882-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 04:27:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA5053D050
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 04:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD42C303A8CB
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 02:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96B31E83E;
	Thu, 14 May 2026 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfBPbO3G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE1308F0A
	for <linux-hyperv@vger.kernel.org>; Thu, 14 May 2026 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725589; cv=pass; b=R76TewAwHrFdqugjniKlf5xGVaPqG7RgbmUYiC6dL9byRmJzXreZh/+MlsKyYWah+SurAv+Z1/wdBkkl8QuY2eGh0kYXiTn4YuzvXcVFqW1RLeQc/MdCWsGX/jI9eGQivCmVrZqpXgcqm6okokjxD28fXDzTbTAoFhXauhjCBFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725589; c=relaxed/simple;
	bh=P4yfmJJT8N6Nt05n/Tl4I4+mKmWwbD9BE0u/XKoXZZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1cSSOlNAUwblcC+PmqGZmZCjHFvTN0N87Z4asRiCOeBWyLC9IPtYXuJaHjjgrLXIKA8YbxOwQnyl08zPQfcOHBNG0kwTuXSzYcrSluJMWCHGoXRm0hnf1gO08VHiS9bTEjnEGh9SibENwYe+ZOq4ccf8q8vBO0v1eeRC+dKmEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfBPbO3G; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30246cfd41aso2146245eec.1
        for <linux-hyperv@vger.kernel.org>; Wed, 13 May 2026 19:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778725586; cv=none;
        d=google.com; s=arc-20240605;
        b=HmuXyF7h3ZomJGNlqVt3Kwsk+RDLbTid8Mj+dSy9Tp4jkJT/cintxITQPaUdDzUovn
         eTKi1DUDtVG7Ep+nd93Q82wu8mDGcXxPdJDB9d68YMWi1e//dh92kyd6tXspkdAR0t8x
         k/7GccTl10MAWS4pqoDtYXtBIvT5cOlv5IoArH1IpTNmEj33ezQLhRlysx7SiD41n+0f
         0k/44K6qkUKw0uGYEuF9/r9X5FSPgon6uc7sirfymnph6ZNGvrfY0emR+8NKjc3RYZLa
         KCbWBLTP7C2YMozCEXS0YJyM3Hos1xQ4K3mkjOVPcMwezn5lTIGod2JhBJr969swqppd
         J5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gV5PMxG5gsDWEMyQs3N9vUcvd4wOJ+6kAS8IQe7BwV0=;
        fh=oM0awo7/FvovwbtkZ5sHZlhpOwlL5zjPoGGp1Ptu/cA=;
        b=HvXQfB0bnQjyB8iSToymFTJFR1J81jPyRW4Shmkt4GuNegRFn0sApqQEK2CxCtzKnA
         jXA5IW34BKge6/zGxjpc19Sn6C1n8n1wy9nsHhH8bUf+AR7T4ajHLvD78uJQWyTqniVR
         9RMxVy6MT+X8JObYtUdBpVwUumtQFwHpmWPbr9hnBm11uEEvHEIJsoKBw7IHZj56gtZS
         CCgrtLRGbpzOwKo/t75hdo7qKIZxy2UXhMYFMifATVWxoGUuQ9sPwrPsqrEElI28qh+c
         9CUx1bE06ayQWE9s2X1Nuw8mCvrcLRYrvWGUFqYL7e6tiQXmAw6hTHlRUYyP/H9MzI/5
         akVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778725586; x=1779330386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gV5PMxG5gsDWEMyQs3N9vUcvd4wOJ+6kAS8IQe7BwV0=;
        b=IfBPbO3GZI0jz/bqGHlgWFW7lov5qJEZs4x2uFJqR2mGgaRHKwb30CgWowkZBSbBEd
         1TUk4H4XDZdnze+C6BWYfH3uZkfgVzRP9APulzUxpc3yZBGWX48WBUQ57a6bl8Gv8Y+O
         zlQKWDgY3dIet1exeVSZOk1Qvy7WrWrOtw0Lejr8lR7y906rCKq9HW27sq//MfaAFVzH
         KHn+AJuQkg+vZTXvXwxSbzdhfxZ2bk9T3ye4mzy/gLkT/usC1a+Cuq5719ZuR4bn8XRw
         FH6pbM1XVQSi4hHmFtAtZw4qoXUHZ2mIADI5GDaefRd7YTCYyu+3w5rpaLOAYc6A3RMi
         ww5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778725586; x=1779330386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gV5PMxG5gsDWEMyQs3N9vUcvd4wOJ+6kAS8IQe7BwV0=;
        b=egTqWnXCEsa2/Jgnq8hlUoxFupLUKZ3w6o7Vt8FR3lGFo6XOsJ1urkgPNgZaXNHCS4
         QwSykCeqYh93wUcC3CF/2UDEmbAh44Ztr/cR2j3Q9jdHjymLdav0oIkqrZ0BvECFrBcL
         Lo594JxrslcVDjg8I7+jfkCy8PJg31OjSsOUMJHGjWiMao/5JerBa1dyHecX+wtjxRxP
         j3phIPfkDxAfXES+pcQ6veT4VdonoSYPzZdkNh6yREx1V4bfXZWMb6lTNsRIN3fe0wZt
         p5y1s3cO9k/7TIcFXM3NFKjEkXC5aiKrbgYo3hiSm2tfDUR3wj59e09n/eS3MYfV7y5K
         CaNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9OEDp8SAyLofDhVx2SbrLDIfv5k+utLG+ibAaHiNzk0ADkFmET2Ah9MsrD4bT7St4Lx0Mni3XsXJfe8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Sz8vHvje7mTzGPUi8YSW8oM8aRvSRQr5ZZi1mvMD4bmcO2Mo
	/fKirfqSu5O2BgskoK1i+kshItg/LzxPtmZq6rvsOeW8Gjd00P5dOTFqci0smwQeTSCJc1MVRxH
	GWmO8EpiiQOkJKgG+YY5P8ZSju82p4Vg=
X-Gm-Gg: Acq92OEEyW/CvxNhc4B1Y4PB4bo8pbxbQB/ZGqpSFOdAuGv72328WzW0JN9EzEQSsvf
	FHOqsZ3Vtl6ZIO+W03rUdomphgsd4qZN1NTlOKkWTJzhpGozUynLiiSJPWEpPyo4vZVd2gI0Plb
	+0DCPI0EFtAISiqTI9fgHmucUGUUpa5rMWxBD2QRwQxECWtb1YAfB2SOz0YD9G1c4FsY/ktfXhO
	ZUsW6bLmqQ0VZo7noLGR3eno6TcCahnvrUHRjl+aOvGu/xSyYJ1ME1SPft5MK6xtLQbO+R9YExv
	iGBA/MM=
X-Received: by 2002:a05:7301:678d:b0:2ed:e12:3771 with SMTP id
 5a478bee46e88-3015631e31emr3268419eec.33.1778725585647; Wed, 13 May 2026
 19:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408073105.272255-1-tiala@microsoft.com> <SA1PR21MB6683C18151A933242F826BCDCE062@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB6683C18151A933242F826BCDCE062@SA1PR21MB6683.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 14 May 2026 10:26:09 +0800
X-Gm-Features: AVHnY4IQ9hMDl8gCjETyR0UTT1mOf5ZqHvIB_v00hQBTolu0WBptaTv6w-Q71Nk
Message-ID: <CAMvTesAjq4qeociH-ct=YHkf+vNnAMwakFUTZdQE2ru4AweCjg@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] x86/VMBus: Confidential VMBus for dynamic DMA transfers
To: Long Li <longli@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, 
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@hansenpartnership.com>, 
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, Allen Pais <apais@microsoft.com>, 
	Tianyu Lan <Tianyu.Lan@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "vdso@hexbites.dev" <vdso@hexbites.dev>, 
	"mhklinux@outlook.com" <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2EA5053D050
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10882-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,hansenpartnership.com,oracle.com,vger.kernel.org,hexbites.dev,outlook.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltykernel@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:url,openvm:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 2:30=E2=80=AFAM Long Li <longli@microsoft.com> wrot=
e:
>
> > Hyper-V provides Confidential VMBus to communicate between device model
> > and device guest driver via encrypted/private memory in Confidential VM=
. The
> > device model is in OpenHCL
> > (https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fop=
envm
> > m.dev%2Fguide%2Fuser_guide%2Fopenhcl.html&data=3D05%7C02%7Clongli%40mi
> > crosoft.com%7C0ccfea7cda8e4500ae9808de9540d01e%7C72f988bf86f141af91a
> > b2d7cd011db47%7C1%7C0%7C639112302777934798%7CUnknown%7CTWFpbG
> > Zsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIk
> > FOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D5Uc%2FM4ZVgJT1
> > NAq08cIlNtfF5oW4n%2FTj%2Bqg3YqBUeZg%3D&reserved=3D0) that plays the
> > paravisor role.
> >
> > For a VMBus device, there are two communication methods to talk with
> > Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic DMA transfer.
> >
> > The Confidential VMBus Ring buffer has been upstreamed by Roman Kisel(c=
ommit
> > 6802d8af47d1).
> >
> > The dynamic DMA transition of VMBus device normally goes through DMA co=
re
> > and it uses SWIOTLB as bounce buffer in a CoCo VM.
> >
> > The Confidential VMBus device can do DMA directly to private/encrypted
> > memory. Because the swiotlb is decrypted memory, the DMA transfer must =
not
> > be bounced through the swiotlb, so as to preserve confidentiality. This=
 is different
> > from the default for Linux CoCo VMs, so not use DMA(SWIOTLB) API in VMB=
us
> > driver when confidential dynamic DMA transfers capability is present.
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 28 +++++++++++++++++++++-------
> >  include/linux/hyperv.h     |  1 +
> >  2 files changed, 22 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c in=
dex
> > ae1abab97835..79b7611518b7 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -1316,7 +1316,8 @@ static void storvsc_on_channel_callback(void *con=
text)
> >                                       continue;
> >                               }
> >                               request =3D (struct storvsc_cmd_request
> > *)scsi_cmd_priv(scmnd);
> > -                             scsi_dma_unmap(scmnd);
> > +                             if (!device->co_external_memory)
> > +                                     scsi_dma_unmap(scmnd);
> >                       }
> >
> >                       storvsc_on_receive(stor_device, packet, request);=
 @@ -
> > 1339,6 +1340,8 @@ static int storvsc_connect_to_vsp(struct hv_device *d=
evice,
> > u32 ring_size,
> >
> >       device->channel->max_pkt_size =3D STORVSC_MAX_PKT_SIZE;
> >       device->channel->next_request_id_callback =3D storvsc_next_reques=
t_id;
> > +     if (device->channel->co_external_memory)
> > +             device->co_external_memory =3D true;
> >
> >       ret =3D vmbus_open(device->channel,
> >                        ring_size,
> > @@ -1805,7 +1808,7 @@ static enum scsi_qc_status
> > storvsc_queuecommand(struct Scsi_Host *host,
> >               unsigned long offset_in_hvpg =3D offset_in_hvpage(sgl->of=
fset);
> >               unsigned int hvpg_count =3D HVPFN_UP(offset_in_hvpg + len=
gth);
> >               struct scatterlist *sg;
> > -             unsigned long hvpfn, hvpfns_to_add;
> > +             unsigned long hvpfn, hvpfns_to_add, hvpgoff;
> >               int j, i =3D 0, sg_count;
> >
> >               payload_sz =3D (hvpg_count * sizeof(u64) + @@ -1821,7 +18=
24,11
> > @@ static enum scsi_qc_status storvsc_queuecommand(struct Scsi_Host *ho=
st,
> >               payload->range.len =3D length;
> >               payload->range.offset =3D offset_in_hvpg;
> >
> > -             sg_count =3D scsi_dma_map(scmnd);
> > +             if (dev->co_external_memory)
> > +                     sg_count =3D scsi_sg_count(scmnd);
>
> scsi_sg_count() returns unsigned int, sg_count can't be negative. The che=
ck for sg_count < 0 below becomes dead code. Add a comment to say this is e=
xpected behavior.
>

Hi Long:
     Thanks for your review. Nice catch and will update.

> > +             else
> > +                     sg_count =3D scsi_dma_map(scmnd);
> > +
> >               if (sg_count < 0) {
> >                       ret =3D SCSI_MLQUEUE_DEVICE_BUSY;
> >                       goto err_free_payload;
> > @@ -1836,9 +1843,16 @@ static enum scsi_qc_status
> > storvsc_queuecommand(struct Scsi_Host *host,
> >                        * Such offsets are handled even on other than th=
e first
> >                        * sgl entry, provided they are a multiple of PAG=
E_SIZE.
> >                        */
> > -                     hvpfn =3D HVPFN_DOWN(sg_dma_address(sg));
> > -                     hvpfns_to_add =3D HVPFN_UP(sg_dma_address(sg) +
> > -                                              sg_dma_len(sg)) - hvpfn;
> > +                     if (dev->co_external_memory) {
> > +                             hvpgoff =3D HVPFN_DOWN(sg->offset);
> > +                             hvpfn =3D page_to_hvpfn(sg_page(sg)) + hv=
pgoff;
> > +                             hvpfns_to_add =3D HVPFN_UP(sg->offset
> > + sg->length) -
> > +                                                     hvpgoff;
> > +                     } else {
> > +                             hvpfn =3D HVPFN_DOWN(sg_dma_address(sg));
> > +                             hvpfns_to_add =3D
> > HVPFN_UP(sg_dma_address(sg) +
> > +                                                      sg_dma_len(sg)) =
-
> > hvpfn;
> > +                     }
> >
> >                       /*
> >                        * Fill the next portion of the PFN array with @@=
 -1860,7
> > +1874,7 @@ static enum scsi_qc_status storvsc_queuecommand(struct
> > Scsi_Host *host,
> >       ret =3D storvsc_do_io(dev, cmd_request, smp_processor_id());
> >       migrate_enable();
> >
> > -     if (ret)
> > +     if (ret && (!dev->co_external_memory))
> >               scsi_dma_unmap(scmnd);
> >
> >       if (ret =3D=3D -EAGAIN) {
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> > dfc516c1c719..bcb143766d6e 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -1285,6 +1285,7 @@ struct hv_device {
> >
> >       /* place holder to keep track of the dir for hv device in debugfs=
 */
> >       struct dentry *debug_dir;
> > +     bool co_external_memory;
>
> You don't need to introduce co_external_memory in hv_device, vmbus_channe=
l already has co_external_memory. Is it possible that you can check the vmb=
us_channel->co_external_memory directly? If you can remove this,  you can r=
eword this patch to " scsi: storvsc: Confidential VMBus for dynamic DMA tra=
nsfers".
>

Good idea. Will update in the next version.

--=20
Thanks
Tianyu Lan

