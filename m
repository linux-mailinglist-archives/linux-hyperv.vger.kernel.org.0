Return-Path: <linux-hyperv+bounces-7069-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 147BFBB7814
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Oct 2025 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF9E3A3B38
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Oct 2025 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797329E0E1;
	Fri,  3 Oct 2025 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfsOhdde"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CA19DF4A
	for <linux-hyperv@vger.kernel.org>; Fri,  3 Oct 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508115; cv=none; b=H5Q1N3cVm1xIAQgD+b9big2/bEQtSFAhhHMojdfCW44XCYm4kzXeLssE81VkLGdhjCze+hVbki41p9ywxZ0KfciscbEKsT2MWe5JXUoItHXakaR57DJyM22KsVI2r90tnqYC7Zhdi7U8OD2GvnJ/r9354Se9hQdMTEz+0k4s9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508115; c=relaxed/simple;
	bh=7wuFMGs0dHFY4V1AjLX74sWwcF/NB+Jk1Zc5be1peEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvvATFnZrvw1Y1IP5J5GMms/VMYpTywg9hTPH2jb4BWD6SEIaQhEKlZerZrtMm19ptBIU1qbvwXtlrRlUzFjCNdZgWJEQZwUZGJJbGybOjOMzv7eDkWnIrODHKhlkA83JssmL4eqvUD+XWdikdyK+zeyhu3SnTUJ7apZkKGEmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfsOhdde; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4db7e5a653cso24167801cf.1
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Oct 2025 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759508112; x=1760112912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRT/iYpKxpou3nIU4G8aZA9jml41omx9hIjrGCgXioY=;
        b=SfsOhdde7T+jjBRwgvdZO4pqAshekPhkCM4BYg+935xeBWdsFT70GSpgqlwuZS1YsH
         sauWqezY5eXtwfpTEvFr9uvlc2YDYoPzqLXh97WsdwtzbtWi27D5+Ep8ARwmbghoFJ66
         EiwmTTfh5CVGUZGc25ow25iNXk6bwxKJxSlBq4EY+0UT0Li8V61DhAt+EsnuUzhyx49I
         Cbbzbvl6rZwUCr0eQWTp4NRe4n5Db6oo7X11J01B/Wh12jTyNg+c+GMtOZM0pn9t1Tzl
         x3QtZsgXaN09yCNPUas8lxPyEHyAsOAnYuf2z2XswptlQvdIgJkkSWjCm95NVqTlQxS1
         +gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508112; x=1760112912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRT/iYpKxpou3nIU4G8aZA9jml41omx9hIjrGCgXioY=;
        b=Goe5QzmLnZok9JwdS4SgmV7LzEUCJ+f7pg2b3tWcUgxzimMzUUxVKJRzMJCZ804fZj
         jNO/DTcyiwmPfZK34mgt4tZWQpDk30MlGtHX6jv/M/lLM7uh04zVBxJOv6GLwDosW+m7
         ijJyiSgFPaei1QYx8W4wNXfXFB1gPLkbQ8cqVFMfSwkxW2B/Pi+lFTaf7tIj2bvqifFr
         Pm/kIdvYHW2NVvzdRFNDO+3I+FvsUzkGjiRWNHMqkWB6X87nxNPm/YiR82Tx4K+1UqjA
         lZYV3E5gv8VvOh54OMy8+o1GVtUF8q5o8VMxI2tNMvl8rgPO2no6YjR65taCnsD8CXXr
         mVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXdrisyO/krdjMzqLicvxGTsrlBaWPYZiY3g4YNp/bVwmuy16YWbHM157v6QXF/N4XciESkQtKtFFhcZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1/Is+jSG5AX5jR3nL/ddLqofL8vOMc8tBcihhzJejvMkVj7A
	JyJEnoDS3qjn/W+M21dRo316Doi+go6fTMStjyx1AULZU3X8RjL/Iw676MJJAr36mGruFQ9bOkw
	MY+IG3tvN+/KZUYRB0o7azJLuyBqrRVqjlmnBc/ar
X-Gm-Gg: ASbGncvlV95AM9xFEjsUcWgw/ClBucNn3iovJnL64tfpEo/zlFIzxFBMe/RIC2HRXyp
	2rVYSH6fCjPrryvdmc6Zejj/SK3ksiiiPSvUI7FXSo2+6RxAsLS3106tDld6BgZfzYxrt+Q/aJE
	R6P70lwAEKakxIGTvtCtaBXiZaHpE0vN5O60B2a9BPbjs3ZoY1T1vI4izQ9dMNNNWwknPsZd9MZ
	hrWpdyqKSofzFRN1h+IilBSQzdEDn4Ru9+7VlYC8f0WWjHWzoYKou0hdzUlXffHK/N1bahO
X-Google-Smtp-Source: AGHT+IF7ePNKC/efflqXHwYHgjxSxDTK8C6+GyU9k0GrT7S6haFlI4McuaUxqH1svu1wQ3PG3W0WiRmSfLdQYtAxFzc=
X-Received: by 2002:a05:622a:5813:b0:4b7:b1cb:5bd8 with SMTP id
 d75a77b69052e-4e576ae6a76mr55687871cf.73.1759508111841; Fri, 03 Oct 2025
 09:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Oct 2025 09:15:00 -0700
X-Gm-Features: AS18NWBvRkA8XJUstYFSzhKHyU5fYwBegMPqLVfkMF5poIlBOyx5qh3MF6NBsnY
Message-ID: <CANn89iJwkbxC5HvSKmk807K-3HY+YR1kt-LhcYwnoFLAaeVVow@mail.gmail.com>
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

On Fri, Oct 3, 2025 at 8:47=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds this
> limit, the driver drops the skb. Add a check in mana_start_xmit() to
> detect such cases and linearize the SKB before transmission.
>
> Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(),
> send other errors to free_sgl_ptr to free resources and record the tx
> drop.
>
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++++----
>  include/net/mana/gdma.h                       |  8 +++++-
>  include/net/mana/mana.h                       |  1 +
>  3 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index f4fc86f20213..22605753ca84 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -20,6 +20,7 @@
>
>  #include <net/mana/mana.h>
>  #include <net/mana/mana_auxiliary.h>
> +#include <linux/skbuff.h>
>
>  static DEFINE_IDA(mana_adev_ida);
>
> @@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, str=
uct net_device *ndev)
>         cq =3D &apc->tx_qp[txq_idx].tx_cq;
>         tx_stats =3D &txq->stats;
>
> +       BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES !=3D MANA_MAX_TX_WQE_SGL_ENTR=
IES);
> +       #if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
> +               if (skb_shinfo(skb)->nr_frags + 2 > MANA_MAX_TX_WQE_SGL_E=
NTRIES) {
> +                       netdev_info_once(ndev,
> +                                        "nr_frags %d exceeds max support=
ed sge limit. Attempting skb_linearize\n",
> +                                        skb_shinfo(skb)->nr_frags);
> +                       if (skb_linearize(skb)) {

This will fail in many cases.

This sort of check is better done in ndo_features_check()

Most probably this would occur for GSO packets, so can ask a software
segmentation
to avoid this big and risky kmalloc() by all means.

Look at idpf_features_check()  which has something similar.

