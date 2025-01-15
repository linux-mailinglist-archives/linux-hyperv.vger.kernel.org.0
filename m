Return-Path: <linux-hyperv+bounces-3684-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A43A12705
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 16:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A784188754D
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8B7580C;
	Wed, 15 Jan 2025 15:15:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863A24A7DB;
	Wed, 15 Jan 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954153; cv=none; b=kld3bfm7yyC9YKRaSb0z1OWAwbPhR81AYJ8pI8QkWFo/qXr1TxpudWFLxb/Omm1KluQCg3hahtTdkukqnERN3j8yxKz55IFbfThcXwB0o95spJArO5W3HiSrm4DIIw0B7BqXd2ZP+xx+N7CjBDXUIQpDFLoUPys+f0V5uNWPEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954153; c=relaxed/simple;
	bh=n3aedPDU58g9oi8jG7q6qNb6L07RnHv5DCH2ebVvDrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqV7LdaWHf1vrRlIFft+e6vEQRoFmTinleFhXQWhQ8NY9+PIZjKUaBOWInTPxqkn0+YQn3zUWwOEp7+JQiwz8qEIXWKb8MFyYjIFwzHWgecb4KhUizSXIVPJRL+3rpR/SbOpRUUyi+xFOr4uGCCjdVRPDKElsnx9JQtZG8zG2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1362698366b.1;
        Wed, 15 Jan 2025 07:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736954150; x=1737558950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxAdtxkE+UEREV6mcvRrNj4o4nik0aOIdra7qRiWZc4=;
        b=KV2Rf2PzVBpG+xmnig1IF++E6MrB71rpernBz3J+rGyEJ78ceCkFmW4VeuuSir6WyF
         OTp8Kg8MkI6FEBNZyudjUmzy6QlTgqJFhjzcpn8gv4yLiZA5/G1Vc5eQv+8aBsYSNdc8
         bWd7Bg29RMQrxtmPjWFNMntLAh8FgxOH0c7vT3WIgdLul0WUlbWB4IyFYzJUym0yVspP
         g17MMZOeADNoP7qeMo+4f2HRju2tbzIsx0O8PhRdHXYp/rcaWCOPU6iScYqe7bF7jDzg
         uGi1ZZiP0P/87gTfFTNOnYRBYVzbWi21Y7n9CMckDdP3SZGHOnjrCDCoBBMWC3FO9da+
         vtgA==
X-Forwarded-Encrypted: i=1; AJvYcCWSQiRllGvc/VL1706xc+Zh23ErH1mATkF5ojI/7rOvl8CJ1KF1RdcGSpq6HtU+8c1WWj8X1nfsGCaQpR2R@vger.kernel.org, AJvYcCX3RzZ5ByvPVam8vaC1jFVw57ZZC/O0SZZFrWQ79pN+2Dzb09+tORxPYhksBHf060U+7rM5ptKL@vger.kernel.org, AJvYcCXE/jsFShp20JmyxN5jm60k4ns4Fbyve1+jUM6683WOM6uDFZ2/qYcxhvNgKbVxxhhuVi1aNbl6mVIXZK/5@vger.kernel.org, AJvYcCXt8H8LnEQdwUdfedWp8yaPqEIwiAhsNc6CJRVzN8Wy0gOkdcS+5yxaAg4w1d8eoU7XYulGq1Ja2A/nz8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhZnLmwLnrBcoBzhEIReqRRofOVr3NWmcjxz7GxFRYdOWgKn8
	nqe0wTP5g1InJl0eKJ0v4BnJCbFGO0mCp4jPB86n97NCFwSTS8E/
X-Gm-Gg: ASbGncv4uk2D5+SJdBLMrG0HAOeiX7FwBnRe03UrQ4B/vOZNFv2jZkb5IFpJRZLqru/
	Yujxja28qApa+/ieZgxlgROecAPEmXA1RatzO+TIzUN0MCUAa1R4E64lf2uUJHVh+fPZIpj9ysa
	OcazGh5VvVSO5F2sg7noF6vjEZRVPwPyJL8P7kfxnAAKKEd/JGPnwVWSVvZ/esQQBei+4WLzWbE
	1nn7hY4aS0G2DuxcvJuRLq+zMDF3cn5sRI3yrK07NHE2n8=
X-Google-Smtp-Source: AGHT+IHiSCWa2oGdZdDLuvQ3qdU+v2LX5LzfGe//YSM+4KYGuK3X4yasIQ/H0OgC3CyaYs2W7qOEFA==
X-Received: by 2002:a17:907:3e24:b0:aac:2298:8960 with SMTP id a640c23a62f3a-ab2ab6fcf7amr2927968666b.35.1736954149465;
        Wed, 15 Jan 2025 07:15:49 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5da0aec6e7asm1101432a12.33.2025.01.15.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 07:15:48 -0800 (PST)
