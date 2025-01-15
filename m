Return-Path: <linux-hyperv+bounces-3682-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344BAA117E7
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 04:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5010E1889E1E
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 03:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC9122E3F8;
	Wed, 15 Jan 2025 03:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnFeAKDc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F214A0BC;
	Wed, 15 Jan 2025 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736912315; cv=none; b=Rj3jt64ivy9NEsXjwnSHd6d407/jc8Eh1w7uc1uW0ARZzAMXLLrpGYY7FbDTgwjJFzgjC6sQILx6HDLb5Juv7gzuFpemnQvkC/OiJBVn4uRAhSJBMK4JKtZ1tcS9aPcDwq9GZ42qQ2hmfM394/+meNTrYcP2foztqWZODI5zGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736912315; c=relaxed/simple;
	bh=gN06EUNT97ngcgK4V6x/fRnJvp2euBs+cFhJIU8hNis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3aCxP1EUquptVUIFxP3ItWXUb4NQowcXwrJXUHvLWlz5Q1X9AhKV8CICvAAIQsFcuTjt0tDag1IQg/yFtIJhZvK7E0SGVcrvKcGadFfnf4HnhBOTUsrXMMM+3BvfCbUeVVw6y8PulmNQxTHmpgNojEVRfWFf7+r0oSFvTr5vDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnFeAKDc; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e54d268bc3dso11146433276.1;
        Tue, 14 Jan 2025 19:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736912313; x=1737517113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggG1Vuf9tiZ0JKZNDTMJJvN8O1nAUNZ5coZeOdFCGi0=;
        b=mnFeAKDcxT3oG/sDf+Ds13LeBgdOjgifrc5Ap8N5qcujmADGqD6CzfyR2g6j1qtUPs
         yQqDDoHvQZ5tX5FioRw8pWiae/sQT2bV2rsfWzSkgh1AQ35XiJ4Ka5q3zsbFAUrf6ygr
         rqPc68ZI20aZvC8z2QAJKR8NU6QxOm8RdwiBJLYpUG7Mxc3g4hTz1/sVPx8EtvLhmvsn
         Yvr+7jRQB3P/FkC+mX4arXdX3AT65DIBaCvfU8gDRjZrYhne53JEW2b9IN3F7BRSWhE1
         J/xk+r/WFkcHtmTnkB2j8jRF67QnnBT/3RwHZYVefErenCfIrEByCxXrT8tDUuKZg1r9
         5vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736912313; x=1737517113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggG1Vuf9tiZ0JKZNDTMJJvN8O1nAUNZ5coZeOdFCGi0=;
        b=cwqINFkx03XZTYmuEGCqaCVh7XuH7SfUHiYRJsxC0DcCDXp/uytIj3xqbOGl+ufbN4
         gTNqhe90D/IO2aiz2ycILknt3MisMgmFXt7lbrQEtO5Yw0XH0mk5NZdbKjdBoUyOycVX
         bwlTgRhVxcE//BOHVDKj8bj3S5M9iOMkNcbemSsC9343L9fFVC4s0q6OnGw7QecSCPpQ
         W8j31cIIxS94R0D3DRwKrls7/oRKg5JWnXMz857j5iazVKkZLL3c0RCPmyeN2sbnVdzq
         eQvI/UDEBNJ725mQCpQQXj2K0eZUfvOpVei9a8Bpmwrgue4urPzriXQ986puHSl6RJuA
         TyxA==
X-Forwarded-Encrypted: i=1; AJvYcCV5aPGjixjM28kstlR2DxEvu5NGwobMWmfPq2+LFvZbVg9uYyC5YuFhA5j3mKEEhQJkRzFB9KMPiZSyjA==@vger.kernel.org, AJvYcCVTvvETJJL79L632NLzO5A62h0lY1eFh94n/3LwezXgWj9NXHIY0qgo9nQ5+91j5HVyyCTaOpxjTjhbkg==@vger.kernel.org, AJvYcCWEvl80RPOIKRSM14TVIIaei6h5Vq+cCoHb6NOMuMEqia4UiawIatdEMnrDfe/KD+sZgOik6BPD6bbmJte+@vger.kernel.org, AJvYcCWRirQTNb5EU+Mvh4+4aq7lzMM987+ifz0fhzzdGSNR2w1KyJTk6y+wH5weVrcT+kYGzjkzQe5tCCvG@vger.kernel.org, AJvYcCXmijoXodwXJJaMkKtCl4aa4tdc4qP3bUucTwkcFlCVYV5DD7BW/yTVnyf2d6Y1e1i5djUa8/1m/8Og7+s=@vger.kernel.org, AJvYcCXsWJRLViMerI0+qRvBNGsoBZyf+va81IItCtvQFY/71zSkYDnZemJrRtEnFzz3PQXv6x7LOiz4@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNHcuRwie5Y5V7Ymp2RdrV+R2YZAoHKFF2ylYh6tgOc1e9bKx
	LKCrwBNGmAYzkTI06WjJ5YuJ7eQf4Z/J6KhlYgXtoFcGed44cR1o
