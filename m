Return-Path: <linux-hyperv+bounces-3683-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0BFA117F7
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 04:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D53A167C54
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 03:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15970155333;
	Wed, 15 Jan 2025 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfi1tIJz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869721DA21;
	Wed, 15 Jan 2025 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736912467; cv=none; b=OZdchNCwkV9PCjfeON7eWUVU6IZX6xFW9Bwhr8iJte36j0eoz3rXqan0LDyGwf2yjGVBAFB/rmkqX9hFcew59gRx48CqnGNWKsmNbSlaFeP19RZ70NT7g+74rX9+4KaxzjvsOFRiqTTeDc9ByG6scHgQ1dQZV3+ttdSbgKdbqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736912467; c=relaxed/simple;
	bh=lx1JoZuyAOvH+tAWIwuUhi8eFxOhxcAC6JbtgL/RLvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksz+t/egkHB6w4nNVEKUh1mw7QiLcQGySaFfozjrnw7w5Cz6oBxahRdQvS3LlHLwOJsw51HJNigebXlwoNV3WqfYE76tx2wwYMqNO0CKl29hx02GwbzZc1FGe+F0n4QZvWOn8DflymYssOn7OnREUGz3Ua68jZQfMdRvAO9nZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hfi1tIJz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so8887064276.2;
        Tue, 14 Jan 2025 19:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736912464; x=1737517264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmTK2k4vF2mqctoCssOfytU8KQ/2i1ya8c1dPxSZwZk=;
        b=Hfi1tIJzaEvPFCF3le0hG16EY7Fxb+IXk/gRu+vZg4lY2/6XkXEUwOdf7EDudX9O5S
         l3ZiMs/teaAUbwlHUqIgRLnsKrQlyGRjoZMNHcvHs39tF2qO9yaTvsNpa7pEG/7NbXZu
         yHRw3ex0rW5dg7uiWnPYawBP6Z2aLBm0W7xeCNgfXrllv8GstTVQ61S1km2knGwH3pL+
         P2xuL3xDj8rUT32jQIyPJEn8dAZKLF0LDLPDa5T9EwlG3ag9bRmkF/8qZshbPMnJbNiG
         Yg+vt9KYRiQAOkkPpAiPEtpnxeC4zx9JRDqaM3E4IUPvSgqLZVOrNEd5X9ysJWeF1U4N
         4D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736912464; x=1737517264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmTK2k4vF2mqctoCssOfytU8KQ/2i1ya8c1dPxSZwZk=;
        b=vKcg/R8sEpuiHKJNYCPAFgiginzJ3OmNrlVW33+LaF4TK0+ykHFKMDWHCQBdvoIDa4
         4IQNET3FM9biKXtu70I7uCLevdR5RgXkgYLVQn/3fftMezX3W0MXKuReuCTOAzfGRXsU
         rVDgtyaeZ0kbQjgGxWfzZhaPHzt8JNeBMzjk0gbW15YnisDUZFlAlR8JJrM3+2pimjMw
         TGK7jFyW4rqq8Z+GmuWsNN8v+wPnTA2S3+NdEnJhLBRzrg5OpNSlU/zlSBufTWYs/vkk
         V9+tm6wtBYt8j1Uh2yMM80NxaoI4WyKoPKF75UFPNaJfVOtLNcsbfC5Ua77YeaLVUXU2
         /wCA==
