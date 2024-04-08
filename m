Return-Path: <linux-hyperv+bounces-1941-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B803789CDB2
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 23:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABBC283E46
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 21:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E114882B;
	Mon,  8 Apr 2024 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ySyZO//"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917E144D2F
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Apr 2024 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612312; cv=none; b=NgPeN0SxWxKdA/ckawBwLHBzVYcadOMy0A4l4DjxYtZIJM5ZgxC1H6pyDwaLr/tpw3DBU9Wfq6i6U1R9Pn6cK3DH2yCg7I4oTftjoR87bF9zgKfN0/qsBq3knwUiElSKQnOXF/gkZd1Cb4b92eAff0UOJt6O6aOyVGkuTS+cbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612312; c=relaxed/simple;
	bh=KY52t5SmcD33X1njIiCPQT2nlbfZxUYuE3YXh3Y14iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgqWGluMHzgqHjXVN5Gs0mmtYxN3sS+8rk4Y2qb86uvYF6vjnFB30KkaTfuKhfoq5QKnbTf8ADgY8vHdh6fgIfODgZyjOc+kyYW6FA54mEJlyZW9gnAF5WD2ugrEgEOQkSItVRfNlAdoJmzMi8hTxBtEd3hDkRiAY/CW5wTncYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ySyZO//; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d5ee54dcecso58653839f.0
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Apr 2024 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712612309; x=1713217109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMfPSpNtTsh6dXJQMFw9y71ouwbsnwGiuVvfGa0D6/g=;
        b=4ySyZO//uao39A6o5lRK3IZdm+cS/eoHOVLuegcLC0FltrHv/46KlXY85SSDc5mLE9
         eO6LN63ui8RhmwlKcOmbp7qJNWdUSSR9QZGN2BxW3HYwMXHLyBqmfn3CzHuNycqUhAdw
         s3v2E0naMbYCGshF2sFpq/re5zRHYQvAuyNSh+KTGYI58QmNISvALho1dLIK4PG/8Scx
         /GoqCzW487QEYoKDcRzWA/AMeq6wwfyfrozVP7l4jRgJC2aYXUxHb7PG5zEv3yHC812j
         r5+ykphqK1HsP1x/dgeSUrwoykFV/l2QkMdbg1K27AdILNn2Z5c5sUg9DLlqGqLSXCLV
         4Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612309; x=1713217109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMfPSpNtTsh6dXJQMFw9y71ouwbsnwGiuVvfGa0D6/g=;
        b=X/8AZwqOO7UnGV2NgqwvQ5jF+4jVux+6FXVXBWNFAzd9BsVgbzd0QmUYiMA8B/n/dh
         psGUISeoNr+WMJkbuZX2PSE0wsFAz1CMHSGrlTKcwPkjodnSkCR2EhFpMwbjMXNNOQlj
         3CJGwWp8M5YCi7drnCmXhfEJEBf0N7xCVyt2f8KzC50k7v/bIlsAJ5iHVpM2bGsfHg4t
         dIyWGzA/zWqLkJP0xM8ISrkBO6ngv3F2a80fi88PmciBGy+xRuxOOQS/+PSa8LswvZKD
         IH2mg6pl4oomG8FvH5YUTo+tVWWmhKSZxLOQ4hOVNqO93lysRKnw3vOKicHGwHWsoKR4
         WZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWkiw4Kc5SI5fqfahZtOZuh3lIPBZbD4fyBCbcvE4L1OnI7l07HkUxAt0t79iF5RQG4+j6Orkxv+vIWEkdXLRw4BeGsp+AHki98zvfr
X-Gm-Message-State: AOJu0YxI0B1Cg8Svfz6XYewL8bTMb60soRN/h2X9o5qe7AKUtTTOjbII
	lETKeRd23/0nxomqRm9m6fXCcM0RUxXwVrvilYmy+gbRdJRQA78kD6adM67JOg==
