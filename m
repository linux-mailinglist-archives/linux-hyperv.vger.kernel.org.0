Return-Path: <linux-hyperv+bounces-8937-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAk/JCfCmWlhWgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8937-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Feb 2026 15:33:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9516D07F
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Feb 2026 15:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32059300B9A6
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Feb 2026 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31A51F192E;
	Sat, 21 Feb 2026 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR9WV1+x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA48262BD
	for <linux-hyperv@vger.kernel.org>; Sat, 21 Feb 2026 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771684382; cv=pass; b=nx4DEMMeT+kUmA7EnyNB6FSKuuKj+X4Ogc4e/7pduDVLE/agcDKl9d4i46x3YmxtYFCdh9FIwo65KhKuNVGrgGGVY6RmbpeBlii/7QY6oWLJUi2WFnOWUtEreEwwvDYPCLcevpKfCUxtVerAY9A60rs46mr0C5kOISQCMDYgt1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771684382; c=relaxed/simple;
	bh=ccR8tiRXpGRTKvvJya8IzIwifwN8+p89MmZZl18KP1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AU4y06EbhVDGZGcS2cnjy7SuFtq5VaaSC9mk8bthQ85iJatS8h+bH+GV/ox9i9/mVxPof2KJBOvD6ZkSSlT2xoFRO3TH3i6Fm/e/1JXEAUt94tpaZCgwGwR5s0fg10NsQ9jiY9X/bKV66yVx6DCo96Y0tSA1cZYNXeeIlqPNcxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR9WV1+x; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1274204434bso2821728c88.1
        for <linux-hyperv@vger.kernel.org>; Sat, 21 Feb 2026 06:32:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771684379; cv=none;
        d=google.com; s=arc-20240605;
        b=Ikq5jvo5FPems8giQSjZlJiPdEysizvYQT+Isnm7UAaZ2BmQC8DcK7+OqxYV9GvIQv
         X0sEOrQBu1J+7o/wkDSegm/6NBx5F1MjtO/ot94+HoWVxH+p262R6ffD1IBALyHyejic
         1rZS8ltBWgZfiiz9NDWDlx6moqiwQZEoIkw4FqnPWAz3a+wwF/v2ddoQrHouCTL7v27C
         Xe5NqREG6D+ZptzNz0k25fYn9gE0Z6sSAxAKavMMX8u+zjRYsr1H+hPdv3bg++/oJ3Yn
         sNm2I16V2IvU/GgjoPkvSiB5XsPYgaEAvua334Q2VVw2onzLwYKuyApEzodvf9MB4DXe
         Vy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IpQICzSBKHlKr1t9q1Yhh1BRovtTm1uKBd4aHFj8Hjk=;
        fh=05Own2+PJX863Zj0p8exf5IW944Z5TJcCSNKgDkizFo=;
        b=kU1oKcfw88UUOqVrt4pPdygOi/9EWnrah4uwr0+dVfd6xAslZUnBtVuyto8Twzl8LY
         mSp8KvqSM0wNhnuEYvjc3Sgow2LMm44d4bEi2KaEv6pKNmb0qm+rjjM9vCvqjluxg91/
         1w0k5E1JS6CBeqBpRo6sljLQtVciS4yRw0skNUqw2txaKdfbroENzCpxLmK+nPnAiddA
         ybDZNR2FUfOJXip5vqbFKGdeAKuozJP4yTEzT2ynETS8yHBhrYM37IgHkZj/EgYIogf5
         5IZjs1UfIcAHnPFIPTMmmMaf8V+BYsbfCQ74xcC7o5caDNpPWr/4XFNum5lBycC8vKCH
         r8QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771684379; x=1772289179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpQICzSBKHlKr1t9q1Yhh1BRovtTm1uKBd4aHFj8Hjk=;
        b=nR9WV1+x5BFo8PW8VuoQzoMcYmSN53l/dAP06f3oNRKo5KumsYgOAoKacuKQrThYsY
         2XI5sds4QIDz1j2yWONOteboNMyz9NIFjWwi41LwajrW3+IY1/DV0Cc9JUbRuXJMFL7k
         69HqP8G3UGPEeO2f7As8BVevrRN7AM4ftErgk5azftiWNnxwgLpmMW45GuDbXAXiUBz0
         OBHnBCc9N1qqw4Di1lRAFFjwO4jkimkM0L2Fs2k+uxf/hZ9ITrkosCZHJD8zxqrZ4+pB
         2o7apVKSfQnvQSqZVm5ym+lONXDfQWmvBo5nSpZsxuqPW8sLIYEn8b5n9T/xTdzWOOfS
         JeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771684379; x=1772289179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IpQICzSBKHlKr1t9q1Yhh1BRovtTm1uKBd4aHFj8Hjk=;
        b=cSfRH8t8ftwtDV2kAGP4leQU7qeP7BoHNpMr7NvuFYGK6GQxTnBPxMpafIuVXorHvl
         i30N4pqUrQPliax0IcjCBK5YPlHpugOMPm8+uiMyrFIN53F5vKOaTm/C1nB/zSyPY/gi
         nRcDIdYVw/lzWo8//ACKoI0h8T7DdVdBqFNXOikpd/KnWhc/YFmDxuvFmL4OEAlPamAi
         i5yD4kUePxnxLjmY/xbZUXaXOk5Ftli2WQWVSDRFT/5k+ket5ksIU9cs2F79f0eVxy3i
         7rqz2cBgEzJGvuJw0MdxibAOja2+KLdjiClhEfGG5So5v5fhiu0jDgD93QCqTjEJKETL
         AIhg==
