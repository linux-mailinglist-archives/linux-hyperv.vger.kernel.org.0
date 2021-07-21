Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404473D0750
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 05:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhGUCjE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 22:39:04 -0400
Received: from mail-bn7nam10on2128.outbound.protection.outlook.com ([40.107.92.128]:44631
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231566AbhGUCjE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 22:39:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oxjce0s4s+/Mc2jDCYdrL4b4gsHvdDI58CvLkoaJtjjheAvfSi9PdeuxoxWjaLxD3TC8iRiyG/2EoLXeKu6SaVA/6xECdrMQgpznaHuJg4JR11I+/31NVmEd0r+Q4UHLq0QsZa31kj8YbqzfAhCb4m8AlXP9RP3X6pfREIzJ/BzTkPfJOhfC3bVLneWadgqgSPOfEj0xDm/eBDikNI/yrHD71AJOKsGuRu3Th/kU8V0TLZXSfGRE51ZD/ZLvvWxE/ygRpc+Vu8eMbpgCWdai9rstIjgnIjxM9VB3ZjuY1gNBFAiEJ/62j22FRqJwotWu1Cmq3tYf2rLKqBYLU9I5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+9JqPphE5k4y1KlKe0XdJ4fUn4ITEKBbSteyILSsdE=;
 b=VKRAahn0q6xi6bdVixp0h9ao/0S4q6Z5xMdgwVokQ20DC+pqqJ9g/U97DfKVAhw78ZWNnDqv8M+IMqyVgF9ng4niO0UCy03xpuS6w2bhfzdD++M5Q/bIPQSMHzLv6FFpQSrSx6xLeBatnVIH4pvym90b732SUe4LaG5IreQUKAB3Ee6EXqeCvKV15g7xkQN8HSwqwmF2/CoFnMSjAclJ1/GOWvH+l5PnfKj93gbpn60nMGvx7VoHFic6IBDLi1VPW27sFQx4/z6N3MIi5KEJ0xxlOZJz6eZ7F9unZPBOBm7bojCFzuXGN8J23wyMVvW/0H20WqLWmik8SBn6UKesLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+9JqPphE5k4y1KlKe0XdJ4fUn4ITEKBbSteyILSsdE=;
 b=Fqphpqd4BCPC0Ly2wSJ18oY4KXpe7v/mSxPGTHtpNATF1bZmp9x97gIL8bOJToE3QKiFjeDbTHX8mBuh/PpaIOfLQkIqz5I+vBrMNvyqGc6sk5jbSq44q1puo87iA6hXufMINy8pFfmxz1tVBF2bWavACNN+ll0WHr7z163YCdU=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.4; Wed, 21 Jul
 2021 03:19:37 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6%6]) with mapi id 15.20.4373.005; Wed, 21 Jul 2021
 03:19:37 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Input: serio - make write method mandatory
Thread-Topic: [PATCH] Input: serio - make write method mandatory
Thread-Index: AQHXfdOSX/s9hSsO2UWhDuuWWgaquqtMv5Cw
Date:   Wed, 21 Jul 2021 03:19:36 +0000
Message-ID: <MWHPR21MB159385686CD54855A5FBE251D7E39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <YFgUxG/TljMuVeQ3@google.com>
 <YPd+nl30LwKWpEZa@Ryzen-9-3900X.localdomain>
