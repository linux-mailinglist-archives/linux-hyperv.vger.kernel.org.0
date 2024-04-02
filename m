Return-Path: <linux-hyperv+bounces-1908-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA62895C11
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 20:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A111C222F4
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F815B542;
	Tue,  2 Apr 2024 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQrhZB8K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFB15B12B;
	Tue,  2 Apr 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084297; cv=none; b=KGcAToEmwKnhbRkNEdCrnWiXKfua1jxxgJ3+7HUpoHcnUuBpRB8FnSMu5khg2aQJ29Jvo7N+SqpWk//aA6IZGatvjc0LlcwzuclgzBUEKo6aK1N/60C5iKl7ZNmOj+BbCja3D2gkMWZT412AZLKHxoPiQkii1C59vJfsTcjEOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084297; c=relaxed/simple;
	bh=xI0XkLqDmTTDw8K3HitXSr6Xh/VlRNLcxQkWF3FVZU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbMsm/Gqs9NnhILZSCOZOuCVE+OFkzkxVz17D0/TESSaVD7Tx6kRp+9lNli637grtWHS+8Qqym7D1YlXJp59HVslG/c8pYfNGC79kRiuHf37R3ULH8t0VVODkQ099pC9aH+HeB1ZXTOwtOlEFHz4DIWIotCVkzHDSGEPs2yBf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQrhZB8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D96C433C7;
	Tue,  2 Apr 2024 18:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712084296;
	bh=xI0XkLqDmTTDw8K3HitXSr6Xh/VlRNLcxQkWF3FVZU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQrhZB8KtQi+IyLI6OJJaahwas93p+FcxStqrmL2aT9HDh4VgpDnuhd0PBafULf5Q
	 yRI6WUoCUb5E/5jEiMOIKsZR++UrU379Z854ZKXNchOL0+acj9UvouViR7pb0uz4wF
	 cQ5eT5y3OfpLbYn5gQlxXYUL6uKq/WRIBzrrOUAN22xBsQOOiZCX++HtP3lYXQI4Wy
	 oZKJPQqp0F3F3/NKSUDC3IJZPH2c0Po7CcxesAz4yd78faWMguaCMDpVSp701W1vA1
	 co2dUOwdXkinO+gxQApZ3pa91g6Wcx/3ddvo/f3rBcYOIJFnkhYRiVQMK6rIeD80LA
	 ptfSWAlkJIgyQ==
Date: Tue, 2 Apr 2024 21:58:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Long Li <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/mana_ib: Add flex array to struct
 mana_cfg_rx_steer_req_v2
Message-ID: <20240402185812.GP11187@unreal>
References: <AS8PR02MB723729C5A63F24C312FC9CD18B3F2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB723729C5A63F24C312FC9CD18B3F2@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Mon, Apr 01, 2024 at 05:37:03PM +0200, Erick Archer wrote:
> The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of
> trailing elements. Specifically, it uses a "mana_handle_t" array. So,
> use the preferred way in the kernel declaring a flexible array [1].
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).
> 
> Also, avoid the open-coded arithmetic in the memory allocator functions
> [2] using the "struct_size" macro.
> 
> Moreover, use the "offsetof" helper to get the indirect table offset
> instead of the "sizeof" operator and avoid the open-coded arithmetic in
> pointers using the new flex member. This new structure member also allow
> us to remove the "req_indir_tab" variable since it is no longer needed.
> 
> Now, it is also possible to use the "flex_array_size" helper to compute
> the size of these trailing elements in the "memcpy" function.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Changes in v2:
> - Remove the "req_indir_tab" variable (Gustavo A. R. Silva).
> - Update the commit message.
> - Add the "__counted_by" attribute.
> 
> Previous versions:
> v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237974EF1B9BAFA618166C38B382@AS8PR02MB7237.eurprd02.prod.outlook.com/
> 
> Hi,
> 
> The Coccinelle script used to detect this code pattern is the following:
> 
> virtual report
> 
> @rule1@
> type t1;
> type t2;
> identifier i0;
> identifier i1;
> identifier i2;
> identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
> position p1;
> @@
> 
> i0 = sizeof(t1) + sizeof(t2) * i1;
> ...
> i2 = ALLOC@p1(..., i0, ...);
> 
> @script:python depends on report@
> p1 << rule1.p1;
> @@
> 
> msg = "WARNING: verify allocation on line %s" % (p1[0].line)
> coccilib.report.print_report(p1[0],msg)
> 
> Regards,
> Erick
> ---
>  drivers/infiniband/hw/mana/qp.c               | 12 +++++-------
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 14 ++++++--------
>  include/net/mana/mana.h                       |  1 +
>  3 files changed, 12 insertions(+), 15 deletions(-)

Is it possible to separate this patch to two patches? One for netdev
with drivers/net/ethernet/microsoft/mana/mana_en.c changes and another
with drivers/infiniband/hw/mana/qp.c changes.

It will simplify the acceptance process.

Thanks

> 
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 6e7627745c95..258f89464c10 100644
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
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 59287c6e6cee..62bf3e5661a6 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1058,11 +1058,10 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>  	struct mana_cfg_rx_steer_req_v2 *req;
>  	struct mana_cfg_rx_steer_resp resp = {};
>  	struct net_device *ndev = apc->ndev;
> -	mana_handle_t *req_indir_tab;
>  	u32 req_buf_size;
>  	int err;
>  
> -	req_buf_size = sizeof(*req) + sizeof(mana_handle_t) * num_entries;
> +	req_buf_size = struct_size(req, indir_tab, num_entries);
>  	req = kzalloc(req_buf_size, GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;
> @@ -1074,7 +1073,8 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>  
>  	req->vport = apc->port_handle;
>  	req->num_indir_entries = num_entries;
> -	req->indir_tab_offset = sizeof(*req);
> +	req->indir_tab_offset = offsetof(struct mana_cfg_rx_steer_req_v2,
> +					 indir_tab);
>  	req->rx_enable = rx;
>  	req->rss_enable = apc->rss_state;
>  	req->update_default_rxobj = update_default_rxobj;
> @@ -1086,11 +1086,9 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
>  	if (update_key)
>  		memcpy(&req->hashkey, apc->hashkey, MANA_HASH_KEY_SIZE);
>  
> -	if (update_tab) {
> -		req_indir_tab = (mana_handle_t *)(req + 1);
> -		memcpy(req_indir_tab, apc->rxobj_table,
> -		       req->num_indir_entries * sizeof(mana_handle_t));
> -	}
> +	if (update_tab)
> +		memcpy(req->indir_tab, apc->rxobj_table,
> +		       flex_array_size(req, indir_tab, req->num_indir_entries));
>  
>  	err = mana_send_request(apc->ac, req, req_buf_size, &resp,
>  				sizeof(resp));
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 76147feb0d10..46f741ebce21 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -671,6 +671,7 @@ struct mana_cfg_rx_steer_req_v2 {
>  	u8 hashkey[MANA_HASH_KEY_SIZE];
>  	u8 cqe_coalescing_enable;
>  	u8 reserved2[7];
> +	mana_handle_t indir_tab[] __counted_by(num_indir_entries);
>  }; /* HW DATA */
>  
>  struct mana_cfg_rx_steer_resp {
> -- 
> 2.25.1
> 
> 