X-Forwarded-Encrypted: i=1; AJvYcCUSoegIQaXnGInT2m/BweLRkn7dCHEv56zqWXSfKdr9aGSZw/EY2JTr3qV+DKCqp4/nbp8hZwwh8VaHDM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7QtXsirey8VktLTJQxMU05AsOiPikdr0TqJuel4jnw3FhRpFC
	g4AdIacD8hHGSPWpYNB3yDW3wk14Tq41glwKJhDR1uUJsIIzectKivi691Yyffaf67d8iWIKmwf
	BIZkH8tJOf+sGIbQqQ9CJKgWOCausC/UKDY7v
X-Gm-Gg: AZuq6aLV/wybpaxdDE5GYR9ohuOvMli/cFnI2O+hqVElfwvqtICVKEhFx6yBOoYO0xg
	CS2JtfpsYrShVagTecLcP2LpcraeOj37pBDkhpyAdLFgKq8mMLULvBAX6Qj2SxjngttHYflGy+9
	L/LVuK6uqAja6zZNQ5ACcMsdx+pfE3aTDhH6TBVyavC09Fc7apXcQC0AplZ2rG+nZtuTIVCkNOc
	746VJCx0VYjPK2nBhra5bGytOlaf58ROvS8DYbfbyzYla1vTV2AorApff3VB5fxPTUUd7Wg5+ZJ
	FzDQrIU=
X-Received: by 2002:a05:7300:cd92:b0:2ba:974c:4954 with SMTP id
 5a478bee46e88-2bd7b881869mr1388014eec.11.1771684378590; Sat, 21 Feb 2026
 06:32:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210162107.2270823-1-ltykernel@gmail.com> <SN6PR02MB41577FB84EC73E48ABAC7D18D463A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <cc4dc4a6-2d74-49c1-bbb0-cfa44802a66b@arm.com> <yq5a5x7xq997.fsf@kernel.org>
