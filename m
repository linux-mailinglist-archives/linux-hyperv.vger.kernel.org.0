Return-Path: <linux-hyperv+bounces-1361-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B6E8199BD
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Dec 2023 08:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80CC2B23E72
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Dec 2023 07:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDEE179AD;
	Wed, 20 Dec 2023 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPx2PC9z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79361863B;
	Wed, 20 Dec 2023 07:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6D7C433C7;
	Wed, 20 Dec 2023 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703058023;
	bh=k13y4aQy798GDSgsKyZ5ZMNS3qH8QIkViAO9lA673gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPx2PC9zpycMDTfHo9YJO3DMnJDMthFukMzqDofVq9wxI4Yk7mP/tkieJT075it51
	 HaSFrMAun1FMk/ueqesv0ZhCQiVQZ/QQQPcmvjOqvXKMp20Ak+hO3/CHvDpySrFkpL
	 59K15d1edS4Mre6dJX90j7rZPf/hMqWK1GVts2oPU9/qFO65KRe6hgQBCMqNlV3inw
	 Ao4SqkbOrGfYoYdIK0MT5a53tmvUXNgq86Vp423VOUCPDVqR4p/QrxGj0dN0GoC1ga
	 4vOUZtXg15JvtMlGka8GY6kPOUwwkTAEOq4462A6AJKkqfB7Fn3LZTTehY20cuAsZS
	 1GdDtcbphnXoA==
Date: Wed, 20 Dec 2023 09:40:18 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v4 0/3] Register with RDMA SOC interface and support for
 CQ
Message-ID: <20231220074018.GA136797@unreal>
References: <1702692255-23640-1-git-send-email-longli@linuxonhyperv.com>
 <20231217132548.GC4886@unreal>
 <PH7PR21MB3263ADBB8113D2BF2DDC0552CE90A@PH7PR21MB3263.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3263ADBB8113D2BF2DDC0552CE90A@PH7PR21MB3263.namprd21.prod.outlook.com>

On Mon, Dec 18, 2023 at 06:23:21PM +0000, Long Li wrote:
> > Subject: Re: [Patch v4 0/3] Register with RDMA SOC interface and support for CQ
> > 
> > On Fri, Dec 15, 2023 at 06:04:12PM -0800, longli@linuxonhyperv.com wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > This patchset add support for registering a RDMA device with SoC for
> > > support of querying device capabilities, upcoming RC queue pairs and
> > > CQ interrupts.
> > >
> > > This patchset is partially based on Ajay Sharma's work:
> > > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Fnetdev%2F1697494322-26814-1-git-send-email-sharmaajay%40
> > >
> > linuxonhyperv.com&data=05%7C02%7Clongli%40microsoft.com%7Caaadcacece2
> > b
> > >
> > 44117bfd08dbff03b2c3%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C
> > 6383
> > >
> > 84163586869634%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> > QIjoiV2l
> > >
> > uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=e4G1tI9
> > VOTGv
> > > rA3UF6YQZ%2BM2uDDd71sZpejOvhl2y60%3D&reserved=0
> > >
> > > Changes in v2:
> > > Dropped the patches to create EQs for RC QP. They will be implemented
> > > with RC patches.
> > 
> > You sent twice v2, never sent v3 and two days later sent v4 without even
> > explaining why.
> > 
> > Can you please invest time and write more detailed changelog which will include
> > v2, v3 and v4 changes?
> > 
> > Tanks
> 
> I'm sorry, the cover letter for the 2nd v2 should be v3 (it was a typo). The rest of the patches in that series are correctly labeled as v3.
> 
> For v3 and v4, I put the change log in the individual patches, as there are no changes to the cover letter. If you think I should put change logs in the cover letter, please let me know.

For the future submission, yes, please write changelog in the cover letter.

Thanks

> 
> Subject: [Patch v4 2/3] RDMA/mana_ib: query device capabilities
> Change in v4:
> On query device failure, goto deregister_device, not ib_free_device
> Change function name mana_ib_query_adapter_caps() to mana_ib_gd_query_adapter_caps() to better reflect this is a HWC request
> 
> Subject: [Patch v4 3/3] RDMA/mana_ib: Add CQ interrupt support for RAW QP
> Change in v3:
> Removed unused varaible mana_ucontext in mana_ib_create_qp_rss().
> Simplified error handling in mana_ib_create_qp_rss() on failure to allocate queues for rss table.
> 
> Thanks,
> 
> Long
> 
> > 
> > >
> > >
> > > Long Li (3):
> > >   RDMA/mana_ib: register RDMA device with GDMA
> > >   RDMA/mana_ib: query device capabilities
> > >   RDMA/mana_ib: Add CQ interrupt support for RAW QP
> > >
> > >  drivers/infiniband/hw/mana/cq.c               | 34 ++++++-
> > >  drivers/infiniband/hw/mana/device.c           | 31 +++++--
> > >  drivers/infiniband/hw/mana/main.c             | 69 ++++++++++----
> > >  drivers/infiniband/hw/mana/mana_ib.h          | 53 +++++++++++
> > >  drivers/infiniband/hw/mana/qp.c               | 90 ++++++++++++++++---
> > >  .../net/ethernet/microsoft/mana/gdma_main.c   |  5 ++
> > >  include/net/mana/gdma.h                       |  5 ++
> > >  7 files changed, 252 insertions(+), 35 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >

