Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3731510DC51
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Nov 2019 05:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfK3EaJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Nov 2019 23:30:09 -0500
Received: from mail-eopbgr760128.outbound.protection.outlook.com ([40.107.76.128]:23105
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfK3EaJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Nov 2019 23:30:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFoF2lOx/+6CKdThc6FxGMyi77v4mMQDbBLxbXudKiHVG3+BztWVvSxnnmHpmt8kM+ZTPKxPWaox6NNDgInZkHTmx6wd+nIvfDCzoCzhVf/8O7UyJ1WwOHUJfTXoqjk2+iergjAmOJW6TUHT1InSmvgoO15AaL5L7SS5y21gA1vNazRfPGPzzh9DPyqNDV7bU1K+g+t4cV3kb2D0iDQgFE316GuUlG+KM6hElQLvnNKNqPVSno3JR3+BImyiTfF8RF4oo78gbXQRBlBlFPN7tiaM6Kk4EOnrkHeR5QXJxpvmKTvnFsgVbUGQBYO6yCABDUkBcnvcchqMJpie2ssz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek599W0cnAadV7AeCqeQ+lVMhFk429fzqTmlmmlWTYs=;
 b=h+XMkjndxzd0/HQ9tAL8Iy62lnlRO1n+eq1X2X0hWbjXMAKNoL7a/YoebsA/NIpN2x4+zASnxeQYCTGhkpBWhwACLBatMWoiQPuwHw/xYltWw+CYkLmGyuILD6AVWR5n2bC8IbCtI1g6i/7K+GwYfITs5YcCU3eETcw7eFfWDpCALh90VYOR2wg0Zqwz+NYqZ6Yo1OprGkb+d0s5KAFrzC2YKM7pqCr6idx7eupUVXkDyQJJ65zIY6MVguHF5dXWp9O6Snp7LcHy6pLYWzR8EVdkDgzGZs4Ime78KC+7kwL5zJRcMMvKeKn9eiPj4LOu5KcwjToT+O55q+Sk6kecjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek599W0cnAadV7AeCqeQ+lVMhFk429fzqTmlmmlWTYs=;
 b=K1kKnZI+U8xGS6mdbGDVpxgsIUl90EQIkqciTzTCWF9YS4WVUGNKSKD2YgXPF4EfUkuFzCh7t1CfUXO+vIk0W5lK3/7Lw5D5tMwymCFFvu+VUDBtE0ZwHD5LY1vT/4f2tiRZCutnH/Dt69F743Q8sCPxyregijshb5t+9XTsD5U=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0775.namprd21.prod.outlook.com (10.173.192.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.0; Sat, 30 Nov 2019 04:30:06 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.003; Sat, 30 Nov 2019
 04:30:06 +0000
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
Subject: RE: [EXTERNAL] [PATCH 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Thread-Topic: [EXTERNAL] [PATCH 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Thread-Index: AQHVoaFcWphb3zmlG0OqjmKFjc5K8qejKdTQ
Date:   Sat, 30 Nov 2019 04:30:05 +0000
Message-ID: <CY4PR21MB06293F8FB8A8A1ADD628A8B8D7410@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1574474229-44840-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1574474229-44840-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-30T04:30:03.2842035Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=739473f4-27c9-42d2-9236-15eb823f680e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: daf0c42b-df3d-40e5-f358-08d7754df9db
x-ms-traffictypediagnostic: CY4PR21MB0775:|CY4PR21MB0775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0775DBE1CC8737FBA3261135D7410@CY4PR21MB0775.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02379661A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(136003)(39860400002)(346002)(189003)(199004)(99286004)(107886003)(102836004)(33656002)(2201001)(6246003)(86362001)(2906002)(7696005)(6436002)(110136005)(76176011)(22452003)(6506007)(2501003)(1511001)(4326008)(8990500004)(10090500001)(55016002)(9686003)(71200400001)(15650500001)(26005)(256004)(71190400001)(25786009)(5660300002)(4744005)(316002)(52536014)(10290500003)(76116006)(81166006)(81156014)(8936002)(14454004)(229853002)(305945005)(7736002)(74316002)(66476007)(66066001)(478600001)(11346002)(446003)(66946007)(8676002)(66556008)(186003)(66446008)(3846002)(6116002)(64756008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0775;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y3CI/vYqDyZ9YvqXh3pNqKTViSEmo0yOorS7eHCPI1SoCZqgVPx8WiAH/HUh7lg7utIc7byYehMTk6x7uTbmU4YPpquoaxgoSpJwFtd5e4dYvivDB87oR3pjzc6fPM68a6PXPcnd4/J8fM9xhrfrOPSW9NkNlPFZt1va9QsmevgQZ3TX9Y0cD7RDjHuidv4o/LPoQfjlDcS0LSp+TxNMQzGYo0mt+CsV06RPGJJhksiiJUfSJ8goszDvVH73v8oWC4AP4o7XXm/gGsIV9lk1nFpWCEfyZJHssDSS8pywaGd3u42bQY4YKvr3wGrC2MpgUgoX52AAISRLbe9xbFn1icdGVVxYl5wcN4Ffh3MEzlRAjIyLeyrRaepBCeiL79prR2CZ/2n254R4mluvigT6cBOSwGfvLYr7IcEPRW/AFgu9ZGRV6jsqZVnbggPa8XRA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf0c42b-df3d-40e5-f358-08d7754df9db
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2019 04:30:05.7819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRuT7ChrdREyJLKwAC9yJJzwd73/GLtU7zDnjRI4XrM5SfAAjx1Yq8lKvikKzUQaWDAqSNN32qFB5xU4ZL1RUy3Icx7AApOHFvAJKXsrCYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0775
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com  Sent: Friday, November 22, 2019 5:57 PM
>=20
> From: Long Li <longli@microsoft.com>
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
>  drivers/pci/controller/pci-hyperv.c | 100 +++++++++++++++++++---------
>  1 file changed, 69 insertions(+), 31 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
