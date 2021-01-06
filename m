Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52432EC558
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbhAFUtT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:49:19 -0500
Received: from mail-dm6nam11on2092.outbound.protection.outlook.com ([40.107.223.92]:9888
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbhAFUtS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:49:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeXKBgHICpUUOHBj9ArB3ADu3uOOD9r7Ug6k2QQaHgOr8n502uiAQ/GJ8B5LA8wYH/sbKyMPoPzgdkM5K0qkk0NxLddPOAXzgV6iDf4tY8UfZQKtHktpv3zvKY8G5GcNfSfZnHGTK9/pPRZ/rjz2yMqdpKRWRIby5dBA+1vguXMnrNfinZiAHekRAOA8/IDRLJp/5rUnG78Yd4rR26xMCHl6xl3bZ0M9Wp6Uz66QRuS8r8QPynlBYCyCEiLhcJqxMl56uxaPrB6J0UrnZZ16az4Pz+08UzAAqnjo3YeunH4pUGnlykRNM32VGbaUDjedWm5kCNoKaZMJ/VjYdsceMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMXcfy8VIcSsOL7ciZPbLVKgZscpP01AWDL6BmM79ck=;
 b=Knfnd8icdaMk7+IryS6wWPrn5WYFvObBGs0GIRzEGf2alUOjEhHRBPHYKXSlXvKEVHfEfNIKUzEPxVbYEKUay9hz6X2p5G5PKViMC5s7v32QTV8HqIDFUMhOZ0EoyAJa4X6aG8+PylZUXgJaQ04u1JzMGClRbWA/0dk6Nu2RHOSqZ7LbJqRHj2+zdh+VTOosn+9X7Yl8WbjURINycmWVOirbgRwhRktVAUWC2Ao8zq8Px6OFELiUDsJlSg8QWjvWcF7gUMnfNBdialgNmfI/2GCMUbMUHqJUKoTmmmblgqRy+EIECWbHIb2JiWAhl41C5aEGrFANBzUCnBIMUpJ0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMXcfy8VIcSsOL7ciZPbLVKgZscpP01AWDL6BmM79ck=;
 b=T9uV+O0DaRmygRDja8MUE0HyPdX8599kqXTK4dgOFdpoeToSdm9fN0NSUe9nzzWmijjyh9obcf60QxQ/JCXiTwaHG4/bCenuawX9UruELH4jPEFVRG/J4wl99ZiEJBrdH3mcIKQCc3bzkxRZFtDO3OB+CQVyCf16brW2I15EOuM=
Received: from (2603:10b6:302:8::19) by
 MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.0; Wed, 6 Jan
 2021 20:48:30 +0000
Received: from MW2PR2101MB1819.namprd21.prod.outlook.com
 ([fe80::5868:f11c:ae6e:8a31]) by MW2PR2101MB1819.namprd21.prod.outlook.com
 ([fe80::5868:f11c:ae6e:8a31%8]) with mapi id 15.20.3763.002; Wed, 6 Jan 2021
 20:48:30 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add /sys/bus/vmbus/supported_features
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add
 /sys/bus/vmbus/supported_features
Thread-Index: AQHW42JoMmd2hzIYf0moXWkZCcjfFaoZnG+AgAEtXICAAEIz8A==
Date:   Wed, 6 Jan 2021 20:48:30 +0000
Message-ID: <MW2PR2101MB18198B5B161F6311B9FB4B5EBFD09@MW2PR2101MB1819.namprd21.prod.outlook.com>
References: <20201223001222.30242-1-decui@microsoft.com>
 <20210105125805.7yypaghcpgafsrcs@liuwe-devbox-debian-v2>
 <MW2PR2101MB18197FBF40A9EC6313FCB5B1BFD19@MW2PR2101MB1819.namprd21.prod.outlook.com>
 <20210106162335.apqevxx2achwsirj@liuwe-devbox-debian-v2>
In-Reply-To: <20210106162335.apqevxx2achwsirj@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=41045f02-42e9-4167-b271-65604e913e9a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-06T20:20:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ce83252-a119-4727-5cf6-08d8b2846cb5
x-ms-traffictypediagnostic: MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09388336FA6EB47FF745AF3DBFD09@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7SsvANOeL7qQeSxY2xRJAObpmsMzsriUIsuV2T39V5mKPA+VLlfROpqwR/3XoU0coMflgLO60UW0wPDMKYFQlfWg6BYgwuv5/M0pRSsFBJ32cXK1Uxg7zcaL2VhpleG2udfreoGjnGFR3wsAaz7TFjHmfM4zP/eTtHDUSjEN3/5wmpKxBWfMD6XkOQPF1RxWasdqKp+YSt71qeLe+csCS/O0RGwUsDHdinrj0eoRIMcEUsn2d51BSfSkMSWncu0JRFkYezcC24zkPGz8W52JhdI4WVTtqE/SrZr2sgo+p3P22/iy8rYjsoEEXyVUvQgyzWT+gRYP4c9ttZdxVh/gQHNDBEOJq+KApp1orBiKa2fBBItZMXhn3ngegGa2SyZZy8RcDEAOESiKrwCMwGio+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1819.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(6506007)(8990500004)(66556008)(10290500003)(6916009)(66446008)(64756008)(66476007)(316002)(186003)(4744005)(82950400001)(76116006)(86362001)(82960400001)(33656002)(9686003)(66946007)(54906003)(7696005)(53546011)(4326008)(478600001)(55016002)(8676002)(2906002)(8936002)(71200400001)(5660300002)(26005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BgNvoVy8YmF2yxscpqdU1PFNd/d5pXAbiF+04AC6qUsQMSeBq6DzenBORuNZ?=
 =?us-ascii?Q?nBNfw4s3pHtMiZ4cE2gSSedrJ7iuKoFgKeGeLYAQsDjDIVMyfmhhW7cm9jYt?=
 =?us-ascii?Q?f5EY4QOGlS6sNglj5TLv5ljBoTwsnMVNiK2NdRBJQe/AWqJWA6ja0rQpRHU1?=
 =?us-ascii?Q?vS0hz+BxCIsq+nIjiGez7XYop3xF74+X5HacZh0cwIEcKJEg/YoOXIvk9FSP?=
 =?us-ascii?Q?vJT7DLU9HhTR6lnmlQIwOhzvoWTdVvjwmQO/RjxcJAuoqVN92xq30mJUUDvS?=
 =?us-ascii?Q?GfYGrJAnolXLKjp4xNDDdbUFK76V8U8d3Ss8nsv3ZRtqfo8cMuPvDIGY44IO?=
 =?us-ascii?Q?2fAsk6Ylhn8UXYwCb3IEqvvGmv8ZguR1tCHeVuzoJllntYpgsFEEkxFVFgZc?=
 =?us-ascii?Q?lYSzvfloTzrKpvO6JP7m90MTq0yvKr5tx9jThVSE1qiii+M6uempweUFA7sR?=
 =?us-ascii?Q?kHa73FIiv6NQiiS4BLi2VVgOhmpH5LN2yONc5jELs+f30VKVtYL13rpvDqAX?=
 =?us-ascii?Q?zsRCjKA3l1TXhX8khJKze3HBWdRW4L6Um9536TSFimYf47i+w6ZTbiwaKLEg?=
 =?us-ascii?Q?/suTQdaBNoDBfshxuoUV8ywwEze4sE5lCdZ3vtKqY0h7z/UQvcsB+GlDaCMq?=
 =?us-ascii?Q?ATZzwzQS61LH1HAWXBxRs2UOKln5Cc5fGlPx6CGk01zhAWwx3enqiNhEHYcT?=
 =?us-ascii?Q?n9cqib8In5jO2jhqj51PUYvJjhOUdHD4DaSdCnzU+zoFpWtKIKaifQOHYNhB?=
 =?us-ascii?Q?ZjxJ+54wAj+/9E66F0aajNMqnOPv8HkmINxKFi+MnPAzDrJrkInk7tsdkPut?=
 =?us-ascii?Q?rTcABvSW1/83u1+YXdjzuHRtU1IZXkrLMxPZbuMOKLskPa5FLvY4fMAms+45?=
 =?us-ascii?Q?NuI1U0BwLsFAIaT31eIiwlLumnbHqe8BHE1rFhNodYhcmg3Un4ff6E4k6hik?=
 =?us-ascii?Q?SBwrQljRmjbdgbNipEdMn2zX2FZYFHHEKMC0jjhDDqk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1819.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce83252-a119-4727-5cf6-08d8b2846cb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 20:48:30.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ON4estLEDSV1BBpr6xPrIgPY5d6FvSSG4OCjow7Y4mCnGIuESSm4/GAnTFu2up+CxWeI/uWAoqP5jEzoS+/xJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Wednesday, January 6, 2021 8:24 AM
> To: Dexuan Cui <decui@microsoft.com>
> >
> > That said, I don't know if there is any hard rule in regard of
> > the timing here. If there is, then v5.12 is OK to me. :-)
> >
>=20
> By the time you posted this (Dec 22), 5.11 was already more or less
> "frozen". Linus wanted -next patches to be merged before Christmas.

Got it. Thanks for the explanation!

> The way I see it this is a new sysfs interface so I think this is
> something new, which is for 5.12.

Ok.=20

> Do you think this should be considered a bug fix?
>=20
> Wei.

Then let's not consider it for v5.11. For now I think the userspace
tool/daemon can check 'dmesg' for the existence of ACPI S4 state
as a workaround. This is not ideal, but it should work reasonably
well, assuming the tool/daemon runs early enough, so the kernel
msg buffer is not yet filled up and overwritten. :-)

Thanks,
-- Dexuan
