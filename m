Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CA52269A9
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jul 2020 18:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbgGTQ2D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jul 2020 12:28:03 -0400
Received: from mail-co1nam11on2104.outbound.protection.outlook.com ([40.107.220.104]:64608
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731806AbgGTQ2B (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jul 2020 12:28:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaUcUBjOsor64sdejMk9uQ3+ovjrJJjTTegbEj2C4bU8zCDkTnr9b4XeYKq7IGLfPE3d3IJ8u1GH7KK/PYR6RQxFGtUapCHWDK6mlDfWAiGQK9PhfTvswJ01KXQ5lIAHn7F5Yf4l380/MD1JtR6rtp2duz6tnELct7QKa/RzfEzNsTPUbRIrvxv4QWIAQrURo/UsVYlgePaEkCWFLDABawxhv2G7V4S7iY5O72ldemyWUO4lrAFCFZeQca3Oxmc8UV/m22lveb4H6b13VqFGsU2DcfwsT/5qS127cfIm2ZowlUgJutd54dFnvaqn9XyEaMHPvH1MBdmTM+Av0LuV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRE7On7IabZ1eW1cwefivFmIBZ6/+O1wpQDJLQdghj8=;
 b=U4dWFz+xJgQB3i5JwFS11nFlMwY+kzGkTBxmm6eV3z3YAoxKBKaINvdpcgcI5QVK7qZJ/7iyWNcioLUdeiMXAwmT3LV3vdnXy3xX7UywR8+ELVI8elIaOeb402eKSndZ8LP83hMoqGPpscwHXRUcJ8Pvqh10hP7lKkhU6j+sAcm6VBlcDwMl6WeXK+ywCtHmahWtB7a/38v35xP1yEN6FXp677JoS89zyNxnOp6CwkxRkxezQJR8AoOWFp8h/EoRH/EboGukUE21//syzKhU81bMlKFLzSpFIG7bVcIBldgfrUqWTFujhxAuuUEbMP5s1QF/NWlVMo9XL8cXFjpEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRE7On7IabZ1eW1cwefivFmIBZ6/+O1wpQDJLQdghj8=;
 b=RWntARiq5XpcXrLXw9o2TbTH4X1ej/dTC8sN/Ibw+aTRDlIH98h19/gtw2ve/do/Dz2fcHkS104tKDcb9BroIvix7WIuCzFSdXcb7xlwqk0vMl5anWylr6Nv9k3DeNtCJhogkeugMJcZACtfsM3tloHzYokP+KrrmtVYNnnAl2o=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1001.namprd21.prod.outlook.com (2603:10b6:302:4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.7; Mon, 20 Jul
 2020 16:27:59 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%8]) with mapi id 15.20.3239.005; Mon, 20 Jul 2020
 16:27:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v3] PCI: hv: Fix a timing issue which causes kdump to fail
 occasionally
Thread-Topic: [PATCH v3] PCI: hv: Fix a timing issue which causes kdump to
 fail occasionally
