Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31EF2953D9
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfHTBwE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:04 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728940AbfHTBwE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQq3WG4wQ2hujyya/ynehEEtddqfqUSj88bsdruc9/UmA2sPAdeCQVitVA/p7PdeoLhIdoIUh2jzUJacctNjAZwlrmM5EJg/72CgIzt5zbfA5xrIiqRmUEKYQDordd/cOn3+aPXhGoNzPWHshRCkTVK7QOV+xJs3oB0koLW9+MjtxUpzzEbCOKd5+jEJqhMY15S48HuR0P+ABVy4sXfVI8RkE5uOlOTNNBKXOE81AMbIYrXE+TvNpU7/sIE+5hX3/KVnjn6S/1GV6lzlCkkXY7PoV1C9aGZdQTAESZo5AoGmiSAAFSE3s6vJ2LSvsv2IsAg+YNa7NWJ3EsnEi0MrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z+u/v8C8a0GLr0IhEtkFheT/AVc0rnj126BVkAvsCA=;
 b=liLgv+0o4LAhKAD7hRESwk4/2zMU7zLwcszeKpPUq17w7UjZxKv9Ti+trf1vnk9GilH5jFsuTnBnpCfQOkUAW+DNbgSYKd8GEPGDIPhF1ZuE2Z5liBOf+/nS0vQBn1/WoLegVqZHIKIxrU8iv0XqZps05qM5S4U5eXXi+i51vM3OHroSSHeXdozM5/FNasYDds17fbW4MhpFDENrBpp0+wuQ3F5+8BwjLDynW786TdJGitsl+Acfd+2SV1xp/YT+6fJP77fVfzbxb+d1oaDT1V3oNDCaNL7NhSlqnywcDu1Ni3+oAYFEpN/WiFpOUESl7lU+Yg0llX6gQW+w6zEP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z+u/v8C8a0GLr0IhEtkFheT/AVc0rnj126BVkAvsCA=;
 b=foc/TJP6q5ZyVC6KfN9Y2chQUSghictxlaGBs1Z6KfGxuC5wZ4nflPG9JUYaGnX17IwqZG3IVm9IrMBYRIincchL8E9NEDdYZlbb/jjECW2DcoIdM0OzCsu3qJCZbM7am7VYWyM9h34v8z3UKW+12y10pMH/uj1Dr0AHzb511XU=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:52:00 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:52:00 +0000
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
Subject: [PATCH v3 03/12] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Topic: [PATCH v3 03/12] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Index: AQHVVvnbA5pXxZ0zO0y2WjzAdIyqDQ==
Date:   Tue, 20 Aug 2019 01:52:00 +0000
Message-ID: <1566265863-21252-4-git-send-email-decui@microsoft.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0056.namprd21.prod.outlook.com
 (2603:10b6:300:db::18) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58dee291-6f95-41dc-bbbc-08d72510fd9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB113322D0C52C7CDD60880B4EBFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(15650500001)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OZKz1R3H1mzCr9Df5DxmJiPPBVluY6W7t7j0NuJjWoLPxYqSLugWkOsDUWUbbDDdKgc0SikoF3Xq25J62/BcOe3vWmqEjSiPuVtUGDSt1ftLA6txQ894pcs9A1mP11Bvd7iF860XYENsDDL9joPKevT2x13e4Hq7XRMTLmvRqfRjnl74oEECOznaUcTv/gThBgj1Zj/ecAjqSKNYX4bi+MuAqtl4t6Id2wgmrROJovMqSJ2sXmWUHz0vfvn5j8+QPEYN0Y4Wm/7vpiFr+nO+mQRI+2mD4yZHl54Be1YuobUS9Y2wfNKFAjskMxvEzD4bLmeV+pOrnAeD/7243W0ArmlRKl0wyqor+lKmR025q2IxC67yV5HcUGuN999s6amS1UcwWcgTlfv76s8KnJLs8ooiCEUSNdWuHntX4pL26ZA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dee291-6f95-41dc-bbbc-08d72510fd9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:52:00.3298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1z5G/NJjKCIkQJXfzki1j4fsC2SafAy4NUl0lq4r78wyu6IjkWe5UwpTJrGwCGmjjo5aX8llgDe5xrR7zzk5xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's TSC page and then resume the old kernel's=
.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyper=
v_timer.c
index 17b96f9..8f3422c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -238,12 +238,37 @@ static u64 read_hv_clock_tsc(struct clocksource *arg)
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

