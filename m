Return-Path: <linux-hyperv+bounces-6773-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C90B475E5
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Sep 2025 19:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C12E164454
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Sep 2025 17:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4832EDD75;
	Sat,  6 Sep 2025 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJjCcOAS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6ED2F0683;
	Sat,  6 Sep 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757179878; cv=none; b=bq2VRoN8gilDaqMGKmcWmB1vA3ECpyuyB4Keluvo/m2BOLJjkEdZCazfmDDlYkxtjnj2IgNgXMVQrXYRKUBKEokACxbdFBMqnTvIauOnmEOgnVDiHt/pPqh1ES6N9U4g15SCNcFBpA1HS3GSoZG0edKMinHpoOIKJjTcEdGZDYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757179878; c=relaxed/simple;
	bh=5Bj8Sf4JqvQExHsKp8RLfVnJ+HtNhyadTTgeaGFD5Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1aOv0AiW982p/FHkmGW5LbKwbwGvHpu/rKzR/n6pqiQaT1QEWMbaAsFNoPXsc+ajgvQeCntAnUzlDEhEOzC9GGELRxERNsx8Px1+/EhT2jJY32d83UjZJMQGUdFGKLBICRYm/MeryE+12yZBLKRy1BEwFeh/Lg1wTmtJZtg1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJjCcOAS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4e84a61055so2202335a12.0;
        Sat, 06 Sep 2025 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757179876; x=1757784676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHnl5AesqLvME4DFg56QY9gEZo2rOIbXRL6JN/NeTXc=;
        b=ZJjCcOASFPjsx2GcE3O78pKyQ3SUxwH/xTvZyt1dCrWweCUHqANLNkEpcakXwwaNnF
         pYQfDiGP+r278NtXVFQfvmgbE06jqUH5dKfCJn1GhjNTO2FgfXMrXjQSQhVHU/0gGg+9
         meDqedAA/OggXjobLbzd4Tnjw/61F2EXtzbm4sHwkjSsR0tErJyT2QMtleMMNeBDOpPU
         JObJEhWBWGvmsR1w4mSrBiEJikJFwvi9E92nXy8tvnZzWfKIYWP0Dv9zhn3azyOyLv6P
         zysYIDv8mqgsQAPWmDii8bYjGViOcx7sCaDPXKdiOZFwOhxv0D5UIvkTjeK6CKk0WYyg
         xv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757179876; x=1757784676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHnl5AesqLvME4DFg56QY9gEZo2rOIbXRL6JN/NeTXc=;
        b=WGyjKn1xUQLDi0vP2d6PXT70rwjDyevs5jpDTN0U33DLbo4gNOw9SQPj3n6yHxKWv0
         EqCbyw1QjZ/BvwZsWgfzPfwfaMzT335BLrT8GzVgCc1/QYCtke1wk4Vn6i2idc11CB4V
         x1gDDl+AeCfIoGD3mUStdO6+2tJiVUg9oIoTbq4jRivisWOvTSPK03PQ+GgWHZ27yaVE
         CYTIHGaGu9kVRSU0hRSgxWoE3h4ajemh41KOudd4gLouMaByC2GWwhP5aNPr+T9KUO91
         Opo59ktMyh2/apPohVPpVfBOGdr/6XadU2YSjOCkVFlBueXrZNs/cV8edfGrHEWXXmGn
         ahfw==
X-Forwarded-Encrypted: i=1; AJvYcCUFbDPcjb6ONmNo8wKwzic4ppvNupzUGXbHd6mO/K8FSwV6woYn+38P0gzMo6sfMwmhqM9LVJlvVJkAFCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydkFSt/OM7ObepW3BFWRu2606g24oOQ1zywnLTi/N+lQAx8E47
	k1a8TTIvRpHEVKaXUExvK15z/gOIhWQxnUl+yH0fD9BeGXN5TU4Jse6e/AGxqK2n+6Q5obdLncW
	nv5+jGJzgUsJxuZpG/RYh6pYN5GNtf5I=
X-Gm-Gg: ASbGnct46TOSEtkudYS7XbE7wvcC+ZG4phIV1oXrUN0JX/czr0I2GGrViSip6PlWz3H
	Rr2N3/gk4ERcdlFCZPJQyWN0M+m45hN2KgDVS3ohJTpVCYRUhGg0JCfr9KrWOrmICIGAYQEU93c
	/JpBarBZr492SsGgabBVi6GB9KMbtEYgTW4J4dfsiHDmFpLdXIDgUpSaVbJLa3ORf+D5MyEgaKG
	tkNp2QMtg1Ax67bxSYUbp1ZFA==
