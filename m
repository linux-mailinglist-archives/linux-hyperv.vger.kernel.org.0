Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E0B6024CE
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Oct 2022 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJRG5o (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Oct 2022 02:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJRG5m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Oct 2022 02:57:42 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71DEA9245;
        Mon, 17 Oct 2022 23:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjLbbSPBe/OrktFsUVmka3n/LLrrdPck4I+ivO/bSE1kce3GSfBXZr8cJsGSwKlZFLUURFjfC1Eo/QNXhKy1DKoGgwRo0e64J3fXxAw1mTVTppol0jharNrIvUyDqlSL8pE3mBzfCiSfJJ6hHCR4MxcB1uR1RktVvXvGM7Cjd4UCSFRjYctLG10kyspIA/TRzl2OngddOSvk8AsO5Blg9ETQL+ovpw2ltKkXb6nWTEUL+jQ6hxnWtope7jeXLiiZzwfh22AIeSmr1KDIv8LETRXh4mFJGli0nwrQl2eORGMKq2vZ0RmoLtWcfMFz4FQcwDl0tt1c39TSdlE8wr5YiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlBe6Hl84UPZca+aFnPqY4aoPHdXbIfE6xMX9CmQFUA=;
 b=CCgKwTzs9ZxHH4eRywwIT6z/3CbaubJGe/OWZ8oQt9li62yVF9i8PQeK8az0MxfUR//Z3WiyREEpCzTIN0LD/pXjyU1h78RDsGKtsmh0s2SEbZcBy/QikSBiPo81auK4dJ3JfVqLTM6GvcetlepvXZzMejS/Qi1wDuAsOIxznOHzycSld3jGjb7VH3BxMhxuojW+t5FCtzRsevPBaUFBQmPtmGHzq3w5VIiOdt1BWg4kkHMJXjaMgGq/lhfkpqM8cwguPI+0v3X1aUUWFDs55psc8j0dEzJaZ1UIDgIIkRbsbu52/XcwZtwPE+RccGgx/klumzB5g0KcUkc+2O2rSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlBe6Hl84UPZca+aFnPqY4aoPHdXbIfE6xMX9CmQFUA=;
 b=Dj+DAVGt30vEnzBO3R82MmVah+sSQMPvQXH9tTJVbdHxUwn07kx4SXMA6WxFZTNTopprrFAd3KPfsQAKUlkFcwR+de4H7ejbkYIT9Tu7OnTdbIjrF0svgrAXcEimbY/Pycin+TWS/ePZ63cCpVJXY0e31/iMIzAFJtC2TL7MkAE=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by DM4PR21MB3056.namprd21.prod.outlook.com (2603:10b6:8:5c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.8; Tue, 18 Oct 2022 06:57:33 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::7c3c:5968:72d6:3b5f]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::7c3c:5968:72d6:3b5f%7]) with mapi id 15.20.5746.016; Tue, 18 Oct 2022
 06:57:33 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus
 devices
Thread-Topic: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus
 devices
Thread-Index: AQHY3zG2NgbGNaLQJkmnL/cmXn/Bqq4NgIeAgAYwnHCAAAldAIAAARWg
Date:   Tue, 18 Oct 2022 06:57:33 +0000
Message-ID: <PH7PR21MB3263ECBE949C7F0858075F3FCE289@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com>
 <Y0kRIcXG+wNbcGx0@kroah.com>
 <PH7PR21MB32633D172133A769357BD97ECE289@PH7PR21MB3263.namprd21.prod.outlook.com>
 <Y05KQFQUR5Is3RuC@kroah.com>
