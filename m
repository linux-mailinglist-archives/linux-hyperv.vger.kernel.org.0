Return-Path: <linux-hyperv+bounces-646-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83207DBA07
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 13:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC79B20C01
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11512E7F;
	Mon, 30 Oct 2023 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b2VjK9lY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115E2CA4
	for <linux-hyperv@vger.kernel.org>; Mon, 30 Oct 2023 12:42:07 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DA6C6
	for <linux-hyperv@vger.kernel.org>; Mon, 30 Oct 2023 05:42:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-778940531dbso309850885a.0
        for <linux-hyperv@vger.kernel.org>; Mon, 30 Oct 2023 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698669722; x=1699274522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaVImc0dkBy3Z9VTY5Zc/APOkE9bH1O0oC3xdyopltQ=;
        b=b2VjK9lYfopeqoSMxqnpGF1Z7qPRaXlTZt4hG+CzcTOrrSAtsnjeeF79xLDAVhtQ0m
         ymnruuu84qnPeBvB8KSb6Bo4VOLsy1dmN9iTEMeWOCB3ddSMku3/QNP8wIi3YKcW8HKs
         XpnOqGg+DwRjfRwMfK5BfKxiR9GdlLS/SAiXGrZOPYldPNzB+Sft/YMuG5l+1CAft3dN
         xsc8TTXKMArFYX5ROH2dOJwi2iM5EJZymzm4LHfxKjq0sQchIUO6JsFrZxyANbBWWPLf
         R5jqgBLVPKFQVUmYcKEsKQbOYkNDiWkFVUSibu3U9p1TY36kLEMfcT54+MUHn3+YLC5Z
         +NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698669722; x=1699274522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaVImc0dkBy3Z9VTY5Zc/APOkE9bH1O0oC3xdyopltQ=;
        b=oW9bfiY/KRh1PmGtmRn94tPOmrwTmuO/GTjqnp70dfAYCqXpIIpOHeh603TPKZ1tnx
         CxW0v0zvX8o4lolW+De/lEh4rO6GVLYOwzdwbD8FB8Ki7YgUS6XdRTCMtLtZZg1YCJd7
         B/8bTtnnDqF3KA0xEipe1h75iyFIYJX2zEFWOwN3ZO1JiIe+19Bcon1yowKiB3N3x6HK
         iJzYY06QkJtWw4E81kndOv7oqdlDJId3tiaWRAj8XYWGMsVgIwZwUc9qDxw1ugwlsc5G
         /Z1XN25fDaECGcFSSP6O/KIBJTyATgp5v9VDCKtaIIljxIeMu/9gkwWf29BfGLrV1s3V
         0kHw==
X-Gm-Message-State: AOJu0YwixA1V1eSj9WGCapCaJPHGcMl+VMzB+HICWedp1toVaJBUuR/2
	37OEKlLyLjGTVduEkmQ0eUPgJA==
X-Google-Smtp-Source: AGHT+IEOz8S23BFi1wdI4YLJqyV/rMmzVLc6eQlLZ2YijSllB3dRYQ7TQWi1PVTb30pu0Qc98Y61Sw==
X-Received: by 2002:a0c:cd0f:0:b0:66d:6544:8eae with SMTP id b15-20020a0ccd0f000000b0066d65448eaemr10074472qvm.34.1698669721602;
        Mon, 30 Oct 2023 05:42:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id w10-20020a0562140b2a00b00656e2464719sm3390314qvj.92.2023.10.30.05.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:42:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qxRai-006ev4-JC;
	Mon, 30 Oct 2023 09:42:00 -0300
Date: Mon, 30 Oct 2023 09:42:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Ajay Sharma <sharmaajay@microsoft.com>,
	"sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>,
	Leon Romanovsky <leon@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
Message-ID: <20231030124200.GF691768@ziepe.ca>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-6-git-send-email-sharmaajay@linuxonhyperv.com>
 <20231023182332.GL691768@ziepe.ca>
 <MN0PR21MB36067E337A53C3BAF8B648E5D6DEA@MN0PR21MB3606.namprd21.prod.outlook.com>
 <MN0PR21MB32641E489F378F0C5B357795CEDCA@MN0PR21MB3264.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR21MB32641E489F378F0C5B357795CEDCA@MN0PR21MB3264.namprd21.prod.outlook.com>

On Fri, Oct 27, 2023 at 09:35:05PM +0000, Long Li wrote:
> > Subject: RE: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
> > 
> > 
> > > -----Original Message-----
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Monday, October 23, 2023 11:24 AM
> > > To: sharmaajay@linuxonhyperv.com
> > > Cc: Long Li <longli@microsoft.com>; Leon Romanovsky <leon@kernel.org>;
> > > Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S.
> > > Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> > > Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > > linux- rdma@vger.kernel.org; linux-hyperv@vger.kernel.org;
> > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ajay Sharma
> > > <sharmaajay@microsoft.com>
> > > Subject: [EXTERNAL] Re: [Patch v7 5/5] RDMA/mana_ib: Send event to qp
> > >
> > > On Mon, Oct 16, 2023 at 03:12:02PM -0700,
> > sharmaajay@linuxonhyperv.com
> > > wrote:
> > >
> > > > diff --git a/drivers/infiniband/hw/mana/qp.c
> > > > b/drivers/infiniband/hw/mana/qp.c index ef3275ac92a0..19fae28985c3
> > > > 100644
> > > > --- a/drivers/infiniband/hw/mana/qp.c
> > > > +++ b/drivers/infiniband/hw/mana/qp.c
> > > > @@ -210,6 +210,8 @@ static int mana_ib_create_qp_rss(struct ib_qp
> > > *ibqp, struct ib_pd *pd,
> > > >  		wq->id = wq_spec.queue_index;
> > > >  		cq->id = cq_spec.queue_index;
> > > >
> > > > +		xa_store(&mib_dev->rq_to_qp_lookup_table, wq->id, qp,
> > > GFP_KERNEL);
> > > > +
> > >
> > > A store with no erase?
> > >
> > > A load with no locking?
> > >
> > > This can't be right
> > >
> > > Jason
> > 
> > This wq->id is assigned from the HW and is guaranteed to be unique. May be I
> > am not following why do we need a lock here. Can you please explain ?
> > Ajay
> 
> I think we need to check the return value of xa_store(), and call xa_erase() in mana_ib_destroy_qp().
> 
> wq->id is generated by the hardware. If we believe in hardware
> always behaves in good manner, we don't need a lock.

It has nothing to do with how the ID is created, you need to explain
how the missing erase can't race with any loads, in a comment above
the unlocked xa_load.

Jason