X-Forwarded-Encrypted: i=1; AJvYcCV8pAq8hhU4/KpZnBa9jssjz1OfsIENEpT4uGJixhiuWrgdbIxy8Q9YFATugmcDtMj9OODiAwfjm+YakDs=@vger.kernel.org, AJvYcCVE/cBO4NuCblNuIAp0te19QAVq2Mh3exPL1kxmDj4/gteUqVT1nzvIA43xhkjMuFnd2AITjIO3qkwcob11@vger.kernel.org, AJvYcCVhyiPIP3p5j2Q0ZrUf7XW66dJagBJs5QWtolJj3aVvoQYlJOcLNT7/JRMV2642GEJKgaNod9Ct@vger.kernel.org, AJvYcCVteOQXqbo5nrtqZKvsWurnqAlEWkNwDdpOAIuGa7zYbdsi5OVJ6kg4oI+iZheNbsxj5pNGqsLIT1w8dQ==@vger.kernel.org, AJvYcCWd9AiKX1Hfg817o4P+AIPGXczWQyGn77IZOEZbREv7iB9cWabU5PQRtD97e4JOqmZtz+Yh6iu/9KwnRg==@vger.kernel.org, AJvYcCXV+z7h/strYjt1ouDU01tF3sN4eh0U3Hime3YrIF8Sfky4EEaKVomWadIpL83CIJwzN3Av8/zEFx3V@vger.kernel.org
X-Gm-Message-State: AOJu0YwbhxAL0+uFTeFvbJklRveEqLShOylFBsqfz2tf1ZMUuuLNsMNm
	bv1XxrMLEfMXARXzgWR/7fL6GW5F5+oq4YP29kK1FHU4kbaPt4zA
X-Gm-Gg: ASbGncvOtNq/6VbtG7ovVdBVU26FTa69d7MnAcWdUUqbJdmCY3ctNEbbo+ZXVggnsZH
	mTV7eT52Pb1I0TznzBqtp+QnZ6yLbsWCcTAAFTMIt6BROTJGZg78MHaE6k7Yd6lYFXTtNC7DEZX
	v0prpdhq1Z+8Ze5lka1uP6Lm40NtTxOjvKRsLZ85HrN+9W6+OVuP3yt/zYoO3oW6ttRB2RuwT6E
	iDWTiqL+Q1gfJbdD2c5o7diouivUgz/0Jhs9kZqdUIp365cIuUd2V2Z
X-Google-Smtp-Source: AGHT+IGlCnPNZfANCVJooif/vwR9Wcfdn14fNs9Squ/CXSzhwHBTvNfC1cp1ga3/es5eAiOB92QKfQ==
X-Received: by 2002:a05:690c:45c9:b0:6f6:cad6:6b5a with SMTP id 00721157ae682-6f6cad66c84mr8171767b3.13.1736912464441;
        Tue, 14 Jan 2025 19:41:04 -0800 (PST)
Received: from localhost ([2601:347:100:5ea0:e12f:d330:c8d6:a6b7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6c93732c9sm1796417b3.103.2025.01.14.19.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:41:03 -0800 (PST)
Date: Tue, 14 Jan 2025 22:41:02 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	"Michael S. Tsirkin" <mst@redhat.com>,
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
Subject: Re: [PATCH 06/14] cpumask: re-introduce cpumask_next{,_and}_wrap()
Message-ID: <Z4cuTsHbO6yiuFKA@thinkpad>
References: <20241228184949.31582-7-yury.norov@gmail.com>
 <20250103174432.GA4182129@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103174432.GA4182129@bhelgaas>

On Fri, Jan 03, 2025 at 11:44:32AM -0600, Bjorn Helgaas wrote:
> On Sat, Dec 28, 2024 at 10:49:38AM -0800, Yury Norov wrote:
> > cpumask_next_wrap_old() has two additional parameters, comparing to it's
> > analogue in linux/find.h find_next_bit_wrap(). The reason for that is
> > historical.
> 
> s/it's/its/
> 
> Personally I think cscope/tags/git grep make "find_next_bit_wrap()"
> enough even without mentioning "linux/find.h".
> 
> > + * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
> > + *			   @n and wrapping around, if needed
> > + * @n: the cpu prior to the place to search (i.e. return will be > @n)
> 
> Is the return really > @n if it wraps?

No, this is a copy-paste error. Will fix in v2.

Thanks,
Yury

