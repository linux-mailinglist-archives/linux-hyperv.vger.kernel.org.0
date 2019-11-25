Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF431095D9
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2019 23:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKYWwT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Nov 2019 17:52:19 -0500
Received: from mail-eopbgr740121.outbound.protection.outlook.com ([40.107.74.121]:6217
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfKYWwT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Nov 2019 17:52:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyvXutqGyzBlIA0Ui59NNlJDrFhhdEtaOX+IuPkhQHEHHTfs8ElFrFg5Dxn5ixpx0Q/S6fK/nyQzqgyrGTSRQAjzNMDzAXCeqT+vp4QEnJk1+HqWA9Ir+E3x0AzP+JjSZJVwEU168xthL0atLWySiAhTLViu9YJPgROhmIN9EhsM07Aizda4vAN70UDoS7/1B16Gfrz7rHygHHMfAqq5SMr937qjnFrNliiPPaelIEhZZCjFGtL3mp3oC0bsvUGV+CQ2CR/yctdOp03IXlITJ7lxTgq46THTwk9UtPBuzP5m0XSRzpV1yNtPW+l8+D+NvMWMciw7W35FmAnDmyhhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8aw1oIZJ/qGV+5bk5sLGZYcGICYOFwxH1UPjhAAp3Q=;
 b=eM583zs/g3wQpj9FBzv/qAepV9MoKUFtOhRkNbylUcRVeINbSD9e88+XeJYQeg9diKdO9usLI+Rdnn9JkTmtlFZ4YOViFTHih8jFNyqzIFve6YLPv1MS80cNBF1KhleKFKYot01xtSceGd5Zn8hCI2QtTELFNFUJrHGGpVsNnEiTt+UCm3gn8r1uDvwt8KpBXXxsuwUAoDC4jq8Uxbqck72q0930ooRhfAhy6ZJELRjXI0HZbCz9Xt1UTgPWjMdV3pXu3TO9E1M6pDBK9m8nGEcyo6eCGegRsnw4FPYbleKE1WIkoFQzm5SCCQp+XIAzFhtq8dHaQEec+LWRiCVH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8aw1oIZJ/qGV+5bk5sLGZYcGICYOFwxH1UPjhAAp3Q=;
 b=JFzPhGDobZfnkSlHiRiQ0glSZq1vLZhy575wB0LUTAjT1FJvVK9uTNwVpcFAuvY8GfEbYMEevpwv7XHjV+2Acz0FC4Ghv1dpioxGDD10omAxY766kF8/zx8CLBOnkH0YtDxTu5lUlTPE35aB3WmnFmtp4Lp+RIX4nIo/l2bIBWk=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.8; Mon, 25 Nov 2019 22:52:14 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.003; Mon, 25 Nov 2019
 22:52:14 +0000
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
Subject: RE: [PATCH v3 4/4] PCI: hv: Avoid a kmemleak false positive caused by
 the hbus buffer
Thread-Topic: [PATCH v3 4/4] PCI: hv: Avoid a kmemleak false positive caused
 by the hbus buffer
Thread-Index: AQHVo1H3gNxGIJA/mEqQ/naH5DHpV6ecftNQ
Date:   Mon, 25 Nov 2019 22:52:14 +0000
Message-ID: <CY4PR21MB062902DC13B46FB1C5A34926D74A0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1574660034-98780-1-git-send-email-decui@microsoft.com>
 <1574660034-98780-5-git-send-email-decui@microsoft.com>
In-Reply-To: <1574660034-98780-5-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-25T22:52:11.7700017Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=86c5da1b-81e7-4a5e-b0f1-859498e89262;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:cc71:9380:de71:b696]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f53d00d0-6228-47d3-b592-08d771fa1d35
x-ms-traffictypediagnostic: CY4PR21MB0469:|CY4PR21MB0469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB04699B3D1DCFD9174B07102ED74A0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(376002)(346002)(189003)(199004)(14454004)(33656002)(46003)(305945005)(52536014)(66946007)(76116006)(64756008)(6506007)(8676002)(2501003)(256004)(7696005)(14444005)(81156014)(66476007)(76176011)(110136005)(71200400001)(66556008)(71190400001)(102836004)(6246003)(186003)(7736002)(8936002)(446003)(81166006)(6116002)(478600001)(86362001)(5660300002)(229853002)(55016002)(10290500003)(6436002)(11346002)(25786009)(9686003)(22452003)(316002)(2201001)(8990500004)(2906002)(99286004)(6636002)(10090500001)(66446008)(1511001)(74316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?+F5jTtL8iz/ylrsvctWy7ufK3c1B3zij7TbWsYcL0U09IkIGxhqlXhOcEdR3?=
 =?us-ascii?Q?THpCwaqsIdxauQqTjyQHeeq1gEqRQH8rhH/ryoD9wH9qPnS76402o97Lzafs?=
 =?us-ascii?Q?owuPNyfhDmVbuu1wilS3tGfNaKmjaRt6k7LNxEIKrEeYJM8/Ko/2Rz+fLiWM?=
 =?us-ascii?Q?caMbCMEHo2rFvNRWfkfHanfdNHVUND+cp1MT3bhw+1TwuGlFEJwYPYQlNlrl?=
 =?us-ascii?Q?H5bRGWFX5pxaV0TIaB62m8VCfMhe04uG2j6WmHfd8MGDW+IJxOfghEcxejJR?=
 =?us-ascii?Q?dNAx2YVrzvKHlKB+YyDdbVC4WE7989iCm81CvbfVXH6BTXTJul43Fc5N64p7?=
 =?us-ascii?Q?RcGwMuQR6wUcvrf/McGH98cyt+hNudRHB6r6bS/Z3UUQXuLWnuK+xyQ2627L?=
 =?us-ascii?Q?o4EJtinv/rktr3yKCh1ybzC91odQg7aJvHIDc2yXfX4wVLV1iWDXqkkHTeRR?=
 =?us-ascii?Q?bM7QZNpjQdikhLTvrxQH1/hhwL0YWt0VCaLnVjjC9zItoQOOm4aFmTyRWR++?=
 =?us-ascii?Q?cGS29QlHoh6++EpgFtizRH4EEIZdMbsiZNQanbTcTejqWwssZtqPnPZ9freG?=
 =?us-ascii?Q?/jAuyNj2Mp8/HbmZ9re5ki21+rqLrr6NO9UPQ33ZpdzlOLfvzBA+fApP6LlQ?=
 =?us-ascii?Q?n2Rqcmpu4T5FHA+hzaTtefMcXsKbUMZcVfRO4hs4QY9jAKJYnfdZBJkw5ngC?=
 =?us-ascii?Q?T/QPrsBMgDC0M6y4PuuDVd58Ql9Wbm671QlZyxbZsAZO+Z5oo3ET+QiuJk4z?=
 =?us-ascii?Q?KixNyAJ2k+22dCSuysuuSo3hCU7D6Byi/ruwYQ8ItEQvxnu/4x/9u+fawmFt?=
 =?us-ascii?Q?ZTtLqAL3nFwAX6WKlYo3eERwP1asbks2ZNlAa0IGI+UMeQ3VdeJWvo0mvWlj?=
 =?us-ascii?Q?pzXk3qcCjwlhXRlijKc5i/37TjNl/YEcpgrJPGpOZzd2KXO0wBf3dAZ6RddK?=
 =?us-ascii?Q?WOK4Rk0iEJ2CdEt61SkUXEmu4djuxIRMVXRziJwEgMEF8qysr9ZhiuBZXl30?=
 =?us-ascii?Q?T42ZB+e+1FZMhFBCwFJlu+DVw475b2lUC/T0eO7XhVPNz/xbrfv3qwLijlG2?=
 =?us-ascii?Q?Pxz0nE5tpO5X5hqLWqSI6/rFHjg7pL5aJrM6Yu8HG38iJ2wGJ134Kznl0kgg?=
 =?us-ascii?Q?saFI/a623paapj/wuJau7GaFU9Hqsd8l6UHqgy61msrsQQhwOPs+cQW0o3s5?=
 =?us-ascii?Q?WKDbBIFTTfYnd9WLTpiFGP0SAnMNGi8g89jFKtC/S8FNY+oEO8GD8E1Asawy?=
 =?us-ascii?Q?3CXUAeSc0ZZsC0gVy881BPLWTTx9NX/WkAXReUlzTzuZ6U8nSih3hzUlPg4C?=
 =?us-ascii?Q?XlEuPl5Lk992w72wQXCpkIXOSdhBhudW+hQxSvQJCbtzpUX0kSKLyImRgG4Q?=
 =?us-ascii?Q?rEKyEU80Gb+L6doSisxRnM0BjrGZn8jaHMFgDG1Ls/VhvRhJBa2o7N8kAl8A?=
 =?us-ascii?Q?1JUktyLbez8LDBPhLqvh6Oe56yEcSjKudxqm8I3FOavcNw9c5rW+YBq/Q3eI?=
 =?us-ascii?Q?yYE4XhP0emSOyUwB+u1W5uw26BwKQ7n7DVuwM4TXTYwkfnnUUXGt4i9pDHLW?=
 =?us-ascii?Q?nbhh7+CKWHvyzLZ+hSl2unbYV3AMFHYHUnKlK4l4qX89cdkVmgpbW1Egv45D?=
 =?us-ascii?Q?ML2T/RbCsXOEwemoCVMn880SbSx0Fj5p2YIpsWGpi5YmZuxoESC3wznxG3NW?=
 =?us-ascii?Q?tNgPJjZL9OZBqpP6X743GpD7fWnHYtJTkO1geM+qFGrL0z3DGUwU/kG/Rvfo?=
 =?us-ascii?Q?J18JQVZWJ+jTgNREtmZgC8W/FYfV0AwwSZi00Yo3pv7/cxvKOOH35FizaU6Y?=
 =?us-ascii?Q?71y7R9r2UUmT4VfNLx6Zx45do1VEQCtmmZkJlU3YUoh6ThLPIeOZ5KQ46UMF?=
 =?us-ascii?Q?8NPm03p1lDULI1/xHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53d00d0-6228-47d3-b592-08d771fa1d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 22:52:14.1156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pVf9TEotI6yT1dqf1yOxUPNzLroNAn9vNq4tkyM/wQC87rgY+X7Ah4h2kjasl6p3Sj5QE6FNWpmAxzAglAJwvpBxW5sIqvhwsPEF11C7TRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, November 24, 2019 9:34=
 PM
>=20
> With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
> alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
> a 4KB buffer that is guaranteed to be 4KB-aligned. Here the size and
> alignment of hbus is important because hbus's field
> retarget_msi_interrupt_params must not cross a 4KB page boundary.
>=20
> Here we prefer kzalloc to get_zeroed_page(), because a buffer
> allocated by the latter is not tracked and scanned by kmemleak, and
> hence kmemleak reports the pointer contained in the hbus buffer
> (i.e. the hpdev struct, which is created in new_pcichild_device() and
> is tracked by hbus->children) as memory leak (false positive).
>=20
> If the kernel doesn't have 59bb47985c1d, get_zeroed_page() *must* be
> used to allocate the hbus buffer and we can avoid the kmemleak false
> positive by using kmemleak_alloc() and kmemleak_free() to ask
> kmemleak to track and scan the hbus buffer.
>=20
> Reported-by: Lili Deng <v-lide@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
