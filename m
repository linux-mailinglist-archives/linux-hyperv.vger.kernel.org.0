Return-Path: <linux-hyperv+bounces-1595-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4722C86695A
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Feb 2024 05:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0294283207
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Feb 2024 04:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09181199DC;
	Mon, 26 Feb 2024 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhUMw5zz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256311759F;
	Mon, 26 Feb 2024 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921558; cv=none; b=PqUXmsm+qWIe31ZqzOOyJ4y8DF9i/igOPkJeaavUKP9XK0kWS1bpjH11m9+P12KAy/xBn8ssDm95yThgEIv0mXa0+zdhv9AoYDZCmwuEaKtf9AkyKRNHvU7MzF4w1lwODifYkPEJnkiks3Psp9j87gN+VQF2nqKtspx1HO+0yUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921558; c=relaxed/simple;
	bh=v3SlkIW6y6ipn1NCWJZvMnmhDwH0Fh2zjcrmBtZ0vWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNTPKlzbZvQ50oNpDm49XaX80lVFKIu0REKx0MARwCjez2nT2X2bCmwTeOqSfg0QdqhPyhSdesKTANvzJbLg5T2UALuy/mkqbDw1Qv+LXe2jXvF79m0k2hhIQfqtdDhBFhx2zf9QO8p4dvHGtqyUNEY0RkJKH0zRGmdeyGAsy9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhUMw5zz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-787aca0b502so85563585a.1;
        Sun, 25 Feb 2024 20:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708921556; x=1709526356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW6Gg9E4iphRs2T7njr0TuJitmVKKihxKcXnC4puSug=;
        b=DhUMw5zzGr6ThqogwfYEY+SFnPv0YsGgobL0ItCp7cyZzJj/Yq7lAxmelVytHT3xhy
         lTDDGlSJTmO8ebwvh5oIBIM76brt4PwuynPuCBrYWLH7yoXhpaJ/vB+yfM41E4ffPRqs
         T3rhHPUTSTz0MO3rbhi4KYluhR8PdPAT/UCz3OtpG90g5m3UwLt1opQyQKsyyHlGmaBc
         GauwvP7J+YNeJtkb8m/7wWMQsvMCtRIAKnzT3+86t1eWvOJagTxY4oKZeb4yh6AVBtQ7
         4phTrP6LgLyuYECSpADufU+DTlFo2B+S1VVRsOOuXab9oFbOdi20IkiJQVo7f7S6uFL7
         aWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708921556; x=1709526356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DW6Gg9E4iphRs2T7njr0TuJitmVKKihxKcXnC4puSug=;
        b=DJeBEMwfEJczk8KK9JJ2eIRK3Gs9Z463TE/XV6J3vCiP9t3yGQbn/jgdg4gyzIIF2m
         wkY9djPlzwRzqXB1Aod1MmYX6nlDiE1sLaa6h9TKnzKT6EbdfDHasrxzN25BPN6bMm3V
         wtcSBkko0JVZRWLLVhjgE1vnHludy7ORh9VsK74eELjAJeX1/KJneyGcpTWd7UjR+SKI
         M+jLwIXDoSBaWLTGKI7LeVF3hXldiQFC0rrV18hlJIIGUCH54QREXH51gf7ltiNLOIdi
         xkrjudAk9k3VNd7mglnvQjLcp2NC1nFHKABMpIM0S8A4wtdwEMAKSI2NiwV3E7qlkxQP
         YzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUopUs1xIjeNpT2qH9O2k/BBWVyxumy0EY/0xlrC84GarMsWqW4LFZ+KDlML+Q14duGSxPB947CfYkHcGhPYSsFIBIS1S8pqFCvILqQHdOqxPBfs3txx4sQql81bxFiqDUlZo/WdOl5uzv
X-Gm-Message-State: AOJu0Yx3YGG6hR9LxmUKhFJMH/j582s5qiLYupu4PmXeszgWrHynHatN
	9V2J+euOhGFuApPbCo3UTnyWB42MHWubVABloHRALJr8OFOIri7D
X-Google-Smtp-Source: AGHT+IGYaQcZ1vWogncOvxWsM9WKWJ+6gvzLlVFfgpW+6iUYYpa0BdswfIujonfVUEwjHkIfPJ3kNw==
X-Received: by 2002:a05:620a:359:b0:787:6f72:2080 with SMTP id t25-20020a05620a035900b007876f722080mr7142934qkm.26.1708921556012;
        Sun, 25 Feb 2024 20:25:56 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q7-20020ae9e407000000b00787ba4095dfsm2095596qkc.32.2024.02.25.20.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 20:25:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 30DE327C005B;
	Sun, 25 Feb 2024 23:25:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 25 Feb 2024 23:25:55 -0500
