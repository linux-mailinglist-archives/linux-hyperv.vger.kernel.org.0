Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730B020FBDD
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jun 2020 20:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgF3ShQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jun 2020 14:37:16 -0400
Received: from mail-co1nam11on2122.outbound.protection.outlook.com ([40.107.220.122]:26663
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbgF3ShP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jun 2020 14:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joqCd6iMJFdFk1M5cxaaIB3ROHoklWuuR+kV01nqd3FnOLAxASHoYh56IeYMUo3BrEU44EiwMAfpcb0EtASOwkNQqGFMFHU+GnKkEWh5NYRwsolOt/YrsbBMz3EVoAJN21dzJsLqktd6txExtZ0BGmxHsu4qi9w9zxkvq/SVj4hIf3lWVFq+bF1CE/NZTDxA9W5TRxV4v98RSA/pBL/QCAV5M/qnnkRPBf4eTpPujLrQy1cK7MEX2LzcK4codXESx7yOeOT5CLXVDCs7KHojdsrjliQFIX8iDBzEyb7tefyfLCE0F3+1QRoGDJW2J9Q7bxTg5M9G27VELfVg5Fdvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyasgmgxhSunXp9NuFtZ1g4nY1hUZkSUJqtZ6C49sVk=;
 b=IUUOH8+fP2Axv2cpPdhwcvdoOJz1rNrDRBQ81YuDphxJbUTt4UGDw/g3JFcmq5T4ZzfGn8qAxL58+lB/UKk6A9Rgb1nYQeyYml5zPN/5+MDI128goaX7nQe2+J35KYAQqHJM/hcKTJ1jv/NM4QKdjLdyGTMJzWTJTtrjKmcnCKmLrLYxtiQQOjOuaBHt6gHAT6mw6uDnJaoimUO8sxb6XNP3P1di+KT7p0yoesbjlYbcPtyRQonV0D5A+FkpaHS7WTFR3F38jiABM15232KBT6tef2G83E4qMUcrYKulAaXoEvIvM8EoTvtflax26cg8pQl4yPHLx8l6mavfoybsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyasgmgxhSunXp9NuFtZ1g4nY1hUZkSUJqtZ6C49sVk=;
 b=Nwd/YjD2YE0ExNuJcIH83hONgTTkziAimRCpc2fNYNEkse4+uunp1DvNP6q9xbPTFKDkm3VvD2HW7xryjbT417nB+ByNyQckTI4F2zD+sdqbvfW18rdw3SaGM+wymn8xpJvRvGlpo/cTIUDvfALzKG5J+WE/C8oHrOTxCpZhelg=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1050.namprd21.prod.outlook.com (2603:10b6:302:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.1; Tue, 30 Jun
 2020 18:37:03 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%8]) with mapi id 15.20.3174.001; Tue, 30 Jun 2020
 18:37:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andres Beltran <t-mabelt@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] scsi: storvsc: Use vmbus_requestor to generate
 transaction IDs for VMBus hardening
Thread-Topic: [PATCH v3 2/3] scsi: storvsc: Use vmbus_requestor to generate
 transaction IDs for VMBus hardening
Thread-Index: AQHWTvOfu6o2DHFLz0esRnWglbS5VajxfLkQ
Date:   Tue, 30 Jun 2020 18:37:03 +0000
Message-ID: <MW2PR2101MB1052A1A033D539E8B1476DA7D76F0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200630153200.1537105-1-lkmlabelt@gmail.com>
 <20200630153200.1537105-3-lkmlabelt@gmail.com>
In-Reply-To: <20200630153200.1537105-3-lkmlabelt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-30T18:37:01Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5ae8c8e6-c82d-4e41-8e9a-71db50331799;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2555057-04bb-4477-fab2-08d81d249558
x-ms-traffictypediagnostic: MW2PR2101MB1050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10502BEA517D5BAE3275D71BD76F0@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K85g+zD9B/u0fDp34vcnULYBiORLbiyMN7HKmN4sM8BSqF/D2UBLhfcTOZgK4ujKcdXA+fbVDM+mzA7+TTAUYRr97IV9sDLOXdlfSG2/qEMZlD0NRw+lrfi7IulIwpCasrbW+8JI57KfZ7ElpliRD/GPbDeZ5Q989TPKB5VzIp5nHl/Xv+r3IzBM2TQzRafUL4W+I+bW2uFQrzpR+WB4beuYsIEEMoPK49k8t/pN4MtQyjsWy39LbE8oxV+KSfVaarvSB2C2qtBLU46OfzYDsv0eppe8/OMGB1+rv0gmFDpjYXTZg2sdwXbAv6qpYtkhQaQkmdnrJVxjAl3JRZOgBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(33656002)(4744005)(83380400001)(55016002)(5660300002)(9686003)(52536014)(110136005)(54906003)(66476007)(66446008)(4326008)(82960400001)(478600001)(66946007)(82950400001)(66556008)(64756008)(76116006)(10290500003)(86362001)(8936002)(186003)(2906002)(8990500004)(316002)(6506007)(8676002)(7696005)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mFL6mDW4cOKdV76NGeQg4GEt6I/yEJWtYqQPZ081dbCFLIQ9UQsqcdgsXGSeV5hLGOuUWFSAvY5zN/rOOTxc0yka/ejgIhip4iI6BZO5gg/bCR9pM6Kk8Ni3Br8PwwunpAVH7cCNdxJEnTnfb8OpR3SO+I+6M1vdZbGtSm6QZPwYfCbKp4BYp7E20KZgRwIq3CAFlHxRslPceE0tDqRoBM+cghS50lBkdhYHhYxszCgNwJaXmLcy1MMT1Zp1cPhwMtDSCTpt8SLK5pQtrSLHhnRwYrXD2w//svq7pt5Kw9iroUyLPJ7WoGctjd8+TdaVpJC1/Ohm8pXbZtxwlkCzkzGVcXLsnRPP6IEvaFTvhcacMjoXdh0HQwKG9N7q9xUzyHSk1shEOZYsx5XGxq6L2BEMj+jo/jVWU7KThdKJQbSAYsweRq76EnK4M+VKRPcG4oKE3s0vMafeS4wujsboB5/Va/Kkd2DsIEdmOOU5hBNqBheESDIxgkplC0pKS8fh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2555057-04bb-4477-fab2-08d81d249558
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 18:37:03.3420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ec19mJpwKa+gR0qu26I/bgy11fVO6tgIPgw8bAzBvkESTZ1XGT/8aanbCqKaeXmMPA4TM4UVhjs9TwdD+OhQ6X4l0LmaHJIGe9MEdaifUGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andres Beltran <lkmlabelt@gmail.com> Sent: Tuesday, June 30, 2020 8:3=
2 AM
>=20
> Currently, pointers to guest memory are passed to Hyper-V as
> transaction IDs in storvsc. In the face of errors or malicious
> behavior in Hyper-V, storvsc should not expose or trust the transaction
> IDs returned by Hyper-V to be valid guest memory addresses. Instead,
> use small integers generated by vmbus_requestor as requests
> (transaction) IDs.
>=20
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> ---
> Changes in v2:
>         - Add casts to unsigned long to fix warnings on 32bit.
>=20
>  drivers/scsi/storvsc_drv.c | 85 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
