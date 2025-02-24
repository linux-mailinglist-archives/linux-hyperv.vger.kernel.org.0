Return-Path: <linux-hyperv+bounces-4036-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F53A42EDF
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 22:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7928C1890F23
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE8D19259E;
	Mon, 24 Feb 2025 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqNDiC82"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADD1C84B7
	for <linux-hyperv@vger.kernel.org>; Mon, 24 Feb 2025 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431942; cv=none; b=CwRYvNF7MkaVwUSoBoBP3NgA+4KjTrMSK52mhJcNwbthnnDmdkkNNn97qgP86Dlt6eN3GpIjKlUy29vgMfaMahyCqV7gecrV9HPFyS2C0XSaI/FaMpLf9+9XwKNakiXFBZA1mrXsECnPlxkivIAu4CSQF8LrXOjxxlIJ+WJwYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431942; c=relaxed/simple;
	bh=/PQO7ZUzimjU555KfQCQmRzVBItJMZqfMDY7mblzjks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la/cNfgsW7wJpKX2+UVbvYnYFLFIzmbUN1EIC0V5ahwMdbD2TEktWPPnnnDFvtD7aQRF8wwMwzDqBeWfLYNnaagXpu5r25ZK0Qd1gPZKr9waDUIy27/+AUTX41k4fbH2wy9WRlAKrh6TGwG8SgmRzrHJHVBjrmdmSeAnZvfil0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqNDiC82; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740431939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4ChK7d4tTnyUI2qkV4nzn6rGiBQ0dJ69F8Ua/liB9M=;
	b=LqNDiC82vdKj1lUIj1FS67vvq8PZ5rplEr6vO1z6gyh/KpT6vwmkrV9Jgm5oGjlVUFEuKr
	mlHM0YPZY4UBNxw/fzWxblNHAdc4m2hbuHAHPnThiMrv0eLVsRUm2+qzrWC/xfd+N4kzUQ
	D4ZGHDulm68HHC1rOUnm7SFruY5cOWw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-zEXFDmWEPHa34AT9MpyUYg-1; Mon, 24 Feb 2025 16:18:57 -0500
X-MC-Unique: zEXFDmWEPHa34AT9MpyUYg-1
X-Mimecast-MFC-AGG-ID: zEXFDmWEPHa34AT9MpyUYg_1740431937
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e073b9cf96so3843059a12.0
        for <linux-hyperv@vger.kernel.org>; Mon, 24 Feb 2025 13:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431937; x=1741036737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4ChK7d4tTnyUI2qkV4nzn6rGiBQ0dJ69F8Ua/liB9M=;
        b=Odo2XveCv9CLuH3AAXUq/BjUwpWWBCtIYagSYa3SV4H/haApo62yWqla045LV67xGD
         0c8z+o+D2RYvzAFm7xk+VYCOeNW5T90Otfhlf/lEpNFdVBZYqFnEJW7HJfu4VBs35R0G
         M434zrSj89cnVHd8zKUpN84L+ZgbB2k+VHLgzzCVhYL1i58B7pV8+OgEmHZkxavUoAvA
         FoVQV8fLMbrZ3/TDEk9jAKot54h2rZhMr1DgeTnX93reovV1v9VsW5hbq1XSvw6Y+SVf
         ENEpShBCmp5eIS5XWeD7RKXeh9h4j14qcYwDB6ZxiJeLJt8oUqim6Q7gPe5fzXKBySPG
         lPVg==
X-Forwarded-Encrypted: i=1; AJvYcCUzHiTwoK62Tp3+z8vIUCLUX/S59dDs8zm5wxRUHjrpL5TNHuLcBstsHRWPrvyksNZXa/74NHo52oX9Dbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJoK26MX5N4AH6zJl63/VKDCqyZtIdPX0+drv0rnxgxVHli4B
	OSrqJ3Eq6E+A/oL905j7bDcAKYxlUKf1i5wppNK2mYO1NDNCexOQfjBN1011x6ycUuxdulH65pw
	E0GKy597G/IR5rNHJCcNBp1/5GcsnTeVXK88WtuAP71XNubeDzhB9gql4GbYMPw==
X-Gm-Gg: ASbGncsWrpTFmE0t9tzmArrVqSa7Qm34zdL/Xyr5aklwe0LUXNy1eTq9u3ge6VaW2eI
	TsizyhKQp8NteRyBijhpQg7JYK5GHZc3vZ6o7Ba5N2tLjzTsk//GUspUdFbM8LCqmMVS/ysS/eu
	oAsiiigM1qrHbKq77Bgj6d3zPKon3XUXAz2slDtz8p/URuqJhB/mTMIYZRYPKYYZjhhLIyVLWQV
	xo+CZdq30/1OmEdBHXA5JBPTaa4JXw3z47hOh/XpbcMpMR1hOTS//8ajOX8C9VWdWk9Ofvwpvuw
	nh5gmCzgBA==
