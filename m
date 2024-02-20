Return-Path: <linux-hyperv+bounces-1580-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA285C2A1
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Feb 2024 18:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365941F21446
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Feb 2024 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFD9768FF;
	Tue, 20 Feb 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSm3oN9H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCD6BB3C;
	Tue, 20 Feb 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450173; cv=none; b=KFpyTSQQdm56hifNCC0nKaF/4lIiTkKZs2iWLEXlqqfwtJnFEoNoglWOgaLln9sIS85aiTx447HifBq4kMFibgvc2sxmqbn4GrAnIdJ5HocCOZFQlOQJtYmgZknf9b6BylPaUaApttTp8bD95BR8pGKdz+CD8o3Auww7ufHkDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450173; c=relaxed/simple;
	bh=LLqmoBA04TRHMZwh3t0T8pZCMbqVUiaFNgh3qreKen0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5f4ISTYdEgYFXrww6yPMrRVgHuHDJl0RViHJ2vgnhWkB2E2dI3eYI74s26pjA/mJf5VCQkj4m7xChPd512KxHZ9YY7/cex9WSVfJ7KjwfFA3+KlBNDAMj3D90k48NnF72EisZeUArrea9YrAAdd+9RcKyBrOt1nIG416kK9F6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSm3oN9H; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42ce63b1d30so60001891cf.3;
        Tue, 20 Feb 2024 09:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708450170; x=1709054970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO9U5sYPFhh0k+yyvUwH5knbzYSiaIx8R62Wuf33g98=;
        b=HSm3oN9HNcvb9BOmq6Y5+FBL5DObu8UN87S7TLCqp9pKbPAzwrB2h0Vgp4dmWDMg2u
         msvksb0u8qVtuImi4ddy43ohQLKlygMCEP1dCWdCAOhTVrZ7t6h8Q+SbqOYna1i0bRgE
         oiSJ6CkQ/7ylPzgT3iPfHB4YxQuLcfTodUejHAccwsQDdLfTPMRq6KIKoc2Eex2sTffy
         ba2tjqOD7BtVu2p3bPAG3RhroPA1Dkm4UnJb9nxbCptesYek/E0azT+U5/mI8Ctpxl+D
         dfDCDoUlbxuypn4/Qm6NXAPFGzVaxEtpqcy+UBcbTPXoqxEj5J4QeszJQmMFTd8Ujroj
         PVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450170; x=1709054970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO9U5sYPFhh0k+yyvUwH5knbzYSiaIx8R62Wuf33g98=;
        b=OOW3RvJ3qCfgmV9fF6esh11DZ2l5RVol5mpPnXjaQ+a5Ol6cduE4z9zkZLxyXUe6R3
         eZJBBPkgXWJtDhcrNcVXUwV1jV3bewFwp/Taqp/1lvZcSzQ+ba7Tod98qRu/7oyrlO77
         UA9w/JqZ0MFJENN5oznqkTBQMPYdCVCIJFjgywpLw2dyQxdMtdiPAuCWFB3cCqSiUdLj
         cHyckCkmJTHysmHqGN8nSuwpv4IqFSSpcHRgE9XOVmHnD9sMYvXhLC93f/K7JJxjc6vK
         7tH8koQKSMuzq48RgD0B30LIube2fC+58iAxCg15yy/skqZocod5TJc6X7BJuF9LDbmA
         4jUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo5sXCw7vr9Rmj4qoSvUsN3hWJdvyUd7VMWReBSFNdggcDYG+12fQq9UEOzGN/KzLapxOCyWLG/XmpLZXO+0lpiKloUvQwPvEomu37jnBQhE/HH7LMDMFlCZ/oyNF50x14Bj6LsFZER65w
X-Gm-Message-State: AOJu0YzPuiVDGrEg4hYn13C1jHeq6fPKhjz6ee2wMiebaisVIAgwEY1B
	/tp5G2MmEXCYFXkaMrGZQZhg0Ix6DBH/1MrX0pBVpqLI+uAh8umU
X-Google-Smtp-Source: AGHT+IHQBTfVv+AwnkV2UWhKzFK8HrtmNhxtY3yc1BnDBMGvB+TDdd4Np2obziymLeO4kYrNJJYLvQ==
X-Received: by 2002:ac8:5fc1:0:b0:42e:1749:6c1f with SMTP id k1-20020ac85fc1000000b0042e17496c1fmr6357141qta.33.1708450169821;
        Tue, 20 Feb 2024 09:29:29 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id f15-20020ac8464f000000b0042db245d609sm3613440qto.86.2024.02.20.09.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:29:29 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A7FB11200066;
	Tue, 20 Feb 2024 12:29:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 20 Feb 2024 12:29:28 -0500
X-ME-Sender: <xms:eOHUZUreTJHiToJl1D2lmdrEcKP952ad15IbfD29Ooif6rkDIZnd7w>
    <xme:eOHUZao9n01qhwBH5tOeqlIKoGshLof6L-BApucRQ5L01ElKqgS5tDC_oadzrsC0r
    VCTcI-dH3kSDsEg5g>