In-Reply-To: <Y05KQFQUR5Is3RuC@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=60de4451-e03c-4f50-ae60-00a2ba54f664;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-18T06:43:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|DM4PR21MB3056:EE_
x-ms-office365-filtering-correlation-id: e5e4a658-c895-4bed-ed3f-08dab0d6080a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gXQcmJgDBQE6sTZP93kqJQs7jBiezjTenU+fueeMpv/coR167u+7mkOkqE21hwKYpEUFfdIhseOh4Cc7GbwX7JudHVlpBIThbtGNq15OcJHyYz2rAssM1vIX37inXIg4XxYTLl9jFTLNrPDetIuPfsDn1/xuivgoLi1XPk3T5zlT+19xlQZhRCCvpXXZu+J5wj8C19Wdg1TnA5cPbEO3Y8dgpi4soE1+TsnOW/Wrb5CyQxZPNPlIIfMkwbgZGEAy6SLDCvAq7H+xq8LRIk9rOgpwjBMWrmwebBmtPReotb6UBuDpYo/t/Jc+znbfl/UX2JL+JZ9nRxaKyHkeRRRL8JPf+zxgEM6WjvP1KdFWKkDR6wYrfSy+pnVtHUbctDurXUlbi/Gk2hrrwg9G00M/jQeP0sTN0T1psSBC5A3SyY0F7ksSa9xKpC+xcDXs3Vc8nHVLuoo6IW25CuuTsRnYkzmpfYE2U4167X3GUFnYKDX8hdtQGJAVNTOoMvLLsiZ1BW06IH7IlSS6lD4tOcPiH8PMmFWZD/FN0Aet3zaZPqOBzLnSvNEXqHVeVYFaTGNDD3ba4WYbpEDRVzkBL55pEzzt5tnsK1FAhpPBunmBdNYDWKFAkVaXWk9D7gvGEilcu3ld7wusfJg9xE8nQb5T7+TWN9393r/J5csXwXAfSobwzVgdp7CGFkEJTI/VzHG792lp6M/ojZmENQW3wSYSz8xudlIUC0EprKmD2s2N6g5jiVT0N2bU53sIXcul78JX6Z31KCV7TwHvgDUBfRP4NqcIwfR5GLVDSiAFppmLjo0ZZSbrkrBbLWrtMIpu/P5upV5Umuzc1lpJxeHL1apvzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(54906003)(82950400001)(66946007)(10290500003)(38100700002)(6916009)(66899015)(122000001)(2906002)(9686003)(66476007)(33656002)(86362001)(66556008)(38070700005)(8676002)(316002)(76116006)(55016003)(66446008)(5660300002)(8936002)(41300700001)(7696005)(83380400001)(478600001)(64756008)(82960400001)(8990500004)(26005)(107886003)(52536014)(71200400001)(6506007)(4326008)(186003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1d2evUtrU7mO0wCAOEQpzi6LG7SDvZ8+LuY9Lil7K8yzr66hE9CoI4QHx1gB?=
 =?us-ascii?Q?zgNsdoQKwj4L2mdvBkiuEn/5kXGSpdpFklmRfAerLuZE8bTBH0eIYhOGdwBZ?=
 =?us-ascii?Q?GfBIdhYrH6qeRq55vUDGrlycXP5z7t5WjFzyCMGiocKNo7YkDPXgkrMu5WLz?=
 =?us-ascii?Q?ixdKWuwmIQEW6Hn7u+ry5b9EwguvOHcfTlIqcydxr9eEv+dHyJWhDyy2FFOq?=
 =?us-ascii?Q?eYzcaFVUYI6/vZ2Z+fxZIfIfRlRafL0f/89XMFjY4Drp2AoOLWXmiZnwoORE?=
 =?us-ascii?Q?C64HVionQt2LsFN/r5lz7qT5164zImRx9xQr3IzXge80Es5N3Cnx2gjyF7QC?=
 =?us-ascii?Q?TcCuFFCJz6AM924e4JaXIo5rwQ94JfryGuzyIMlyYK3uEwtg32cVD+F83JVl?=
 =?us-ascii?Q?G2DXcIkhWIUU+Nx7owDZbt9Lpjvf0thJ7O5Ztz+2W8+uGbOrFQ3o25fEveQZ?=
 =?us-ascii?Q?QL/h/9PeTqf9d+SN2iyERL+47u0aAg0quG8xZOts8H4Yg3zbXD8XciWMoxDa?=
 =?us-ascii?Q?VaAicDnRUiD18h3aWRMdydMYUcZWHIGUN4VuCGxbDpJU7d/xYmZJ8oDzfW89?=
 =?us-ascii?Q?3wKU0TDA2VexPWL4dfejCmpSZVBWbqoyAmtvVsbpuzqqUnkh5x9fHdRjaXR2?=
 =?us-ascii?Q?3eMHip8ihOgSrnv6v5hfvuAjtUsriupB3SlTUZg9qN91nlji+ZpNBmazGoi4?=
 =?us-ascii?Q?NHoRxFyBePC0g0Rb1cfEEh+cba2/6RhnzlXl7oC7/nHiaKE5wFHxd+aWN5AO?=
 =?us-ascii?Q?G/uAtrIgux/dbRCKcyy90hvHYUn4HPAKvglXhTr4gCBtYKYwDIZjaIQBzTOv?=
 =?us-ascii?Q?61Gz4zD2dyy7h86sxWzrjhZ+8DFREpDUNuhrr3q6/Jj6X5mNSlaBTpKQlo43?=
 =?us-ascii?Q?C63v2tJboPhJihzttlegsWwgURpRetcumNc59hQWokVjCez1IKx702dXc9N/?=
 =?us-ascii?Q?+9R5NCxZictjHtQqlAqTQq80cY6UbCbaBfkyovJa5IyQyzIXzxTIrK9FB8kY?=
 =?us-ascii?Q?m/vt/MNXjJZT1BjL/CuJukp8DimIDP8KwQsadyyAcpoBW13RGgTboKbCUwxQ?=
 =?us-ascii?Q?MIQVI9UqFtSPp/uHFMx+77xhcI3GdodoRzizo+VgRpyVEy+rNNTlNUY3rnL8?=
 =?us-ascii?Q?2lGqLY+zv4XsdHcHe/DxfetElK0lstGto+GyG3ubKwuA+C/9u12ZeKKmISO6?=
 =?us-ascii?Q?woydRzPZ3cORxzPDg/Yzgj1UCVQG7S8sY44HLBkrWW0fceh4pd7ajBeE/LNq?=
 =?us-ascii?Q?toNwUEgI+4js/Ghk03Kv+H/0bvKPnb+8cxAp0cL4tMdZumR60oZSutbBU0/Z?=
 =?us-ascii?Q?ufGFpD9Qu+o10jwtUiycaDJ8MgqFX8h4dWQLglSJFOk8LqDByVKdPqE0gVfO?=
 =?us-ascii?Q?FtwC8I9JzeELI4LoL9d2Z6l925+RU+TA9ApBUkxqDhbL5xdt3knXfCVW4d0B?=
 =?us-ascii?Q?eiugdGrxWt3CKKi+2VARdmNbffVU53aqZixv5Muetmc3UUhiW2BV5Sh1+Auo?=
 =?us-ascii?Q?+VpRQBFy5DnUm+VCvw/TmaVrG95R5k157JfNn4aiew3gadxpKi2PBz7un53A?=
 =?us-ascii?Q?0/Qe8Rbw43gV/lZ7D473waAnr9p7c3YqwfRwDiq1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e4a658-c895-4bed-ed3f-08dab0d6080a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 06:57:33.0614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdE2OLuqrgZfhF1MUuX0JCc7rIiz/Npr57e9YRsu34O0WHD8QQtUAmy6txy0KEeNNmMB9tf43EDs9vvgeQ09ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3056
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus
> devices
>=20
> On Tue, Oct 18, 2022 at 06:31:16AM +0000, Long Li wrote:
> > > Subject: Re: [PATCH] uio_hv_generic: Enable interrupt for low speed
> > > VMBus devices
> > >
> > > On Thu, Oct 13, 2022 at 11:29:14AM -0700, Saurabh Sengar wrote:
> > > > Hyper-V is adding some "specialty" synthetic devices.
> > >
> > > What devices are those specifically?
> > >
> > > > Instead of writing new kernel-level VMBus drivers for these
> > > > devices, the devices will be presented to user space via this
> > > > existing Hyper-V generic UIO driver, so that a user space driver ca=
n
> handle the device.
> > > > Since these new synthetic devices are low speed devices, they
> > > > don't support monitor bits and we must use vmbus_setevent() to
> > > > enable interrupts from the host.
> > >
> > > That is not what the UIO interface is for.  Please write real
> > > drivers so that they tie into the specific user/kernel apis for those=
 device
> types.
> > >
> > > Without a specific list of what these devices are, I can not
> > > recommend that anyone use the UIO api for them as that's probably not
> a good idea.
> >
> > There are some VMBUS drivers currently not implemented in Linux. Out
> > of all VMBUS drivers, two use "monitored bits": they are network and
> storage drivers.
> > All the rest VMBUS drivers use hypercall for host notification and
> > signal for next interrupt. One example of such driver is to collect
> > process level crash information for diagnostic purposes.
> >
> > Also, we want to move some existing kernel mode VMBUS drivers to
> > user-space, such as hv_kvp and hv_filecopy. They don't really fit into
> > an existing kernel API, and they create their own devices under /dev
> > and communicates with a user-mode daemon to do most of the work. It's
> > a better model that we can move those drivers entirely into user-mode.
>=20
> How are you going to be able to remove drivers that export an existing
> user/kernel api and not break current systems?

It will be some configuration challenges, but it's doable. Newer Linux
VMs can be configured in a way to use the UIO interfaces. This doesn't brea=
k
any existing VMs because the old model will continue to work when UIO is no=
t
used. Also, this doesn't require any Hyper-V changes.

>=20
> > > Also, if you do do this, you need to list where the source for that
> > > userspace code is so that users can get it and have their distros
> > > package it up for them.  I do not see that here at all.
> > >
> > >
> > > >
> > > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > > ---
> > > >  drivers/uio/uio_hv_generic.c | 9 +++------
> > > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/uio/uio_hv_generic.c
> > > > b/drivers/uio/uio_hv_generic.c index c08a6cfd119f..8e5aa4a1247f
> > > > 100644
> > > > --- a/drivers/uio/uio_hv_generic.c
> > > > +++ b/drivers/uio/uio_hv_generic.c
> > > > @@ -84,6 +84,9 @@ hv_uio_irqcontrol(struct uio_info *info, s32
> irq_state)
> > > >  	dev->channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
> > > >  	virt_mb();
> > > >
> > > > +	if (!dev->channel->offermsg.monitor_allocated && irq_state)
> > > > +		vmbus_setevent(dev->channel);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -239,12 +242,6 @@ hv_uio_probe(struct hv_device *dev,
> > > >  	void *ring_buffer;
> > > >  	int ret;
> > > >
> > > > -	/* Communicating with host has to be via shared memory not
> > > hypercall */
> > > > -	if (!channel->offermsg.monitor_allocated) {
> > > > -		dev_err(&dev->device, "vmbus channel requires
> > > hypercall\n");
> > >
> > > I do not understand, why is this check not made anymore here?  Why
> > > constantly make the call above in the irq handler instead?  Isn't
> > > that going to be massively slow?
> >
> > Some VMBUS devices exposed by the Hyper-V are not modeled as high
> > speed, they use hypercall, not monitored bits. Because they don't fit
> > into other kernel API (as explained above), can we use UIO for those
> devices?
>=20
> UIO is for mmaped memory regions, like PCI devices, how is this a valid
> Hyper-V api at all?

Currently uio_hv_generic is used to mmap VMBUS ring buffers to user-mode.
The primary use case is for DPDK. However, the same mmap model can be
used for all other VMBUS devices, as they all use the same ring buffers mod=
el.

Long
