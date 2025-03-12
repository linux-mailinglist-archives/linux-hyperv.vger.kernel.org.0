Return-Path: <linux-hyperv+bounces-4422-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1086A5D6AC
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 07:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0247A4F5A
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 06:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7E1E7C2D;
	Wed, 12 Mar 2025 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfdx6bEW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EE01E5B71
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Mar 2025 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762556; cv=none; b=Mfu3/LE53zDu5pM2dDc7wTs7AeSj333NGIq4EhCtjW1JWi8TdDxwvluf//sVWNs3nxn3A0A+uB7G9z+vXR3H9nT1HeY+oMF73fRlAzrGaNCR8weMCbZEe2cai5bJqn8FcxenNgblQbVPGbFz7NgA9+d5QtDiSucICnvGnlN8Cvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762556; c=relaxed/simple;
	bh=mmZWO8rrKBhcxVobJcb1/dMSVYN+sIlK9Rb8Ecs/XBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3qr4Su+j3jZudVxEq4H6/Iu51fTxH2K+1mnObu0Ljvbs9awR95CN95vj1wMVguk36TG6X0cbbKsG6Gqku8Yao+7BfC9Bwr8XYTQvoBUf3PIcZn1t2se129E6bS4DZR522hUrruprX7arX+5SfGuVUHdjs3cutdmPcRxj89qaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfdx6bEW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741762554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M5urNoJLNtNizXgsJBqJ+K7FyEmcih4A00lRbzK+XcU=;
	b=cfdx6bEWMVEBpVOc4NpurOqLnfNg7n19bwbGRKkrpjDH3074vULp6OLn9vhJvRZTdQF7fl
	mO7/bMTDhImiG0F/D1FmhnuqKs9xOQfh/Ahzlzz4mZrcABORLGW3ZOdNYhAPreSWijm4Ye
	mMia4Ypnq01hUkZw4t1tMk3xE5cCZWg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-fxbn8-jVOCOtfdqwfomq-A-1; Wed, 12 Mar 2025 02:55:52 -0400
X-MC-Unique: fxbn8-jVOCOtfdqwfomq-A-1
X-Mimecast-MFC-AGG-ID: fxbn8-jVOCOtfdqwfomq-A_1741762551
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3914bc0cc4aso1662572f8f.3
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Mar 2025 23:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762551; x=1742367351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5urNoJLNtNizXgsJBqJ+K7FyEmcih4A00lRbzK+XcU=;
        b=OVYEWK2Rv3PqHdru4iSoiW+X5LODOQuq09aEy7ccZSbbq4PiaAU2gdp0h7vWV4n982
         GoJeSkdyyFjvkkuSAdbm/Xh+EHlMqlTnYN1GSTQY/KR4Xe+Uoaqpe1KbwbqzovOJkz+J
         tOQfjK/kFnmvdw1ZNdYGKzlDn1sCiof/szeZV7EJSAnFz/5wV6PW4iWDe0MCsuM5VAQO
         TndfcVAZnCSNF7f9aVcXnhkoCSSRqKRVXULnA0WdlhEGoe5XHNsk9Z77VCfL8M3yeqXd
         DkZXkqpMaOR2cE12CwRomjdfSUsTm7WnKi2YoE600AnJkLOuquJ/UEKwvE59sxFwqxo8
         Y8wQ==
X-Gm-Message-State: AOJu0Yz8wvYzsqkSQ24Z1QpMvKYDl6XqBbg2Qj0eDIQM9sjKbQk1ZQrC
	aSZD/xz36iZhHP0DBpw3Ot6+cASpIDx5FoqbF7gR2xSGohb2TDo+VUEKv4RrUX/TuJTSQ5lIyXb
	VKcjbKC7vPEta4/h1QmJNdrjHGzf4BMv6x0WJtX9Pc5aBdwWZr8FQmYetJTlJ8g==
X-Gm-Gg: ASbGncuaGjbt+OCqS4qhWIy+bMVW8GPF5eFQ3PGDJHMuDh/Z6GwUyGyER7GUL1A9qtT
	4YbxDltv5jbB9OL47QAgiWxB3XgMgWuOgaFM9N/7gOH949GwNCPL/CcHivh0sZsCVndqZpXk7xn
	y/9SpTdE5XNwIhuOP5y1ygsbalK/Jwi8K5rErgs5O/9AoGxTJJNtc9CK19cwWPc1/g98wFfMxh8
	ttJgtl3qv3kiHbYB43TxvPmUn8x6AvwBrSZvP/K7LavVEwQTkjuNnJO1A0zpqw9N8B3Ei1X7vKo
	QN9NFyJo9w==
X-Received: by 2002:a05:6000:402a:b0:390:ed05:aa26 with SMTP id ffacd0b85a97d-39132d30c22mr15005790f8f.5.1741762551531;
        Tue, 11 Mar 2025 23:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDerobH2f/muGrjnyAjilHqba0+0kowFg3s8AIPcyJb001SG0K4ObuoiA+X/VxHvC5d0rDfQ==
X-Received: by 2002:a05:6000:402a:b0:390:ed05:aa26 with SMTP id ffacd0b85a97d-39132d30c22mr15005774f8f.5.1741762551189;
        Tue, 11 Mar 2025 23:55:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-394a8a5a304sm565705f8f.40.2025.03.11.23.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:55:50 -0700 (PDT)
Date: Wed, 12 Mar 2025 02:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 2/5] virtio_balloon: update the NR_BALLOON_PAGES state
Message-ID: <20250312025331-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-3-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312000700.184573-3-npache@redhat.com>

On Tue, Mar 11, 2025 at 06:06:57PM -0600, Nico Pache wrote:
> Update the NR_BALLOON_PAGES counter when pages are added to or
> removed from the virtio balloon.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 89da052f4f68..406414dbb477 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -274,6 +274,8 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
>  
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			VIRTIO_BALLOON_PAGES_PER_PAGE);
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>  			adjust_managed_page_count(page, -1);


This means the counter is in virtio balloon page units, which
runs counter to the declared goal of making the interface
hypervisor-agnostic.


> @@ -324,6 +326,8 @@ static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		list_add(&page->lru, &pages);
>  		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			-VIRTIO_BALLOON_PAGES_PER_PAGE);


Same.

Thanks,

>  	}
>  
>  	num_freed_pages = vb->num_pfns;
> -- 
> 2.48.1


