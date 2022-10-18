Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179E5602467
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Oct 2022 08:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJRGb2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Oct 2022 02:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJRGb1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Oct 2022 02:31:27 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021025.outbound.protection.outlook.com [52.101.52.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316016599;
        Mon, 17 Oct 2022 23:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZUv2tF8nguip0wWgZElkZhV5lNfgZbpMdQtXJA/igI7AGNMnZML1fgIg7Yc1zfS//08b6Ixzm0pYpQ5XYHdiHsOOV4C5sqlatKgpj5XrPqHP+ymz3ZV5yBLC+gNE38n1/koV7O0zhmtyW0Ok7gWkA79+WZWKt3e+kv3o4oMn+p8i53vkoXcJnRDP2QNyg6xdW5cyy8IQYcukaYisZdLqkvC/isFjSC9JPX3ikKqV14+36R5CeMb70Wy1uB9KKh87lxEi7Lwn/YiRyOIhE5P+6QCHmEfi9D6pcuEn6378jYG+JhaeIB/5ZKsfMjCx7FGr3riUW6O8fpij91W5TrrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Dfsge9JDruuGo6bIsQTVzzFjT82ocg/CtFvjB6zx5M=;
 b=gTGX2pKF2eNonVgpoKqusBKxQUsUEeqH9NdI8fiMTC68Ol2JPKDgQYpxsONjmdFGb6t2feq8rmKTi56oie1OCAWhD8C1FTmIMcF09HT5sD5Y0skPeRFsjEdfSVVEc7B55gGOXuf4Xff1YcDydpJVXCB/aR1xdDFhcj7IDLXyXFafJCfIlnBy/3X2CNC/C33OOlbU1RGO7C8ho6D5xGQMXyi9ihAuiRKaFn0rb85wn+jJw+b0BDctkRojeUSNzWlxfGSVQ9x/80sHUFwzE36f5c9ZQitWp8eroigUQjUx30UfeCtL72zKRkBTER8yyw2oWPPY2sm8OCd/2/jS1+BBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dfsge9JDruuGo6bIsQTVzzFjT82ocg/CtFvjB6zx5M=;
 b=OD6wsLwhG3TBBKvh+9lkxRLKa0QSFcXglG6bA6nv9CIpvoV/stC67KZHeAogC6ChWJus+f9LX7z2kYkhEECYjfeB4TiHS48KODLCzlxN4P8jLzYfu9drjgNmb76gIV5Cv9FAUqSnZN4N2H8K2/QtDmC76GtOCQCZXbOreFA8InQ=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by PH7PR21MB3070.namprd21.prod.outlook.com (2603:10b6:510:1e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6; Tue, 18 Oct
 2022 06:31:16 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::7c3c:5968:72d6:3b5f]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::7c3c:5968:72d6:3b5f%7]) with mapi id 15.20.5746.016; Tue, 18 Oct 2022
 06:31:16 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     Saurabh Singh Sengar <ssengar@microsoft.com>,
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
Thread-Index: AQHY3zG2NgbGNaLQJkmnL/cmXn/Bqq4NgIeAgAYwnHA=
Date:   Tue, 18 Oct 2022 06:31:16 +0000
Message-ID: <PH7PR21MB32633D172133A769357BD97ECE289@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com>
 <Y0kRIcXG+wNbcGx0@kroah.com>
