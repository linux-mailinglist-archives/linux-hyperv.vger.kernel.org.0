Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB751135E4
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2019 20:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfLDTpD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Dec 2019 14:45:03 -0500
Received: from mail-eopbgr690125.outbound.protection.outlook.com ([40.107.69.125]:8245
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727867AbfLDTpD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Dec 2019 14:45:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGlsKb+FTdcVBuW1ZnMYfvit01Bv5iWf6ATz7EPCFCF+Fyxu4w/WyOcAHuNEBo9vrFdvmql3Z2TW+fke8E8CJaQRHIEvADpiHsMDk89uf8MGJ88pYrCrN8qWDOhZj2+7U1atpUBVooQFPON3u+FeP0LhWyWARohyCSzo6+LleLEucsjHF2RpfoE04McZGxvjkrYpNRzDMwQzIKklDuNVpQpFDn5mO3D1VGxolYiCYNmf13xmy0OdLI638Zj3/hD+LJ142RzJufETCn4MaFXMHXrRpcMHtJ1SoAXJ9A13kqIyChBeRz22rwuB9gIfPG/8c9SDPxtjciCnahJ0gl8fMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i7UhJkiqIsV5K7QnADv/1amsw/g4zHs53w7LTvwyPA=;
 b=Px/rmdRV9OMnn+YlY51N2aeN+ZUcYkVlc5lNDtqAWequA9pOpgnPHNgfvqwblWFcIbPlHbf7Hnx27jKhfjw+MPBntTEkBYrBIQCOdPXodJOGsGZV26lExkMG7aIYTxdN+u3UCineLuDSBEHrJAThxBkGeRDp8UAk2q1mL3T111m9VC4JX6BW3tz0S97J9W/EyuCk83RYJlC9RfYWJf1FPzeJruOsTVcdNyhDsRayu2rA95g9nFymdhIREr6fqCzTf8KWQR/IRw8nGnr5WjNygPcLC3u+CWCzJOi9JXLAhXdGHOQdrXipHP0dvA9BTaMW8DcmCidtni2dBUtBxJkzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i7UhJkiqIsV5K7QnADv/1amsw/g4zHs53w7LTvwyPA=;
 b=eGna4PtaYnq4lxJ8KKmDZHmJmHdK0aNiIFzWnmk107bMdrj+Gyeyu39MTxSG4GjIJ+b9pDsoRzMJ2eII6vUQ2u+GLIs/TZ197WPvUUTwC8xd1zCzLyTkOJR+9fnN+9EdATf3QwUXf1uANksBTzK22trMrNpQZHAAFgmuzdZ2gSU=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.8; Wed, 4 Dec 2019 19:44:57 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 19:44:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [Patch v2 2/2] PCI: hv: Add support for protocol 1.3 and support
 PCI_BUS_RELATIONS2
Thread-Topic: [Patch v2 2/2] PCI: hv: Add support for protocol 1.3 and support
 PCI_BUS_RELATIONS2
Thread-Index: AQHVqk4QCmd6fp+5IUqR2bXfsR0Lw6eqYYPg
Date:   Wed, 4 Dec 2019 19:44:57 +0000
Message-ID: <CY4PR21MB062908EE52EA87D24F2E5D42D75D0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1575428017-87914-1-git-send-email-longli@linuxonhyperv.com>
 <1575428017-87914-2-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1575428017-87914-2-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-04T19:44:56.1090335Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c3b362b3-1887-4e3b-9307-65474d8d78c8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:5d27:4b38:668e:1019]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5827f7cc-42d5-46ca-d852-08d778f2715f