Thread-Index: AQHWXLZO4rg806/YAkqpm5I8FMMzTqkQq3Jg
Date:   Mon, 20 Jul 2020 16:27:59 +0000
Message-ID: <MW2PR2101MB105217EA920CDA1600449D3AD77B0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200718034752.4843-1-weh@microsoft.com>
In-Reply-To: <20200718034752.4843-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-20T16:27:57Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=89844ab3-3063-440d-bd17-ed0f5aafdec9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f63397b-24f2-4a5a-bcf3-08d82cc9ddb7
x-ms-traffictypediagnostic: MW2PR2101MB1001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1001A08CF8D32AFFC6BB5014D77B0@MW2PR2101MB1001.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/aurKXNEAmpYSL5DJicJWJtMjp6LeBh0cFkql4habiquUosg/YQbL17PSE8z6EofCSZCEBZNmTLDcHXKta8Vma6fNvEjLWqHAJS2kKPTZDGa6NoYMKb4Y3KULi0vdv8ednBzRUTURwYq2IjLRmxK2fm8ypCBVqpUqT1MMfBk8TpQP49uxtNRxJa6V472fX1/8GyyTDxSRkrD29xUBrLW8ueUTUCAwSdn0rQaPTXNO366da5dZKV+ucuUfTOSwbEfuCLBSNBkeIyHiJWdaiULNaWJxpXrUTwRwdiw2jRrXONPmK5mhWzCEb8TlmD44rIouMPHtEkCdDSMVg0vo8YQ9Nc/4COpTrdwsrUqZejqHd2tHVmvrsMHoRKYz9LidzC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(5660300002)(83380400001)(478600001)(8676002)(53546011)(55016002)(9686003)(7696005)(33656002)(52536014)(86362001)(110136005)(316002)(6506007)(82950400001)(82960400001)(8936002)(71200400001)(10290500003)(64756008)(66476007)(2906002)(6636002)(186003)(26005)(66946007)(66446008)(8990500004)(66556008)(76116006)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9Qyt013VsU6ZEL6ELrXi33DXkiA4Mrb3MqMS58bm4uGTF6lDzOE1RtYFRZ7QxmvIpysrl+wm4sp9+iC3udeX2+298fnB9AI4LAzEp2RaLLVMC8mxrHnKWqd1BNlCkzxJWdF0272IP6g4gVxDk+78LdnYeLvjb5C4Mm7lmG55pMWiZ8ECRV/gChalvkUuil6gnwYKp+ix6BrWyPGDX1koJLSJVwqEahefO2kTvEGgWNSkaQ1pcYLH4MgTxjbvbTtllVGSO51u2eh1yVEmqFx2hJS8ksQokM+xF/slS/wIqHqYewLZ8FtkCBgC79I2JhBJfZxPVfXkXLcaQlg3+Y8jXgXx9nC1P0zWKlFBDbTsLzO+lpIPM+SPg+8rlrv0jW1s2PWhs1VlwtVr92528mRt7WnnjXkfgtABW0g1RmZaD/GIxE/Il///Tfy0UR9cnuw5W1aO36fglkY9fnOZSnVfCa//HjrBpAxqVa6i17tmTh/P6isnNO3FG7e8aVrRztVR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f63397b-24f2-4a5a-bcf3-08d82cc9ddb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 16:27:59.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOcLCjfBZCCGrgWSvdQdqt8vL442oampXosuCCDO1vBarmZXiGwX9Cd8rlstZ+2xgAoVy2G7kJJ6ucsjUeATcsQT0kfOoQe9H0Q/2+X5Lvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Friday, July 17, 2020 8:48 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.=
com>;
> Stephen Hemminger <sthemmin@microsoft.com>; wei.liu@kernel.org;
> lorenzo.pieralisi@arm.com; robh@kernel.org; bhelgaas@google.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-kernel@vger.kern=
el.org; Dexuan
> Cui <decui@microsoft.com>; Michael Kelley <mikelley@microsoft.com>
> Cc: Wei Hu <weh@microsoft.com>
> Subject: [PATCH v3] PCI: hv: Fix a timing issue which causes kdump to fai=
l occasionally
>=20
> Kdump could fail sometime on Hyper-V guest over Accelerated Network
> interface. This is because the retry in hv_pci_enter_d0() relies on
> an asynchronous host event arriving before the guest calls
> hv_send_resources_allocated(). Fix the problem by moving retry
> to hv_pci_probe(), removing this dependency and making the calling
> sequence synchronous.
>=20
> Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid device s=
tate")
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>     v2: Adding Fixes tag according to Michael Kelley's review comment.
>     v3: Fix couple typos and reword commit message to make it clearer.
>     Thanks the comments from Bjorn Helgaas.
>=20
>  drivers/pci/controller/pci-hyperv.c | 66 ++++++++++++++---------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>=20

I gave my Reviewed-by on the earlier v1 of this patch, but reiterating it
here:

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