X-Google-Smtp-Source: AGHT+IEWo8zg8mz9Sqktu0L4SU3CqdGgZSIxW7EC9BDBZpcjVGgPWlFxUrkW52v7rmzfQrPsYLl0as5zWnhTfULPFO4=
X-Received: by 2002:a17:902:fc8d:b0:251:4e9a:a9ed with SMTP id
 d9443c01a7336-251736df099mr45827885ad.48.1757179875687; Sat, 06 Sep 2025
 10:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1756428230-3599-3-git-send-email-nunodasneves@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Sun, 7 Sep 2025 01:30:56 +0800
X-Gm-Features: AS18NWCpVLcP6_W37WxN7S9jsNtr3zse4llHr6k4E4ZBzCwvlme-KJYPlkn00ew
Message-ID: <CAMvTesA17jtxN_L3QbbVGUcjnPRYtNZWHzFmCYgqZosOrM0RoQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] mshv: Ignore second stats page map result failure
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 8:44=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>
> Some versions of the hypervisor do not support HV_STATUS_AREA_PARENT and
> return HV_STATUS_INVALID_PARAMETER for the second stats page mapping
> request.
>
> This results a failure in module init. Instead of failing, gracefully
> fall back to populating stats_pages[HV_STATS_AREA_PARENT] with the
> already-mapped stats_pages[HV_STATS_AREA_SELF].
>
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.micros=
oft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c | 43 ++++++++++++++++++++++++++++++----
>  drivers/hv/mshv_root_main.c    |  3 +++
>  2 files changed, 42 insertions(+), 4 deletions(-)
>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>

> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index c9c274f29c3c..1c38576a673c 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -724,6 +724,24 @@ hv_call_notify_port_ring_empty(u32 sint_index)
>         return hv_result_to_errno(status);
>  }
>
> +static int
> +hv_stats_get_area_type(enum hv_stats_object_type type,
> +                      const union hv_stats_object_identity *identity)
> +{
> +       switch (type) {
> +       case HV_STATS_OBJECT_HYPERVISOR:
> +               return identity->hv.stats_area_type;
> +       case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
> +               return identity->lp.stats_area_type;
> +       case HV_STATS_OBJECT_PARTITION:
> +               return identity->partition.stats_area_type;
> +       case HV_STATS_OBJECT_VP:
> +               return identity->vp.stats_area_type;
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  int hv_call_map_stat_page(enum hv_stats_object_type type,
>                           const union hv_stats_object_identity *identity,
>                           void **addr)
> @@ -732,7 +750,7 @@ int hv_call_map_stat_page(enum hv_stats_object_type t=
ype,
>         struct hv_input_map_stats_page *input;
>         struct hv_output_map_stats_page *output;
>         u64 status, pfn;
> -       int ret =3D 0;
> +       int hv_status, ret =3D 0;
>
>         do {
>                 local_irq_save(flags);
> @@ -747,11 +765,28 @@ int hv_call_map_stat_page(enum hv_stats_object_type=
 type,
>                 pfn =3D output->map_location;
>
>                 local_irq_restore(flags);
> -               if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY)=
 {
> -                       ret =3D hv_result_to_errno(status);
> +
> +               hv_status =3D hv_result(status);
> +               if (hv_status !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
>                         if (hv_result_success(status))
>                                 break;
> -                       return ret;
> +
> +                       /*
> +                        * Some versions of the hypervisor do not support=
 the
> +                        * PARENT stats area. In this case return "succes=
s" but
> +                        * set the page to NULL. The caller checks for th=
is
> +                        * case instead just uses the SELF area.
> +                        */
> +                       if (hv_stats_get_area_type(type, identity) =3D=3D=
 HV_STATS_AREA_PARENT &&
> +                           hv_status =3D=3D HV_STATUS_INVALID_PARAMETER)=
 {
> +                               pr_debug_once("%s: PARENT area type is un=
supported\n",
> +                                             __func__);
> +                               *addr =3D NULL;
> +                               return 0;
> +                       }
> +
> +                       hv_status_debug(status, "\n");
> +                       return hv_result_to_errno(status);
>                 }
>
>                 ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bbdefe8a2e9c..56ababab57ce 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -929,6 +929,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp=
_index,
>         if (err)
>                 goto unmap_self;
>
> +       if (!stats_pages[HV_STATS_AREA_PARENT])
> +               stats_pages[HV_STATS_AREA_PARENT] =3D stats_pages[HV_STAT=
S_AREA_SELF];
> +
>         return 0;
>
>  unmap_self:
> --
> 2.34.1
>
>


--=20
Thanks
Tianyu Lan

