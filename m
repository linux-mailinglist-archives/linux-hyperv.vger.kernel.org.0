Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAA219D69C
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390924AbgDCMVx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 3 Apr 2020 08:21:53 -0400
Received: from mail-bn8nam12on2124.outbound.protection.outlook.com ([40.107.237.124]:39041
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728140AbgDCMVx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 3 Apr 2020 08:21:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX5E3bo+ZSNCxi/WSIK25DuGmd2jk62LmGNdueegLK3u8WjafQjkh22aDDGFObnwKYjGq3M4yi+2CpRbW8A5Z9w0wTznS4aWOxdzN+BRqdX8Wf7HjyxnLAVWokMsaXq2KMcRlQ9+7ZYR144uylHmlry8gImE+2BBikc/BAWKFEmRrNez2IW6VBDfT/gFNeujas4eP6ESleA75ShEI/9BdOntbM3aUQ3p0H25wIshEKabDexGeIy++Eng3Qi+7LbX442q8aqiv9vCpGYO1XK67Udrda6gIhUtTrJSTfFKs1rNKEAHbx5Q+Y5ndSsIlLXzDEJLQb042QZwIKgBeaQFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnU9SZ7p/LUsAewRE/akMglyvqmV5W7DpOIi/770cWM=;
 b=RP8R1dNhTyBKeTLIALPOlaTtlGDgfgkb3mo06nCiWvSQCdGk4/FTAuqX2R+eCjO9zN2AMoQNqzwQ3GgLh7lupCZjtUnBqb1WQ/Ju1CZYAo4x3TV2G69e6hcF4l0oZdS5aATU7XTfHdVIYRljpMwXjLQ+ilddyefPHqeok7ap0j9gCmergae3EUq2oH03KLfUq7gx20n4ShiWj4PXRIxTE3ACYipytXQ9gjhHz8GcMrt5XmRRdhITiF/CIf0/qu0m8P9INXEU6yUTPkMvOo7Rdka3U5jw2Em8pYMmfpEsmEW+HyXMKy7+70jyWUdObUnb6XUTaVdcV2CLlen2q22YUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnU9SZ7p/LUsAewRE/akMglyvqmV5W7DpOIi/770cWM=;
 b=DvDrzamu3VdOQnMADdsckkkEQB/MiDsA08hki/Kl33yOUEXmojaiHC1w0aT+7MoHrjJ2Ec7X1e677wIFQmgxddleYbLG8i0QmjlZgeE/xR7Xv1fGrwW3dBzxibQBavSddvfWsTIkwBjY8dbKgoqcIETv3n4Ry2cB3dEo+rQCgcg=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0924.namprd21.prod.outlook.com (2603:10b6:302:10::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.4; Fri, 3 Apr
 2020 12:21:47 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.002; Fri, 3 Apr 2020
 12:21:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] hv_debugfs: Make hv_debug_root static
Thread-Topic: [PATCH -next] hv_debugfs: Make hv_debug_root static
Thread-Index: AQHWCZIjVQU/P4vQBEiV/n4KA05cSKhnUWGg
Date:   Fri, 3 Apr 2020 12:21:47 +0000
Message-ID: <MW2PR2101MB105222D949FB4944EE647F2FD7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200403082845.22740-1-yuehaibing@huawei.com>
In-Reply-To: <20200403082845.22740-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-03T12:21:45.3772385Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=700a9e34-20b5-4557-beda-d128ec16fa16;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78662916-1c05-4bf8-826a-08d7d7c99443
x-ms-traffictypediagnostic: MW2PR2101MB0924:|MW2PR2101MB0924:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0924A66FEA2ABCE62C397A8AD7C70@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:287;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(26005)(5660300002)(2906002)(4744005)(186003)(9686003)(71200400001)(316002)(7696005)(81166006)(82950400001)(8676002)(86362001)(82960400001)(66556008)(55016002)(54906003)(66476007)(478600001)(4326008)(6506007)(110136005)(81156014)(66946007)(66446008)(8936002)(64756008)(52536014)(10290500003)(8990500004)(33656002)(76116006);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFJw2eJ4yowwt/iniOIMTqxaVoMIGvUUxLg6eBZ3SSJfRCqIluj7+5t+SdrMdWEN9Fxm3u8naKQjmS86InMBS9Fquu8PwrUFrLDIUU5MRDR9yFN0k5+Nef8ebUyArPtCSVIY+hE61uNlujs3saJKzKYG8SmXREg3N3ClS7hOWtmWwqbdXsRlJWeuPjTMrMX3XV4UxCt1cDzDBfQsUQu/vCuOOSOJaHA+PHInXYN7Hdc2+UgTh67tZqXVASjzMPk6nGGcyJ64lYEGLk+dVTcvGFn/YlD/gk+ZDF4BKioTA8IzBrhfBb3jnEnLe5ZW1TPec1umsMBrvqQbdYllBSZ7qXUuADHJ78jvpn8/oXAsbnq7nfTZJ8FWldW82I7C+5Cl0WVs/XzYXJunv4UfdECOBdt6OEj57/T56IhCyDEkGDzF2vAsPjYyGodfGe3DFDkY
x-ms-exchange-antispam-messagedata: Ofz+rywIRxQOsHRXjGON5CeRNdlybvPUprYAi3eDgl9/V7OnT0gXesJVsDFvIL1MdfP3eJsTh5hQ4zkzZK81i4/IiH/VXuWCQxF0WZo/CxCeWMwAGwjO9KFMcMFEbm743zaXGg57tkYxF/BRObBiOg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78662916-1c05-4bf8-826a-08d7d7c99443
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 12:21:47.1355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7wjdFRqZN0k6IhQADFsY1eyCyiRKqHWBA4Is1Bk44vHDez2HzNeM7kCyl0Y/GpCa6yAjxA9NmTJnHxKJdQLQ0fHm3bmThqi6GkJAZsPKdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com> Sent: Friday, April 3, 2020 1:29 A=
M
>=20
> Fix sparse warning:
>=20
> drivers/hv/hv_debugfs.c:14:15: warning: symbol 'hv_debug_root' was not de=
clared. Should
> it be static?
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/hv/hv_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_debugfs.c b/drivers/hv/hv_debugfs.c
> index 8a2878573582..ccf752b6659a 100644
> --- a/drivers/hv/hv_debugfs.c
> +++ b/drivers/hv/hv_debugfs.c
> @@ -11,7 +11,7 @@
>=20
>  #include "hyperv_vmbus.h"
>=20
> -struct dentry *hv_debug_root;
> +static struct dentry *hv_debug_root;
>=20
>  static int hv_debugfs_delay_get(void *data, u64 *val)
>  {
> --
> 2.17.1
>=20

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

