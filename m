Return-Path: <linux-hyperv+bounces-6771-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D6B469D2
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Sep 2025 09:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4871BC3AA0
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Sep 2025 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEBE2C0290;
	Sat,  6 Sep 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm+kgE0Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D31E51EF;
	Sat,  6 Sep 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757142679; cv=none; b=S97qyg99q5aT1yX28m5GYDgjRRsK6j0w/cIxWUJfUcwYZPNF8+dUrKZcvdgNBRsW7a2fOT6cYK+60znMq6bafiHLpzcjnayMJRqNUAZeyf521rUORhTC8mUhVeGWE2H/xqNzmG+N19RpfodoMk5HNCwsqCCt7Wkr5nj4ws7ZfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757142679; c=relaxed/simple;
	bh=DxQq3Z93Q+7De7ifNN0KUyxuB461dT4DWf1PMEQXf7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8KfUqiSkZP8c92bsOGvR8x1LiDDo66KGIpPBJFdSE0Tr+v1eAB9Jjxws+YLpPE7LgnyKgiPM7abknxlBYppJTXXSmNl7+23pBZKPk11j/h4NtSUEeZk6+5Ra85Q4Ns7IBHKBquz4PVR5QFCEvoNJYmPchlGekea32iflpP2wcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm+kgE0Y; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so1953801a12.0;
        Sat, 06 Sep 2025 00:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757142677; x=1757747477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncm/Q1A/CjNR58docxc/YFmW4YuUqQkf2NQGD87zbNQ=;
        b=fm+kgE0YGGhf4nmi87AQB6V1u4FtmlYxB+/7TeCATCgEFUAKHo0S3MBqCI5iK23rWX
         Hn1KnamnLz2K6bR7cYiYGV6wTztEYFjWcU3YYZto2RzJiiyJiqPbJOZpxp8W296DuXI7
         /zyHCzj1U/+CrPyCxjzJeUtnOmd4Ru3CxeMG9f0T+LyCjOJ3lpMm1/ihl/7LtqOJqBV1
         Ujv5jfEeYh7ON1dJqPdwOyZSfb2GzuEB2+VjrwlgbZ3TUnNxgc9r0fR3mXQFliiHx3Do
         LF5Lei6WtsiU3QY+Ey6jV5W6Miqmbzf4kxBxCZRh4CZ2+2W/TtTVV7tldbWZ9NXhjpXy
         VQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757142677; x=1757747477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncm/Q1A/CjNR58docxc/YFmW4YuUqQkf2NQGD87zbNQ=;
        b=LGJDsgpS6UaB3KoeQITuN1rCPIH3cQMoiltYMl4BFCztuqUY8Idz9eyIFd32i2O+Cc
         iXSy+Sz+5S0WUXkH96wcawtryVi4UH4JNaav5faCwmzeI14daLlj92Hz6LPZNFQ0zbvU
         uUiJ9kct0c9tsQsWgsDwJ3qnQ6l6c9/jSGj3dUB0Lfj86S8Evlmnbarmi28a25M65x88
         5FsX/59VSqBS4PkFNltLE9QmjMAL4UHG2yqXH/lc7dKBS7YgjFwmNbEePkm+xGKfBgJm
         88a/vdeoBoUxndWUNysc1suN8ojJWgaSYGW+ijt1GdeZ5fdCrU2LrKSIxJEkKVTXZcpX
         vd2A==
X-Forwarded-Encrypted: i=1; AJvYcCV98av/aqGxeMyH/keXQcQy4JTk/rourmVjs1ebE38AGbqn7Jzc3n0WfqlrlkXj7QwDZ4DrDdQvScjBSes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+aXDGZ3+/e5Uo4aIcOPllsIArYENkTovCoL2AW5l+xK1FmC2W
	wo2jZ1DyZ4cWiIpr0/mnwUwxYmYN3BXkOP7yW+Y2vAsnBEVffMvTgCjli0CvcMY25kpxnNJAkac
	VQSSjadKuC0T/FlamqyCXHpuF4T4AEfmf1P3CDsQ=
X-Gm-Gg: ASbGncvJSvG78Krk1h48a8hT7ESguKD5MMTeNfh0pT041TCPTq7+mhEsDji/yuVKFqB
	YpS+Bkty4JBuL98OgKK+HNGBVVyUC2zU4wCnN16dd205vSewNG6rsQ+p8Fa3P1heUt/82amzXez
	CEdUVMZRmzwOEnG1gt28h35whAU+nXp38Ij26NXqtU/f5EeVvmP//RVnwzvVggVwcUsDU9Y5KVq
	roRwiH98AH2A60=
X-Google-Smtp-Source: AGHT+IF6h8LirdBZDzlOUBgOOQU3T/pZSFCm+s92MpYYmwzQxjA5E2keREsvzBT5hJxIcXja56geFix/1CUw2QVxJy4=
X-Received: by 2002:a17:903:2447:b0:24c:8984:5f87 with SMTP id
 d9443c01a7336-25170c4177bmr15337365ad.28.1757142677152; Sat, 06 Sep 2025
 00:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1756428230-3599-2-git-send-email-nunodasneves@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Sat, 6 Sep 2025 15:11:01 +0800
X-Gm-Features: Ac12FXwO5surBSTTznfYx_JVv_fHi6RDPRdgxzMVq0-0FpyfgGc584Gb4lX8rtg
Message-ID: <CAMvTesDBRxL5E6hctfOO0fJOHDykvZ7p=AL6Cm71tg--7Y6XaQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] mshv: Only map vp->vp_stats_pages if on root scheduler
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:08=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> This mapping is only used for checking if the dispatch thread is
> blocked. This is only relevant for the root scheduler, so check the
> scheduler type to determine whether to map/unmap these pages, instead of
> the current check, which is incorrect.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e4ee9beddaf5..bbdefe8a2e9c 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -987,7 +987,11 @@ mshv_partition_ioctl_create_vp(struct mshv_partition=
 *partition,
>                         goto unmap_register_page;
>         }
>
> -       if (hv_parent_partition()) {
> +       /*
> +        * This mapping of the stats page is for detecting if dispatch th=
read
> +        * is blocked - only relevant for root scheduler
> +        */
> +       if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT) {
>                 ret =3D mshv_vp_stats_map(partition->pt_id, args.vp_index=
,
>                                         stats_pages);
>                 if (ret)
> @@ -1016,7 +1020,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partitio=
n *partition,
>         if (mshv_partition_encrypted(partition) && is_ghcb_mapping_availa=
ble())
>                 vp->vp_ghcb_page =3D page_to_virt(ghcb_page);
>
> -       if (hv_parent_partition())
> +       if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
>                 memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_page=
s));
>
>         /*
> @@ -1039,7 +1043,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partitio=
n *partition,
>  free_vp:
>         kfree(vp);
>  unmap_stats_pages:
> -       if (hv_parent_partition())
> +       if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
>                 mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
>  unmap_ghcb_page:
>         if (mshv_partition_encrypted(partition) && is_ghcb_mapping_availa=
ble()) {
> @@ -1793,7 +1797,7 @@ static void destroy_partition(struct mshv_partition=
 *partition)
>                         if (!vp)
>                                 continue;
>
> -                       if (hv_parent_partition())
> +                       if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_RO=
OT)
>                                 mshv_vp_stats_unmap(partition->pt_id, vp-=
>vp_index);
>
>                         if (vp->vp_register_page) {
> --
> 2.34.1
>
>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>

--=20
Thanks
Tianyu Lan

