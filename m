Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5653E62FF2
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jul 2019 07:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfGIF3f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Jul 2019 01:29:35 -0400
Received: from mail-eopbgr820117.outbound.protection.outlook.com ([40.107.82.117]:5824
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfGIF3e (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Jul 2019 01:29:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9W/w9+ppnQsOoBbSUcOMynr/YcLaufdTiykDPyjeqLEPFG8G2b6sr6IyOZJ2P4xL856UpeaSrdXDS2fvDx4GTsHPX4Rcf7ENNp4fxs2pKNXfA0HEsSUUDYfkxZpTx4FJGscnQ5V9ZtKPwOvvpaRyd6a1oKrxcxiHpsLR0fh8I3XCSTJYV/TpAKySRZRQ4J/dUc5MC7TSULJOHx57J+ya+KRpV6fjB0CfswmUkdyrT8a2mRPRr1VjfiIKQ8o78t5V94xCONaKg8SBqDkgCZOam5LdXIUgEf5/2TqdQxA3BNvnLsjNLR1aFc3CFaQtJbnEk/682Yb3w4YBaW1nAUFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfGMCdiGHcLljipkTqhs/LomNvYqJHyFZYW1JVurKz0=;
 b=fkxew46iTKSAIxElVoxDVnQOzPGKP8XEsUxDbNLI3gv/0ocWK1TD/zbubb8mPq+hFp2zj4ZdrlUevbxRUVZVNnFgWxrYAvpmGJCVhG/HhbagkA5MS3vzYLI0r9ILGwmvqXrNgDehRvnKEj5acg9xkqK7SMiwQZv/8V/hJFW+UClaknRoq5m7EyUwYVNmVzDVHQr3jMw0DG7SKtCPcfjXYQrJT0iz12xCzBxj/ayYxRPpJOwfD8X1bmDypOoiUKYpm/KeKYmWvB1T+8GDspD5FZ4tkv15CzbgY6H4qy282qWSxTrVMCIEWg73SfWGgFszFAeMbVmZuZ93gUASbgS0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfGMCdiGHcLljipkTqhs/LomNvYqJHyFZYW1JVurKz0=;
 b=R3Ao0vQyzj5pFWTwoTmw3k2GD8wcp705zkHDP1nMXatiSkz4L28INpp0ANFt2ToOtSTiLCR5XWRyo2usuNgmfmbrySiZsTn1JsD9ALxbsimJtesHYUJoKCb4iEybD/5WPbazg1TNiQ+WZRXPgyOI4H7CCLYoPdLPQAbF0HjLBHA=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1040.namprd21.prod.outlook.com (52.132.115.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.3; Tue, 9 Jul 2019 05:29:26 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab%3]) with mapi id 15.20.2094.001; Tue, 9 Jul 2019
 05:29:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 2/7] clocksource/drivers: Suspend/resume Hyper-V clocksource
 for hibernation
Thread-Topic: [PATCH 2/7] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Index: AQHVNhdGnJjyF98260ebvjc6bcOKoQ==
Date:   Tue, 9 Jul 2019 05:29:26 +0000
Message-ID: <1562650084-99874-3-git-send-email-decui@microsoft.com>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1562650084-99874-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:301:4c::22) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4872ea9f-a34e-41f8-2f87-08d7042e687a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1040;
x-ms-traffictypediagnostic: SN6PR2101MB1040:|SN6PR2101MB1040:
x-microsoft-antispam-prvs: <SN6PR2101MB10404B8121367C0F455F28A1BFF10@SN6PR2101MB1040.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(6436002)(10290500003)(43066004)(2906002)(2501003)(4720700003)(316002)(54906003)(110136005)(6486002)(22452003)(64756008)(1511001)(66556008)(256004)(66446008)(66476007)(478600001)(73956011)(14444005)(476003)(66946007)(52116002)(66066001)(305945005)(8676002)(81156014)(81166006)(5660300002)(76176011)(486006)(4326008)(36756003)(6116002)(3846002)(71190400001)(71200400001)(25786009)(99286004)(8936002)(50226002)(446003)(107886003)(10090500001)(2616005)(6512007)(14454004)(26005)(11346002)(53936002)(68736007)(186003)(3450700001)(7736002)(386003)(6506007)(15650500001)(102836004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1040;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EOKFU1UJe7JVwHZ0UKsvC8N6rcFspXfuHcxDlgg8pzY41P7q9Tq8glva7qbGQlq62MoqHIbU4A7jKhEnBL1fjqZ7ev7AE3jeoJtxUTujvdnMUivTy/esv5KgwTLKhNhfljgVVfVMsERviiQHthrfIi6EapPCGZmONrP8pODD9v8PSz4UI+Z3GbsQI4M/rJ5TbtwZ2wWHVm5hdbRVI+FeCiBcZ+lNw3afdgyGrRGdqz+gJIonlYQ8mNTuYd+7gQnhjrGOkl25UMJe6yfSxyJT67rkq/XayHgaSoSDjlZ0G9rDcQz9IjEfbYOF0kmeIP6wRMYJ0T8ROZ42WHITXXEezMWEeZAJb4FdxKuCEIw+uiMQVo1/UZdQxOrq0KzOD5h9vMFoDuLO4VDi+M8fn0dqosAVo0jmafCGF4DKePLDt6s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4872ea9f-a34e-41f8-2f87-08d7042e687a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 05:29:26.6387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmldc@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1040
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's TSC page and then resume the old kernel's=
.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyper=
v_timer.c
index ba2c79e6..41c31a7 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -237,12 +237,37 @@ static u64 read_hv_clock_tsc(struct clocksource *arg)
 	return read_hv_sched_clock_tsc();
 }
=20
+static void suspend_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 tsc_msr;
+
+	/* Disable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &=3D ~BIT_ULL(0);
+	hv_set_reference_tsc(tsc_msr);
+}
+
+
+static void resume_hv_clock_tsc(struct clocksource *arg)
+{
+	phys_addr_t phys_addr =3D page_to_phys(vmalloc_to_page(tsc_pg));
+	u64 tsc_msr;
+
+	/* Re-enable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &=3D GENMASK_ULL(11, 0);
+	tsc_msr |=3D BIT_ULL(0) | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
+}
+
 static struct clocksource hyperv_cs_tsc =3D {
 	.name	=3D "hyperv_clocksource_tsc_page",
 	.rating	=3D 400,
 	.read	=3D read_hv_clock_tsc,
 	.mask	=3D CLOCKSOURCE_MASK(64),
 	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend=3D suspend_hv_clock_tsc,
+	.resume	=3D resume_hv_clock_tsc,
 };
 #endif
=20
--=20
1.8.3.1