In-Reply-To: <YPd+nl30LwKWpEZa@Ryzen-9-3900X.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=398079d1-5c01-494f-ae75-440ce517779b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-21T03:07:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04e6aa6d-4b89-4279-d61c-08d94bf65ea9
x-ms-traffictypediagnostic: MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB09380B2798D5DCEF7F573307D7E39@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P+ziQ9FelbI2B9vUenNIiCWvDVyoc019ozUXwZofckdJBnI1SS5fTlBRbuO9UTd8LiRUjU38Jz63R4vxiDo71VzdP6vwnpxEoECu9EL+/A65uF6UOwCLrOpwqwUXF8Z7NBQdnKpseI+1NbVKyEplgOXv/FbVcl5Y3G6maEMxo3OKpp6eIRkFcXz2xp2f5iozdfhMHFn39uH/xaCuhYY9VGcNmcX5XIXTonj8WJfGBVO7z7XRrrmS3WFXMFgCePQNHpR105XC5vTz4tcZAYeBggrEMP7BUVN8Kf5ZgjY77lEnfgJObf8O5WBth23g3Xrlzl9siXFjR0i3Tw6337ROvuQDtGvYuS0qajXj6WrKNRxBJKUK02zzh+weN4DJmWMm3e6ALRISC9jSCmX5YdB35pDmdTjyjSNK3ug6CQRQ9UzWkR+jU2CDFS+tfaRAFgAAZxEj/g8ly54IRXFF2UthjRNlhcXozBqmlpVa9KF+sD6gCak4pl807G8ILJJaUvsaZR98pL38qAd6LxWifXHKkaVyFPdWcmZIjxR+KXWhkY54hCmLCnVGWpuaYRlUuRgqwXVSO7FKHbvWUY6HP5Wpzqm1oE8Iono64L7n1Mw2QFJkbwp9/ZydfgHM5bYkEZK0y+VPKL79jtWJo2OvhNchKZOKMil+bJ7cvRPkOUClXzg42nwLnlSBI0YonOljvhwsU55WjFnTcYb9tucakCBV3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(10290500003)(82950400001)(316002)(33656002)(5660300002)(83380400001)(8990500004)(38100700002)(7696005)(54906003)(110136005)(66476007)(6506007)(2906002)(71200400001)(508600001)(82960400001)(86362001)(66946007)(55016002)(64756008)(66556008)(4326008)(8676002)(186003)(8936002)(76116006)(52536014)(122000001)(26005)(9686003)(66446008)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m6TeJCKNhqCH6MMaorPqfQr9Bh9LlG4MY1R97wvg15rcK58D2K74zLIZE+9T?=
 =?us-ascii?Q?K+9yUL1NISxTpIo03TWjPI5awNnS8R4Mc+0mBNImn9zZBr80V7ZxbMyQ5hQs?=
 =?us-ascii?Q?tW5W/MO5C1L7proXz2IaRZPx90twWFOxUYqR5K3M7HmUD1oJ5FqWICEroCG/?=
 =?us-ascii?Q?/TjihJtEaj35hCe6nfD08uC33xsa6L25IqY4F/d6YFvPkGm8YF+rdbRBeImg?=
 =?us-ascii?Q?zkffscX6YM2hOsqywAN4p/dG5IlAXzes/P+sgt12AP+MFkivjVzAHsSGf21+?=
 =?us-ascii?Q?7aF+HRuuNLVHzbPyAsMnHhNawuSp64Ys7TNc0PP+ZO/mey8Q5se97v6hq4JM?=
 =?us-ascii?Q?VvegE965gBlXOzDsLW8T8ATq22RA+YA/1i6GLlHjKVKBQnI9MFuiXpqIuI9A?=
 =?us-ascii?Q?ghmRdAUJ0qdYgZqA24faw8Fv3rz+so6Z2f1mwi0BTcg0ZTUYkfmkg+zDNpzE?=
 =?us-ascii?Q?YiM+hd+EpehxrEDrNkxLeocaj7U4vl7iFXiFjESDKhSUJEI+UJaWEUNWbCSr?=
 =?us-ascii?Q?oknUEnnmY0+42291UUNkjoH/tZbYF0ttHBhrkn4LbDfBFtjLF1fx8D/5pzGa?=
 =?us-ascii?Q?fqTzrKjIELuO0JgK3n5xZKZoogaKMdZaIT2QkH0fg9rRs8dCNV/kaWydJ/q4?=
 =?us-ascii?Q?YFT/CjektnPdzj/XwKL7UC7dY41FL67JCyppktR8cK5p8TkbpZnDxwKE6pzt?=
 =?us-ascii?Q?DelilV6Cw5D9mORbPitjd68eenBabky5F9mlWmGCFgJaGsQZwrcoAdQUY1mt?=
 =?us-ascii?Q?kSv88qZI4EpsYsrKOnRNyHKHlFGZqRk6d7w44vmaseGFGf4iLuvMp/T3cup2?=
 =?us-ascii?Q?MbRTUDkC0bIfMlFNUOzNzfgXAdQLZOpIOQwaNYBcdOH2uP5+joFFws67qJWf?=
 =?us-ascii?Q?5XAUfcZtQ2eBlUQqL6dFvSZN44tz8+ORVGz2p4FvZghOmb4UDSl9UmIM9d0Q?=
 =?us-ascii?Q?YdBaGDYQdlop9Db5t1tSv3ynJV64iJdBskcI3Qk7KLgzY/3wwJ6uLtSbV4ZF?=
 =?us-ascii?Q?74l1r4WNQjK0Mb8g+QrGhT21GDDFEDivSEH+54Abw5b1jBYVLXPuNI2bKxYl?=
 =?us-ascii?Q?zlXFPyXfBByJ8J6gl3eJml6WbZ7cGZs+XmXhYkZbZKpXkZdtpZFz3P8SfXX+?=
 =?us-ascii?Q?YhDXp0x+cmu132Znkmzr1CsBmJiXP4RDhf9t6CC2GKUYDST5KyVWXvLsLmRw?=
 =?us-ascii?Q?QWuV2zhbnbwz9dQ6z//i9VJp6UFP+pb1yHY19uQ4qZBTD3w8F4M5j8EBbHB1?=
 =?us-ascii?Q?d8tLkjZgRnvQiQJl8QmoW5OEuRXPdAmGrAWJK6gd7C+vBd+ArOH2o8vnNssX?=
 =?us-ascii?Q?D3fcXzVr72zmdZu+4or0aYOy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e6aa6d-4b89-4279-d61c-08d94bf65ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 03:19:36.9274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXcTMLySE13oJrndjLTIO6fLwek+/ksQWTQ07RGmOg6keCM3Z8E2FFuu09U9vyOQHx9b5GF+UkBvWmvqRBpV6JDKXZgX9gqCX1zaG2OYnGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org> Sent: Tuesday, July 20, 2021 6:=
