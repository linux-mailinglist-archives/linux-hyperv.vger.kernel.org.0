Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401A849FC38
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiA1O4E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 09:56:04 -0500
Received: from mail-eus2azon11021026.outbound.protection.outlook.com ([52.101.57.26]:40710
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231628AbiA1O4E (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 09:56:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB5fOBB7TRnqvKZcjfzJE64Ialf1zzQItAZPr4eh/Jsu5An2MwQe6bQND351ovECZu337dkCIUGdBzf1Vo1z8fDmIQxuO9gXbvJfqxcqfCCu7Ol2ZbX9Y3lPT2NBATob4jQKDJGN8rCD2gOR1+CwQtTo9ICT9fBK5w/HURtG9J9weCNwrEPDPa7Bu6OVIj9Nxn7xlPpYgBTDUQq+T5rmlEgKGk1/t5xq3cjOpUP/Mi9nZUEOa4KvCebwnm6e2YUgICzE6+FWZBQU2Qstb8oQ8XXDmjYsA6v0PRjwpAja7NsYptWT6mzupT6g/ZU9TZzA2SY+5qah/fPmFd3xP0yhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLkH+E9ymLPuSdas77iq62du01XdU6ArDVlNrZHvlKg=;
 b=CflZUmniCM/xzgf/VqwPXU5KU/MCCNre9mMxnFhg/qP9PS8M+nnKlsIJ2/G65OcgaagX0seWdY+OdGQdXNk4LsjYFVZSh+Z+WDq6ZMUWlegy86wP6JqsuEyDVLoa+TDbI+UnV+U811/y1WuL90HhqB01L4yaVZwS5zdWg8ngk3MGgcH6Pd+3H8QkTOvmd20/Ai31H6qR2GsDvHPFFH9Lxkle9ut6LLhQ1qS8Q7whJeE7vIcp8Zg0yJOlyCeGCJvCXwtiowGYVZwa3o8aRqiFVo1BQR3YR0GAC4c0KXJRyEtJC0i/rdRluHUKjAxUegdHJb4e9xOjMOnN+f3AYLW/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLkH+E9ymLPuSdas77iq62du01XdU6ArDVlNrZHvlKg=;
 b=Jrdu2kXmRpVXzyt/odkdNwTcL6Go6iOkarH1yYTxpTIbMrF7Kkj2V17AaEy4+DLWaTx2XRHGz+UOQymRj1VpIUKizcjEY8QN5w7LMiNmKcvbvWvjy09DZvJjbS/TSifmLJOW3KOxzzPYwpFVjwrnkhBJ9vakiP9AJ9oY3CgHHmw=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by DM5PR21MB2111.namprd21.prod.outlook.com (2603:10b6:3:cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Fri, 28 Jan
 2022 14:56:00 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%9]) with mapi id 15.20.4951.007; Fri, 28 Jan 2022
 14:55:59 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 1/2] Drivers: hv: Rename 'alloced' to 'allocated'
Thread-Topic: [PATCH 1/2] Drivers: hv: Rename 'alloced' to 'allocated'
Thread-Index: AQHYFDKgZTj/iGGrE0KbT3DOVO0XH6x4hang
Date:   Fri, 28 Jan 2022 14:55:59 +0000
Message-ID: <MWHPR21MB1593DF0B20DFCCDCDC04A172D7229@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220128103412.3033736-1-vkuznets@redhat.com>
 <20220128103412.3033736-2-vkuznets@redhat.com>
