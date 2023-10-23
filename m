Return-Path: <linux-hyperv+bounces-576-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21E7D3F23
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Oct 2023 20:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3684A1C20A9E
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Oct 2023 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED222219E4;
	Mon, 23 Oct 2023 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AUeGajGc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430721379
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Oct 2023 18:23:36 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A493293
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Oct 2023 11:23:34 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ae5a014d78so2390119b6e.1
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Oct 2023 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698085414; x=1698690214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asV/mzEgZ0QPpPGTkL/tZKxIZbV4pZf1YGZ30QE3Rpg=;
        b=AUeGajGcM9qqd0H0+u84YQUazg5mZQSwadjvuIsUeKb8yUmWQn/xmc7Whjnxg7YNDv
         OLaZ6TPBJNlFrf/0GYxZwWVgO5T0PpAe511cRJx3fatgj7qQmk3EUia+c095gQ45z2em
         vMDGCKr1HdcDOhO1/MNr7TgnyAgQmcx5lk++9UpUsv9WTU7lFHuAmMSELdOYH1mKuUmK
         8+2hMZya9TPOSjx9FQ7j40yEA05AQH3+EpDf7o/diKFgBqLGXvtWKfiZmZbrZQm1VfEd
         9Ll36m7GRWwyEoxMMZ6JX++nr0sr5ajAzK/UHI+YFe0obsrym+SMlDg3gXTNDN8pHi2h
         NQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085414; x=1698690214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asV/mzEgZ0QPpPGTkL/tZKxIZbV4pZf1YGZ30QE3Rpg=;
        b=p5sYFVpOPAFwrZcTGXKOKwHOmZhGTviH85osmXKfWk3s1kCmdV5L0cZaALASltYGS5
         4KxHB5LUvX4xJBJiMVDgFJwrZ6aLidXM+9dnuJ7UJgrHEXp77/bTA8/37h/e3ezfnx0l
         aXiVt9BkIobw7tTDR/bxbzyA1DlXXPcq+sb5mcigvUg31gfF/8ANy1/3+PL19/ZPw1/k
         Ca4wMsJ+mmRou4I6FEQez99UH0u39aKIcO/JcoqkaACQurZ1kq1j7GUxSm5hRmVCvhYu
         o2SeBVp65vfK7UpqcaECmBLQhPoTurm0vXOf74ZWB6xBnAMyIdMpHwmxYKlT/EuGnCQh
         WQ5A==
X-Gm-Message-State: AOJu0YyVVJG4nJCQQTVUpE4J5g8i/L0IqDnvF6uBBFdxKIIxyBqMKdP0
	8sBmDVZpy1ycTH3eZ76pmY+eLA==
X-Google-Smtp-Source: AGHT+IEqObC+cIKLIFikGXPFoFK2xQU9I3Zh+K8TuPgknSCWC7VYdDuKHSMhiAnrYCeSVxsNF5l/Cw==
X-Received: by 2002:a05:6808:1a24:b0:3b0:f8bd:9503 with SMTP id bk36-20020a0568081a2400b003b0f8bd9503mr8622436oib.10.1698085414027;
        Mon, 23 Oct 2023 11:23:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id j9-20020a544809000000b003b2e4b72a75sm1582234oij.52.2023.10.23.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:23:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1quzaO-003jRh-QZ;
	Mon, 23 Oct 2023 15:23:32 -0300
Date: Mon, 23 Oct 2023 15:23:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: sharmaajay@linuxonhyperv.com
Cc: Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
Message-ID: <20231023182332.GL691768@ziepe.ca>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-6-git-send-email-sharmaajay@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697494322-26814-6-git-send-email-sharmaajay@linuxonhyperv.com>

On Mon, Oct 16, 2023 at 03:12:02PM -0700, sharmaajay@linuxonhyperv.com wrote:

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index ef3275ac92a0..19fae28985c3 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -210,6 +210,8 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  		wq->id = wq_spec.queue_index;
>  		cq->id = cq_spec.queue_index;
>  
> +		xa_store(&mib_dev->rq_to_qp_lookup_table, wq->id, qp, GFP_KERNEL);
> +

A store with no erase?

A load with no locking?

This can't be right

Jason