In-Reply-To: <yq5a5x7xq997.fsf@kernel.org>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Sat, 21 Feb 2026 22:32:39 +0800
X-Gm-Features: AaiRm50E_ESGVbiltZLXK5zgxnpO_9NduCkDEaa772nqMwo8MU7PE3h6Mm6IHnE
Message-ID: <CAMvTesASofn8HO90Uf1Xcbc+k69R+95ZYRtVJMT0NFrzM6W2wA@mail.gmail.com>
Subject: Re: [RFC PATCH V2] x86/VMBus: Confidential VMBus for dynamic DMA
 buffer transition
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Michael Kelley <mhklinux@outlook.com>, 
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, Tianyu Lan <tiala@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@infradead.org" <hch@infradead.org>, 
	"vdso@hexbites.dev" <vdso@hexbites.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8937-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,outlook.com,microsoft.com,kernel.org,vger.kernel.org,infradead.org,hexbites.dev];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51A9516D07F
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 6:21=E2=80=AFPM Aneesh Kumar K.V
<aneesh.kumar@kernel.org> wrote:
>
> Robin Murphy <robin.murphy@arm.com> writes:
>
> > On 2026-02-11 6:00 pm, Michael Kelley wrote:
> >> From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, February 10, 202=
6 8:21 AM
> >>>
> >>> Hyper-V provides Confidential VMBus to communicate between
> >>> device model and device guest driver via encrypted/private
> >>> memory in Confidential VM. The device model is in OpenHCL
> >>> (https://openvmm.dev/guide/user_guide/openhcl.html) that
> >>> plays the paravisor rule.
> >>>
> >>> For a VMBUS device, there are two communication methods to
> >>
> >> s/VMBUS/VMBus/
> >>
> >>> talk with Host/Hypervisor. 1) VMBus Ring buffer 2) dynamic
> >>> DMA transition.
> >>
> >> I'm not sure what "dynamic DMA transition" is. Maybe just
> >> "DMA transfers"?  Also, do the same substitution further
> >> down in this commit message.
> >>
> >>> The Confidential VMBus Ring buffer has been
> >>> upstreamed by Roman Kisel(commit 6802d8af).
> >>
> >> It's customary to use 12 character commit IDs, which would be
> >> 6802d8af47d1 in this case.
> >>
> >>>
> >>> The dynamic DMA transition of VMBus device normally goes
> >>> through DMA core and it uses SWIOTLB as bounce buffer in
> >>> CVM
> >>
> >> "CVM" is Microsoft-speak. The Linux terminology is "a CoCo VM".
> >>
> >>> to communicate with Host/Hypervisor. The Confidential
> >>> VMBus device may use private/encrypted memory to do DMA
> >>> and so the device swiotlb(bounce buffer) isn't necessary.
> >>
> >> The phrase "isn't necessary" does not capture the real issue
> >> here. Saying "isn't necessary" makes it sound like this patch is
> >> just avoids unnecessary work, so that it is a performance
> >> improvement. But that's not the case.
> >>
> >> The real issue is that swiotlb memory is decrypted. So bouncing
> >> through the swiotlb exposes to the host what is supposed to be
> >> confidential data passed on the Confidential VMBus. Disabling
> >> the swiotlb bouncing in this case is a hard requirement to preserve
> >> confidentially.
> >
> > Yeah, this really isn't a Hyper-V problem. Indeed as things stand,
> > "swiotlb=3Dforce" could potentially break confidentiality for any
> > environment trying to invent a notion of private DMA, and perhaps we
> > could throw a big warning about that, but really the answer there is
> > "Don't run your confidential workload with 'swiotlb=3Dforce'. Why would
> > you even do that? Debug your drivers in a regular VM or bare-metal with
> > full debug visibility like a normal person..."
> >
> > The fact is we do not have a proper notion of trusted/private DMA yet,
> > and this is not the way to add it. The current assumption is very much
> > that all DMA is untrusted in the CoCo sense, because initially it was
> > only virtual devices emulated by a hypervisor, thus had to be bounced
> > through shared memory anyway. AMD SEV with a stage 1 IOMMU in the guest
> > can allow an assigned physical device to access a suitably-aligned
> > encrypted buffer directly, but that's still effectively just putting th=
e
> > buffer into a temporarily shared state for that device, it merely skips
> > sharing it with the rest of the system. !force_dma_unencrypted() doesn'=
t
> > mean "we trust this device's DMA", it just means "we don't have to use
> > explicitly-decrypted pages to accommodate untrusted/shared DMA here",
> > plus it also serves double-duty for host encryption which doesn't share
> > the same trust model anyway.
> >
> > I assumed this would follow the TDISP stuff, but if Hyper-V has an
> > alternative device-trusting mechanism already then there's no need to
> > wait. We want some common device property (likely consolidating the
> > current PCI external-facing port notion of trustedness plus whatever
> > TDISP wants), with which we can then make proper decisions in all the
> > right DMA API paths - and if it can end up replacing the horrible
> > force_dma_unencrypted() as well then all the better! I'd totally
> > forgotten about the previous discussion that Michael referred to (which
> > I had to track down[1]), but it looks like all the main points were
> > already covered there and we were approaching a consensus, so really I
> > guess someone just needs to give it a go.
> >
>
> With my device-assignment=E2=80=93related changes, I have made the follow=
ing
> update. It may be a slightly stronger requirement to enforce that
> trusted device cannot use SWIOTLB, but it simplifies the overall design.
> I also have a prototype, that added two default swiotlb, ie,
>
> static struct io_tlb_mem io_tlb_default_mem;
> static struct io_tlb_mem io_tlb_default_shared_mem;
>
> Looking at that change, I would suggest we avoid doing this unless we
> are certain that there is a requirement for a trusted device to use
> SWIOTLB bouncing.
>

Hi Robin & Aneesh:
     Thanks for your suggestion and draft patch. Later response due to
holiday. We may combine the Aneesh's change with Michael's suggestion
that DMA core exposes DMA core API of disabling swiotlb allocation and forc=
e
using swiotlb and latform or subsystem(e.g, TSM module) maycall them
according to user case.

> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index b27de03f2466..07ef149bd9fc 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -292,6 +292,9 @@ bool swiotlb_free(struct device *dev, struct page *pa=
ge, size_t size);
>
>  static inline bool is_swiotlb_for_alloc(struct device *dev)
>  {
> +       if (device_cc_accepted(dev))
> +               return false;
> +
>         return dev->dma_io_tlb_mem->for_alloc;
>  }
>  #else
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 34fe14b987f0..a89a7ac07499 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -159,6 +159,14 @@ static struct page *__dma_direct_alloc_pages(struct =
device *dev, size_t size,
>   */
>  static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>  {
> +       /*
> +        * Atomic pools are marked decrypted and are used if we require r=
equire
> +        * updation of pfn mem encryption attributes or for DMA non-coher=
ent
> +        * device allocation. Both is not true for trusted device.
> +        */
> +       if (device_cc_accepted(dev))
> +               return false;
> +
>         return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev=
);
>  }
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index a862712f4dc6..6d9f0c869c6f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1643,6 +1643,9 @@ bool is_swiotlb_active(struct device *dev)
>  {
>         struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;
>
> +       if (device_cc_accepted(dev))
> +               return false;
> +
>         return mem && mem->nslabs;
>  }



--
Thanks
Tianyu Lan