X-Google-Smtp-Source: AGHT+IEqoqkR5AWqou6onCNjn8vaNElyi1V6FD1NmKsITlpZWvsr/E3SBZIBNs73yi5+UHFFMvVmXg==
X-Received: by 2002:a05:6602:3f02:b0:7d5:c902:62ef with SMTP id em2-20020a0566023f0200b007d5c90262efmr11294477iob.13.1712612309089;
        Mon, 08 Apr 2024 14:38:29 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id bv24-20020a056638449800b0047a4a3e14b8sm2775504jab.174.2024.04.08.14.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:38:28 -0700 (PDT)
Date: Mon, 8 Apr 2024 21:38:26 +0000
From: Justin Stitt <justinstitt@google.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: Long Li <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 2/3] RDMA/mana_ib: Prefer struct_size over open coded
 arithmetic
Message-ID: <bvcyipeq22p3gtozzpb3jkmp2tcjgil2hru3ecussflroxiz2r@4nr3f7elpmvs>
References: <20240406142337.16241-1-erick.archer@outlook.com>
 <AS8PR02MB72375EB06EE1A84A67BE722E8B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72375EB06EE1A84A67BE722E8B022@AS8PR02MB7237.eurprd02.prod.outlook.com>

Hi,

On Sat, Apr 06, 2024 at 04:23:36PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "req" variable is a pointer to "struct mana_cfg_rx_steer_req_v2"
> and this structure ends in a flexible array:
> 
> struct mana_cfg_rx_steer_req_v2 {
> 	[...]
>         mana_handle_t indir_tab[] __counted_by(num_indir_entries);
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + size * count" in
> the kzalloc() function.
> 
> Moreover, use the "offsetof" helper to get the indirect table offset
> instead of the "sizeof" operator and avoid the open-coded arithmetic in
> pointers using the new flex member. This new structure member also allow
> us to remove the "req_indir_tab" variable since it is no longer needed.
> 
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/infiniband/hw/mana/qp.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index ef0a6dc664d0..4cd8f8afe80d 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -15,15 +15,13 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
>  	struct mana_port_context *mpc = netdev_priv(ndev);
>  	struct mana_cfg_rx_steer_req_v2 *req;
>  	struct mana_cfg_rx_steer_resp resp = {};
> -	mana_handle_t *req_indir_tab;
>  	struct gdma_context *gc;
>  	u32 req_buf_size;
>  	int i, err;
>  
>  	gc = mdev_to_gc(dev);
>  
> -	req_buf_size =
> -		sizeof(*req) + sizeof(mana_handle_t) * MANA_INDIRECT_TABLE_SIZE;
> +	req_buf_size = struct_size(req, indir_tab, MANA_INDIRECT_TABLE_SIZE);
>  	req = kzalloc(req_buf_size, GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;
> @@ -44,20 +42,20 @@ static int mana_ib_cfg_vport_steering(struct mana_ib_dev *dev,
>  		req->rss_enable = true;
>  
>  	req->num_indir_entries = MANA_INDIRECT_TABLE_SIZE;
> -	req->indir_tab_offset = sizeof(*req);
> +	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
> +					 indir_tab);
>  	req->update_indir_tab = true;
>  	req->cqe_coalescing_enable = 1;
>  
> -	req_indir_tab = (mana_handle_t *)(req + 1);
>  	/* The ind table passed to the hardware must have
>  	 * MANA_INDIRECT_TABLE_SIZE entries. Adjust the verb
>  	 * ind_table to MANA_INDIRECT_TABLE_SIZE if required
>  	 */
>  	ibdev_dbg(&dev->ib_dev, "ind table size %u\n", 1 << log_ind_tbl_size);
>  	for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++) {
> -		req_indir_tab[i] = ind_table[i % (1 << log_ind_tbl_size)];
> +		req->indir_tab[i] = ind_table[i % (1 << log_ind_tbl_size)];
>  		ibdev_dbg(&dev->ib_dev, "index %u handle 0x%llx\n", i,
> -			  req_indir_tab[i]);
> +			  req->indir_tab[i]);
>  	}
>  
>  	req->update_hashkey = true;
> -- 
> 2.25.1
> 

Thanks
Justin

