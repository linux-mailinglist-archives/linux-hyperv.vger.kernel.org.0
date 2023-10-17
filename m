Return-Path: <linux-hyperv+bounces-542-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97A97CBCB3
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 09:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF95281811
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 07:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F430F87;
	Tue, 17 Oct 2023 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSnzO381"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B623766;
	Tue, 17 Oct 2023 07:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF21AC433C8;
	Tue, 17 Oct 2023 07:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697528905;
	bh=l5ZXyU0FFeiZz3s3YxfAjMelGvfe4yY/Uqvl5whdjJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSnzO381cZbIdNu+uowcvK2rffi44JvZEphJ5p4qGAZxVj4wDWtLSytZBW5CdPK0M
	 wIzJlzA0P36K/wtZZwQCU20t0+Y8f58wgCeZ+X8blug445WKmL9DYDUTFTq9rf+wV/
	 LWSNcVe9JopgvP8WzmTRvPY/DTXA+Vi5IpUVSfNQNV5b7Nzd9XU+6zA8Id7hB7yppW
	 GN8wH+tzOuLMmumbEcfo5i8Fiux4i2tywLmLUCdsxnLY688OUP+uw8WDSQeuck8UzN
	 sTkoRDsAu/fCMpoAa38l03sW6X9qttYn18Rs/uKogvTSunLkK68cLYDxDTPj/scVq+
	 CJjxZESzBg69Q==
Date: Tue, 17 Oct 2023 10:48:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ajay Sharma <sharmaajay@microsoft.com>
Cc: "sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>,
	Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
Message-ID: <20231017074821.GB5392@unreal>
References: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <20230911123231.GB19469@unreal>
 <BY5PR21MB1394F62601FEFE734181FFF7D6F2A@BY5PR21MB1394.namprd21.prod.outlook.com>
 <20230918082903.GC13757@unreal>
 <MN0PR21MB3606BE5B57AF1FEE85915F3AD6D7A@MN0PR21MB3606.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN0PR21MB3606BE5B57AF1FEE85915F3AD6D7A@MN0PR21MB3606.namprd21.prod.outlook.com>

On Mon, Oct 16, 2023 at 10:15:18PM +0000, Ajay Sharma wrote:
> I have sent v7 patch series with the space removed 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Monday, September 18, 2023 1:29 AM
> > To: Ajay Sharma <sharmaajay@microsoft.com>
> > Cc: sharmaajay@linuxonhyperv.com; Long Li <longli@microsoft.com>; Jason
> > Gunthorpe <jgg@ziepe.ca>; Dexuan Cui <decui@microsoft.com>; Wei Liu
> > <wei.liu@kernel.org>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; linux-rdma@vger.kernel.org; linux-
> > hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
> > 
> > On Mon, Sep 11, 2023 at 06:57:21PM +0000, Ajay Sharma wrote:
> > > I have updated the last patch to use xarray, will post the update patch. We
> > currently use aux bus for ib device. Gd_register_device is firmware specific. All
> > the patches use RDMA/mana_ib format which is aligned with
> > drivers/infiniband/hw/mana/ .
> > 
> > ➜  kernel git:(wip/leon-for-rc) git l --no-merges drivers/infiniband/hw/mana/
> > 2145328515c8 RDMA/mana_ib: Use v2 version of cfg_rx_steer_req to enable
> > RX coalescing
> > 89d42b8c85b4 RDMA/mana_ib: Fix a bug when the PF indicates more entries
> > for registering memory on first packet
> > 563ca0e9eab8 RDMA/mana_ib: Prevent array underflow in
> > mana_ib_create_qp_raw()
> > 3574cfdca285 RDMA/mana: Remove redefinition of basic u64 type
> > 0266a177631d RDMA/mana_ib: Add a driver for Microsoft Azure Network
> > Adapter
> > 
> > It is different format from presented here. You added extra space before ":"
> > and there is double space in one of the titles.
> > 
> I have removed the space
> 
> > Regarding aux, I see it, but what confuses me is proliferation of terms and
> > various calls: device, client, adapter. My expectation is to see more uniform
> > methodology where IB is represented as device.
> > 
> 
> The adapter is a software construct. It is used as a container for resources. 
> Client is used to distinguish between eth and ib.

Do you have multiple "adapters" in one ib/eth device?
If yes, at least for IB, it will be very unexpected to see.

Why do you have client and device when they are basically the same objects?

> Please note that these are terms used for different purposes on the management side.

We are discussing RDMA side of this series.

Thanks

> 
> > Thanks
> > 
> > >
> > > Thanks
> > >
> > > > -----Original Message-----
> > > > From: Leon Romanovsky <leon@kernel.org>
> > > > Sent: Monday, September 11, 2023 7:33 AM
> > > > To: sharmaajay@linuxonhyperv.com
> > > > Cc: Long Li <longli@microsoft.com>; Jason Gunthorpe <jgg@ziepe.ca>;
> > > > Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> > > > David S. Miller <davem@davemloft.net>; Eric Dumazet
> > > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > > > <pabeni@redhat.com>; linux- rdma@vger.kernel.org;
> > > > linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; Ajay Sharma <sharmaajay@microsoft.com>
> > > > Subject: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
> > > >
> > > > On Thu, Sep 07, 2023 at 09:52:34AM -0700,
> > > > sharmaajay@linuxonhyperv.com
> > > > wrote:
> > > > > From: Ajay Sharma <sharmaajay@microsoft.com>
> > > > >
> > > > > Change from v4:
> > > > > Send qp fatal error event to the context that created the qp. Add
> > > > > lookup table for qp.
> > > > >
> > > > > Ajay Sharma (5):
> > > > >   RDMA/mana_ib : Rename all mana_ib_dev type variables to mib_dev
> > > > >   RDMA/mana_ib : Register Mana IB  device with Management SW
> > > > >   RDMA/mana_ib : Create adapter and Add error eq
> > > > >   RDMA/mana_ib : Query adapter capabilities
> > > > >   RDMA/mana_ib : Send event to qp
> > > >
> > > > I didn't look very deep into the series and has three very initial comments.
> > > > 1. Please do git log drivers/infiniband/hw/mana/ and use same format
> > > > for commit messages.
> > > > 2. Don't invent your own index-to-qp query mechanism in last patch
> > > > and use xarray.
> > > > 3. Once you decided to export mana_gd_register_device, it hinted me
> > > > that it is time to move to auxbus infrastructure.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >  drivers/infiniband/hw/mana/cq.c               |  12 +-
> > > > >  drivers/infiniband/hw/mana/device.c           |  81 +++--
> > > > >  drivers/infiniband/hw/mana/main.c             | 288 +++++++++++++-----
> > > > >  drivers/infiniband/hw/mana/mana_ib.h          | 102 ++++++-
> > > > >  drivers/infiniband/hw/mana/mr.c               |  42 ++-
> > > > >  drivers/infiniband/hw/mana/qp.c               |  86 +++---
> > > > >  drivers/infiniband/hw/mana/wq.c               |  21 +-
> > > > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 152 +++++----
> > > > >  drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
> > > > >  include/net/mana/gdma.h                       |  16 +-
> > > > >  10 files changed, 545 insertions(+), 258 deletions(-)
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >

