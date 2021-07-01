Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36923B8DFE
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jul 2021 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhGAHBi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jul 2021 03:01:38 -0400
Received: from mail-mw2nam12on2107.outbound.protection.outlook.com ([40.107.244.107]:1409
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234733AbhGAHBh (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jul 2021 03:01:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z39bastWr5QaUyuCGl0HjDdZhvOT6hdUEp++HeJBanN89bXr7dxd+3X/+GBvKZ1mo/Zws1MCezrbsl2eMxobFaQPcZfepckKeeKOP2U38XDu1uQhYbMDMgI9/CEBzbxkIWCVicgDy6NZR7yGgC4/UZjaDP1Edhi1VcQ+NKDZlST+7Ueadqr/7ogq4/wc7Qm81pPkAXRgpy+hhnjl2V01ewltR0t8MayVpVLG9rODuCqRY1teTsGnTVy29t+zWyaZZb4W7JjouvsME+VPX1K0cfxIAKrTlVwGQues8Aj3VZnFD2kdCrOzJ/HzOFLJXyvqeWOXNlv2KcoHsZbixgNiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro8M9MArJDrYB2acsF6Jw6ekpScera7w57COwrMtMno=;
 b=hXIh2kxMjkq7uXRPRxOQPRY0bg7EEtAiNJbOUX4dyyNyR4ioKsb95ONdkK0G1TgazS2TIJMKdE+wVYBw7jySC0GhXxqT8ZvORO6SNvumebMlfknpTZObTWOswuY6eLRrO9s17xrt8TRTfIZDQo/xCKEexWc11L9vt/+H0rx988rCqlwnvIk0euNnGVDoe5zqF1ha5aOPwjwv4q78pFNKt/qfgIeNcxnKGA0IyfCUaGB6a3JXwgdfDWhIZf3J31YFtkk7lFcbyYw9khck+0W/ms9jY60HCZyP1Y26favKykw+Xgd4CPQs9E84ZjHLy/W/H2njjUvuLZNGNjRUPdkzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro8M9MArJDrYB2acsF6Jw6ekpScera7w57COwrMtMno=;
 b=Zx9AV4pgvbCKF9LQJ/qxgMd2dwcRsmtYOUT3ydPQFpFryDKw8gC/pVbPtN8SbrM2tciVeiP0IjzGs0uF+O4h9dk52Jk/VqIUMJWVG/SFiOJhdY85hiQKKrei+fKB8IYnbPRqx4pMFQXHfWG5o7EbpeJtnvcbq4bQ65JLWnYy+P4=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1656.namprd21.prod.outlook.com (2603:10b6:a02:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.3; Thu, 1 Jul
 2021 06:59:05 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3%5]) with mapi id 15.20.4308.007; Thu, 1 Jul 2021
 06:59:05 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHXalTR5lVKFlOZkEmq8/y9Kgt/basqingAgAMt6iA=
Date:   Thu, 1 Jul 2021 06:59:04 +0000
Message-ID: <BY5PR21MB15064DFA9450916A3AE69D01CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <YNq83qS24pO9wVJk@kroah.com>
In-Reply-To: <YNq83qS24pO9wVJk@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b33c5f51-9f35-4a0b-8a17-4d0188e2a58f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-01T06:58:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cad53ba9-ab63-4da1-f228-08d93c5db714
x-ms-traffictypediagnostic: BYAPR21MB1656:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1656D093C25E34A601BDE8C6CE009@BYAPR21MB1656.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjlE6J8St1wSdANMMgv2fjF/vSbKQn1SgY2Yjb1L3TEMMn17CPl/2o00+Am1BpTbkeG00ma95euoSAu5RaMGcxnPHM7kEdrmGHvkLYuchzhhBdHBy6nXZz+TbkNQr/tkq5Z9ulUi1/txBmpyFooTccfsmyUqunGpOrhDWKJWuY/wDlj5C4KZBWrpE6k8T9QiEHmerWj4j34ejT7Wgu8lNlNlb+AvvbtHGAOO1Azxg3w+dxnrNByxVhBvZiniO6VofRWXGUkDNOgm+7pDRohKW1y8RR8iwK56hJiV53TGtmxYVPYcaKjQyR6lqwo7pPiw5TIepxanR0tYXlz485/m3IPVcprOPDJgq9+yu8HBg6vjFZFkRaLyQjT44rgODUEwUNtdcCe3v/SvuT+UwGgzCQziPV3x2IYl5lim4FA82LzgUzfipUGZukk6pRG7/WBW0HpxY/PvKRybdTbaKUOlwL/7QgNGEAxS8S1BeNSvler9CPcMogoo5ptoaojc+bqTj1xZOQAG1kxpW9fQo7/UYPPh0cIUkwT/eWxnmX85+P51Q5KYpSZQlWeUvE1r6zhHKpBdf2FADL62upBhsMAg0IOivhWeEAJvZVaek5r1k1ICOI/DwkYpcc6pgQusJiXG2gG6V1N3cZOylmSJzSOkxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(71200400001)(2906002)(38100700002)(8936002)(122000001)(5660300002)(4744005)(478600001)(10290500003)(8676002)(7696005)(26005)(54906003)(316002)(86362001)(66946007)(6506007)(76116006)(4326008)(33656002)(66476007)(110136005)(64756008)(9686003)(82960400001)(186003)(66556008)(55016002)(82950400001)(66446008)(8990500004)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Nk07+jNOLftY3EYyJBPXwiIDaC2k/m7U7uqofjCW+kM2IwP8aK/N3EpdNIw?=
 =?us-ascii?Q?dAyjLCeR+RU7np0P37fAHTEcYfACRoU9rOvFHOt/iEQSW4QpIZtjs9qHQRzA?=
 =?us-ascii?Q?OPUrVVioWonEOX3sHTT/idXsw8poJSmMFGsobkgsec1j0RTfoOTegrLzQ7JR?=
 =?us-ascii?Q?Wz/EUmZRVnTeqxDD7mmrSrcCTR64+20iMxrLY4Na5ZqxdolbidfbUvO4y9R9?=
 =?us-ascii?Q?vLbwVBK9XSI7IEbXbEtc1RAKtrrRVXjGFXDTa+rCdtCqbrM8t7r4g3FNG8XS?=
 =?us-ascii?Q?lfn6IkXsUAttx73RZMspZiNxqeJ8ck+hiGGzYRgh1+DbWJO1KAp7Hs/RpjTy?=
 =?us-ascii?Q?A8jsulEIcA1xJ3zyO5yCWXV7CBitmpkhAPuPa9rEZnQ6yMvgOCvEjMlMIqfD?=
 =?us-ascii?Q?0zyMI3OSVT6v1/L+QEew8tMPk871H9WjO6puE5evvOmRtIkOnckOUAUo6+hW?=
 =?us-ascii?Q?Jqo6KIP5F+9CuW11MjknYdtcG1SQk1nZX5tCG0xMvFoIcnc8ACef7d2UWvDr?=
 =?us-ascii?Q?rYrXQ9A8dCUTg5ExsAmMLMDVdnbcx8jpbgPtwL+/6PgxtcURbsAbOGIqJ+i3?=
 =?us-ascii?Q?q8VfKWlMapSxqa8O7q0bP+TYCHr7ZGq7mk3CQT+E1YtuLo9zaDmm+bm+foE+?=
 =?us-ascii?Q?sPj+Ntv3j/Omd9g6r6BhKOalbyGX+pfhXBx/NUzl522vXwMN2D18ePGm4VSq?=
 =?us-ascii?Q?hUYi2TD7d8RAA6oUsn7eR9Jmb8A9lKrQpvohpjdnCrfQv5ND0ESm0yf83+Y/?=
 =?us-ascii?Q?6duz5OgumDSs2Wh1glEP99zRB8QL/zESozN2R29lv/lcXMs3wfsE56ARE6xm?=
 =?us-ascii?Q?nce1BdDemwASx2aeIP9gCU5AkDLxGqP9UgXKqsGYFebTWHZ8qMvVnT6JJrQI?=
 =?us-ascii?Q?OfZvOVxDsjYS3mQu0dc9aU/w5IlhjV69qcIxZa6nDTdaiDRKs+ZP0GZEFyuE?=
 =?us-ascii?Q?Uhqc2qjO687PhQ68EpA0Jh52ifSnIhE4i77QhKjMVBV5Oy7qSZoWdTDShvYC?=
 =?us-ascii?Q?erd5QC1nm3MYtBDxAIf0eCKLdMnyCsUD/27VTOK3TEirO7TWh4O9nufRmwRI?=
 =?us-ascii?Q?TSXos9swOV5bBfofXHpsiIjoyZwWJ+1OV5/2YACsqe7VAryPyBK3zHdL+Soo?=
 =?us-ascii?Q?GkPLAt/BZrGaocAeygOfmEv2LDj1CMqt9ogQWTSr1qyxKw8Soibv0lS253Gh?=
 =?us-ascii?Q?AzmALl+A1VHBTzzsGWRjnfYWck7Yzsf8c130W4NkuMLHh5Tgs00mhdK/DI3y?=
 =?us-ascii?Q?oSu9UB65iQUdBrEqt89WOeBhGkTE7G5FWynLQWtUmt8xUpV7aUF0sqrhjSHY?=
 =?us-ascii?Q?crh0RIYtCNPy6SBKeMIaT5Xq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad53ba9-ab63-4da1-f228-08d93c5db714
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 06:59:04.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WZxTnTnmF1ByV3EnqqRgvoI6FMM+/8oohz+n1xDmXb3Nfx3Tarhf66/SqtOc1kw2wLGVoVZacO7Ftye/c2+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1656
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
>=20
> On Fri, Jun 25, 2021 at 11:30:19PM -0700, longli@linuxonhyperv.com wrote:
> > @@ -0,0 +1,655 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>=20
> If you _REALLY_ want to do this, please document _WHY_ you are doing this
> in the changelog comment as dual-licensed Linux kernel code will just cau=
se
> you a lot of problems in the long run and we want to be sure you understa=
nd
> all of the issues here and your managers agree with it.
>=20
> thanks,
>=20
> greg k-h

Will fix this.

Thanks,
Long
