Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03E42EB5C7
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 00:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbhAEXFF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 18:05:05 -0500
Received: from mail-dm6nam11on2134.outbound.protection.outlook.com ([40.107.223.134]:49537
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726600AbhAEXFE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 18:05:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBEZZclJm2asXtzdugIcNbwpGkkKEmaBRYPuB8PJ9Hm4GTkU7LPUFqvnS+MQEDh7CYXJweVAqJski+Nm8LOIzfsYGstfpJwD+B/unzB3fsZY1FBrqUPR5+vJigyfHvJaU1GVyDuXbPktACcKDOiVyLq9OM07ZKdTkZZKtV9Q7Pjmeym5Aac95vWgXC1E7rs92d+wZO3bDzTgjBFw7AjaKiTuCWOKDDQ0wDZj3EL9xrhM/i6GhaY4N5UuPrTs9bxp7LuN80/vPhYab4B4Qab6tFcnFgta9irg+nWQDXVHLuFtRbj02SzXQxGZ9E7kAwi2kMpML1rstHx8yVD4KgGKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vNL9JzuAYMXIgiIc0UDunulAGkivelWeDtpRR9xphQ=;
 b=c2NGzdaLVtI9M6jPiJIMzlGxSzmMXKd/GQPMHdZiK7FwNIHW7pARRuGCA4sCrdUW3SmC3KB9RJZSAIp7e7PEf6JI9gObahZFo7t288mk3EnS/UWDdz1kJE8ZSh3b/GJd2weUy1tXDKRziac607dCWcqodsfum/ckXv8Zujr2WewPVvMxX/PNBZi2Oev7QlmxxW7iWX0Dz7ZCJUV+CSH9CJgD8QcBgfFPrO2wMJuZgUEHqKfIQLR9ae76a6wcguaxjbcwX6+7ZqteDHtFX5n8nag5Aj+rUe2SgRWSMsVVVDFznM1WGQ50itzz7iGTKDPpek7xj/SKLsfN3bzGqmrF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vNL9JzuAYMXIgiIc0UDunulAGkivelWeDtpRR9xphQ=;
 b=PhSbz6Qyob8QvQVLA83ab++AA0rZdlVxmkxtKojacFSD/JvK1XjS1Iz1qrB+mQVozxyMP3J3DpJa9Skci0WYbAljH27hVNS3yVpRCue3ZuU+QJxeKfcoVOxYRJGGxHFuWCTk9B7HoN62qnlma7yxv/VYwYd3xUB6hxclFPUFjaE=
Received: from (2603:10b6:302:8::19) by
 MWHPR21MB1548.namprd21.prod.outlook.com (2603:10b6:301:7a::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.0; Tue, 5 Jan 2021 23:04:16 +0000
Received: from MW2PR2101MB1819.namprd21.prod.outlook.com
 ([fe80::5868:f11c:ae6e:8a31]) by MW2PR2101MB1819.namprd21.prod.outlook.com
 ([fe80::5868:f11c:ae6e:8a31%8]) with mapi id 15.20.3763.002; Tue, 5 Jan 2021
 23:04:15 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add /sys/bus/vmbus/supported_features
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add
 /sys/bus/vmbus/supported_features
Thread-Index: AQHW42JoMmd2hzIYf0moXWkZCcjfFaoZnG+A
Date:   Tue, 5 Jan 2021 23:04:15 +0000
Message-ID: <MW2PR2101MB18197FBF40A9EC6313FCB5B1BFD19@MW2PR2101MB1819.namprd21.prod.outlook.com>
References: <20201223001222.30242-1-decui@microsoft.com>
 <20210105125805.7yypaghcpgafsrcs@liuwe-devbox-debian-v2>
In-Reply-To: <20210105125805.7yypaghcpgafsrcs@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e5d50e2b-6a5a-4e6e-95bb-eb79b9635a6e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-05T22:24:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4684417-c621-494c-b651-08d8b1ce397d
x-ms-traffictypediagnostic: MWHPR21MB1548:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB1548D73011E4A9C9E5507E2BBFD19@MWHPR21MB1548.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M7dvyTPZBnwEoizwr7ugV1qxRA5UCf+jien8YOYJzPAX3wBUAcDhdUQHqp6Lb+kPpqU8lnhohTWjhlq/lsvZGoqQjQaKQ3FVEuM1j9EY0mfoWcy2MD7iLm5cKVsB6wOZy9frILYHDP6HzcZyzUjAX0sIpQTVUbHjG2MH8XdwqFPAMNOwU/bwnVGkVr58Ve3E2SXQWegGuePvY4MuywSci8HNS3u71OdYKDt0V1999n84TMdpGJoI7jSKdV20rGRDwyTIoPjLG12U2Nyv1UrEhsdaZoHaI06oa5QyftJInuKlkg1VKKIPuW8NxkMbHmTYw/KY95d9Gje/iAwtGF/ymPMAQosq43qIBWghXHmPuBvOO3WZSb/E5qCEu6fz2nZ7efJj5bk3obpf4DfDJ0UQiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1819.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(316002)(478600001)(66556008)(64756008)(66476007)(66946007)(76116006)(86362001)(9686003)(10290500003)(8936002)(71200400001)(52536014)(82960400001)(186003)(7696005)(82950400001)(6506007)(54906003)(8676002)(26005)(33656002)(4326008)(8990500004)(6636002)(2906002)(110136005)(5660300002)(55016002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cTcfrkbJ9DYl2PhY++40QTIRIEKsEAqFV7Nn78DbJ4EGLCiq9JGxtaHadR2Z?=
 =?us-ascii?Q?iIOKgE+g5iWkpzq7HWP+N70ThQzuXdtDyyZWqZyRbHMH5oQx2pilfL5JUENF?=
 =?us-ascii?Q?q8thfAq2uzEDl6+LIWugWzE6sbhsCYmK/9LVy5DPZqU7KEaJCasWwMLIMyZk?=
 =?us-ascii?Q?DeGIE/J0tzKDwn/2DblrcQjgNfNhbLEC0IOu9OAP1m1oHCV/0mCCJPEi9dX1?=
 =?us-ascii?Q?jQhyUGbBVuMTdoIXgpJ9/cK3e48eHO/tnvkiA+vC/KXMiCdkKqPZwBPUM8+I?=
 =?us-ascii?Q?W0pkGMOAtts+8qQtwFnTuzJYsMilqCfwTJW+0gzDBB52QBW1FUXW3JGxWuZB?=
 =?us-ascii?Q?fnkIJJ24H8hkP3EbzOotLkqWnOvrCbTjB8haNUssrP8auV7hcGj1FNQ1Jv40?=
 =?us-ascii?Q?3EioMIdnAl4NYsaSyJIZYhk1yvaQy/1oMs4VphOn7OsXHj+aovwT/NWaKz/C?=
 =?us-ascii?Q?3wqvrgcTEnqAqNb+aLR+5dOO5HEHza0gg99nj8vYBF6+ORGmcwsCjuSfD4v2?=
 =?us-ascii?Q?euCBpoWXjhii5a05EwELnfJO8tG8DE+S6MrhReq0WDFadgCqYk+x3fwg2+dy?=
 =?us-ascii?Q?qTstm+2tTlx0H8go9kPf6xk/FSb4WXjXhcWPu+14qw2Kof4OctJqfBJJykHb?=
 =?us-ascii?Q?pEI6U6bdEmDwQWaRgq2uLxHEo3tA2Ph+l2ZrbLspJR+j4xk/a41/7+mjEmhK?=
 =?us-ascii?Q?+Ub7wHTd3flHWVuoWGxXrl3OpvRU8LHSejV4HwRaX7+bMu/GrhysQ/ZFtX3B?=
 =?us-ascii?Q?CfM0XAIgiR9QwRUPQlKuRaTrnGGymw9wEFMy4nrbKiGdJ/FxfaONryO7qDur?=
 =?us-ascii?Q?GpdcF00afKzvZjshDgDSyufoN1+6t4bR/yjb3/gmoBKS56YnDgmd6NXGGT1V?=
 =?us-ascii?Q?fqRv3USdKshpkk5R+zzUVBSfIEDsB0JlRYpVwf929MYbUOZd1Mnl9zxNlew8?=
 =?us-ascii?Q?86OLAwy5xdrNq66T5TmXP8ENIbv1LLc2ykddxBUi1G8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1819.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4684417-c621-494c-b651-08d8b1ce397d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 23:04:15.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdVqYRCI/Qq2LpsAZ7Bz1O6zwvKp+/0yRNhf4oZxMy0VbB87C1nVc3O0NTNcEVaXM97zbVI+0H3FO9t1EVVqIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1548
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Tuesday, January 5, 2021 4:58 AM
> > ...
> >  Documentation/ABI/stable/sysfs-bus-vmbus |  7 +++++++
> >  drivers/hv/vmbus_drv.c                   | 20
> ++++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus
> b/Documentation/ABI/stable/sysfs-bus-vmbus
> > index c27b7b89477c..3ba765ae6695 100644
> > --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> > +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> > @@ -1,3 +1,10 @@
> > +What:		/sys/bus/vmbus/supported_features
> > +Date:		Dec 2020
> > +KernelVersion:	5.11
>=20
> Too late for 5.11 now.

The patch was posted 2 weeks ago, before 5.11-rc1. :-)

If possible, we still want this patch to be in 5.11, because:
1. The patch is small and IMO pretty safe.
2. The patch adds new code and doesn't really change any old code.
3. The patch adds a new sys file, which is needed by some
user space tool to auto-setup the configuration for hibernation.
We'd like to integrate the patch into the Linux distros ASAP and
as we know some distros don't accept a patch if it's not in the
mainline.

So, if the patch itself looks good, IMO it would be better to be
in v5.11 rather than in v5.12, which will need extra time of
2~3 months.

That said, I don't know if there is any hard rule in regard of
the timing here. If there is, then v5.12 is OK to me. :-)
=20
> Given this is a list of strings, do you want to enumerate them in a
> Values section or the Description section?
>=20
> Wei.

Currently there is only one possible string "hibernation".
Not sure if we would need to add more strings in future, but yes
it's a good idea to list the string in a "Value" section.=20

Will post v2 shortly.

Thanks,
-- Dexuan
