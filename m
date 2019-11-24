Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20938108536
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Nov 2019 23:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfKXWAT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 24 Nov 2019 17:00:19 -0500
Received: from mail-eopbgr800105.outbound.protection.outlook.com ([40.107.80.105]:21523
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbfKXWAT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Nov 2019 17:00:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEs7tXrG1PIArH92fuyCB2eNBsWrdxvqmj0BMNXaKUnrT36QgMj/W9smfv9Z01MwMWaf0PZcUOzCGpzbDEX96RRGVRuXzs/K32AYq3H+MKD6bKP3juPc1jitpgEtMnkIlWNX9tyu7bkYeVAB8vLjqqx+lrMVvyUZ+wpEp0N5NUyWVEHZ2H4v5vFY+1TC1Qttw6eUXSwBLfFeYx5XuuZMKCKVUGUUCZG0tUnU6b3CxXF3zV1TaLujI1G69mKY1scncXuusqLuT0fHXLSYv4uRQ5MzxaDqxlldfBA93soKwse57XuIkSptu80i+HJ5Y+gssus6IzQu9nbzpGqMZwqttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv4pKx5fArH55+/oY8o6GpHU/SjhKolsuxec60lZCU4=;
 b=MGCmvMmFD3LS+GgK84Cw874L7F1EkAFjaawklHQQGgOBxpks3uxowR4Ww2tP0Hy/Sbw26yxB8fnXEaSv5v8/UI+T1Zb0rL5n3wDAisQ4/gYH4XDSeIPEuzNkb8xHPGDNFxW+G19aUH7NEl+cX2TIAOjzYXf+YkYYGcwTJs1DGvWEh/1NGhKYHEA/69YUCsNUgmXp1sY1ZIxrjz64lDJTJMZFiS2imUPx9lfgth5g8Yqef9erxmxWxf0xmmUmJ5ZaPWxnw0L07H6uSHYTNHynNqnxb0wdVlYIVPzCvF1oE8TH0h92uoZSpKzQHpzkGXQqyA458NhsMUjGYiVNOTpc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv4pKx5fArH55+/oY8o6GpHU/SjhKolsuxec60lZCU4=;
 b=UusYnkax3D8pAmrzF0SxShX9YEMtcS8ni4Oy+dZIjTibLEGe+PTJ86G+W/XyarhBJjm6mefjXsqYRPcBc0tx+iTEf0ec2pbTLNtPDSXbLCcfZy9xKxJveQn61bOhxhJy4ru8sR0nxoZJyjWR+bf3vpJ2QuJtvrbDV+EUpIDX9yE=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.0; Sun, 24 Nov 2019 22:00:15 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.000; Sun, 24 Nov 2019
 22:00:15 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v2 3/4] PCI: hv: Change pci_protocol_version to per-hbus
Thread-Topic: [PATCH v2 3/4] PCI: hv: Change pci_protocol_version to per-hbus
Thread-Index: AQHVn3KMxNeyeISNr0aRJ94xK3v7R6ea5eIQ
Date:   Sun, 24 Nov 2019 22:00:15 +0000
Message-ID: <CY4PR21MB06292E58EB3A53C01F860C55D74B0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
 <1574234218-49195-4-git-send-email-decui@microsoft.com>
