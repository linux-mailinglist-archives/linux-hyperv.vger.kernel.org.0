Return-Path: <linux-hyperv+bounces-4433-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFCEA5E520
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 21:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591B43AA90B
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 20:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFAC1E9B36;
	Wed, 12 Mar 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+OB2tca"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048161C695
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Mar 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810531; cv=none; b=XRIYV5Nn1MM7K+Z6QgEzE91c707ggf5GRyWCQiOx7NxG/PKPJtM/KbfDBwoaqeSLpDdXZCiwhuMSJd091mcWRDVkMWCwJq3m0Dx4XMgFF/wKHe3bdeX8Vb1ZjWvn7YwDiADgct2pAHYU6MtNJBwLXNvsQLxT20X/g4x48TmZ6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810531; c=relaxed/simple;
	bh=AW1UNFDZG15j41J3sF+UBm0LublPLpiYaZymjtd3AYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzhof14ZA7IcL/YLdXM502SzH56RQYFsBF8PnK11M+TdL9D452XVCEA6xPH+63VCwmVTUvsN0bo24MAg70dZZRHsd5KVUR+idSL3y8Lg3331ndm12BcGoSf4x7boc97JaFF+EyENifyyA6ZEy5wA2xICLMg9l/zzAasQscu7ikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+OB2tca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741810529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLkIeO0MCQT7MR4XxoTZC2Dt6fLNdFPHwBMGedp21e8=;
	b=I+OB2tcafrTm1EtZUBRIZsSkBqirfWVNHAF9xymnrUXHxaoGvBhm2vSiOlDI4X3eoU433m
	aFrFRROvAhK98gIB9jhswH2mKRTimmjX+B6etVt3vwZmOQoe2lE72Y5/QCFb5KH1WG5NPI
	YaGHiccqhhHvGu/wjQR4dAo/kISMZcQ=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-o_BPf6OXNSW3XQOcikxyzw-1; Wed, 12 Mar 2025 16:15:27 -0400
X-MC-Unique: o_BPf6OXNSW3XQOcikxyzw-1
X-Mimecast-MFC-AGG-ID: o_BPf6OXNSW3XQOcikxyzw_1741810527
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e63533f0a65so370157276.1
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Mar 2025 13:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810527; x=1742415327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLkIeO0MCQT7MR4XxoTZC2Dt6fLNdFPHwBMGedp21e8=;
        b=uB0B3U2xQdppusdpfMf7glkcz0YkbOLnlixJcmvaHTntZ+PrWQAmtYPCUyDSrDiwYr
         AQ8Da8CfVKayANayJXNV99f30eNXAwCDL9u4fYxpSG+VpuJJWG5AQlBffQWcifHFxVw0
         DsLELnNA1QEOI5YIcLPMEA63mXVCQW4cAxEmEdYrV+XEFD+v8oslxzpBIf6AT4M1J0m6
         3o4T3djsVVf/36VC095u0HtRrzYvY6Z6YRKeD8/GHBMPV7K6tGIOBx63wWUCk3I96yh/
         uEF7NsWMqfQrsuE5DTvM0ljehozG8CV+YQrH/B6kfz9MIPaQ677VI/f99CW2Ybx8xLEt
         JthQ==
X-Gm-Message-State: AOJu0YzEnG5u60qTMZAW5QSjHaTD3mv/0yGk9Mw1VwW7HMMjr10a87n/
	n00ufABYdas/Zp+RAz2w7GjZfyeU8TMNki0WE9SxN/9XzWRR3SldTkXMAzVdiR/pI9LC5e30xKW
	ESqeEeC4kzpP3EodUwJIMSjoiYyZ/ZVM60vR3sYO4fx95JDxAOjdyKT1BWBN+GmMWAseAwbjzLy
	Z/cznml7WOmeAG6GQoIEA42Ibmd173Rl53Us9W
X-Gm-Gg: ASbGncuwra7vvDguJUpOHSZ/e/brrZR6mdPXSEI2AhZpsRjoFKa/roTuPqo0usIB6Sj
	usfS7dUFBoH2bFNT2LjkRcknFhDEQvvsbMSwjynjVCmZTY5vdHhW5yaYcv/B+bOhQ/saLPvDBVj
	qA2t7gC9zXAIo=
X-Received: by 2002:a05:6902:1b8a:b0:e58:cb:70f0 with SMTP id 3f1490d57ef6-e63dd280e5amr1426521276.6.1741810527327;
        Wed, 12 Mar 2025 13:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRjCueQJTtD1Yip12lTSRS0J2WXsza8uUs7pkqkkc4WEhTu9c6Jn8ZqT/i5u+iVlL2g8+CwS2JOOpWtSQA1o0=
X-Received: by 2002:a05:6902:1b8a:b0:e58:cb:70f0 with SMTP id
 3f1490d57ef6-e63dd280e5amr1426459276.6.1741810526854; Wed, 12 Mar 2025
 13:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-2-npache@redhat.com>
 <oiues63fvb5xx45pue676iso3d3mcqboxdtmcfldwj4xm7q4g7@rxrgpz5l23ok>
In-Reply-To: <oiues63fvb5xx45pue676iso3d3mcqboxdtmcfldwj4xm7q4g7@rxrgpz5l23ok>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 14:14:59 -0600
X-Gm-Features: AQ5f1Joh0g4Z83aGfjvoE-bfcrPmBotalHWvxVjzooJnUWJwOvfHN9lhNGt-h0o
Message-ID: <CAA1CXcCG6pdVaU7PGks2n3SdRjT1xxpP=yfsF3Mt-J4eCcshiw@mail.gmail.com>
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mst@redhat.com, david@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, nphamcs@gmail.com, 
	yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 10:21=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Mar 11, 2025 at 06:06:56PM -0600, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers an=
d
> > expose it through /proc/meminfo and other memory reporting interfaces.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  fs/proc/meminfo.c      | 2 ++
> >  include/linux/mmzone.h | 1 +
> >  mm/memcontrol.c        | 1 +
> >  mm/show_mem.c          | 4 +++-
> >  mm/vmstat.c            | 1 +
> >  5 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > index 8ba9b1472390..83be312159c9 100644
> > --- a/fs/proc/meminfo.c
> > +++ b/fs/proc/meminfo.c
> > @@ -162,6 +162,8 @@ static int meminfo_proc_show(struct seq_file *m, vo=
id *v)
> >       show_val_kb(m, "Unaccepted:     ",
> >                   global_zone_page_state(NR_UNACCEPTED));
> >  #endif
> > +     show_val_kb(m, "Balloon:        ",
> > +                 global_node_page_state(NR_BALLOON_PAGES));
> >
> >       hugetlb_report_meminfo(m);
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 9540b41894da..71d3ff19267a 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -223,6 +223,7 @@ enum node_stat_item {
> >  #ifdef CONFIG_HUGETLB_PAGE
> >       NR_HUGETLB,
> >  #endif
> > +     NR_BALLOON_PAGES,
> >       NR_VM_NODE_STAT_ITEMS
> >  };
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 4de6acb9b8ec..182b44646bfa 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1377,6 +1377,7 @@ static const struct memory_stat memory_stats[] =
=3D {
> >  #ifdef CONFIG_HUGETLB_PAGE
> >       { "hugetlb",                    NR_HUGETLB                      }=
,
> >  #endif
> > +     { "nr_balloon_pages",           NR_BALLOON_PAGES                }=
,
>
> Please remove the above counter from memcontrol.c as I don't think this
> memory is accounted towards memcg.

Fixed-- Thank you!
>


