Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26B6D772D
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 15:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfJONMt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 09:12:49 -0400
Received: from mail-eopbgr730105.outbound.protection.outlook.com ([40.107.73.105]:14467
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730853AbfJONMp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 09:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7GvJZD2MJ6gFdkYAxjVKUm12czh461wuUYOrp6xaQ5XQ95RY012mT+d1UAl4C0PXUxzfbQF1tmSBwta9uIet4JkkI5+yDlARGENnE08jCLOARV2OIMm0YG+32WJVGHeCxAuizd7bh/c2+JcI6Xxm8DXzIhuCqM59UDwlQdq6EgHV0QsgP+2/D83Fik38b2s8cFyL956D+wDjAYFZ+EVBA1qQFIIVYEP9M+HGT1uNBP9LrRi5N/rkgN97G8vZ1P3ZKOZncDLIXbRbVYIADNo5LcD7GdYGuXfeHBZOV3WUqxTyW6lzhjrtgarZ69jOPZET+gz8XrpDy4qJLL4eykz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkut6Lfyjm+88/F3mY1snyHLb35WdTiNeM+aw81//Z4=;
 b=KO8gzkD1nRUayNd0Ae/gHvNyZEujE6jtOW6zrwPpPjWouEZLJdVolbM4YMwoFeZ26uTpfCloqfwXFOIBz1p9thAsJFLL5B5umX8jP4pUAtbMtc1fGikzSowLwTwPy8hqCOb9tKFMKyPwhiA8/zRNABgg+3MTPzMi0APcqvrAyCOzBzyFRY8tMRm3FopAZYCpod8MpsjeBybHd23pdyVZTDP1E4ghpXmPIJRxQqs0C0AwHBG3iZpPIgQYxcZ0YFgVbOEC+7FagfztTqo1OREb/eV1Qvpf7EbcPOa9uV0e8Ty3PzBsui43xAxBkDzTR65ap9vN1pbmNqgn4piKMbDbmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkut6Lfyjm+88/F3mY1snyHLb35WdTiNeM+aw81//Z4=;
 b=Ii1WetGV2D7TITJ9Qpc7Qd45D+BZvhRQ00gBuaiKuXtZz4ETeoL9GsGluzACZhOylH9ARnCiRJEBsmFwaD/5xFnF1m4YpW4HY2v94goshuowUpXleSzuKOnUQGLQTSzYAkoKx0v2e5mL1sAigbYDFqeTST2zgEN5xg40acInF0w=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0188.namprd21.prod.outlook.com (10.173.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.4; Tue, 15 Oct 2019 13:12:43 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::a50f:aa3c:c7d6:f05e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::a50f:aa3c:c7d6:f05e%11]) with mapi id 15.20.2347.023; Tue, 15 Oct
 2019 13:12:43 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        vkuznets <vkuznets@redhat.com>, Dexuan Cui <decui@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH v3 2/3] Drivers: hv: vmbus: Enable VMBus protocol versions
 4.1, 5.1 and 5.2
Thread-Topic: [PATCH v3 2/3] Drivers: hv: vmbus: Enable VMBus protocol
 versions 4.1, 5.1 and 5.2
Thread-Index: AQHVg05QNZzTb6chqEyqiLj5ZV36XqdbrMiQ
Date:   Tue, 15 Oct 2019 13:12:43 +0000
Message-ID: <DM5PR21MB0137C98FEEAA15CB5B3485D8D7930@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191015114646.15354-1-parri.andrea@gmail.com>
 <20191015114646.15354-3-parri.andrea@gmail.com>
In-Reply-To: <20191015114646.15354-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-15T13:12:41.4926141Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=759b8823-5f17-471b-96bc-e901e67c9ad8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5e57091-527f-4244-619b-08d751715d5a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR21MB0188:|DM5PR21MB0188:|DM5PR21MB0188:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB01888006B0F548497B818A04D7930@DM5PR21MB0188.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(199004)(189003)(9686003)(14454004)(66446008)(33656002)(2201001)(66476007)(76116006)(66066001)(2906002)(11346002)(7696005)(6246003)(74316002)(99286004)(446003)(186003)(66556008)(66946007)(64756008)(76176011)(10090500001)(6436002)(256004)(55016002)(25786009)(71200400001)(26005)(4326008)(8676002)(102836004)(81156014)(81166006)(229853002)(6506007)(5660300002)(4744005)(6116002)(8990500004)(86362001)(71190400001)(8936002)(478600001)(486006)(316002)(22452003)(10290500003)(2501003)(110136005)(54906003)(7736002)(476003)(305945005)(3846002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0188;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7iGmWZHH8TTc4dFmKf+WmMmBbc/MUkHMq5hwMNIpiL4CsMnB55kHhDKdp7aZVXSJp6TqV65nL5SyQKUAaVpttNVzhSi/ZeLXclGtVHdhOdfxduF2djrLqOtZ0bcEtHqu8Kq7p/fuNO7j7Bdm+FdxaKjO2A7dpjIwFb1iyo/Uw9vXkWBQAR4VyU3IWrcGro2R3a/c1FFCfPA7DWAYYWG1towPNSC5mwcZI8tOHIKvaZGDaX7NI+lwAvaGtWyM/D5+85nuiK7h0RBjImQXC412LAoyEs5FztoRQB0WI4Eel3//gvzsY335Nlibw70rWo8O7OtXEvNMIi40sl6/MquSPOePxk+LX9CDT6bu4q5I/yNJiJLWCQvLMy7onWnTXdhgOEIXt9BnVavwgT1PYQWul7VJ9rId2IG1KEWz5ZrOtI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e57091-527f-4244-619b-08d751715d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 13:12:43.4873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/dLAr5q1oOoVlJCbuwHcu/2pOhu2tlk/SifT9bV7fJiKIOc0Ls7P3WpzbXg5h58qsUXXmRQNlK0Txm3rVzIYP0sWoJOK1UY7MSxKc0N4+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0188
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com> Sent: Tuesday, October 15, 2019=
 4:47 AM
>=20
> Hyper-V has added VMBus protocol versions 5.1 and 5.2 in recent release
> versions.  Allow Linux guests to negotiate these new protocol versions
> on versions of Hyper-V that support them.  While on this, also allow
> guests to negotiate the VMBus protocol version 4.1 (which was missing).
>=20
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  drivers/hv/connection.c | 13 ++++++++-----
>  include/linux/hyperv.h  |  8 +++++++-
>  2 files changed, 15 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