In-Reply-To: <1574234218-49195-4-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-24T22:00:12.6273716Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=11517a81-51b7-4a71-86d1-1209b0d4dbf0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 696bff10-4fbc-4efb-462d-08d77129b010
x-ms-traffictypediagnostic: CY4PR21MB0853:|CY4PR21MB0853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB08539C11EE16DE3A90C937DFD74B0@CY4PR21MB0853.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02318D10FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(396003)(366004)(54534003)(189003)(199004)(26005)(229853002)(6246003)(5660300002)(6636002)(86362001)(76176011)(81166006)(256004)(76116006)(11346002)(102836004)(7696005)(99286004)(52536014)(66066001)(22452003)(81156014)(3846002)(2501003)(1511001)(8676002)(316002)(10090500001)(110136005)(6506007)(446003)(55016002)(74316002)(4744005)(25786009)(7736002)(9686003)(33656002)(8936002)(2201001)(8990500004)(14454004)(186003)(71190400001)(66446008)(64756008)(66556008)(478600001)(66946007)(6436002)(10290500003)(66476007)(305945005)(71200400001)(2906002)(6116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?Q7CtlVEbUBwYL++AAPjUsIyfFD+hyyV4loT8QgsPdCu3PxKuWMaWkDv5KB3/?=
 =?us-ascii?Q?vf1ksWHxKpHucwU5njwQFNcRLwYYOk1a+/E92K/QKzmwdN16Jnk5a4RAtB8w?=
 =?us-ascii?Q?Zj7SLoWJqhiNyGSN75Idu+o5xaGOudBKhY2Yrnfpi5NRNqzV1S5z2jTvXbH8?=
 =?us-ascii?Q?DlvVwPcC1GqYdgBMg4YGJRVn5Va5tMARD0HhwYNGPbZ4CA8WLhxCf0KUSvLx?=
 =?us-ascii?Q?3wDAxbWwfGcM9cc9tVTRn9ZxSXiuz/BOzLioecCOQLo0RoouSdrePvOGKVfr?=
 =?us-ascii?Q?bXWhVGjK2XsIGCt/wxALUzh6+MCITajeLmjXXA59RI+U+1V/gMSXvycmq9ky?=
 =?us-ascii?Q?GS0SsIHQCqhYbM/0/bHsa9cv5RRw4foTePz8cggOYh5V+nri9QHLZtd844lZ?=
 =?us-ascii?Q?EWcy7qdylu1hAxIQRtB47i8g16wlo+kPtPZEqGKr6XyKlNdsgK1JHZRCKyHT?=
 =?us-ascii?Q?gG2R5wLGbNuykXNooqC8OlwsQ9r+Otkq4wJbnRk0lRxJLn7zGdGgt9kn+wpB?=
 =?us-ascii?Q?1GRMSqPYbFBS8jk3zDyOCWB1Bi1frdQP1iRKa5c5hTPvMMw25P3kWolsqtBw?=
 =?us-ascii?Q?YmMZ5GykuvQcUB7/aQFQSpq9GkfEl4hlcAXMmxyJFM/QOTg+Tg1b0MiaWdL3?=
 =?us-ascii?Q?VhxsvpcVh0HPpqLnFS6UeL+6qSjzwN1gBGkgnGAOReRsqPULN2zVCg4KF/9q?=
 =?us-ascii?Q?BCgBVqAVpGZApF0inOgn455Nta7MznRnk3JWOg2nuKRTEWFSNu0PzwcBx84A?=
 =?us-ascii?Q?D5s6LEifmAgywQkAAyc0DBut10prQxtWCDcS5oXUpg4DjTgTsew4OhAUsHjB?=
 =?us-ascii?Q?Kd2WvXt/4f8LQjB8+NSBzKk8+eXypidlOdw2ATT6nkANhQR5RCp6khuwJNKp?=
 =?us-ascii?Q?kNhUTbujUvBwwka6Hj7rTiZzYlwjVrlSOaIREv+VO8DrSh0RfFSbOHrklFcA?=
 =?us-ascii?Q?2qGGGsOorz0HVYQxe2wg4iZUDgHWmTqE+raZYRY888t+uID/FCNBJIQQJPvK?=
 =?us-ascii?Q?n9PV5aSxV4rkDgBtLYRevF5IK76uccr8AzW9db0uELlq0DboojJE/iYPgU3O?=
 =?us-ascii?Q?MCypWSquEJvAiTYGfKTFeEuVurWGmeTWS8yCNEvoHvZRxztuYo2TjJhsqE2/?=
 =?us-ascii?Q?G1msvsOYgkrEsPfz7GKVXBlytVMqopcotnv7yQgpv17Uanyye/aY0QemxaEq?=
 =?us-ascii?Q?xCACZCHHFuBNardf6mA6d3DzukK6fVIsh04eYMVBDB0NPZbyN3gK6hOm3vau?=
 =?us-ascii?Q?quG9Cv9DBMywC5yNMSBJnRDr0FKzkhSdXC9TssIWxSvPN3RD7Uaw4jdy29dC?=
 =?us-ascii?Q?tAa+LP39EVeuAws3nAZAdA4Tkk8plqIVdSckLI4ccnmwR23IzFeSS1foyMve?=
 =?us-ascii?Q?lhXb5T2V2BG6vVYv94Ric1GqC6S+xDHOjQDYlNT9l0QfNhPEoFxvrEKFyMxB?=
 =?us-ascii?Q?SxzpPHduAsisjCCSbfFL/87VeAck3UlvLL/UDUksuaxtMcCcjAcf/H+zSFSL?=
 =?us-ascii?Q?kbFGITARFdvLmp7xGjXTfyz1dKDvCcq4smhsgb55SCRys1S51B8dsiddLFIt?=
 =?us-ascii?Q?XnBu6IW7y2bqvUoH+/QQj3dnjTnbe9/rlDtxMmYwvo7HO3/JKmuHjDmbvIyv?=
 =?us-ascii?Q?3WokHBAwb1HNFUoCY5DocAHboJ1OGEEFAaj3rIZrbUwVBlCBbZAN18aVDUKe?=
 =?us-ascii?Q?xxjGD9H7G2n6e0YpSClMkQ8xWhndq7cYcdmuSwaW2X+RY3AVBW/oRl+B2ZKq?=
 =?us-ascii?Q?Cd/c6fYVpoMaeM2MKl07xEc13GrTeDvyw+NSRamltBpxjJ/tYM/FBlvQKOlI?=
 =?us-ascii?Q?V+J20K4AepWuKWyH7Zy+tNhUt5GN/SsN/0M0nur9ydL/XxSFQLazTYukgugf?=
 =?us-ascii?Q?+DBGiikhV1WNflHRhvPVklpVBp9VEu8ai1qA19PLTTG7YZShw9BkSlkPuW1C?=
 =?us-ascii?Q?XOTx9m2wIAb+Y2Sm/i0LDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696bff10-4fbc-4efb-462d-08d77129b010
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2019 22:00:15.6249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeRaTcQKhxlpeje1a5DGus086NUo/nczWwxt3wGTnkZ5Otzc7ejtoyu/DP0dhSjrXS2y5dG08n8XhFSjlY0of2Gji/vApIeaQ1VJZBzbrC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>  Sent: Tuesday, November 19, 2019 11=
:17 PM
>=20
> A VM can have multiple Hyper-V hbus. It's incorrect to set the global
> variable 'pci_protocol_version' when *every* hbus is initialized in
> hv_pci_protocol_negotiation(). This is not an issue in practice since
> every hbus should have the same value of hbus->protocol_version, but
> we should make the variable per-hbus, so in case we have busses
> with different protocol_versions, the driver can still work correctly.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> changes in v2: Improved the changelog by making it clear that this patch
> fixes a potential bug if we have busses with different protocol_versions.
>=20
>  drivers/pci/controller/pci-hyperv.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
