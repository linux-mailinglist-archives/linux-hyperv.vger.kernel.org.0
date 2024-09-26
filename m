Return-Path: <linux-hyperv+bounces-3074-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABFA98719E
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 12:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C1F2836B9
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2024 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A761AD40E;
	Thu, 26 Sep 2024 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TAKL88GY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAD91AD3EF;
	Thu, 26 Sep 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346885; cv=none; b=eETkNrAzvhI1qmnkGPsNCtW2DD5Zurk4LWTMebYW+GkoFA39tXCJbIJl5aUOsEXBEJ6g2AjAVXIVLqci+axS3OW71GnLPZLr8r7v/Q8ps+RCHsDSEy5uKAI0PwCvWK6R3y5AkJ7cNR++8iBy30739npm2IQSZPF1+aZkGmYp9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346885; c=relaxed/simple;
	bh=8eeMh/90Pbf93L8V5WKd+a+xGgcpat9mtKyIErEKKYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3kpJewhPMjxa99qDrZUm+qMX/48MPdy7YK+ZsqL/FcKQeBIRoo0swsyZyYHZUXmp//j6C1rTell6D9UoCHoYiQ6rmOAX6xbrBL9SRpHV9wJWs/8pIX3ayUW3WZy0AvNmku3n0dru1o0ztZOpQNuDGrg9TPSyFysAbOuUGDbczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TAKL88GY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id D717720C77C3; Thu, 26 Sep 2024 03:34:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D717720C77C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727346883;
	bh=/FjYRxUkGAZHXP1M9clF5rzCvm4POJ/Lj4DkA3ENSl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAKL88GYF+qd8WVF/2sc/ZpljcIkYP9nsIrAnw1b27cjl9tJBBxbi5AARXNm3HFAP
	 zKV51QSoDsY9tLe0+VUoMDsMeqXx8WfjXUqWodHzOL5YUp/Jha1YWb+n4yBw+qarz7
	 jR4YByMBGdso+K2ppWkgcqLWBcjEp4xhS9eGLxEg=
Date: Thu, 26 Sep 2024 03:34:43 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Joe Damato <jdamato@fastly.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Erni Sri Satya Vennela <ernis@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Message-ID: <20240926103443.GA3014@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240924234851.42348-1-jdamato@fastly.com>
 <20240924234851.42348-2-jdamato@fastly.com>
 <MW4PR21MB18590C4C1EDFF656E4600D62CA692@MW4PR21MB1859.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB18590C4C1EDFF656E4600D62CA692@MW4PR21MB1859.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Sep 25, 2024 at 07:39:03PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Joe Damato <jdamato@fastly.com>
> > Sent: Tuesday, September 24, 2024 7:49 PM
> > To: netdev@vger.kernel.org
> > Cc: Joe Damato <jdamato@fastly.com>; KY Srinivasan <kys@microsoft.com>;
> > Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> > Dexuan Cui <decui@microsoft.com>; David S. Miller <davem@davemloft.net>;
> > Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> > Paolo Abeni <pabeni@redhat.com>; open list:Hyper-V/Azure CORE AND DRIVERS
> > <linux-hyperv@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> > Subject: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
> > 
> > [You don't often get email from jdamato@fastly.com. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > Use netif_queue_set_napi to link queues to NAPI instances so that they
> > can be queried with netlink.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
> >  drivers/net/hyperv/rndis_filter.c |  9 +++++++--
> >  2 files changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > index 2b6ec979a62f..ccaa4690dba0 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -712,8 +712,11 @@ void netvsc_device_remove(struct hv_device *device)
> >         for (i = 0; i < net_device->num_chn; i++) {
> >                 /* See also vmbus_reset_channel_cb(). */
> >                 /* only disable enabled NAPI channel */
> > -               if (i < ndev->real_num_rx_queues)
> > +               if (i < ndev->real_num_rx_queues) {
> > +                       netif_queue_set_napi(ndev, i,
> > NETDEV_QUEUE_TYPE_TX, NULL);
> > +                       netif_queue_set_napi(ndev, i,
> > NETDEV_QUEUE_TYPE_RX, NULL);
> >                         napi_disable(&net_device->chan_table[i].napi);
> > +               }
> > 
> >                 netif_napi_del(&net_device->chan_table[i].napi);
> >         }
> > @@ -1787,6 +1790,10 @@ struct netvsc_device *netvsc_device_add(struct
> > hv_device *device,
> >         netdev_dbg(ndev, "hv_netvsc channel opened successfully\n");
> > 
> >         napi_enable(&net_device->chan_table[0].napi);
> > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
> > +                            &net_device->chan_table[0].napi);
> > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
> > +                            &net_device->chan_table[0].napi);
> > 
> >         /* Connect with the NetVsp */
> >         ret = netvsc_connect_vsp(device, net_device, device_info);
> > @@ -1805,6 +1812,8 @@ struct netvsc_device *netvsc_device_add(struct
> > hv_device *device,
> > 
> >  close:
> >         RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
> > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
> > +       netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
> >         napi_disable(&net_device->chan_table[0].napi);
> > 
> >         /* Now, we can close the channel safely */
> > diff --git a/drivers/net/hyperv/rndis_filter.c
> > b/drivers/net/hyperv/rndis_filter.c
> > index ecc2128ca9b7..c0ceeef4fcd8 100644
> > --- a/drivers/net/hyperv/rndis_filter.c
> > +++ b/drivers/net/hyperv/rndis_filter.c
> > @@ -1269,10 +1269,15 @@ static void netvsc_sc_open(struct vmbus_channel
> > *new_sc)
> >         ret = vmbus_open(new_sc, netvsc_ring_bytes,
> >                          netvsc_ring_bytes, NULL, 0,
> >                          netvsc_channel_cb, nvchan);
> > -       if (ret == 0)
> > +       if (ret == 0) {
> >                 napi_enable(&nvchan->napi);
> > -       else
> > +               netif_queue_set_napi(ndev, chn_index,
> > NETDEV_QUEUE_TYPE_RX,
> > +                                    &nvchan->napi);
> > +               netif_queue_set_napi(ndev, chn_index,
> > NETDEV_QUEUE_TYPE_TX,
> > +                                    &nvchan->napi);
> > +       } else {
> >                 netdev_notice(ndev, "sub channel open failed: %d\n",
> > ret);
> > +       }
> > 
> >         if (atomic_inc_return(&nvscdev->open_chn) == nvscdev->num_chn)
> >                 wake_up(&nvscdev->subchan_open);
> > --
> 
> The code change looks fine to me.
> @Shradha Gupta or @Erni Sri Satya Vennela, Do you have time to test this?
> 
> Thanks,
> - Haiyang
> 
> 
Hi Joe, Haiyang,

I have verified the patch on a VM with netvsc interfaces and the seems
to be working as expected

CLI output after applying the patch:

[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
 {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
 {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
 {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'tx'},
 {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'tx'},
 {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'tx'},
 {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'tx'}]

The code changes also look good.

Tested-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Thanks,
Shradha.

