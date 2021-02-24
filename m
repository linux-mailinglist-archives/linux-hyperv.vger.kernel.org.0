Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921553242E1
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Feb 2021 18:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhBXRFJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Feb 2021 12:05:09 -0500
Received: from mail-eopbgr760108.outbound.protection.outlook.com ([40.107.76.108]:2485
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236006AbhBXREn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Feb 2021 12:04:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5zxCrY3KnFJDmNHycXYvDeLfBgcZ6TP2CbyllmtGmqXVCwp2/VIyWE9QUqG9W0PXY5mZARVSDdqAAPk7NrToYsWM9f+PEoJBSDvuSUi87EHV0KHRCHkow1AWPPJ8LtIclUo3ryJRMQ6natgcylVpgX65yMwZb98EUguREFnrs19yxnaqAEeSZ2pRkmG9bAHF41otpTgcs5SM2tbCuvO3EHJxxTwQCNmad/wY4ErmgBUgD6IDeDfYOwRwyjJUGFdx6w7qFLqK53W5+T8dKGJZ9bVxV2wd1tKluMVZ8A1mgp9Xbtrdc6P1wU0HPmVUf0102MulDAqi+JWHzevg69TqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F8eC2iN9PwCO1E7xqrjDI187kE3+tzeuiVnM+ZWGnM=;
 b=c+C9qjszdRs2ZlqYkLCUMWZs+bjMH5/Cpy3HEMCU/kbqHERp65sONZ1HDszqXc81ySNU1zSjW1V76CNULh+OZDrm6UO/F5l1YuHfX92jQhcGtpOzItYDxjsGc49A5vwz8fr5UmmhL7hrQAoifw/hw5EmctUF6pNhE40z9Ig/RpXHGiHUeSEihZat8Zocb1wWcVYkZ+nvpeGMNu/0lAla1DtpM7ufZPuwPdctJOsNkbpb9JFE7iNTlwwW8MuzOM+GnpRXjmmZakgaE95cwrAq9vSUpPXVSc2j+I21XmLHmL1KrFbQzNyasFZ/9uV5uKboYy3ycYeJCkM810SToxswOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F8eC2iN9PwCO1E7xqrjDI187kE3+tzeuiVnM+ZWGnM=;
 b=Iq6KqpDTYNBLrMJflzquJtnSeXPVGxVMRYN7vVWiIi01Bj5m6tXWXQg8TtPCDyU7p0KGXDAvDxRGX8YmR3Aiv1GELHFV6XY+geitw6dWiW+G678mfSunfRpGLdtwZyGDnAh8W5Mr8598lA53j4z2vnh/wYYcmYBzqTivRnqeYWc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1818.namprd21.prod.outlook.com (2603:10b6:302:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.1; Wed, 24 Feb
 2021 17:03:59 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3912.008; Wed, 24 Feb 2021
 17:03:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Christoph Hellwig <hch@infradead.org>,
        vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 1/1] scsi: storvsc: Enable scatterlist entry lengths >
 4Kbytes
Thread-Topic: [PATCH 1/1] scsi: storvsc: Enable scatterlist entry lengths >
 4Kbytes
Thread-Index: AQHXBjlaeseUgmW2gEGnERM19Pp+w6pl1E6AgAGpaYCAABFJ0A==
Date:   Wed, 24 Feb 2021 17:03:59 +0000
Message-ID: <MWHPR21MB1593657F4149BAFBE041842BD79F9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1613682087-102535-1-git-send-email-mikelley@microsoft.com>
 <874ki2yhzm.fsf@vitty.brq.redhat.com>
 <20210224155241.GA2284544@infradead.org>
In-Reply-To: <20210224155241.GA2284544@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-24T17:03:57Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94038de8-be05-4172-9e82-dd0910107859;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8af5013a-bf7f-4ec1-2cbe-08d8d8e62df1
x-ms-traffictypediagnostic: MW2PR2101MB1818:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB18180662D081C330FB82F150D79F9@MW2PR2101MB1818.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zAuuFfvtOf76ymR/Q/wNqHaTdFlehjB15GxO3o9erbUtYzn6yXRwchwFCl5R6dttdgK2aMTPEo/aeeeZWIfdad97cw6DV4wHlYagpQe26c3s3pD39+IGbQwYj3H+zMOek8IOriJjkWDqO9IahHBBLyJCi9CjYNDMsoxVY7uoZtq2l/HRmPavsNs9L3nO2WfisatuHXQ3TpE2dA4SS4ckvc5RbIJkE7cVoZ1Z5U3ByOlxJlLH4nq6tQlO/0H3M1LNvjaaXvEh6xm2nDqEqRxxU1730h9/mlw3SmZYbwjFXhddpuol8AMjXl49HtKiOGWolnDxGW4UqDcOBhGKxWych//mzE00moPhRfrDYSw1/yOvvlOLZA4CW17ibKLL/rnqPC5/rf6WioR+VHXODiWsvcF2gJRzi6/ckwwXpnTChZQ3xkikpqOFRGGij+29MbqPGmtVu1scQMRfJtQFsaqrZeMLP4JGfyiER0I5lNdojLcVIlzcNwQJ60CEYabYj9v0Xd0c1aEgalPg7GujAHwEIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(9686003)(54906003)(4326008)(4744005)(8990500004)(7696005)(6506007)(478600001)(10290500003)(66946007)(71200400001)(2906002)(5660300002)(86362001)(52536014)(76116006)(110136005)(55016002)(316002)(82950400001)(186003)(8936002)(8676002)(82960400001)(66476007)(26005)(64756008)(66446008)(66556008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rEPx91B8nX14mKuL50EGX+F9eUU3D9jXxL+gF/h6A7HPrZvSghiXiPWoLZGZ?=
 =?us-ascii?Q?ebUdTg6jzoGVweF1kTHKQS6P5jPBe9a89uQqtbe0U+xE+To+2pN2gHdxyU2m?=
 =?us-ascii?Q?4NZyXP+Ohc4rv6f6+sTOz8qAJwyd96H8m18KdCccv3t9K6u+o/i8AQEMXf0A?=
 =?us-ascii?Q?jN8rFsJn8Js8uZUaHMMD8tZrhrO33r3TLFmETUFU4Ly1RDNUYp1sxiBIfmEa?=
 =?us-ascii?Q?bDWVUlSIYUKfehFU606vfGEwRl8ERfz5xrPT9p6H8LVSZ7+vN1ANdy3b3N/Z?=
 =?us-ascii?Q?nqRM2M4Jo340m8J7U2Oc1KOVt/ydbKd37aec/UP+Tavq3HZgOH4ci2J9da/1?=
 =?us-ascii?Q?b6G+vo2esCSxS2k4APH1DlBObkqm78cqjBoFZ1G6KmvGJ+NNbfM3g1yJTKmq?=
 =?us-ascii?Q?1D3LKrSlRQvArSBnGnyLBbaE5/0nPoQRlrwO93QyimAwmxJmjXNoDowqtKmn?=
 =?us-ascii?Q?CiqlXOAao439ANwpjC3heFF+9uvRPK+ObBl9hdS6w+J9+D7WuTMU7Hokhasp?=
 =?us-ascii?Q?tTceq1bjQEW9YTtW1VdgtK76YB5d7AiEGrh/QBY9/KPaKcFq316hMdJ9of4J?=
 =?us-ascii?Q?gdWGLf6sZKaKt+moyj6uEkH5GXuxFoqVIDZd6jekJfrjlItAo72jcHW5jUC9?=
 =?us-ascii?Q?OV5he2A4rpmjmuMePkinvBDTR6+KJRnY44RtMTt4BHiV/F1hNpliJeG8Qiud?=
 =?us-ascii?Q?hbYsjD4ldhB2FCA5sWsuEJLdsWaiMEtwZf6wULh02rNjca5EPJP63DDRKRsi?=
 =?us-ascii?Q?I+WPTOwqPh/jDLKSVuMf6EC0+d1IdBRnzxJR5Y8cVSW3aB48BL8V8yL2n+tf?=
 =?us-ascii?Q?GsX7xjSWfVyiCtqld1rx6q4KqKfcNoHakbdi8DYzSd17OrSMSGOA8aKgh4Fl?=
 =?us-ascii?Q?BNSYE5kkQeMVII9e7dJ8xtIp3jpB47vtj2G6Nj629ysMRPUfP/1/Ly5KEH1o?=
 =?us-ascii?Q?kiQi0g7asrMhup1n1ygDhGII5ehg45uaYSgNuZRDeyFpm4dbfAQlebcrtFM6?=
 =?us-ascii?Q?tXf4HcfJE6gjiHhAFyKs5SpkShsqoCIXUILoQx1lNAT4yyORExTxSYQNUCkd?=
 =?us-ascii?Q?cptnZzmiYQV/w+fTAXlAKjBuTqY0kuajzpiUhU+4BKMIiunNHwhOCt/KPeQN?=
 =?us-ascii?Q?+82JwMitgsMp201k7ZQ7BvLEGTPzQZu66H/XR4ZVD7xIolvo7m9nc3fn27Bc?=
 =?us-ascii?Q?v9059ISxudZ+wUksHRmX4WNBerk5pFBVntG8O90w6XddLQEexyIirk2dkkUl?=
 =?us-ascii?Q?V/1dvOxH8+ln7OQW2AL7mJTDQ6tK8md+a6H02RkzE5RFlRMLZnB/mwPN2uw1?=
 =?us-ascii?Q?zGblJ/9QZcwCC5VSpv+2+1fR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af5013a-bf7f-4ec1-2cbe-08d8d8e62df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 17:03:59.6983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqI7YffyBNx5G3T+s9WFqfNmotRLuOOtrfblUMC78X90pJvZt2tzyAMjuC5FBBEpql2lS2OCyD1eiu3TK9cMcA+vUFZCXDhfdwGWUZeslk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1818
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>  Sent: Wednesday, February 24, =
2021 7:53 AM
>=20
> Shouldn't storvsc just use blk_queue_virt_boundary instead of all this
> mess?

The storvsc driver does set the virt boundary to PAGE_SIZE - 1.  But
the driver still has to translate the scatterlist into a list of guest
physical frame numbers (each representing 4K bytes) that the
Hyper-V host understands so it can do the I/O.

This patch improves that translation so it can handle a single
scatterlist entry that represents more than PAGE_SIZE bytes of
data.  Then the SCSI dma_boundary (which turns into the blk level
segment_boundary) no longer needs to be set to restrict scatterlist
entries to just PAGE_SIZE bytes.

We also have to preserve the ability to run guests on ARM64 with
PAGE_SIZE of 16K or 64K, while Hyper-V still expects each PFN to
represent only 4K bytes.

Michael