X-ME-Sender: <xms:0hLcZSpIruUxrsIZhXxsTAHp1cXx8ri1j2uPUuBRUT1aGvIl36eRtw>
    <xme:0hLcZQqSuJrnoDBXKETvEErpVTxs4s_vgZ1XMvVLfB5h2-M7kJxSdFF9QqRPSgz5F
    YIz1JXthXq6Ze-IXg>
X-ME-Received: <xmr:0hLcZXOCY_iRRN9adBSHNc6jtvViOygW0yzs3iIR6ciKIbAXe16fh3aRJ2Z1nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedugdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0xLcZR5JeWoYCVt-AiVOWgGULFcdXKgKKxYsmGRvtBAf7YG5QAqxlA>
    <xmx:0xLcZR7aQPXkQzLUSg_UD0UPDX2PHuI6LU2f8VKTHNghR1hziMOa8A>
    <xmx:0xLcZRhvIkm-FhxBNHYXLiMce1h8Or_xgedGK2vsCzUoCcxiQREVbQ>
    <xmx:0xLcZcay8pjfLjb86FaYIe0Nq4_GUDGxmwRD5yZ03hK-HGIIEpuYAA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Feb 2024 23:25:54 -0500 (EST)
Date: Sun, 25 Feb 2024 20:25:20 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Calculate ring buffer size for
 more efficient use of memory
Message-ID: <ZdwSsH9bz05XztOb@boqun-archlinux>
References: <20240213061959.782110-1-mhklinux@outlook.com>
 <20240220063007.GA17584@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZdThZUUmGhY2shrX@boqun-archlinux>
 <SN6PR02MB4157CF4A309971B21296D465D4502@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157CF4A309971B21296D465D4502@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Feb 20, 2024 at 06:15:52PM +0000, Michael Kelley wrote:
