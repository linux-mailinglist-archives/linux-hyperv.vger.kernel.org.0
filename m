Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C93B9570
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jul 2021 19:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhGAR1F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jul 2021 13:27:05 -0400
Received: from mail-bn8nam12on2110.outbound.protection.outlook.com ([40.107.237.110]:16161
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232977AbhGAR1C (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jul 2021 13:27:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6qMPXDltNmi6hGBFpMu6jzBSB0qzO0jQVEy7KNp5Anklj3GTWDH0BR72V8GcAhDYgzwWpO3nPzFxuUSKUZCOTyaXG4ByLYJrOseFaxH6LIgMclPtwBJkUTj+eT7nHDM6N5ougeilvhmZrmDCKVjOr886uRvBGvmMhyVHktNv8cMjpFfsNIV9SW/vDwt4uEPCT2X4Q1ghwzi15CAp3p0owyuMMeoQPeYPqba9viiQ7wVGhkpbMNCVcsPLOJ+qehYEzDa8nPawsGXT1cZZvs2/JDJosja3gUQNgElwRCnsd8mf11gyY7NiCNjR1Q4wXsPfw5MeEHq+uP+SmJZHYvafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cniL2Flm89r5AXpmDT5Og5sVJ0XxMmH/KVUt9ECFm88=;
 b=IGfE0A95Yb9ssExCySHA8O+satVomX+fahHxkHigaKa89r/Fgo9mwB8IwbCvUxxBTK/exhkvRTW4kDfsExOq9hoFSGIiHCPqA/+4vrmirgv719zA+1HcIG7XyVqYhRhdTECwjrXBZ68z2GGlzYVwbqNSupMh3J5nT9HeUSWqpGqPvZEimXodPdUjD6mUSv3A8jGQe251JTUDq8CBEYBBULfBRDG6+/gjghNh1DrwNkV6xvsAQtfs01C4YD15JEvJ7qRELCFtycRm6WFqu2GU9z630HKft9djlbdJQAD/YbaDgcfwpZHzY6jn8u54cqUTFzLvNwIj5fusavfhTxnCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cniL2Flm89r5AXpmDT5Og5sVJ0XxMmH/KVUt9ECFm88=;
 b=dc/ksfsEvhoTtpND7oQevQxEicc4HCSi6q/A6Q5ALRgyVVfzwYOKKH+i8kI3PXFCoTFF0E8WxCkibtT2jg6z0tlTnMX7ZSDGrTVd5LybaGlhFWy7ch6d/rgn3P6dxrEwmKTzXzWd9N3vbNx1Rxob10Os6m0yUM2o3Q4K3l+VpvA=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1221.namprd21.prod.outlook.com (2603:10b6:a03:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.5; Thu, 1 Jul
 2021 17:24:29 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3%5]) with mapi id 15.20.4308.007; Thu, 1 Jul 2021
 17:24:29 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXalTR5lVKFlOZkEmq8/y9Kgt/basqijaAgAMsL9CAAC4xgIAAgSdQ
Date:   Thu, 1 Jul 2021 17:24:29 +0000
Message-ID: <BY5PR21MB15065D01F0AC2DBFE1E40C47CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <YNq8p1320VkH2T/c@kroah.com>
 <BY5PR21MB1506FC199A753667E72C9B09CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YN2MtVFOC+yd/rRZ@kroah.com>
In-Reply-To: <YN2MtVFOC+yd/rRZ@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0b452feb-7d61-4194-aeb5-4d3b5639905a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-01T17:19:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a44b2d5-e570-4b66-70d2-08d93cb5153b
x-ms-traffictypediagnostic: BYAPR21MB1221:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1221286A60841D3705598288CE009@BYAPR21MB1221.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEYBuRS3hUBhCkAmIvsoNA2rkMGOertdLiO/4tCZk1fmCBxbHGxWx1L+gLa6as97w+8pnJwOztOk3S4xQ4aK/RsiLYBRnmNjrWGN44pvFjl9MakGYiza1WDOPUhnA+zwCt+ew6S+YSfsHO844rhkKJ07pbWSKSkGRQmb2ayEZVHKs10gUe2l9SDd7CdOAgIPxWYliWKRNkbZ7O02r8gA6O7QiqhyNptXmNQUOrtmSCNQ7sngntqsgVT4QpV7hnIj+YvENgDTDi0OqN3w6YA3E5JlTfq5o03/rDIU1S4j5LanF071Frhuxi9+xt44hmvHeJDZKyapGVGlPfWgmmAp4EFUjhG6HfZLIGW4c0AOqUg0NpkBk8yD22JillHLU4pd6zdoeOQk20HcgcXac3M7nq4QS9RlBRk7xMrjh8w3db55ZzKSbgnye4ZosfkSE+M0uNmjZbGuSfmaV0JUQpCy9THn7etlruXGuK1Ai2TUm6+IZyB3PrmuTMNc2Z9/7eU1jM7qKyh4KDKIPwj1ytwwnOiqK6sMRLZQxexI/sAH/YsQ4ag2jRlHMh/jdebuc6cvjdMol8vsTqmBzGNNzrgo2QW317ckxYYonLI1/FoBzB2dKVkWip+FL/mXm4nYLy1aob/WOMBK9+47Wl0kA8QwoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(52536014)(76116006)(66476007)(122000001)(7696005)(6506007)(478600001)(7416002)(55016002)(38100700002)(66946007)(33656002)(54906003)(8676002)(26005)(4326008)(2906002)(10290500003)(71200400001)(82950400001)(64756008)(82960400001)(86362001)(316002)(66556008)(66446008)(9686003)(6916009)(186003)(8936002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N7jH4MxA03iJJjrjs72vcT4+k1ZX3VAL2qux27DbZe/FZStZfOA1OmbpQb3S?=
 =?us-ascii?Q?BSUOoXyTaXCTTX/3D2mCIFUPQ4x/1JZi8+qqWEvhu7hTrI2WdqR6mAQO4nbC?=
 =?us-ascii?Q?7oCmy7qh/g0OIA1aZJlODGjn7xn3GIWp2gKPBgabVT5gfy2hxJq5y46XKycp?=
 =?us-ascii?Q?VDRokBJOlAUwxmUgEnepKKXVKwkl6TXacg8OxOjTFylt1U37bPZlvMlhROqu?=
 =?us-ascii?Q?1d3F/lBSUV6qtp4mEZMCwlwIOPVk0eAhVFgWUQxOseyTUiqUWsXqUc6ri12j?=
 =?us-ascii?Q?tvJBNCbqkDB4xZ8VOak79/3NVqgYuSJpmyiKbvqDc/rYbbpl/8FlAZXcAvn3?=
 =?us-ascii?Q?fNNIa1qmA103aiQvWw0XEfhaGSPGkGdD76tcVtAbcPwFeuZTJtiJosrqmdgE?=
 =?us-ascii?Q?2dTforgFCiPgqrmOp9VLJz04reHw0qDn1h4uKRCUQkJq6XUjuwlBfrdn/CZo?=
 =?us-ascii?Q?d1xn7BusIU/G4YITn0zo5HDut3KoXYgakm1Z8R5+XBwppuHuFqUqDFg9IrIV?=
 =?us-ascii?Q?jN4v4RuE3BDXpd8BPt9wlduhw5BbjuqXL9X+wewdcTW4fOACDzpJWAmqAJ4P?=
 =?us-ascii?Q?yqSSumxvT4+BUyNk7cRYx7FPljl2IaNJKVrH23sM8f/uBa8A3UANevPsA1+v?=
 =?us-ascii?Q?Du2Sxq9hc7OipENmbVqcYnMySychBmfwQCQyiLa21jWqQdg7o9p/VU4t/SNg?=
 =?us-ascii?Q?Ds8Urq4dzisUwvTGw9plEB9P1B2N3d6tbS7ukwYmqvFHmQbkhkZ6z+z3KRSt?=
 =?us-ascii?Q?hh4zqNox+MrpHixXh7Qf+aX+G6pKrWCPGymv/SynUjGOmQKzhC1NVQNZkA5f?=
 =?us-ascii?Q?oawE+m5uBAIMgkbLoJM8zrmG7CxNXEcjZ5bODhn1AeOXF+4tR8Kd9IfdtchC?=
 =?us-ascii?Q?kEeXeex9jWVOM5iMD5JoRGIuaFoIOcIyQlOChEI7ry19zjNY5POa6mx5U+5G?=
 =?us-ascii?Q?2NHP8goxSHHu0JxK4jFSz+IQPpoaGfBe0KtLNl0BdsZk3y/O02hgaoQQbLwq?=
 =?us-ascii?Q?4IEFnoQmWzoSB/6nLU3mXKjwv85EvD1NilOEqkHcM2XTJogaaMEpj4TIDDYV?=
 =?us-ascii?Q?yfWhU7q7qzfM4CmoS/aGLU8Ag2n01f5vA6Q2aGlogAXCBtZfosgy/NxtVtuw?=
 =?us-ascii?Q?iY6l09+lvmgAEd7NfPvI7N2Tlaw8MOgKBLf8udr1OeVDC7AGELjdFLfURsIy?=
 =?us-ascii?Q?ADVuN68+TsuGeliYe6eS1dyvFFkzRAICof0NghznU8CdknAEwBEdmlZZZarQ?=
 =?us-ascii?Q?+shvsglfbTdRQ2ICftVFFFtsKSZNATkaYM3Bw7DugfbDYPTYpIQPhjcvC9od?=
 =?us-ascii?Q?wQEG7wJPasvglFdwb8ZXzmYW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a44b2d5-e570-4b66-70d2-08d93cb5153b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 17:24:29.0598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVEZ0qoE1rZVHjnNLUE0iGL7T3fDv8jN26v/JOxzyKD+BainaBjiXUo84xDGjUYh3hbIDTgY3zAv6Kpixz4Bow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1221
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
>=20
> On Thu, Jul 01, 2021 at 06:58:35AM +0000, Long Li wrote:
> > > Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
> > > > +
> > > > +static struct az_blob_device az_blob_dev;
> > > > +
> > > > +static int az_blob_ringbuffer_size =3D (128 * 1024);
> > > > +module_param(az_blob_ringbuffer_size, int, 0444);
> > > > +MODULE_PARM_DESC(az_blob_ringbuffer_size, "Ring buffer size
> > > > +(bytes)");
> > >
> > > This is NOT the 1990's, please do not create new module parameters.
> > > Just make this work properly for everyone.
> >
> > The default value is chosen so that it works best for most workloads wh=
ile
> not taking too much system resources. It should work out of box for nearl=
y all
> customers.
>=20
> Please wrap your email lines :(
>=20
> Anyway, great, it will work for everyone, no need for this to be changed.
> Then just drop it.
>=20
> > But what we see is that from time to time, some customers still want to
> change those values to work best for their workloads. It's hard to predic=
t their
> workload. They have to recompile the kernel if there is no module paramet=
er
> to do it. So the intent of this module parameter is that if the default v=
alue
> works for you, don't mess up with it.
>=20
> Can you not just determine at runtime that these workloads are overflowin=
g
> the buffer and increase the size of it?  That would be best otherwise you=
 are
> forced to try to deal with a module parameter that is for code, not for d=
evices
> (which is why we do not like module parameters for drivers.)
>=20
> Please remove this for now and if you _REALLY_ need it in the future, mak=
e it
> auto-tunable.  Or if that is somehow impossible, then make it a per-devic=
e
> option, through something like sysfs so that it will work correctly per-d=
evice.
>=20
> thanks,
>=20
> greg k-h

I got your point, will be removing this.=20

Thanks,
Long