Date: Wed, 15 Jan 2025 07:15:46 -0800
From: Breno Leitao <leitao@debian.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, Tejun Heo <tj@kernel.org>,
	Hao Luo <haoluo@google.com>, Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [v3 PATCH] rhashtable: Fix rhashtable_try_insert test
Message-ID: <20250115-cordial-steadfast-perch-c4dfda@leitao>
References: <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
 <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
 <SN6PR02MB41577C2C4EB260F3D2D4F85FD41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4FXs8vAtitHIJyl@gondor.apana.org.au>
 <SN6PR02MB41570F1F5F4F579B4E8F0CD3D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4XWx5X0doetOJni@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4XWx5X0doetOJni@gondor.apana.org.au>

On Tue, Jan 14, 2025 at 11:15:19AM +0800, Herbert Xu wrote:
> On Fri, Jan 10, 2025 at 06:22:40PM +0000, Michael Kelley wrote:
> >
> > This patch passes my tests. I'm doing a narrow test to verify that
> > the boot failure when opening the Mellanox NIC is no longer occurring.
> > I also unloaded/reloaded the mlx5 driver a couple of times. For good
> > measure, I then did a full Linux kernel build, and all is good. My testing
> > does not broadly verify correct operation of rhashtable except as it
> > gets exercised implicitly by these basic tests.
> 
> Thanks for testing! The patch needs one more change though as
> moving the atomic_inc outside of the lock was a bad idea on my
> part.  This could cause atomic_inc/atomic_dec to be reordered
> thus resulting in an underflow.
> 
> Thanks,
> 
> ---8<---
> The test on whether rhashtable_insert_one did an insertion relies
> on the value returned by rhashtable_lookup_one.  Unfortunately that
> value is overwritten after rhashtable_insert_one returns.  Fix this
> by moving the test before data gets overwritten.
> 
> Simplify the test as only data == NULL matters.
> 
> Finally move atomic_inc back within the lock as otherwise it may
> be reordered with the atomic_dec on the removal side, potentially
> leading to an underflow.
> 
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Fixes: e1d3422c95f0 ("rhashtable: Fix potential deadlock by moving schedule_work outside lock")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Reviewed-by: Breno Leitao <leitao@debian.org>

> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index bf956b85455a..0e9a1d4cf89b 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -611,21 +611,23 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
>  			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
>  			data = ERR_PTR(-EAGAIN);
>  		} else {
> +			bool inserted;
> +
>  			flags = rht_lock(tbl, bkt);
>  			data = rhashtable_lookup_one(ht, bkt, tbl,
>  						     hash, key, obj);
>  			new_tbl = rhashtable_insert_one(ht, bkt, tbl,
>  							hash, obj, data);
> +			inserted = data && !new_tbl;
> +			if (inserted)
> +				atomic_inc(&ht->nelems);
>  			if (PTR_ERR(new_tbl) != -EEXIST)
>  				data = ERR_CAST(new_tbl);
>  
>  			rht_unlock(tbl, bkt, flags);
>  
> -			if (PTR_ERR(data) == -ENOENT && !new_tbl) {
> -				atomic_inc(&ht->nelems);
> -				if (rht_grow_above_75(ht, tbl))
> -					schedule_work(&ht->run_work);
> -			}
> +			if (inserted && rht_grow_above_75(ht, tbl))
> +				schedule_work(&ht->run_work);

That makes sense, since data could be ERR_PTR(-ENOENT) and ERR_PTR(-EAGAIN), and
the object being inserted, which means that nelems should be increased.

It was hard to review this patch, basically rhashtable_insert_one()
returns three type of values, and you are interested in only one case,
when the obj was inserted.

These are the type of values that is coming from
rhashtable_insert_one():

  1) NULL: if object was inserted OR if data is NULL
  2) Non error and !NULL: A new table to look at
  3) ERR: Definitely not added

I am wondering if we decoupled the first case, and only return NULL iff
the object was added, it would simplify this logic.

Something like the following (not tested):

	diff --git a/lib/rhashtable.c b/lib/rhashtable.c
	index 3e555d012ed60..5a0ec71e990ee 100644
	--- a/lib/rhashtable.c
	+++ b/lib/rhashtable.c
	@@ -554,7 +554,7 @@ static struct bucket_table *rhashtable_insert_one(
			return ERR_PTR(-EEXIST);

		if (PTR_ERR(data) != -EAGAIN && PTR_ERR(data) != -ENOENT)
	-               return ERR_CAST(data);
	+               return ERR_PTR(-EINVAL);

		new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
		if (new_tbl)


Thanks for fixing it,
--breno