> From: Boqun Feng <boqun.feng@gmail.com> Sent: Tuesday, February 20, 2024 9:29 AM
> > 
> > On Mon, Feb 19, 2024 at 10:30:07PM -0800, Saurabh Singh Sengar wrote:
> > > On Mon, Feb 12, 2024 at 10:19:59PM -0800, mhkelley58@gmail.com wrote:
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > >
> > > > The VMBUS_RING_SIZE macro adds space for a ring buffer header to the
> > > > requested ring buffer size.  The header size is always 1 page, and so
> > > > its size varies based on the PAGE_SIZE for which the kernel is built.
> > > > If the requested ring buffer size is a large power-of-2 size and the header
> > > > size is small, the resulting size is inefficient in its use of memory.
> > > > For example, a 512 Kbyte ring buffer with a 4 Kbyte page size results in
> > > > a 516 Kbyte allocation, which is rounded to up 1 Mbyte by the memory
> > > > allocator, and wastes 508 Kbytes of memory.
> > > >
> > > > In such situations, the exact size of the ring buffer isn't that important,
> > > > and it's OK to allocate the 4 Kbyte header at the beginning of the 512
> > > > Kbytes, leaving the ring buffer itself with just 508 Kbytes. The memory
> > > > allocation can be 512 Kbytes instead of 1 Mbyte and nothing is wasted.
> > > >
> > > > Update VMBUS_RING_SIZE to implement this approach for "large" ring buffer
> > > > sizes.  "Large" is somewhat arbitrarily defined as 8 times the size of
> > > > the ring buffer header (which is of size PAGE_SIZE).  For example, for
> > > > 4 Kbyte PAGE_SIZE, ring buffers of 32 Kbytes and larger use the first
> > > > 4 Kbytes as the ring buffer header.  For 64 Kbyte PAGE_SIZE, ring buffers
> > > > of 512 Kbytes and larger use the first 64 Kbytes as the ring buffer
> > > > header.  In both cases, smaller sizes add space for the header so
> > > > the ring size isn't reduced too much by using part of the space for
> > > > the header.  For example, with a 64 Kbyte page size, we don't want
> > > > a 128 Kbyte ring buffer to be reduced to 64 Kbytes by allocating half
> > > > of the space for the header.  In such a case, the memory allocation
> > > > is less efficient, but it's the best that can be done.
> > > >
> > > > Fixes: c1135c7fd0e9 ("Drivers: hv: vmbus: Introduce types of GPADL")
> > > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > > ---
> > > >  include/linux/hyperv.h | 22 +++++++++++++++++++++-
> > > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > > > index 2b00faf98017..6ef0557b4bff 100644
> > > > --- a/include/linux/hyperv.h
> > > > +++ b/include/linux/hyperv.h
> > > > @@ -164,8 +164,28 @@ struct hv_ring_buffer {
> > > >  	u8 buffer[];
> > > >  } __packed;
> > > >
> > > > +
> > > > +/*
> > > > + * If the requested ring buffer size is at least 8 times the size of the
> > > > + * header, steal space from the ring buffer for the header. Otherwise, add
> > > > + * space for the header so that is doesn't take too much of the ring buffer
> > > > + * space.
> > > > + *
> > > > + * The factor of 8 is somewhat arbitrary. The goal is to prevent adding a
> > > > + * relatively small header (4 Kbytes on x86) to a large-ish power-of-2 ring
> > > > + * buffer size (such as 128 Kbytes) and so end up making a nearly twice as
> > > > + * large allocation that will be almost half wasted. As a contrasting example,
> > > > + * on ARM64 with 64 Kbyte page size, we don't want to take 64 Kbytes for the
> > > > + * header from a 128 Kbyte allocation, leaving only 64 Kbytes for the ring.
> > > > + * In this latter case, we must add 64 Kbytes for the header and not worry
> > > > + * about what's wasted.
> > > > + */
> > > > +#define VMBUS_HEADER_ADJ(payload_sz) \
> > > > +	((payload_sz) >=  8 * sizeof(struct hv_ring_buffer) ? \
> > > > +	0 : sizeof(struct hv_ring_buffer))
> > > > +
> > > >  /* Calculate the proper size of a ringbuffer, it must be page-aligned */
> > > > -#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(sizeof(struct hv_ring_buffer) + \
> > > > +#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(VMBUS_HEADER_ADJ(payload_sz) + \
> > > >  					       (payload_sz))
> > 
> > I generally see the point of this patch, however, it changes the
> > semantics of VMBUS_RING_SIZE() (similiar as Saurabh mentioned below),
> > before VMBUS_RING_SIZE() will give you a ring buffer size which has at
> > least "payload_sz" bytes, but after the change, you may not get "enough"
> > bytes for the vmbus ring buffer.
> 
> Storvsc and netvsc were previously not using VMBUS_RING_SIZE(),
> so space for the ring buffer header was already being "stolen" from
> the specified ring size.  But if this new version of VMBUS_RING_SIZE()
> still allows the ring buffer header space to be "stolen" from the
> large-ish ring buffers, I don't see that as a problem.  The ring buffer
> sizes have always been a swag value for the low-speed devices with
> small ring buffers.  For the high-speed devices (netvsc and storvsc)
> the ring buffer sizes have been somewhat determined by perf
> measurements, but the ring buffers are much bigger, so stealing
> a little bit of space doesn't have any noticeable effect.  Even with
> the perf measurements, the sizes aren't very exact. Performance
> just isn't sensitive to the size of the ring buffer except at a gross level.
> 

Fair enough.

> > 
> > One cause of the waste memory is using alloc_pages() to get physical
> > continuous, however, after a quick look into GPADL, looks like it also
> > supports uncontinuous pages. Maybe that's the longer-term solution?
> 
> Yes, that seems like a desirable long-term solution.  While the GPADL
> code handles vmalloc memory correctly (because the netvsc send and
> receive buffers are vmalloc memory), hv_ringbuffer_init() assumes
> physically contiguous memory.  It would need to use vmalloc_to_page()
> in building the pages_wraparound array instead of just indexing into
> the struct page array.  But that's an easy fix.  Another problem is the
> uio_hv_generic.c driver, where hv_uio_ring_mmap() assumes a physically
> contiguous ring. Maybe there's a straightforward way to fix it as well,
> but it isn't immediately obvious to me.
> 
> Using vmalloc memory for ring buffers has another benefit as well.
> Today, adding a new NIC to a VM that has been running for a while
> could fail because of not being able to allocate 1 Mbyte contiguous
> memory for the ring buffers used by each VMBus channel.  There
> could be plenty of memory available, but fragmentation could prevent
> getting 1 Mbyte contiguous.  Using vmalloc'ed ring buffers would
> solve this problem.
> 

Yep, that will be ideal.

Regards,
Boqun

> Michael
> 
> > 
> > Regards,
> > Boqun
> > 
> > > >
> > > >  struct hv_ring_buffer_info {
> > >
> > > Thanks for the patch.
> > > It's worth noting that this will affect the size of ringbuffer calculation for
> > > some of the drivers: netvsc, storvsc_drv, hid-hyperv, and hyperv-keyboard.c.
> > > It will be nice to have this comment added in commit for future reference.
> > >
> > > Looks a good improvement to me,
> > > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > >
> > > > --
> > > > 2.25.1
> > > >