56 PM
>=20
> On Sun, Mar 21, 2021 at 08:53:40PM -0700, Dmitry Torokhov wrote:
> > Given that all serio drivers except one implement write() method
> > let's make it mandatory to avoid testing for its presence whenever
> > we attempt to use it.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/serio/ams_delta_serio.c | 6 ++++++
> >  drivers/input/serio/serio.c           | 5 +++++
> >  include/linux/serio.h                 | 5 +----
> >  3 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/seri=
o/ams_delta_serio.c
> > index 1c0be299f179..a1c314897951 100644
> > --- a/drivers/input/serio/ams_delta_serio.c
> > +++ b/drivers/input/serio/ams_delta_serio.c
> > @@ -89,6 +89,11 @@ static irqreturn_t ams_delta_serio_interrupt(int irq=
, void *dev_id)
> >  	return IRQ_HANDLED;
> >  }
> >
> > +static int ams_delta_serio_write(struct serio *serio, u8 data)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> >  static int ams_delta_serio_open(struct serio *serio)
> >  {
> >  	struct ams_delta_serio *priv =3D serio->port_data;
> > @@ -157,6 +162,7 @@ static int ams_delta_serio_init(struct platform_dev=
ice *pdev)
> >  	priv->serio =3D serio;
> >
> >  	serio->id.type =3D SERIO_8042;
> > +	serio->write =3D ams_delta_serio_write;
> >  	serio->open =3D ams_delta_serio_open;
> >  	serio->close =3D ams_delta_serio_close;
> >  	strlcpy(serio->name, "AMS DELTA keyboard adapter", sizeof(serio->name=
));
> > diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> > index 29f491082926..8d229a11bb6b 100644
> > --- a/drivers/input/serio/serio.c
> > +++ b/drivers/input/serio/serio.c
> > @@ -694,6 +694,11 @@ EXPORT_SYMBOL(serio_reconnect);
> >   */
> >  void __serio_register_port(struct serio *serio, struct module *owner)
> >  {
> > +	if (!serio->write) {
> > +		pr_err("%s: refusing to register %s without write method\n",
> > +		       __func__, serio->name);
> > +		return;
> > +	}
> >  	serio_init_port(serio);
> >  	serio_queue_event(serio, owner, SERIO_REGISTER_PORT);
> >  }
> > diff --git a/include/linux/serio.h b/include/linux/serio.h
> > index 6c27d413da92..075f1b8d76fa 100644
> > --- a/include/linux/serio.h
> > +++ b/include/linux/serio.h
> > @@ -121,10 +121,7 @@ void serio_unregister_driver(struct serio_driver *=
drv);
> >
> >  static inline int serio_write(struct serio *serio, unsigned char data)
> >  {
> > -	if (serio->write)
> > -		return serio->write(serio, data);
> > -	else
> > -		return -1;
> > +	return serio->write(serio, data);
> >  }
> >
> >  static inline void serio_drv_write_wakeup(struct serio *serio)
> > --
> > 2.31.0.rc2.261.g7f71774620-goog
> >
> >
> > --
> > Dmitry
>=20
> This patch as commit 81c7c0a350bf ("Input: serio - make write method
> mandatory") in -next breaks input for my Hyper-V VM, which prevents me
> from logging in. I attempted to do something like the following (-1 or
> -EINVAL) which should be equivalent but it does not resolve the issue.
>=20
> Cheers,
> Nathan
>=20
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/=
hyperv-keyboard.c
> index 1a7b72a9016d..d3eee2d4c327 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -311,6 +311,11 @@ static void hv_kbd_stop(struct serio *serio)
>         spin_unlock_irqrestore(&kbd_dev->lock, flags);
>  }
>=20
> +static int hv_kbd_write(struct serio *serio, u8 data)
> +{
> +       return -1;
> +}
> +
>  static int hv_kbd_probe(struct hv_device *hv_dev,
>                         const struct hv_vmbus_device_id *dev_id)
>  {
> @@ -341,6 +346,7 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
>=20
>         hv_serio->start =3D hv_kbd_start;
>         hv_serio->stop =3D hv_kbd_stop;
> +       hv_serio->write =3D hv_kbd_write;
>=20
>         error =3D vmbus_open(hv_dev->channel,
>                            KBD_VSC_SEND_RING_BUFFER_SIZE,

I'm seeing the same problem.  I've added the code to hyperv-keyboard.c that=
 Nathan
proposed, and that solves the immediate problem in that the "refusing to re=
gister"
message no longer occurs.

But there's now a different problem in that this error is output whenever a=
 key
is typed on the Hyper-V synthetic keyboard:

[   11.576716] atkbd serio0: keyboard reset failed on d34b2567-b9b6-42b9-87=
78-0a4ec0b

The Hyper-V keyboard driver depends on the AT Keyboard driver, and there's =
code in
atkbd.c that checks for the existence of the serio->write function.  I have=
n't debugged all
the details, but apparently hyperv-keyboard.c depends on atkbd.c finding th=
at function
as NULL in order to work properly.   See atkbd_connect().  These messages a=
re output
during boot when the two drivers are working properly together:

[    2.672693] hv_vmbus: registering driver hyperv_keyboard
[    2.700587] input: AT Translated Set 2 keyboard as /devices/LNXSYSTM:00/=
LNXSYBUS:00/ACPI0004:00/VMBUS:00/d34b2567-b9b6-42b9-8778-0a4ec0b955bf/serio=
0/input/input1

I'm not seeing the second message when running the latest linux-next.

Michael