x-ms-traffictypediagnostic: CY4PR21MB0823:|CY4PR21MB0823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0823FB62B9894DFF870E1580D75D0@CY4PR21MB0823.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(7736002)(99286004)(66946007)(52536014)(14454004)(8676002)(2201001)(76116006)(66476007)(110136005)(33656002)(102836004)(81156014)(229853002)(81166006)(66556008)(5660300002)(64756008)(4744005)(66446008)(55016002)(6116002)(10290500003)(4326008)(22452003)(86362001)(186003)(498600001)(25786009)(305945005)(7696005)(76176011)(8936002)(10090500001)(9686003)(2906002)(71200400001)(2501003)(74316002)(11346002)(71190400001)(6246003)(6506007)(6436002)(107886003)(8990500004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?Cfvc5MUpfo+nj15gO4JP0llKzty9zrPWCD49teoUPMqMGpjLecDIISuLyKQB?=
 =?us-ascii?Q?Z27YRaJdr3tArKdvIgsh17Qx+6KJiaSXbhfe9YoAH+CChvR2bJLBSseKYN82?=
 =?us-ascii?Q?ul2QMm667B3lEd9uq4zTBv3Lhtb6qxpDh3CFmwPnSGLhGXEjNto+cvO337Fu?=
 =?us-ascii?Q?sfJbPSO2QnlWgOLvOIUDdim13cqnXy0eW9q++bkSD/3c8jOQ0TkJyJ365TY8?=
 =?us-ascii?Q?BQuX1TFsdR/CmT+FDj2GmdSmhgiyCDtXMufOlSrz0qS/BKFvAboEll0vVu4R?=
 =?us-ascii?Q?UnsR+AbmmFLMthNsRP4lGUNftGT9LT5NXtrpZH8hSuL5mxIzqsILiVEN9cXw?=
 =?us-ascii?Q?gaX+gs6kFw/MO5xJ+b+Td9O14Fe0Y8/kL0jLU7I/sfeb3SEcnJZM4HLcKBHM?=
 =?us-ascii?Q?V8A4EMddK1s1vFfJyYvg+oXXa3JJSW1okxZox7VehgjeHY0L1TooYiJFHkRB?=
 =?us-ascii?Q?+KP8EDzU4SBIUIjnPNclrzRpUiBw7unIE6No7A9o8qiX4q5sy5SaA/LL0HdO?=
 =?us-ascii?Q?eH4AWVF/hWO1xJbMUp4FGDOGlZbT1I6uY+iRkjLDi396/xYgsLmyYhZ3w0zz?=
 =?us-ascii?Q?3R/TEZKgzfg6fRZ/iqPUHuBPpxpRmS00W/Rw6aysi78jaoo7TVO/7TLoohx0?=
 =?us-ascii?Q?NuzdO+nlNbpbKhXutzlSIAJ08RfSRwH0F6lbzAEcZQ2Bfov2mK9xibeL5pLb?=
 =?us-ascii?Q?ggdSjj6hLGPIZOamhMWSpvMJud+KsgeKpXbPGU4w1cVEmPOWbCdp+HDjTdH0?=
 =?us-ascii?Q?ifInyPCKmnMJjSM7ami3GzvLSiYQYWsXWX3laRQmOxgLMZKkHVkD8OA6vwGS?=
 =?us-ascii?Q?mCWxUNl+VdB2I3w9sbXXvG7cK0WSozN4/NZaxvjRLkz0nW6tgVX1njsGa/l7?=
 =?us-ascii?Q?fuF7hTjfvjaJA2EyJVdoxDKzKFJq6miGN4UnFd/aRAF+3/d6VBI4Hd6nUzMe?=
 =?us-ascii?Q?PQkppxJixoHFtNqGNxIe2U4Ufy/6VobnoBWtQ2/4S6ZMDy2+pMdoPLK2Bp2t?=
 =?us-ascii?Q?dr7s5ROluSKD8c3tbWYdFQF1BVh+v9nT5tHTU0cG+6UcV07Wv/gN2qGfdLI7?=
 =?us-ascii?Q?ulDgdMm/rMxAk7bmdlIauyD91kvdr5+Uz13ljY4RpSfHmnI2m82oiA+b333Z?=
 =?us-ascii?Q?70Ujte/KnbeAjRpk/nb+KUNq0EHMbCfCYJuIY9zt+8VzodEn/2ocH16Wbh7g?=
 =?us-ascii?Q?sRC0DCHYD0CKca833b1XwVLJOrEqvuYaeRncSOjALOpkI9mi0Xzn1+R5fz7I?=
 =?us-ascii?Q?98sPVmKoNoxXHozC1gzk+3dpYzDVFmrN/qCEYCjuSMjl60wbqBNkMKJ35qQJ?=
 =?us-ascii?Q?aZwS/0u9ejWbIN0UN95l6vW6nvsy/uRhprX6oSNQ+ul3MbNRHz9oQOJWzX/I?=
 =?us-ascii?Q?V6YQa6vrSqMecLaOje4pUQdXTl9jy8tHMHbci6GplqYRBJAN92bN8rRcfHLh?=
 =?us-ascii?Q?gHohEBY9cMMsvQwKJLo6rTNnuDrIlYNyggWXtI/NGeJM6FepsRZPvOo4k1+3?=
 =?us-ascii?Q?/AmhOr4zZi5rfMieoq0LMSBnUKZggFvexpA5ABSpLf7CNxGgJioPFP+tHGNa?=
 =?us-ascii?Q?YCaVQoI35T7vBxh3AMiGu9E0lVC9ctflBQF4jlpyWNkVxdJujSeTKbcjv014?=
 =?us-ascii?Q?nZa5TU5WjzjVW+3EMu9+nBm6RYnZGirUTa7+UjmAA+ep/2DJdeD5jmFW5ix2?=
 =?us-ascii?Q?PRSE2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5827f7cc-42d5-46ca-d852-08d778f2715f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 19:44:57.4470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIJEQQ72AZOl/DpMWtg7O47Jwbix641D2hGMV9GN9PlUcGljilqnSBdcnxFw/8FVyjQ08+7Iloiv3EQUlP2Rp4JqbQZWihWhUIhH3228tLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Tuesday, December 3, 2019 6:54 P=
M
>=20
> Starting with Hyper-V PCI protocol version 1.3, the host VSP can send
> PCI_BUS_RELATIONS2 and pass the vNUMA node information for devices on the=
 bus.
> The vNUMA node tells which guest NUMA node this device is on based on gue=
st
> VM configuration topology and physical device inforamtion.
>=20
> The patch adds code to negotiate v1.3 and process PCI_BUS_RELATIONS2.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>=20
> Changes
> v2: Changed some spaces to tabs, added put_pcichild() after get_pcichild_=
wslot(), renamed
> pci_assign_numa_node() to hv_pci_assign_numa_node()
>=20
>  drivers/pci/controller/pci-hyperv.c | 109 ++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
