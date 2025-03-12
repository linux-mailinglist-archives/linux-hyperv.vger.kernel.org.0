Return-Path: <linux-hyperv+bounces-4448-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418BA5E7FD
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 00:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522A0189A65D
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787BF1F12F1;
	Wed, 12 Mar 2025 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlU6q2A8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6E31F0E45
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Mar 2025 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820685; cv=none; b=OEp24VDBTzSybxDFEZffBqjjESa9bxcLcM+ZmZTwQLiWgVWqUIzRpNgP1fy5tfk+hYJNbuuNtz3nROzytoBBP3btzhqeB5M9+TtMYlaAKHPgh+qCEj3W7tDcyZNV2tZZHk5ks667JY6n4XBlpW5OlbXOymcByVZJ2v5QcXva70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820685; c=relaxed/simple;
	bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvWwKxCQ8afnJdpRsPqh6ZD1LTIanM6bzPVMXDyUAIXNnm/5HPACLc+U3bzxcq+jzqGSL23VlMdo2wyKMok0BXjZ2c097XN6ZbxHVqLYeYl9w9HPz5ngWqH/2rg1kDYt1iRnF4GzrAs0PUq7Eq8G2cdQEHub1NNOzCWPKo5KS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlU6q2A8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741820682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
	b=MlU6q2A8a4uCwqBNOlxeDEILGorCOSeWUvxDY+SIWf5LWnKEi1j7LJyx151qsyGUl2RY6t
	NiR9c+TsFmuceIU6+dGFxR1J9sfo1xk8irhkoqPSbYwLVSnYz1FrJDYI8hqERbUhNU4yNv
	+8X9qeZ9LqKRd2CvH1K/NA4ervmG4fE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160--Nv1wwO6M_u8s9BuG4_Niw-1; Wed, 12 Mar 2025 19:04:41 -0400
X-MC-Unique: -Nv1wwO6M_u8s9BuG4_Niw-1
X-Mimecast-MFC-AGG-ID: -Nv1wwO6M_u8s9BuG4_Niw_1741820681
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6feb1097d64so4946077b3.2
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Mar 2025 16:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741820681; x=1742425481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5PEY+yC9Huewb0HnCtpeT52eaIOfYoMMqMSFveNI50=;
        b=KuJrGU6RzA6NKoJdL2V9k8VDvmr1yJFM7Z3ft8yDBy19K7YsouKQYGfY1c+2TsY4jj
         WZpyvENs9YuFi2sjx70rTZNZ36DkiWDfcD9pDkKMsHynYCrOiWAp78g3fPnT++41u3hG
         dd/35M7q63XwYRnHAvZT43gtBH3XKQpvvC2ERLUVP/yrm+Q40P1871+exJ51Enhpp5im
         qzKOia+DyYFCHrjrlFmcZn7G2is5nMEr0TwXUJAkTNLLMpS5jcgiKVC/T6Pz+IGKt9b0
         lmo4/cmaxp5+92a2VvXS6hCKeqvBlc1C1vqltUZvKEQLev7DTR5JcaREdALceaM6KTHa
         LrfA==
X-Gm-Message-State: AOJu0YzSPOtkQ03DWhiD8bt83iN/HAxaITpGDshTFMMyQv4NT0ewWdN0
	idvmh2KX2bVlO7I6p8gOWGfGO+I+UuHSYmYqvSiXcQriJALSNr0D3clZmcmefdThTiSelXB+Xse
	brMumkjm2yhou6a0Tu+mBMv9nqw7cWoSgI+ALLMfGdp0Cj859TsRjzZMfW3lHOB/BczqXHSXNy7
	FQ+PQ7lBJoZkxFw4id3srWN9ZlHi+ZoyuCugNw
X-Gm-Gg: ASbGncv7JReWbCv03SfofkS16B6M+Lbq3GG99CPpenEo9tLbCy5Ozp7/KFT3G58SIfA
	N1NxZhdn7U9iSTP4Gx/6MYQjlIPhkg7pJ+qjHU7lUCKsE1MLbbnW5vz39RVJ82lK3ok1rdvaHd0
	JvlyOVrLCGMEU=
X-Received: by 2002:a05:6902:2ec3:b0:e63:65bc:a173 with SMTP id 3f1490d57ef6-e6365bca293mr20489045276.41.1741820680977;
        Wed, 12 Mar 2025 16:04:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE29IOsL3if064ONRlZf/bCswPuk7JbIN/+ScTtHA6PhUNFhrt31PPwWl6SfPGyM46nmrjRUH8DQbWz44H/+M=
X-Received: by 2002:a05:6902:2ec3:b0:e63:65bc:a173 with SMTP id
 3f1490d57ef6-e6365bca293mr20489001276.41.1741820680678; Wed, 12 Mar 2025
 16:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
In-Reply-To: <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 17:04:14 -0600
X-Gm-Features: AQ5f1JrCck7ZrLXTjsNL6uP-21nbhhEyl_MT0WXZGBOwpNadq0-oKKZGcnVqKd4
Message-ID: <CAA1CXcCv20TW+Xgn18E0Jn1rbT003+3gR-KAxxE9GLzh=EHNmQ@mail.gmail.com>
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: David Hildenbrand <david@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:19=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.03.25 01:06, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers an=
d
> > expose it through /proc/meminfo and other memory reporting interfaces.
>
> In balloon_page_enqueue_one(), we perform a
>
> __count_vm_event(BALLOON_INFLATE)
>
> and in balloon_page_list_dequeue
>
> __count_vm_event(BALLOON_DEFLATE);
>
>
> Should we maybe simply do the per-node accounting similarly there?

I think the issue is that some balloon drivers use the
balloon_compaction interface while others use their own.

This would require unifying all the drivers under a single api which
may be tricky if they all have different behavior
>
> --
> Cheers,
>
> David / dhildenb
>