X-Gm-Gg: ASbGnctNkodeSO1I3knsfOIZzIhQ53tzTNzxsuH4JWhPdyxjwmL4eXxghn41Uq3kYzX
	TCyS25UgKTe0oYqYpZFHUxOi8noXdWNqdq3QGpgoYKqACGFPPIXdCinv+6444SBNRuOeigREfkM
	Ih6ZhA1Doi2Bs8aDSIGzt3pazKEvMNDZYIUKPWZ/oDTTO6E6oXnYVRkloZHs4iazLUqVK9RV2qc
	b2gg8MUtQ6vFLyiqEY5/HWRmfIVmH+kUpbFexPN7CH03I+lOe1CY9kq
X-Google-Smtp-Source: AGHT+IGcxF5UAr9VMjmEWcxKQm1jPE9VpwQlX4HhGZHkGGwOlZgKnKfAZqEBywSv8uk39tmS/FGABQ==
X-Received: by 2002:a05:690c:62ca:b0:6ef:7d51:eba6 with SMTP id 00721157ae682-6f5312a8384mr216747977b3.28.1736912312722;
        Tue, 14 Jan 2025 19:38:32 -0800 (PST)
Received: from localhost ([2601:347:100:5ea0:e12f:d330:c8d6:a6b7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546dd712esm23854477b3.79.2025.01.14.19.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:38:31 -0800 (PST)
Date: Tue, 14 Jan 2025 22:38:30 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
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
Message-ID: <Z4cttq0dfHnapkUI@thinkpad>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20241228184949.31582-7-yury.norov@gmail.com>
 <Z30r/6S8VBU8/Ml5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z30r/6S8VBU8/Ml5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Tue, Jan 07, 2025 at 02:28:31PM +0100, Alexander Gordeev wrote:
> On Sat, Dec 28, 2024 at 10:49:38AM -0800, Yury Norov wrote:
> 
> Hi Yury,
> 
> > cpumask_next_wrap_old() has two additional parameters, comparing to it's
> > analogue in linux/find.h find_next_bit_wrap(). The reason for that is
> > historical.
> > 
> > Before 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
> > macro"), cpumask_next_wrap() was used to implement for_each_cpu_wrap()
> > iterator. Now that the iterator is an alias to generic
> > for_each_set_bit_wrap(), the additional parameters aren't used and may
> > confuse readers.
> > 
> > All existing users call cpumask_next_wrap() in a way that makes it
> > possible to turn it to straight and simple alias to find_next_bit_wrap().
> > 
> > In a couple places kernel users opencode missing cpumask_next_and_wrap().
> > Add it as well.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/cpumask.h | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index b267a4f6a917..18c9908d50c4 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -284,6 +284,43 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
> >  		small_cpumask_bits, n + 1);
> >  }
> >  
> > +/**
> > + * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
> > + *			   @n and wrapping around, if needed
> > + * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > + * @src1p: the first cpumask pointer
> > + * @src2p: the second cpumask pointer
> > + *
> > + * Return: >= nr_cpu_ids if no further cpus set in both.
> > + */
> > +static __always_inline
> > +unsigned int cpumask_next_and_wrap(int n, const struct cpumask *src1p,
> > +			      const struct cpumask *src2p)
> > +{
> > +	/* -1 is a legal arg here. */
> > +	if (n != -1)
> > +		cpumask_check(n);
> > +	return find_next_and_bit_wrap(cpumask_bits(src1p), cpumask_bits(src2p),
> > +		small_cpumask_bits, n + 1);
> > +}
> > +
> > +/*
> > + * cpumask_next_wrap - get the next cpu in *src, starting from
> > + *			   @n and wrapping around, if needed
> 
> Does it mean the search wraps a cpumask and starts from the beginning
> if the bit is not found and returns >= nr_cpu_ids if @n crosses itself?
> 
> > + * @n: the cpu prior to the place to search
> > + * @src: cpumask pointer
> > + *
> > + * Return: >= nr_cpu_ids if no further cpus set in both.
> 
> It looks like Return is a cpumask_next_and_wrap() comment leftover.
> 
> > + */
> > +static __always_inline
> > +unsigned int cpumask_next_wrap(int n, const struct cpumask *src)
> > +{
> > +	/* -1 is a legal arg here. */
> > +	if (n != -1)
> > +		cpumask_check(n);
> > +	return find_next_bit_wrap(cpumask_bits(src), small_cpumask_bits, n + 1);
> > +}
> > +
> >  /**
> >   * for_each_cpu - iterate over every cpu in a mask
> >   * @cpu: the (optionally unsigned) integer iterator
> 
> Thanks!

Thanks, I'll update the comments.