In-Reply-To: <Y0kRIcXG+wNbcGx0@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=760fcc7b-e9c6-428d-a63a-2736fd0b3d5e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-18T06:06:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|PH7PR21MB3070:EE_
x-ms-office365-filtering-correlation-id: 6eb1bb38-36ab-47da-d768-08dab0d25c43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d6dgMla3V2YDWBAbAlO/EkwbkgWDqB/o7rvGhVgxDTi7V6wgyLnxPhQ9++S2NGkOd/yG6bJXTSoGi3UywIZaql/FpWKtwi7Npzff5/1nROUqg93qOwslvwXvjHobVMgq1ZfmXxAMUei38rfNfkh18dO0xLqRGy9yF350kP0b/jjbaPNE/GvZQSOx9nXwkKUKfBNfInfebw4sqiu34p5zkZ3kc/3mCzvbHmGQ9TRe3tqqHDQgPVCn2IA5r1++bTfOBvlZIE46pBt2Kjciz0+2/wFN5xJnvOG7ov6vcucTe38nBlMi5FZHI1zc0OexdUKRmb142puE4my2w+3IZ952RecHvkNQ1LImbRu/j2LBE9Ru9FQ0/YYi7otbRlRhLnbxNfbJ3C7r04JYFmdK68vyKCwUxVJLuIgssPl0KPd4p51kEjK933RwvKbZFWbHINngNqf+hiLzbME8HYTAXMU1XxaWo0cb7KHytrH1fLNfEWCZPhZeM+1HZRTOa/WQvq1016rrXHj02blTM1C4QnDXjXLKY0DWP1a0eiqAO6/wc6Qf793gDa64zK0v/p58HRA5ZLOQuzKxLRAsbmg2TBkiqBG22z0J4188Jy5j7EEMPREGbRHxU7x0uI+CfWGgs9wYifMUsHW5zTJYglF7qvQ/aUGRoHmO6w88l5IQkJDTevnwo6Ch9CvKwwAhLd0TFdOSa31gmQUBPTNBh9KokIGbA0aTzVjN0DfVmqKHBPN0cjp9o/LXRKw4ZqvEY/fsZQ1y4j1j9+C5zNb0nZQioNpBT/0T5M0RjYO1i2h2AKZk4VqBBCPIBV1xTOw7jZ9WV9wSu0L4H9HAvifsbPvWu+GKUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(10290500003)(55016003)(66446008)(9686003)(66556008)(478600001)(8676002)(66476007)(52536014)(107886003)(66946007)(76116006)(5660300002)(6506007)(86362001)(64756008)(7696005)(38070700005)(82960400001)(122000001)(82950400001)(26005)(4326008)(38100700002)(316002)(2906002)(41300700001)(8936002)(186003)(110136005)(33656002)(54906003)(71200400001)(83380400001)(66899015)(8990500004)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AAEor7KwKTa8ceFwDBIJL05coz19uA9S1cSJyN8zQ3mmL7Z7i22xbPlNj/Rr?=
 =?us-ascii?Q?EB1FfLo4UQllY5pDVFRS24CnQx7e2Ndlq/OwInldyrIR4n713xPmFHqDsDGO?=
 =?us-ascii?Q?N7IpsQPy4Xq8upDABBYIW4aor54xKNlunbaufGuUu4N7peSLZsna59XwYxxc?=
 =?us-ascii?Q?CJ6CpuZDLzTwZgE6/yokN7mWJ6dLsqkqizK2vZy7QIg4NHRTbP+LCNQ48RjV?=
 =?us-ascii?Q?iLcX0TocCcCR4boTwfXKngLnX0ruEA6osA4pWCn/7Z+n3NEif7l+NRq3OZ12?=
 =?us-ascii?Q?YNVJ0qAIJ1jml85oceeVeW+dCO04hA4QiUVJk31D2Shtj8tprdHJSUS9Gt/M?=
 =?us-ascii?Q?JrECcTrdOUiLFS1pJ1yAdBa75BEf2ICIvEDyZP7tUYpJfOsokM2xj+JLWbKM?=
 =?us-ascii?Q?xN0Vm5vJhvxh6Boi6xa9OiKmDdeXecXLbO0L78rw9kOrDBAzzbK8gmRcgdP4?=
 =?us-ascii?Q?Kv2U3+moct7USPY4N89EMbgCmW1cCJqhoio+ORgGGYCPutx8SY82QDD3UvfX?=
 =?us-ascii?Q?QUqQ+50b3ycMU1NPRTn+zTEoRB36QdO5O3S918XFy9mhdLwdsetb6gIiTaTF?=
 =?us-ascii?Q?2PVsbjoxyuqpJVTisBGfXAvJBYLQsJZOV0R7tr1BCv4A7/x8gJBeK9H3CvPx?=
 =?us-ascii?Q?Jt5/uUhGI2lS1Vw4fazfVTCZME8a7UiViZaKvJtBXHL1VrSbopxeeqcqj1wK?=
 =?us-ascii?Q?oCoYd1ra4ItmlkeanNQJdegb2BdviVvfcM+iS+T8P3khGUHQ1yaPmnpbfkb3?=
 =?us-ascii?Q?K6DiLmIAtDEEIzrUf+7R4bmouBMXxh6yx/uT7GmcKIpy/7G21+uMuPjyQqr2?=
 =?us-ascii?Q?n9KASgehJjaag7atajMnVwrNTNwVTNP4vfsV5GeZ4ov3P84pOfHjegYSHBY4?=
 =?us-ascii?Q?G9NpWRcosVunPm38MTIcW/LGvvyAQL3Zx6UOAXmLnZRLzy58g/6QuuMf46Gf?=
 =?us-ascii?Q?Zwu8i5i4OK9x9QcG1f4DPQD/AytJMj55g5EBF/R4VTmb/uf14sMwPPuB78dD?=
 =?us-ascii?Q?DCBVpfJq8+5aD/IaSjvMuk2H60iC2KXvjtBCCM/qctdWyWCSXYEKxbTc1Veg?=
 =?us-ascii?Q?swXSEpl3rnXABQ44n/EQJHkag3UGs/csGUptS2XeNm5L3EzhfC053FTHRyDH?=
 =?us-ascii?Q?N9NXSevU6+RqyZAnyjrvd3VDQJtAWoXoS95Hty8p1biWQ9dbbFLjy5Xh4iGI?=
 =?us-ascii?Q?CiVwvhjj61hUhCcOgGMaLCh/HLqn5ZmR+Y8Y14YNg9L35BH5ya4wo2bJNF9X?=
 =?us-ascii?Q?xAdU+YtUm9WvYm/rqhI8yFjIz+qCVtggt6RFwI8j5QCC3bu/j+vqsm82SDkG?=
 =?us-ascii?Q?NoLZ46vfocu3uCUbvppR2IZmy9Z5ZPPagSCqO2s4BKfYU49bu0KkpdfEOi3C?=
 =?us-ascii?Q?lRNLxwhLoWkuEYUD2d7Bt10UX29K2yM7VnW810Nxe8SlA99fI63NyA+od4CP?=
 =?us-ascii?Q?KwWoSyLUOs5sEDsr/z8ts3bmu08whrcKK69c/qEGJAJ+xq/vf4gkeUIpbURB?=
 =?us-ascii?Q?tWgbz0gKn9Xe5P7ngQXcdcf28h3VZ6E3QAL+KxL5M5CPe3+0QHehyuHWvOMl?=
 =?us-ascii?Q?8FItlR9ZQ7u0Rwxd+K5F/L3o9srSnShJskTuCJOT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb1bb38-36ab-47da-d768-08dab0d25c43
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 06:31:16.3448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0z7VAEF8VUW9z4wNpyia5il/37Vi0v7qiQvWVCTWdLuu1ANvA57+f554KTGe0KF2awFHjFF4PjlC5rKux9KNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3070
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
> On Thu, Oct 13, 2022 at 11:29:14AM -0700, Saurabh Sengar wrote:
> > Hyper-V is adding some "specialty" synthetic devices.
>=20
> What devices are those specifically?
>=20
> > Instead of writing new kernel-level VMBus drivers for these devices,
> > the devices will be presented to user space via this existing Hyper-V
> > generic UIO driver, so that a user space driver can handle the device.
> > Since these new synthetic devices are low speed devices, they don't
> > support monitor bits and we must use vmbus_setevent() to enable
> > interrupts from the host.
>=20
> That is not what the UIO interface is for.  Please write real drivers so =
that
> they tie into the specific user/kernel apis for those device types.
>=20
> Without a specific list of what these devices are, I can not recommend th=
at
> anyone use the UIO api for them as that's probably not a good idea.

