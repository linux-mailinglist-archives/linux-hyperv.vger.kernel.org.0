Return-Path: <linux-hyperv+bounces-7139-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63ABBC58E3
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Oct 2025 17:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278054050F6
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D862F360C;
	Wed,  8 Oct 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEImfvoi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9F2F25F3
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Oct 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936912; cv=none; b=AZROSkFpJq6fKT3TacDBAE417f4FtBbj4B82y/L5kc7/8B0ntpNN5uErWIC0poiwuVStzWzu2rq+81QiBYYA9RCnBpCzikcXP3uEoClthL+2r20bx9Pr3q+RFPwNNjbtzNeUDpp32YLl/w1mHhhehCyLMA146DPGnOPNStTHGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936912; c=relaxed/simple;
	bh=ecKGtBcssmAsD25710NuJEJAaZrg9hPPYN3pFhCJ6AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+F4cRIcMYdJvI13W/JxvDCeZVeKaFBc+NYybTnfs7sVzd9J3wj0rcZqtFm7JE70Ir6GpZUKskCqfofDSsLjL4cybHefzDsw/XCUEyajEnuf5QQM3syVQrE62R7ne2C8mWFJXWDw8910mlnet8GWqH5kRN9yQR+dK71adO7+HCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEImfvoi; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4dffec0f15aso92418151cf.0
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Oct 2025 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759936909; x=1760541709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdvcJHdCzP+y1b69oKpmC8BZe0dizJUy2NZiOnbaMhg=;
        b=nEImfvoiHSr+nE48/dD0Rat1WOHfTMqOTUWoYhNdd5VjwvInX2pH8dciCZ0vzYVi3o
         3I8Z8iFbqfDJ4ihL8WnLM3fabDkeoN7pM3KONTsxY9ZCR/u/1QajAXWTLhAiL76VvLw6
         7bfAEbY28KwdiZ234r/EwCpHhy9+NdYuT0VsliobXS3nlnLWuRFDGy1dfmp/Hk7AzPzu
         SMjPuOY4hhaTS/qFxF2XCKR+YqYC3hzIPdUWfq6qIegXRBvYzHx3BHWWDSAxooKWxqhW
         kzKnhiOQ+UoZ9DBG5rFP5SC27Q4fC5mkkKqgz0wUeRrTdZPSPQ2RHdnU8UX3dmwdN3d1
         LK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936909; x=1760541709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdvcJHdCzP+y1b69oKpmC8BZe0dizJUy2NZiOnbaMhg=;
        b=w/70KNHpqkN7a2USFXVieYouoibG7bDmtky8h26F6kqlrk7Jt2F4OlJKC21+h/tpZ/
         0sN0AK/Gr2oraRzH93LSf6VuPYE67fxW2wxfq+G2kl8DLrxvRwzHh7HQTRju0/RnNFjN
         5wYZi0Ck1dHEMQXWyzOwuHedEhRW38pPnb3rGq305EHFNAHjUj8NfQPTrwApUn055ODY
         Msdju5MJFGBpGRfZi+RYpbg5Cj//KZWIYBrg5T9s5Ofyl9M3uFlGV+tFy3p9OYuZOWsh
         s5GKqeACj7hpyIWtf8toM8uxhx9bKTN7b6/WA2hRq7uH7Hmd9uLe2mOHFOhGBLBSNUki
         APhA==
X-Forwarded-Encrypted: i=1; AJvYcCVpMQAOcEG7fOydIisIblV5a7MzpCwV9e7N1O+RTaV2AFf9bcseR/SXHGRE20mROX9xKhRYf9mYadg27bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjFyCLRIpgNaHhoMoGn8BxxqGKaqy1iWVibyWAhXZCtseVX0M
	1EDq3sYp3exmve8A5oDTAaOVFg18+sQgCdW88PehYR8bl4Gq5tNrU+Bf80+WsGuH8dEf2wiiTo6
	SObAItVbBOBsLhQt7XLgV/JHq+S9J8WxsGJCMmEsE
X-Gm-Gg: ASbGncufxZNzON0ob5/i/BBMkGGDGH5VYuWy3oToOnSlCNOTgScradZ2Dc4PbExt/Il
	cQFpdi1Ip1pt8VyAIOazwrQ7Dj9TJVzSg8vuu2RokGC6dljY+3ClPfLWa07KV1LtrT6bj1y4tNl
	911SCmt2PbyDVPrhXs97W5qKelkPOJiE0is65XqjFNmz8dJvI7rLmyPm69Jre3ZNFJn5GWwgTgG
	a5LEs1Zga//Hl704eg/th/v7r/60mTetMeQDsWk8e/czeLePeXHihA3ZahdHzOnfbHsstJF
