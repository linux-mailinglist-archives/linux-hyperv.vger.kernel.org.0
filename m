Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673202CFC8F
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Dec 2020 19:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgLES23 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Dec 2020 13:28:29 -0500
Received: from mail-mw2nam12on2129.outbound.protection.outlook.com ([40.107.244.129]:23680
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbgLES20 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Dec 2020 13:28:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mugOmE9AvIo0B/BJUoGdWqvNeDff/VZ4xRv4c8V61ZZY+Ej9ZZk8sMGDdha3iD1nsMbaOTSlzjH7SJWhB2HJjUFDGswGRBVt/RpiicPAo7Z96w47PvVslq5/E8YOlgTofSb0I41jEcuUuHreyjXwdLWvmQbKVPKy1GJ7co1po4w6l+ttuGNtGXtswdkQcjtUhno7JTJvFAhBos3KZspJ5MVxiA3h3RiwTD9ujCvtc5eo+saVJq5DWGVQeo3K1Yg/dAvPCm4FSED5xwCiskgfpfm6Mlz52YRLhLLcWooV28hoJ8S6a+gXVLsV8OU2Q4TuRJy5HNh5lru2dwpWAwl8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPVVlApDI+Jy3Ftyt3NLfqRa2eDWace+zO6dC3DNsHI=;
 b=AZ0/BlCndoAZ3wyG3CUoibuC1ojrj5dTtKHol5akaF8Gpcou5nd5b0RTNHSAgm50sDUGptk5NcYqMplVPrYevNXCQ/K7HdKtp6dpUBNfDBfdz5x0QrhhqqBfh3rjj8ekkXksyoEhy1vRQ95boPaCg0KapaZh+djUL/n/RUiobD4drWK+IVcnNivmny6Lu3dde5lWkq+onLhhZnBCahIDbWRUs+EsKKi8/THJltMO9+QxhD7Zj8P1vQ/GHTtxeo1WZ72PFHVlBTJ8HEHk807oL1bgen0xxh/QFN7ws5x4WtCTgkHaAJX7aCyvPO4xsg+/jJWgAdlBfl5gqQ3pX/EJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPVVlApDI+Jy3Ftyt3NLfqRa2eDWace+zO6dC3DNsHI=;
 b=KiOaFq3aX+dkDeeQmaiMxhZgimT4Av5WjTWG/btLYtUUG9DP72v6C+M7g5970A1DKE+4mzRF040x5U4urmIlSSEu5BlHjI+Mv/k2pok8hGGaQYEB8oq7K9LBkMTLRXy07TXFgGinU/cv0ivRBjgL4jITX+pE/ym8jEQX5In69ag=
Received: from (2603:10b6:302:a::16) by
 MW4PR21MB1889.namprd21.prod.outlook.com (2603:10b6:303:77::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.11; Sat, 5 Dec 2020 18:27:38 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3654.005; Sat, 5 Dec 2020
 18:27:38 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Stefan Eschenbacher <stefan.eschenbacher@fau.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel@i4.cs.fau.de" <linux-kernel@i4.cs.fau.de>,
        Max Stolze <max.stolze@fau.de>
Subject: RE: [PATCH 0/3] drivers/hv: make max_num_channels_supported
 configurable
Thread-Topic: [PATCH 0/3] drivers/hv: make max_num_channels_supported
 configurable
Thread-Index: AQHWyy4HqEchZIoy5kOEspja/IM9V6nozdYg
Date:   Sat, 5 Dec 2020 18:27:38 +0000
Message-ID: <MW2PR2101MB1052DC9416ABC1ECFE25E38DD7F01@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
In-Reply-To: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-05T18:27:36Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2fba6f91-7a32-4e79-a432-c3826b079fbc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: fau.de; dkim=none (message not signed)
 header.d=none;fau.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9a1ecca-0809-4db8-b805-08d8994b71f7
x-ms-traffictypediagnostic: MW4PR21MB1889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB18895F1916594DF9CC7C027ED7F01@MW4PR21MB1889.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AUj9tDQk8mlyWTIEIZPbTIR6C2tcHzdpjREzab5hOwmxNKxkW0HisKaMHKY9X/1DqIV0wb84AfPdUWx5FNT3q1N+zSUpFGwGO+66IDoEtRTESRUfH1Cm/Og+EGkFQUH3EcSZUmIumT4PHpio/hwPGd87GmL/ACNs3KrxSyLKJbdkEqYNKJVuxrarq1mnQvCPXUXxFUp0Dd+o3OmOttA13+MVgShXRx80svR/+1JXRLYvYuE5I1K6Lk6x/GgdrS+/G4/XsrXvoqJC15imb38qRuJ7CeinLFAJrRRA1D8zPM8fW5bGMDk5fF5DTn3BwAoj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(8676002)(8936002)(33656002)(110136005)(4326008)(55016002)(10290500003)(9686003)(86362001)(66476007)(64756008)(76116006)(66556008)(66946007)(66446008)(52536014)(82950400001)(83380400001)(7696005)(6506007)(26005)(186003)(54906003)(316002)(5660300002)(2906002)(82960400001)(71200400001)(478600001)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+d9Pxe1KEp5qHDPfUmeezGECw6HskVwaJtp3M6qI3jPCslrInVSwBYxTT3KZ?=
 =?us-ascii?Q?2hnXoCg3pCDPIpQ6+8thLyLVxO6um52LUZ1saUCcjcXOsYPy/9zWUR2Kb1I/?=
 =?us-ascii?Q?yP2Lr3m9lfNLW1tcj8p/MfHguapbMoXseVgvZrYvTXhQHqJt+ZyzafGScxD0?=
 =?us-ascii?Q?j4V26VGNmA69v1Q9RPnKTmlqhnL3BZzWIj2ti8j4dgGay1I2KxSmBsQxpW/G?=
 =?us-ascii?Q?cPHgcEJlBHsGlKQrgcrcJkp2iiyvZXZ7i9rIDTGsHguMS3UmYxR1Fv4gCR7M?=
 =?us-ascii?Q?3+HnKoX9lFuTDZpoSGq8GY+Nb6p7wP6gRMF88DVusSgvVg5deutytDN/p/MP?=
 =?us-ascii?Q?y/q3Vc6pnCpQNOmClCIDY/swiHUNuPbVu4W7KbYxNf5hWauuvru6A093/cRt?=
 =?us-ascii?Q?uLtH/0Ue0K0lIIZA/8mvZ8XXIKfdfTeAEmd/HVeC3zCAuHskMv0Ewn3z+qg+?=
 =?us-ascii?Q?rriF8fK4vhLz26glQv2U2mNhxnFufOnvb9VLJnQKj++U4lpQpA+spvigXQUG?=
 =?us-ascii?Q?8hcMhPQ1BOdkun2t9bZYMShUO3B28XejSKAqUsrrafqFxJyr6lIjFxwjv69o?=
 =?us-ascii?Q?LjLjDb6icqv0DHhjs4QKWnd1g1+rh0UawPJmD5Y+I9lW4lCuRE+eGV66wGVI?=
 =?us-ascii?Q?wFoP/52LGOgJO1oGKnfHFIwQ8FyaHpjV8iQejoVbzemT6z24X1EpJTKK+Kys?=
 =?us-ascii?Q?JoDUqeS4RYMW7F65E6U5oHPyYvqVPAbIxcHvHkPt0eBBNmX92h9h87mrSuX8?=
 =?us-ascii?Q?TEbeyhHx7Gy8hkdsTO2H7LRbk8P4/rPyV3l42JVEA+XWPzUedP+AB1YHXH4z?=
 =?us-ascii?Q?TvIhZgslGhyIb4pyB/IH9iAr9tI2afiU/YWyT+kv1L/hkU5/w4VK1zxWzJ+8?=
 =?us-ascii?Q?zC5JaWXgTplV24uOQ0GeCtx7GMKdcTbPgGn3o52mfCXaK+kspIr/SZdFWUuM?=
 =?us-ascii?Q?Z4l/n/4X3a05mz+glzNzNNCwLVrL3n2e3wwjYmK3peA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a1ecca-0809-4db8-b805-08d8994b71f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2020 18:27:38.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNsTzK+ntDEfYPoKdjTmz7VrRnIajP91dfe+C6RJ8AYQ/GBAd1MzxnhEWkaEdOwoeVxewoiL0290LD62/tZfOw/OObs44NzE99BcfZ2TYkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1889
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stefan Eschenbacher <stefan.eschenbacher@fau.de>
>=20
> According to the TODO comment in hyperv_vmbus.h the value in macro
> MAX_NUM_CHANNELS_SUPPORTED should be configurable. The first patch
> accomplishes that by introducting uint max_num_channels_supported as
> module parameter.
> Also macro MAX_NUM_CHANNELS_SUPPORTED_DEFAULT is introduced with
> value 256, which is the currently used macro value.
> MAX_NUM_CHANNELS_SUPPORTED was found and replaced in two locations.
>=20
> During module initialization sanity checks are applied which will result
> in EINVAL or ERANGE if the given value is no multiple of 32 or larger tha=
n
> MAX_NUM_CHANNELS.
>=20
> While testing, we found a misleading typo in the comment for the macro
> MAX_NUM_CHANNELS which is fixed by the second patch.
>=20
> The third patch makes the added default macro configurable by
> introduction and use of Kconfig parameter HYPERV_VMBUS_DEFAULT_CHANNELS.
> Default value remains at 256.
>=20
> Two notes on these patches:
> 1) With above patches it is valid to configure max_num_channels_supported
> and MAX_NUM_CHANNELS_SUPPORTED_DEFAULT as 0. We simply don't know if that
> is a valid value. Doing so while testing still left us with a working
> Debian VM in Hyper-V on Windows 10.
> 2) To set the Kconfig parameter the user currently has to divide the
> desired default number of channels by 32 and enter the result of that
> calculation. This way both known constraints we got from the comments in
> the code are enforced. It feels a bit unintuitive though. We haven't foun=
d
> Kconfig options to ensure that the value is a multiple of 32. So if you'd
> like us to fix that we'd be happy for some input on how to settle it with
> Kconfig.
>=20
> Signed-off-by: Stefan Eschenbacher <stefan.eschenbacher@fau.de>
> Co-developed-by: Max Stolze <max.stolze@fau.de>
> Signed-off-by: Max Stolze <max.stolze@fau.de>
>=20
> Stefan Eschenbacher (3):
>   drivers/hv: make max_num_channels_supported configurable
>   drivers/hv: fix misleading typo in comment
>   drivers/hv: add default number of vmbus channels to Kconfig
>=20
>  drivers/hv/Kconfig        | 13 +++++++++++++
>  drivers/hv/hyperv_vmbus.h |  8 ++++----
>  drivers/hv/vmbus_drv.c    | 20 +++++++++++++++++++-
>  3 files changed, 36 insertions(+), 5 deletions(-)
>=20
> --
> 2.20.1

Stefan -- this cover letter email came through, but it doesn't look like
the individual patch emails did.  So you might want to check your
patch sending process.

Thanks for your interest in this old "TODO" item.  But let me provide some
additional background.  Starting in Windows 8 and Windows Server 2012,
Hyper-V revised the mechanism by which channel interrupt notifications
are made.  The MAX_NUM_CHANNELS_SUPPORTED value is only used
with Windows 7 and Windows Server 2008 R2, neither of which is officially
supported any longer.  See the code at the top of vmbus_chan_sched() where
the VMBus protocol version is checked, and MAX_NUM_CHANNELS_SUPPORTED
is used only when the protocol version indicates we're running on Windows 7
(or the equivalent Windows Server 2008 R2).

Because the old mechanism was superseded, making the value configurable
doesn't have any benefit.   At some point, we will remove this old code pat=
h
entirely, including the #define MAX_NUM_CHANNELS_SUPPORTED.  The
comment with the "TODO" could be removed, but other than that, I don't
think we want to make these changes.

Michael