X-ME-Received: <xmr:eOHUZZNVTFpTEtq3UEis6n8Ga31IlRNFsMacNMa8g3GRLzQ_0tpNMWMtEmoPFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:eOHUZb7tyamPce-_NozdpZKW1-jB70d7YFlA-6BtE5nCwGU4GF2d7g>
    <xmx:eOHUZT6y_uHm0nclCS-lJWl-hT4_GMGuXqFWGFQwP42WMYB5yetEQA>
    <xmx:eOHUZbg0pKPF3ANGmmhhfo1nLNM9JLSUNz8_WnlZJ2hMTbJEBRnFRw>
    <xmx:eOHUZWaGW5d3lQ-rrJPik7ToJ6Pr5gS5ZymG1TjRDA9gdgFABBPoUO1sj5Y>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 12:29:28 -0500 (EST)
Date: Tue, 20 Feb 2024 09:29:09 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Calculate ring buffer size for
 more efficient use of memory
Message-ID: <ZdThZUUmGhY2shrX@boqun-archlinux>
References: <20240213061959.782110-1-mhklinux@outlook.com>
 <20240220063007.GA17584@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220063007.GA17584@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Feb 19, 2024 at 10:30:07PM -0800, Saurabh Singh Sengar wrote:
> On Mon, Feb 12, 2024 at 10:19:59PM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > The VMBUS_RING_SIZE macro adds space for a ring buffer header to the
> > requested ring buffer size.  The header size is always 1 page, and so
> > its size varies based on the PAGE_SIZE for which the kernel is built.
> > If the requested ring buffer size is a large power-of-2 size and the header
> > size is small, the resulting size is inefficient in its use of memory.
> > For example, a 512 Kbyte ring buffer with a 4 Kbyte page size results in
> > a 516 Kbyte allocation, which is rounded to up 1 Mbyte by the memory
> > allocator, and wastes 508 Kbytes of memory.
> > 
> > In such situations, the exact size of the ring buffer isn't that important,
> > and it's OK to allocate the 4 Kbyte header at the beginning of the 512
> > Kbytes, leaving the ring buffer itself with just 508 Kbytes. The memory
> > allocation can be 512 Kbytes instead of 1 Mbyte and nothing is wasted.
> > 
> > Update VMBUS_RING_SIZE to implement this approach for "large" ring buffer
> > sizes.  "Large" is somewhat arbitrarily defined as 8 times the size of
> > the ring buffer header (which is of size PAGE_SIZE).  For example, for
> > 4 Kbyte PAGE_SIZE, ring buffers of 32 Kbytes and larger use the first
> > 4 Kbytes as the ring buffer header.  For 64 Kbyte PAGE_SIZE, ring buffers
> > of 512 Kbytes and larger use the first 64 Kbytes as the ring buffer
> > header.  In both cases, smaller sizes add space for the header so
> > the ring size isn't reduced too much by using part of the space for
> > the header.  For example, with a 64 Kbyte page size, we don't want
> > a 128 Kbyte ring buffer to be reduced to 64 Kbytes by allocating half
> > of the space for the header.  In such a case, the memory allocation
> > is less efficient, but it's the best that can be done.
> > 
> > Fixes: c1135c7fd0e9 ("Drivers: hv: vmbus: Introduce types of GPADL")
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  include/linux/hyperv.h | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index 2b00faf98017..6ef0557b4bff 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -164,8 +164,28 @@ struct hv_ring_buffer {
> >  	u8 buffer[];
> >  } __packed;
> >  
> > +
> > +/*
> > + * If the requested ring buffer size is at least 8 times the size of the
> > + * header, steal space from the ring buffer for the header. Otherwise, add
> > + * space for the header so that is doesn't take too much of the ring buffer
> > + * space.
> > + *
> > + * The factor of 8 is somewhat arbitrary. The goal is to prevent adding a
> > + * relatively small header (4 Kbytes on x86) to a large-ish power-of-2 ring
> > + * buffer size (such as 128 Kbytes) and so end up making a nearly twice as
> > + * large allocation that will be almost half wasted. As a contrasting example,
> > + * on ARM64 with 64 Kbyte page size, we don't want to take 64 Kbytes for the
> > + * header from a 128 Kbyte allocation, leaving only 64 Kbytes for the ring.
> > + * In this latter case, we must add 64 Kbytes for the header and not worry
> > + * about what's wasted.
> > + */
> > +#define VMBUS_HEADER_ADJ(payload_sz) \
> > +	((payload_sz) >=  8 * sizeof(struct hv_ring_buffer) ? \
> > +	0 : sizeof(struct hv_ring_buffer))
> > +
> >  /* Calculate the proper size of a ringbuffer, it must be page-aligned */
> > -#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(sizeof(struct hv_ring_buffer) + \
> > +#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(VMBUS_HEADER_ADJ(payload_sz) + \
> >  					       (payload_sz))

I generally see the point of this patch, however, it changes the
semantics of VMBUS_RING_SIZE() (similiar as Saurabh mentioned below),
before VMBUS_RING_SIZE() will give you a ring buffer size which has at
least "payload_sz" bytes, but after the change, you may not get "enough"
bytes for the vmbus ring buffer.

One cause of the waste memory is using alloc_pages() to get physical
continuous, however, after a quick look into GPADL, looks like it also
supports uncontinuous pages. Maybe that's the longer-term solution?

Regards,
Boqun

> >  
> >  struct hv_ring_buffer_info {
> 
> Thanks for the patch.
> It's worth noting that this will affect the size of ringbuffer calculation for
> some of the drivers: netvsc, storvsc_drv, hid-hyperv, and hyperv-keyboard.c.
> It will be nice to have this comment added in commit for future reference.
> 
> Looks a good improvement to me,
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> > -- 
> > 2.25.1
> > 