In-Reply-To: <20220128103412.3033736-2-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8712e704-6df7-40ac-9020-cb1ae4ce15dc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-28T14:55:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3abe9314-fa11-4b4b-9e0e-08d9e26e4c0c
x-ms-traffictypediagnostic: DM5PR21MB2111:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB2111DEF5700551A79F3D8596D7229@DM5PR21MB2111.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:231;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jcco/dqZLme8TrzPcjbPt7eYBdjEGVWYXJbe8n9V5FWfpFnsNFA09sY3OfJjFdRHYl/y2XCFauGQVjqcnO1h1Hyqh1dk9IZpAHFv6NGgslWwB1PgvdIy1uX/HeuFbav9ZBoPM2VX4vlraJrG+TRejQTCFlH5bRpCYkGKbqZAypHobi6yPMUHbSSIL3yvFrkeuzmEUn+HUIMmER7hX2e27taXDeaI5mZ8mkxb7CrUd9pUc3yebWTgXm3ewAB4Q2eNhL1SUIx4r9E5sXw4Ohn7E/bJb3hEliIj/XDYUyKWJ9yo24HDrfaYAlGSxuFW3GC4qQ/4ur+iuL+LhkMhrmSOuOF6r5fpCmN4XSMQ17OZwcL4E9CW1i9PMAEPWBmOTPO0fWsavl/34PfpNJ155WapPb8KOPS7p+nbMU/Irct8V8Jv1D3CEGoBgajff7jrSBy/U2cJdrW0wUw6XnloNVLIYGOWwqjVrFxn3Hx0Tr+j9P+SNtzTVnGstvS25y31+00PNOYBOdl5tcox7SLeu2qdBmiuGSesjYKF8KACiReiRIS3KFugBxr9j4DMUvhTBbD4ZLZGlBWROuk09cddkjxuQhLOgfoZtLesVC2zPZR87KP+yPnWlDx53Fk8yN6I5wON7+TYAFfVDlNnSaIkrZmuLOXdsWT1yBCoYVs0YLWqNiEvMnRciTqUU5S4tvgkFhmMrFiJB/GzuQceV1/PJ5nwaFidHdL76MfAXGm1kjm+DXFvJf25LBblew3P/XLLsn+h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(82950400001)(5660300002)(86362001)(2906002)(82960400001)(122000001)(8990500004)(52536014)(83380400001)(26005)(186003)(38100700002)(107886003)(316002)(7696005)(6506007)(4744005)(10290500003)(71200400001)(9686003)(508600001)(66556008)(66446008)(66476007)(64756008)(4326008)(8676002)(76116006)(66946007)(8936002)(55016003)(54906003)(110136005)(33656002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5p+pq98Kp3G9ILIKiaqhKJ4dbqw5yW/cyGq5nlw8Cn15g1iuro26VeArdmeF?=
 =?us-ascii?Q?ERItIf71kSs5vNovsodUqvRUbwSsMx/LA1deZKZNxkPFzLAKyaC0t8fChRV5?=
 =?us-ascii?Q?RL1K2mtv7yxdPviQdUi+EpTRD3L5KGLzotvO8lpP9vZCxdea4edUCyPVggMd?=
 =?us-ascii?Q?TRD0MycLz0KdQe1hx9nn31QwRK8xKO595kX6my9Ata14WIQAeLBOSGyziiKJ?=
 =?us-ascii?Q?0IxeH98QaDXAPjnjlIrSOsuPe3OMFP8XAStTyeqA4m6YJLZwxJwjFX1hgYEX?=
 =?us-ascii?Q?LKNKSses4gS00xswAhGYcDut9PIWTrvCR8IoUgVztjoi5/OeZbpSxKqr2rcO?=
 =?us-ascii?Q?fDmNNZAc3WAKlqE1FchrPaPCCoH4JKbIrVLVulTw7KTjuvqiDaeXdeQ7dyQ7?=
 =?us-ascii?Q?aoBEDdLTXN40BAxx0KXcuLYvZUya07I8mPAY8uyw39MWynJwQytM0UwD2UVC?=
 =?us-ascii?Q?bri6WrBCtrDWvnvVB9WXkTf3grpslzVrWAtQBQKB3/H8AbGTYx0CFoEnzgRV?=
 =?us-ascii?Q?u+n11hr8MQ00+AlHmosnYFN/vFkpRfYxij/HLjVqcmmoDYRYsl+p25jwt3ZT?=
 =?us-ascii?Q?5olac4Y06A8EHRwt83vmLJr3yjkqJuZq9bqMiE4c8CQ7Dk5S4Q/o1paIiEDd?=
 =?us-ascii?Q?z2VndXM2WtZzlJbPBYkpkRRVj8GRXautTGXfS8hGhJ+5KLH2On6z4oSkuM7X?=
 =?us-ascii?Q?zW/QOsu3/yg5MwasDMbij7V5a8517sbB7E/c032XrxkEWCo3SuLeR/i8TMq/?=
 =?us-ascii?Q?p/trwwntboVKLshuyMgpFBwaDrlojLsSbB0CQxOtL3zGkus+eUmeu9KGYsT2?=
 =?us-ascii?Q?+hNassvdLfmlIe14CwUrjGHZ7Qip2sIxQsDipHAkpYK3/Rh94bT/Vg8peUqS?=
 =?us-ascii?Q?JTmc2ZFP11Mriyh0xWGnWXMW7Yrg/FIxubJTuq63rCLX/2keW8dqxnu8CLsr?=
 =?us-ascii?Q?BOMwkoZ6Pmusw+4FRmSV7uoerQYShTjRkD3eEKgEwm+xMtDJ6BBGI3fIuIVo?=
 =?us-ascii?Q?kd9GmX4tWr2cJ0PoVzLUJAHI4PEodfd3qv/kTeJANme4bEysLiYYBogzcVKu?=
 =?us-ascii?Q?9FyRO+OtxlTrafGu/kFDobb4vjOTNCjgdM7WKKomYXnOcRQu+Ov8Xln2M3vD?=
 =?us-ascii?Q?Gfu9VnxKJB967gbtD93ZCvHF+CqQa51NjaePT0nQNYLWFmvdxKfp/2eD+8aK?=
 =?us-ascii?Q?947hhParqt4rrqFo+s4VGJiYFH/cJyzFs4a0B4W4K7FdkCvpTzIYmdHrYtk5?=
 =?us-ascii?Q?ZZSpnDgP4wgjbWH3qzWYHf02MpS4udpav0Xav0WltC5TJfZEnBkFDcVjvd9t?=
 =?us-ascii?Q?e7kbinRKsRZ1Xk0ukr7TUsdSsI0GlsAnhaI6v0occp0/9hszzYLVqhEr6vsL?=
 =?us-ascii?Q?OlIv5aBGu3aheA2KU28zoLZD4ulh+sehcqeqA4wZMjq+MGVOopbcJhqglXr3?=
 =?us-ascii?Q?SoEMgll97TavW0dhdt6biKE0x97EhirrWMV9+lwa0+HwBsMdzA+JAUKTHJ+O?=
 =?us-ascii?Q?oBJsM5n8H3TWjjK2zGdCPxDYRficwPVcrfEOAyoSUyzMsuG1mjeR59Rk9T+e?=
 =?us-ascii?Q?LfNtdt6Z30Y3c0tg42ZxKQqxWt/PCI1issuEcDwRK+ZD+4GeuPnmVQOMXVME?=
 =?us-ascii?Q?fEdQ8c6vzJ/gbV3gvtUgXJsC09XEsxfg7yjT9ZBeieOhmrWkGMxkrRIRNU9R?=
 =?us-ascii?Q?OaRAqg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abe9314-fa11-4b4b-9e0e-08d9e26e4c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 14:55:59.7861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoXK05MYRZPRftQKnBySAFlGFnvI732aV/IB/LLE3yYLr7tuEQEwX3/qgP6fE9yES3ZUjZ7lHl0fd+Zlht1kZCxXEfWlbERlw6gqwPsJmdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB2111
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, January 28, 2022=
 2:34 AM
>=20
> 'Alloced' is not a real word and only saves us two letters, let's
> use 'allocated' instead.
>=20
> No functional change intended.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/channel_mgmt.c | 18 +++++++++---------
>  drivers/hv/hyperv_vmbus.h | 14 +++++++-------
>  drivers/hv/vmbus_drv.c    |  2 +-
>  3 files changed, 17 insertions(+), 17 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
