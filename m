Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848A68BBA1
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2019 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfHMOgd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Aug 2019 10:36:33 -0400
Received: from mail-eopbgr1310092.outbound.protection.outlook.com ([40.107.131.92]:58584
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729581AbfHMOgd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Aug 2019 10:36:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBYE/RdFH7O2aDOv7qgYDn+1W3uDhcHO771P9TtRk7xfD4v5nxWD4UIXsBx2YrK4ecP1Ze81tTsafOPx9m6+anDDNzd8aJYPMUmgsZLGAP50A/p8drI4gLbg1904nWB9FAEg6a5Cfdnva1wHhu0KVge0L9TeqTAygHWurdqKhejB3MdAixRmdZyBZhX/5S+13/H72ibkkdOMy10wwQimiP/EoIkKUURicC629HzS184TlCn2rWw7UmEEYZ6wkJjMNURZx33h5bw4cT4lDbF60M1eRDo8brL5sTduGIxAifjJlwQf+/CGxteQkjOGmABp6cIdM1LyoOi5CUQDrAlmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPrTVF9CwiW/D13ZC0ej5pgwo8FzImjbKYLyhWKCHKU=;
 b=SaXSxUHpElEspVj2vdgwKtNs2WxtP0mSpu+wCCNWp4T6xkI6sR5VXNUZzkv5Lmr+JH3m4zzpCACoDoGPzTO9AqI15JbLTK4bZLHqGhJk0g+R6Cw8JIeJbzxuySlTBt03/IrzXatDrH9xe0B7BrLB/cLkDG5xqq+OLfHJYJfp0IXu/KO8camadj5zEPWwxLGjmP0qQFDKuzxcJbZkNRGhaSS+oHvGV0saEOUETHyMapBfUWDnow6ZLYjklPeJX8wy6euQfXBroaVbDTw8w7325Uc6CwDkO9mG+huWE6GijYIpWaWyCEsSz0t9BcrkRzs87BnIqulILpYk4Gy/fKS5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPrTVF9CwiW/D13ZC0ej5pgwo8FzImjbKYLyhWKCHKU=;
 b=H4Z1mGSNBqJN+3TQlApiHFK1VLTEG7dV6CpNbLseu7Fq21apsOCdokFDpacs/RDF+RCKqSOoppAaJJTBejzIlIwbEsPzkr0LPghcPb4VmTy5wwVUKqT7TpfvKKu5/XXA3bgP/L1KuCvz4J4T300+DKcO4bCNbIkVA8QMAN85FM8=
Received: from HK0P153MB0290.APCP153.PROD.OUTLOOK.COM (52.132.236.143) by
 HK0P153MB0131.APCP153.PROD.OUTLOOK.COM (52.133.156.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.6; Tue, 13 Aug 2019 14:36:27 +0000
Received: from HK0P153MB0290.APCP153.PROD.OUTLOOK.COM
 ([fe80::2c10:be63:5b1f:bd17]) by HK0P153MB0290.APCP153.PROD.OUTLOOK.COM
 ([fe80::2c10:be63:5b1f:bd17%6]) with mapi id 15.20.2199.004; Tue, 13 Aug 2019
 14:36:26 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Denis Efremov <efremov@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "joe@perches.com" <joe@perches.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: Hyper-V: Fix typo in a filepath
Thread-Topic: [PATCH] MAINTAINERS: Hyper-V: Fix typo in a filepath
Thread-Index: AQHVUZz+RKGrCQJcvU+/Bs1dHSrJ9ab5I/gg
Date:   Tue, 13 Aug 2019 14:36:26 +0000
Message-ID: <HK0P153MB029066532EB85C14E77E60F692D20@HK0P153MB0290.APCP153.PROD.OUTLOOK.COM>
References: <20190325212516.26489-1-joe@perches.com>
 <20190813060422.12634-1-efremov@linux.com>
In-Reply-To: <20190813060422.12634-1-efremov@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=tiala@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-13T14:36:23.0287258Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2925e0ba-f0c6-4326-973b-0272d587aa1f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [167.220.255.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3545f1a-4cd0-414a-4b12-08d71ffb9f7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0131;
x-ms-traffictypediagnostic: HK0P153MB0131:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <HK0P153MB0131AEEC85940657F3B8F82592D20@HK0P153MB0131.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(13464003)(43544003)(189003)(199004)(5660300002)(8990500004)(11346002)(66946007)(76116006)(52536014)(2906002)(66066001)(229853002)(66476007)(66556008)(64756008)(66446008)(25786009)(4326008)(2501003)(53936002)(99286004)(54906003)(110136005)(14444005)(256004)(316002)(22452003)(486006)(6246003)(476003)(6436002)(71190400001)(71200400001)(86362001)(6306002)(33656002)(446003)(7696005)(478600001)(8936002)(81166006)(81156014)(10290500003)(10090500001)(76176011)(8676002)(3846002)(6116002)(53546011)(966005)(6506007)(14454004)(102836004)(305945005)(186003)(9686003)(26005)(74316002)(55016002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0131;H:HK0P153MB0290.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YnJcrSEYIEbGjU091N2eoKeHHdKq9uKjUC2bKY+dP4D0Sy0f/CGhX/+V6ycSh1W511mtwMmDwCoNiI6kSUYGZP3lmFqG+ElBx/98w7Zku1FZYJjeDSdxBNbqPCgS/2avjtNacJOH7lFQVgpE+H7+pvjYkuExDJlj/C41XxLEe6mquteZN8cQevXQNdyXUi7tXpQmiu05dm1EvYd6/P/Sl5Z8yszABifJFOaqoKiBREfd2dNJI3mc2m4/NqO5C1MBauXir1B0geV1iFp7uHEGj+o6oL2DakLkfDufjpXaxE1FBp014QQfqwW0Z586NftBcISl9KAFNQGPQNWBA4f/xkCtjtLl3cLA2pkGlbeMyeOXZrrbMMLqwHq0IocsmJCOx54StNeaxTEb5IQvPj7+Cde4Hp56VAN43rdtFENP0hw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3545f1a-4cd0-414a-4b12-08d71ffb9f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 14:36:26.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5mVg1sFBGUdxEhS+ol9Ts6pZml6mswsw0Sdtq6J+pmilgQf73O5aMLncu2IJwsgEHssKjdN75S+ZVjucsKSZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0131
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Denis:
	 Thanks for notice. I has posted a fix patch before. https://lkml.org/lkml=
/2019/8/13/73

Hi Sashe:
	Could you take care the fix patch? Thanks.

-----Original Message-----
From: Denis Efremov <efremov@linux.com>=20
Sent: Tuesday, August 13, 2019 2:04 PM
To: linux-kernel@vger.kernel.org
Cc: Denis Efremov <efremov@linux.com>; joe@perches.com; Tianyu Lan <Tianyu.=
Lan@microsoft.com>; Sasha Levin <sashal@kernel.org>; linux-hyperv@vger.kern=
el.org
Subject: [PATCH] MAINTAINERS: Hyper-V: Fix typo in a filepath

Fix typo in hyperv-iommu.c filepath.

Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org
Fixes: 29217a474683 ("iommu/hyper-v: Add Hyper-V stub IOMMU driver")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2764e0872ebd..51ab502485ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7452,7 +7452,7 @@ F:	drivers/net/hyperv/
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
 F:	drivers/video/fbdev/hyperv_fb.c
-F:	drivers/iommu/hyperv_iommu.c
+F:	drivers/iommu/hyperv-iommu.c
 F:	net/vmw_vsock/hyperv_transport.c
 F:	include/clocksource/hyperv_timer.h
 F:	include/linux/hyperv.h
--=20
2.21.0