There are some VMBUS drivers currently not implemented in Linux. Out of all
VMBUS drivers, two use "monitored bits": they are network and storage drive=
rs.
All the rest VMBUS drivers use hypercall for host notification and signal f=
or next
interrupt. One example of such driver is to collect process level crash inf=
ormation
for diagnostic purposes.

Also, we want to move some existing kernel mode VMBUS drivers to user-space=
,
such as hv_kvp and hv_filecopy. They don't really fit into an existing kern=
el API, and
they create their own devices under /dev and communicates with a user-mode
daemon to do most of the work. It's a better model that we can move those d=
rivers
entirely into user-mode.

>=20
> Also, if you do do this, you need to list where the source for that users=
pace
> code is so that users can get it and have their distros package it up for=
 them.  I
> do not see that here at all.
>=20
>=20
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/uio/uio_hv_generic.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/uio/uio_hv_generic.c
> > b/drivers/uio/uio_hv_generic.c index c08a6cfd119f..8e5aa4a1247f 100644
> > --- a/drivers/uio/uio_hv_generic.c
> > +++ b/drivers/uio/uio_hv_generic.c
> > @@ -84,6 +84,9 @@ hv_uio_irqcontrol(struct uio_info *info, s32 irq_stat=
e)
> >  	dev->channel->inbound.ring_buffer->interrupt_mask =3D !irq_state;
> >  	virt_mb();
> >
> > +	if (!dev->channel->offermsg.monitor_allocated && irq_state)
> > +		vmbus_setevent(dev->channel);
> > +
> >  	return 0;
> >  }
> >
> > @@ -239,12 +242,6 @@ hv_uio_probe(struct hv_device *dev,
> >  	void *ring_buffer;
> >  	int ret;
> >
> > -	/* Communicating with host has to be via shared memory not
> hypercall */
> > -	if (!channel->offermsg.monitor_allocated) {
> > -		dev_err(&dev->device, "vmbus channel requires
> hypercall\n");
>=20
> I do not understand, why is this check not made anymore here?  Why
> constantly make the call above in the irq handler instead?  Isn't that go=
ing to
> be massively slow?

Some VMBUS devices exposed by the Hyper-V are not modeled as high speed,=20
they use hypercall, not monitored bits. Because they don't fit into other k=
ernel
API (as explained above), can we use UIO for those devices?

Thanks,
Long