X-Received: by 2002:a17:906:3151:b0:aba:5e50:6984 with SMTP id a640c23a62f3a-abc099ead3amr1385577866b.2.1740431936630;
        Mon, 24 Feb 2025 13:18:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYEBC44CLKnEsK0LbK9e6zpwdED/WRkdl8e2EWDOlyh5Ynisvb1G99K7KkazLO1N5pYn2zMA==
X-Received: by 2002:a17:906:3151:b0:aba:5e50:6984 with SMTP id a640c23a62f3a-abc099ead3amr1385570066b.2.1740431936166;
        Mon, 24 Feb 2025 13:18:56 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20134fdsm23497166b.94.2025.02.24.13.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:18:55 -0800 (PST)
Date: Mon, 24 Feb 2025 16:18:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH v2 00/13] cpumask: cleanup cpumask_next_wrap()
 implementation and usage
Message-ID: <20250224161832-mutt-send-email-mst@kernel.org>
References: <20250128164646.4009-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128164646.4009-1-yury.norov@gmail.com>

On Tue, Jan 28, 2025 at 11:46:29AM -0500, Yury Norov wrote:
> cpumask_next_wrap() is overly complicated, comparing to it's generic
> version find_next_bit_wrap(), not mentioning it duplicates the above.
> It roots to the times when the function was used in the implementation
> of for_each_cpu_wrap() iterator. The function has 2 additional parameters
> that were used to catch loop termination condition for the iterator.
> (Although, only one is needed.)
> 
> Since 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
> macro"), for_each_cpu_wrap() is wired to corresponding generic
> wrapping bitmap iterator, and additional complexity of
> cpumask_next_wrap() is not needed anymore.
> 
> All existing users call cpumask_next_wrap() in a manner that makes
> it possible to turn it to a straight and simple alias to
> find_next_bit_wrap().
> 
> This series replaces historical 4-parameter cpumask_next_wrap() with a
> thin 2-parameter wrapper around find_next_bit_wrap().
> 
> Where it's possible to use for_each_cpu_wrap() iterator, the code is
> switched to use it because it's always preferable to use iterators over
> open loops.
> 
> This series touches various scattered subsystems and To-list for the
> whole series is quite a long. To minimize noise, I send cover-letter and
> key patches #5 and 6 to every person involved. All other patches are sent
> individually to those pointed by scripts/get_maintainers.pl.
> 
> I'd like to move the series with my bitmap-for-next branch as a whole.


virtio-net changes are straight-forward, so

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v1: https://lore.kernel.org/netdev/20241228184949.31582-1-yury.norov@gmail.com/T/
> v2:
>  - rebase on top of today's origin/master;
>  - drop #v1-10: not needed since v6.14 @ Sagi Grinberg;
>  - #2, #3: fix picking next unused CPU @ Nick Child;
>  - fix typos, cleanup comments @ Bjorn Helgaas, Alexander Gordeev;
>  - CC Christoph Hellwig for the whole series.
> 
> Yury Norov (13):
>   objpool: rework objpool_pop()
>   virtio_net: simplify virtnet_set_affinity()
>   ibmvnic: simplify ibmvnic_set_queue_affinity()
>   powerpc/xmon: simplify xmon_batch_next_cpu()
>   cpumask: deprecate cpumask_next_wrap()
>   cpumask: re-introduce cpumask_next{,_and}_wrap()
>   cpumask: use cpumask_next_wrap() where appropriate
>   padata: switch padata_find_next() to using cpumask_next_wrap()
>   s390: switch stop_machine_yield() to using cpumask_next_wrap()
>   scsi: lpfc: switch lpfc_irq_rebalance() to using cpumask_next_wrap()
>   scsi: lpfc: rework lpfc_next_{online,present}_cpu()
>   PCI: hv: Switch hv_compose_multi_msi_req_get_cpu() to using
>     cpumask_next_wrap()
>   cpumask: drop cpumask_next_wrap_old()
> 
>  arch/powerpc/xmon/xmon.c            |  6 +--
>  arch/s390/kernel/processor.c        |  2 +-
>  drivers/net/ethernet/ibm/ibmvnic.c  | 18 +++++---
>  drivers/net/virtio_net.c            | 12 ++---
>  drivers/pci/controller/pci-hyperv.c |  3 +-
>  drivers/scsi/lpfc/lpfc.h            | 23 +++-------
>  drivers/scsi/lpfc/lpfc_init.c       |  2 +-
>  include/linux/cpumask.h             | 69 ++++++++++++++++++++---------
>  include/linux/objpool.h             |  7 ++-
>  kernel/padata.c                     |  2 +-
>  lib/cpumask.c                       | 37 +---------------
>  11 files changed, 81 insertions(+), 100 deletions(-)
> 
> -- 
> 2.43.0