X-Google-Smtp-Source: AGHT+IFnCXJF7a8mwX4u6M/G/DluGiMoMcD9a0V+zOvUBJbRksBjY0SPvGpDiJoMRCeGymuah5UrwX6yMOliI6hi0gs=
X-Received: by 2002:ac8:538d:0:b0:4e6:ee34:2f0d with SMTP id
 d75a77b69052e-4e6ee342fccmr31006471cf.76.1759936908728; Wed, 08 Oct 2025
 08:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CANn89iJwkbxC5HvSKmk807K-3HY+YR1kt-LhcYwnoFLAaeVVow@mail.gmail.com> <9d886861-2e1f-4ea8-9f2c-604243bd751b@linux.microsoft.com>
In-Reply-To: <9d886861-2e1f-4ea8-9f2c-604243bd751b@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Oct 2025 08:21:37 -0700
X-Gm-Features: AS18NWA4rjzPyXivisvXLvTjcjSNyre7mla4J_1tYNcVnh0bB68GXqduG9SI-w4
Message-ID: <CANn89iKwHWdUaeAsdSuZUXG-W8XwyM2oppQL9spKkex0p9-Azw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com, 
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, gargaditya@microsoft.com, 
	ssengar@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 8:16=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> On 03-10-2025 21:45, Eric Dumazet wrote:
> > On Fri, Oct 3, 2025 at 8:47=E2=80=AFAM Aditya Garg
> > <gargaditya@linux.microsoft.com> wrote:
> >>
> >> The MANA hardware supports a maximum of 30 scatter-gather entries (SGE=
s)
> >> per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds thi=
s
> >> limit, the driver drops the skb. Add a check in mana_start_xmit() to
> >> detect such cases and linearize the SKB before transmission.
> >>
> >> Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(=
),
> >> send other errors to free_sgl_ptr to free resources and record the tx
> >> drop.
> >>
> >> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> >> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> >> ---
> >>   drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++++--=
--
> >>   include/net/mana/gdma.h                       |  8 +++++-
> >>   include/net/mana/mana.h                       |  1 +
> >>   3 files changed, 29 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/n=
et/ethernet/microsoft/mana/mana_en.c
> >> index f4fc86f20213..22605753ca84 100644
> >> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> >> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> >> @@ -20,6 +20,7 @@
> >>
> >>   #include <net/mana/mana.h>
> >>   #include <net/mana/mana_auxiliary.h>
> >> +#include <linux/skbuff.h>
> >>
> >>   static DEFINE_IDA(mana_adev_ida);
> >>
> >> @@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, =
struct net_device *ndev)
> >>          cq =3D &apc->tx_qp[txq_idx].tx_cq;
> >>          tx_stats =3D &txq->stats;
> >>
> >> +       BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES !=3D MANA_MAX_TX_WQE_SGL_E=
NTRIES);
> >> +       #if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
> >> +               if (skb_shinfo(skb)->nr_frags + 2 > MANA_MAX_TX_WQE_SG=
L_ENTRIES) {
> >> +                       netdev_info_once(ndev,
> >> +                                        "nr_frags %d exceeds max supp=
orted sge limit. Attempting skb_linearize\n",
> >> +                                        skb_shinfo(skb)->nr_frags);
> >> +                       if (skb_linearize(skb)) {
> >
> > This will fail in many cases.
> >
> > This sort of check is better done in ndo_features_check()
> >
> > Most probably this would occur for GSO packets, so can ask a software
> > segmentation
> > to avoid this big and risky kmalloc() by all means.
> >
> > Look at idpf_features_check()  which has something similar.
>
> Hi Eric,
> Thank you for your review. I understand your concerns regarding the use
> of skb_linearize() in the xmit path, as it can fail under memory
> pressure and introduces additional overhead in the transmit path. Based
> on your input, I will work on a v2 that will move the SGE limit check to
> the ndo_features_check() path and for GSO skbs exceding the hw limit
> will disable the NETIF_F_GSO_MASK to enforce software segmentation in
> kernel before the call to xmit.
> Also for non GSO skb exceeding the SGE hw limit should we go for using
> skb_linearize only then or would you suggest some other approach here?

I think that for non GSO, the linearization attempt is fine.

Note that this is extremely unlikely for non malicious users,
and MTU being usually small (9K or less),
the allocation will be much smaller than a GSO packet.

