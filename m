Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1463B1135DD
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2019 20:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfLDTlb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Dec 2019 14:41:31 -0500
Received: from mail-eopbgr690102.outbound.protection.outlook.com ([40.107.69.102]:24322
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727867AbfLDTlb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Dec 2019 14:41:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoCUvFmCymUg6Gkjxmt0BRjBj5AhwMI1rHOuzsg0QLFvVvxQFFulhLZesX9Ls7mp6hd8RJKp+RNL9SKjJFbF0Lx+EBLBH97sce+iw73oVNeU4WDyzlxojyd3AOjLAQ0wAYcDgS1rFUcAgv7t7i/w25X1FCBszEcVyA1drofrpN9+vmnONom3Tgpc8GRynA+WN16wIoFGZMMs8QcPvsdMSeYLdcW/zwFZAHjtSozLbhCrAK3DqsUOPwfDlmZx/0ZsFWcCazOshk+jw/4DqIAsOlqDrFt2qwsAuYpyhXu5F4TPOKaedAb0DpQu9sNVe5slBjMoq7dItHYuDD6A82mgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDoEM7EgNd6eOXCaY4bLJsYyW1U3Lz2SQMA3P3LXDv8=;
 b=LHD967lccKQeBnLtR2wWfeMOAg0je5fWh3glaso5ynjfo/9+AR67s7y4IN+58n8VnIkZi0rahOijdKmIo6WOvosUO2bwRhuWIzYq7Jw/KEyc1eMl4WecCuIayeM84Ti9/sEyv6Jk9X+P+OoI5Q7gpXqTUQJxZ6fpCgtu499XyQkGzSAno35ZsBjo3r6NqTIYZ87yyJq0OvKhqBBpfQD4wjwchRwKmAzB2Qz/1M7+A1l6TRf9CUbTJIFQgQmfL8zKOJ1knlLrgOSCOsGKhodESNQY6phNWY7+3i/iIv5YDbsYO+EmGgpcPDbYyU2LWiFU37pUeRoB9QCTJlHmaq3YpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDoEM7EgNd6eOXCaY4bLJsYyW1U3Lz2SQMA3P3LXDv8=;
 b=KzQqsxoXrnO8/37roOs/4rUfBMu7pIjufkb4fwLpeX4e3JXADS3TrEMRieuONt2T+/knBuJ4+TWqKGr0JvKGcHz+UBGYCPPaGmgF3pZypq3ikC9yOUZkIvsbPxQ3RyY/6HPmgSSNzHAF8NBxoGqVAgRMNfFfAx2HEsxMTGJjQpU=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.8; Wed, 4 Dec 2019 19:41:27 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 19:41:27 +0000
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
Subject: RE: [Patch v2 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Thread-Topic: [Patch v2 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Thread-Index: AQHVqk4NaxK6CpnVL0m95xDbFY0JxKeqYMPA
Date:   Wed, 4 Dec 2019 19:41:27 +0000
Message-ID: <CY4PR21MB0629F44348FF838E261932BCD75D0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1575428017-87914-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1575428017-87914-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-04T19:41:25.7087183Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b21d9c28-862c-4501-a145-112dc716f4a8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:5d27:4b38:668e:1019]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cd25bc4-7b5e-46b3-feb7-08d778f1f42c
x-ms-traffictypediagnostic: CY4PR21MB0823:|CY4PR21MB0823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0823AB1F32876CC92E64A243D75D0@CY4PR21MB0823.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(7736002)(99286004)(66946007)(52536014)(14454004)(8676002)(2201001)(76116006)(66476007)(478600001)(110136005)(33656002)(102836004)(81156014)(229853002)(81166006)(66556008)(5660300002)(64756008)(4744005)(66446008)(55016002)(6116002)(10290500003)(4326008)(22452003)(86362001)(186003)(25786009)(305945005)(7696005)(76176011)(8936002)(14444005)(10090500001)(15650500001)(9686003)(2906002)(71200400001)(2501003)(74316002)(11346002)(71190400001)(316002)(6246003)(6506007)(6436002)(107886003)(8990500004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?q0nYnwAM2OQNJN+U/iIx3EFjdwlqFu7X15rhQbOZXjF5KZLFnfCb5/pcIpO5?=
 =?us-ascii?Q?GqB19E0Nih5eAc4TJYN+sDr1iAT8R+lnTfqMuUHw3FzgHlAUkB7PO3Odq5Ur?=
 =?us-ascii?Q?xI1VN6K7flXIMMXzitTbQZQLpOjo3KOw3GDpGqebrcivsxVz/S5Uf0J+rsMv?=
 =?us-ascii?Q?qUF+BnilKShitZaoxxOQJ3CPV5NE7vh02CpdLhIIT7YiNQFKHvplxSZ9gpIA?=
 =?us-ascii?Q?n75v8OKA7FNngR77kaQdDPKos9L4PJnOXRxSBpFff5mtrdQWx978mOANioSd?=
 =?us-ascii?Q?9VIJOvvP4EZr/QGH73qqKAU2XuQ1Xpwtig3J0bZRdeHRQgHjee0HS/woq+xS?=
 =?us-ascii?Q?ii8HQZP7UeeU7ABMjmLbaNQwp5aQ6asfn2cY5lnC78YfOtMP+f7/I2od9vWs?=
 =?us-ascii?Q?ay4b7KejxNlIftrDXfgKqhWdo5XBnuGMeBnVgiyau2Cb6QXkOm52+QMOepYA?=
 =?us-ascii?Q?+gZu/0GwvM7nx2SSV5tDZ3/4MdmcIwbSOQAIMuZHH/w+wh/9xhhGn2+DkATs?=
 =?us-ascii?Q?72HDX9qGDgfRb0k2hVafVoHgqkJanCUmuVjhpEerC37SDnmQf6LbcASnvgD3?=
 =?us-ascii?Q?i5MLcflccZR8ECS+b4gOZmAgrrdx+qm2mPjEFASL4YxISXsSUijJMoY4g8nv?=
 =?us-ascii?Q?pv8ByvsQiXkZPjd8RABa8rMXwYScY/ssNoH3+lOuF5DYVBVGIIAL2XA0LHK/?=
 =?us-ascii?Q?B1HarK2s6lUE98+ZhqtJsUpsYIiTEvSPCO5ynBIXDbsz6exURQa4lfjKwyZT?=
 =?us-ascii?Q?xqFzHE+Iq5ylvTaOmuV+NJJTPB0ivP7hAlgcCUcMCP+eLgA+9BHjYXvOAcJR?=
 =?us-ascii?Q?whbzkOSP8LVNrNIHC0XEdmb1g5d6HPkYqexy+5EbOHp+RKFRUgD+ciYCA3W0?=
 =?us-ascii?Q?psbv9j2VDyXFQmDZm9f2LkFA56cPevY3wWJQj1kOkuac0GCwFICpZKr7T3oH?=
 =?us-ascii?Q?KZcMMItvMEhrH5095js0qsgZ252JwiSic8VmOhL0MQhpzKMaIJejkpf1jCwm?=
 =?us-ascii?Q?YJ8OOAP62MS9IBIwfyGpIBKFd0d9QHpg/UIabOR4B3nMFKgnnnapj7JLQLkr?=
 =?us-ascii?Q?vMc+KxbmgevGNG+uFRSmKMcMcw3DAFwV7wtRqce0QBX9bi6Bkcyhc8Tvinhf?=
 =?us-ascii?Q?IZaOFzNjUssiIJm5M+PYn6obJO8/xo/ysI84R/pI3JN/iXnKiwrvK2w6+J4J?=
 =?us-ascii?Q?HDQdS5aryqX4zS833tnt/5v1WOB3gl41mMGrDr1iRZ0UR6D7UUCIFrV7qPXS?=
 =?us-ascii?Q?P7PcIkPQxKcBbpMTglnHbXDMtcJjFbh0e8d9W4fbfc9csvkk3T0Wnx46+nPE?=
 =?us-ascii?Q?7366I6KVxBSyJ8ddGzuaQxt+Szq1+tSZ3iPJG6sXylSvmmGrY1jN6AGfCAFN?=
 =?us-ascii?Q?gC2WC7Dz1hbpaL+75hCbq+KjxEASfQnalGf8S6qLm3nPWJV9gMblsABWDGES?=
 =?us-ascii?Q?UFrrYWhGeOPbiSw/hzMtVOWw9S9qzZ9L0Vp9JIZEEFGM1UeiowdHssna4b3F?=
 =?us-ascii?Q?AVoOZZquF6ckZzQe69LcWWvao+xaJqL3VPt73lUMX4Btf89sco+glEOjLIx3?=
 =?us-ascii?Q?bgxlxGFLbRpq0Gd+7pmHnPGTpY2Xy8Eovp7SFxz4HfPBSVsFF6PkAShzNGyv?=
 =?us-ascii?Q?hD33kpd55EcbRFiBbi9t0wapH8e2jaGZuwhMm4SqVujzFT4YSMRO91stTPau?=
 =?us-ascii?Q?1ohogQQjFjJQlNBrkbfl8K7bbf8uP3zsVL/GMwhNr7IukWzHprVeqkmVy9R2?=
 =?us-ascii?Q?AyEV2j4sc89M+54z8qmA1YdkkbKUyjO0qRgu3y6fxr/P370nb5q8h1APcrsc?=
 =?us-ascii?Q?+q46M0FAMiB+EAVGu/eEc6tPXeYOpz+DEQEYQu9Ozu3EwRRtVD5aSMA8a9LX?=
 =?us-ascii?Q?roPSszmA6LSt0hJU4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd25bc4-7b5e-46b3-feb7-08d778f1f42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 19:41:27.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upd1SGVkvtknhJS3KW7A4FyUBgGzm/Xb/7/rTqpiKG7HJagVig7/r0h1r7pxWrLeFESfLO7mJYFaHFN887HB1hmDB5gk4qjUFp+fB0kmL9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Tuesday, December 3, 2019 6:54 P=
M
>=20
> hv_dr_state is used to find present PCI devices on the bus. The structure
> reuses struct pci_function_description from VSP message to describe a dev=
ice.
>=20
> To prepare support for pci_function_description v2, we need to decouple t=
his
> dependence in hv_dr_state so it can work with both v1 and v2 VSP messages=
.
>=20
> There is no functionality change.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>=20
> Changes
> v2: changed some spaces to tabs, changed failure code to -ENOMEM
>=20
>  drivers/pci/controller/pci-hyperv.c | 100 +++++++++++++++++++---------
>  1 file changed, 69 insertions(+), 31 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
