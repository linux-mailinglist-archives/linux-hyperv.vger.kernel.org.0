Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA01AA565
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2019 16:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfIEOFx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 10:05:53 -0400
Received: from mail-eopbgr760118.outbound.protection.outlook.com ([40.107.76.118]:11467
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfIEOFw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 10:05:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq68ixzBsxfm6hf8jSEk3SVAtSePv9NEq6b7glrIO4XOElKcnDYhJYW5P2314x0wY8+rHy6ZShJkLs2xkRS/fFCDjoSH8WC7KxFjFozH3CnQ+6Gh/2nuAZpRC5pU7cDR1Rx9StFdAIGx5E0t6brbZnNv8DCmEDwBjgMfFXQe1HGQwAhQGwpmD/nYyuNO8P/Bv2kDs6o16M9/kOZsMoDgnohOxFc+Lp9YH3EOCYv8LtW/CiT4kXXZ8aXYVG+gIDjsaYQ1cgjHsLJ2glOAOrvmoZ53kggPGIZ2m/JmtlStgQXrsl27VsfEC94vxHhdOcQw1370y15dWJaDjqvbgmwXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iavyn5/LeMujLUYzJfuyfS+4LKPlHifEu2K00ZmAld0=;
 b=NLO8hrYT/trBeqndA4ZG55KBCzIvtZswJUj7j3i3E3BfyMOIIS1hOOA07ijkqjAAcZXH9aFsIzAOZ7VOfXd1CQsBrw0eqxIcPj3HDIy5cmzCRRtElKBmfxXAytRxgswOrwj2CrEwjW2awRjZo6XisYPNdkPxfctGjA8SnXwXDoivvGRGc4IPmTP7mSl93PnAwO7plSTG0hseRIdDsusPDNk0iAS+lYBEeClrWGp2ylFfq2Rean7leO6/fUqHvYLYp0BX1G1WjFVsKmaas8N3NIM2NPF0u0i3RHtVMUUMALnixdlc/N72qExcT/BHOp1jFetdpChPHpDhFHPan2d4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iavyn5/LeMujLUYzJfuyfS+4LKPlHifEu2K00ZmAld0=;
 b=Yzt0MNrMKJh6//1/79waRMybbzkxpgLxkBWtAscpRjBMYJRHTOaewTt84qTPXsja4U5PDd6akIz0bUguUWW9vKQxoP9bVlxvhEEybogd2slRDGmvf+yR1JbfymwAHmTZgjx05vZOC7kMZItJ9zyANND12Hv0zfgOK7fpue+Uy2Q=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0843.namprd21.prod.outlook.com (10.173.172.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.7; Thu, 5 Sep 2019 14:05:49 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%7]) with mapi id 15.20.2263.004; Thu, 5 Sep 2019
 14:05:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC:     Iouri Tarassov <iourit@microsoft.com>
Subject: RE: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Topic: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Thread-Index: AQHVY8n1ZHStyEKyQEWtq6qT8x1cIqcdHi/Q
Date:   Thu, 5 Sep 2019 14:05:49 +0000
Message-ID: <DM5PR21MB0137D40DF705CDB372497266D7BB0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190905091120.16761-1-weh@microsoft.com>
In-Reply-To: <20190905091120.16761-1-weh@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-05T14:05:47.2964572Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5fdc59c0-9d8b-4103-9a31-ed8f82961311;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1eebf27-c839-4db0-5391-08d7320a27ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0843;
x-ms-traffictypediagnostic: DM5PR21MB0843:|DM5PR21MB0843:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0843C0D93057DFE6CACADD72D7BB0@DM5PR21MB0843.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(2201001)(86362001)(4744005)(478600001)(6636002)(81166006)(10290500003)(6506007)(33656002)(52536014)(229853002)(8676002)(81156014)(8936002)(66066001)(76176011)(14454004)(99286004)(1511001)(5660300002)(186003)(486006)(25786009)(4326008)(476003)(10090500001)(2906002)(6246003)(3846002)(107886003)(53936002)(9686003)(446003)(55016002)(7696005)(256004)(2501003)(11346002)(6436002)(66556008)(26005)(305945005)(71190400001)(71200400001)(6116002)(316002)(7736002)(102836004)(8990500004)(110136005)(22452003)(66476007)(64756008)(66946007)(66446008)(76116006)(74316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0843;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 62YoNtJ4rqfQGlhygqWLMdIVo1wXXYN0fPuOwwiHuBNm4s8SprVSmiTZjt1iA2sq1NYP1600XBULdzJkvbvtXFjnX/8eKW8e9vOWN8mptx8OWSsjma1zgzae0wCLUPzvuvWQc3oRvODyrgIdvouF4oqAdV6lFMs24CPNME8j6Iu9mQv/uLarojb8PQodn+M6mA+RGmy3ESalnss2W6U0nC3onQTLUSB+nyWdNSoP9Huu+V70m8vXgLOlbBImINffzZKjeAaZ0yBFFDwbCfV8KQh7S793o2uOmkKiIHIZwo1SBEkNobJkPEe55tr7WOO4/hIGBqIcThq+g5if9W2qWB/5JmfXc7vlIPtBPk8lovvT2RcbwX73QVCqfdtT9NqXzETmh4Hy/bmVTBodlO/gPb9SjD1yZs9k+8nCUlB5xXE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eebf27-c839-4db0-5391-08d7320a27ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 14:05:49.1083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvaKevwvhc5NnMsUW9bAqhbWLA0iGcI4z/0ZN3iHba04kbdFq6RLYAZJcU1299ElHcRrH2TeC0KdvHLhBCxcPc/DnGxc40Ri+ae7AgyX/Ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0843
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Thursday, September 5, 2019 2:12 AM
>=20
> Beginning from Windows 10 RS5+, VM screen resolution is obtained from hos=
t.
> The "video=3Dhyperv_fb" boot time option is not needed, but still can be
> used to overwrite what the host specifies. The VM resolution on the host
> could be set by executing the powershell "set-vmvideo" command.
>=20
> Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>     v2:
>     - Implemented fallback when version negotiation failed.
>     - Defined full size for supported_resolution array.
>=20
>     v3:
>     - Corrected the synthvid major and minor version comparison problem.
>=20
>     v4:
>     - Changed function name to synthvid_ver_ge().
>=20
>  drivers/video/fbdev/hyperv_fb.c | 159 +++++++++++++++++++++++++++++---
>  1 file changed, 147 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
