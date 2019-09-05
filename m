Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C361CAAEE6
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbfIEXBW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:01:22 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:14272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389436AbfIEXBV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:01:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uqs1/JDLIWZJBVGjBi007F8N02DU9ZQMnVtgFhMADXEnJpG546UrIwXGNkdOpPXGPHGyoQJr3+qYUKh1RC1usHYyBMkcwTwnEFDo7iaBOFL/Z3EYLO847D4hfzKuW0Q0Fq87WOyXLcuPpxiAXQNSXS3dLxU8rQfq9fEEpT1IErYe+4wtNdLsMoCXbB6QLzFWVfHsLahA692f5ByvPTsxSTlgGEVCiI386wwyUlLw4wIauKSkq8V8jovpfRRNexGgt42/mvwvsk+0dZxcz+SdPXdzuImUtMsHwvuhNxatdibnZbxJ9vvWVZoEtStRjpCymtK5Gie79viwxPTMzFV7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9WbU0OQPgQXFUFxw4BePAz1VpZSX9sufx/nLcR4vr8=;
 b=N/5TXNtjQjaMATmtYTaTWYQhCbBUlmNTi5560BTp+EFXvpRHiGOE0+IT2IU8hxZmRarGOQ6Im+H6vJ6avEZnN95JzZyTce+bjB++QlGpQF1HB2F1AyJtWuW1TQSglGgoc5S2rSC++HdN+4SO2K2v8a2fkrKU2Oh7Y2Re4A4URJ+OWazJt1P9GeIR65P1dVBSY3KBPc0dqvLpS4ykC8o8DH+ARniiCt8BqkJfxlvKRvkEtm9sv2sS8SlC3FM+TiTjhhilud0KM3Bk2JM9IpHu3AvEdL/kPmI/ZD0RQU9VW24bNppYvYXek8sWEABfOmdPrBEwCU07fi3qnbP51/UlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9WbU0OQPgQXFUFxw4BePAz1VpZSX9sufx/nLcR4vr8=;
 b=moKHqv7koqw2oGURBq5BOJw7YtoIDOMn9ZfNprGTdUg9DDYCWU1Ik53d3pX4cHVFmb8rv21ZuVSCd8b/RjgTivy6u3UC+M/XLJbKh4ezlN5osktHiNkWd0JPiB6iDJ2uCNUDWC0FRH5DRz44eGf09kjtQbWmmQiDPGInZzDiX10=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Thu, 5 Sep 2019 23:01:16 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 23:01:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 2/9] Drivers: hv: vmbus: Suspend/resume the synic for
 hibernation
Thread-Topic: [PATCH v5 2/9] Drivers: hv: vmbus: Suspend/resume the synic for
 hibernation
Thread-Index: AQHVZD3SuZYV+tZA5kuOJHGCZXExNA==
Date:   Thu, 5 Sep 2019 23:01:16 +0000
Message-ID: <1567724446-30990-3-git-send-email-decui@microsoft.com>
References: <1567724446-30990-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567724446-30990-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:301:73::25) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 286bc1b2-a924-4c36-8215-08d73254f49d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:|SN6PR2101MB1038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB103880F6476C72B6B0A2FF09BFBB0@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(66446008)(256004)(14444005)(10290500003)(478600001)(476003)(102836004)(186003)(36756003)(52116002)(64756008)(71200400001)(26005)(11346002)(3450700001)(6512007)(71190400001)(305945005)(15650500001)(107886003)(4326008)(446003)(66946007)(316002)(76176011)(7736002)(6436002)(66556008)(386003)(22452003)(66476007)(6486002)(486006)(53936002)(2616005)(25786009)(14454004)(54906003)(110136005)(5660300002)(2501003)(3846002)(2906002)(6116002)(81156014)(8676002)(81166006)(86362001)(50226002)(4720700003)(66066001)(10090500001)(1511001)(99286004)(8936002)(43066004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qp343C5XBOIL1ElE4kucQsYxmuz3E5WMN1YzCXQXyxjK47dfVFy8jLWXGR1tbcExzYdAKeKdloBJFfzUPrfZwj+SLhEOlEzONHG23U+AnkHkY/MrB7huRPKwsiu1rxMntvMj3BTCCoazk3uYvcW8wbCLw431Mj7ctFdlZ6Ia9IJXBGXfMpVr29XtfVBDRIqwwjsvwt/ItplF4m0M3l0BkzIQQ+JxT4kmKjG+Z+j/L2BqYlHs6hN2EVNmWM+S4g8bTqpkMNbQBc3R7OsfQn7QDRqV7UuGnvjRzyNbt6Sk4NOr7VybReRFxRsfJDu1bMS01BZP8IhgQamquUdzh/5+CmYMBEmRTni2EDnHi0KoxCiN2cXxrN2SDUqCmlkt5XY3QfbvAnlVIY+l4xZlkRDojOeeNVKpZjAt3emkyvsNSvk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286bc1b2-a924-4c36-8215-08d73254f49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:01:16.0578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otqdXQHIzUMbGGAq4xlFkasofuiQ3+UJhG4BpV4CPW9QFDBpIwhaBE9nM3GhRSjfdgN7EHtxKiqlk4sZMbsu3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is needed when we resume the old kernel from the "current" kernel.

Note: when hv_synic_suspend() and hv_synic_resume() run, all the
non-boot CPUs have been offlined, and interrupts are disabled on CPU0.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index ebd35fc..2ef375c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -30,6 +30,7 @@
 #include <linux/kdebug.h>
 #include <linux/efi.h>
 #include <linux/random.h>
+#include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 #include "hyperv_vmbus.h"
=20
@@ -2086,6 +2087,47 @@ static void hv_crash_handler(struct pt_regs *regs)
 	hyperv_cleanup();
 };
=20
+static int hv_synic_suspend(void)
+{
+	/*
+	 * When we reach here, all the non-boot CPUs have been offlined, and
+	 * the stimers on them have been unbound in hv_synic_cleanup() ->
+	 * hv_stimer_cleanup() -> clockevents_unbind_device().
+	 *
+	 * hv_synic_suspend() only runs on CPU0 with interrupts disabled. Here
+	 * we do not unbind the stimer on CPU0 because: 1) it's unnecessary
+	 * because the interrupts remain disabled between syscore_suspend()
+	 * and syscore_resume(): see create_image() and resume_target_kernel();
+	 * 2) the stimer on CPU0 is automatically disabled later by
+	 * syscore_suspend() -> timekeeping_suspend() -> tick_suspend() -> ...
+	 * -> clockevents_shutdown() -> ... -> hv_ce_shutdown(); 3) a warning
+	 * would be triggered if we call clockevents_unbind_device(), which
+	 * may sleep, in an interrupts-disabled context. So, we intentionally
+	 * don't call hv_stimer_cleanup(0) here.
+	 */
+
+	hv_synic_disable_regs(0);
+
+	return 0;
+}
+
+static void hv_synic_resume(void)
+{
+	hv_synic_enable_regs(0);
+
+	/*
+	 * Note: we don't need to call hv_stimer_init(0), because the timer
+	 * on CPU0 is not unbound in hv_synic_suspend(), and the timer is
+	 * automatically re-enabled in timekeeping_resume().
+	 */
+}
+
+/* The callbacks run only on CPU0, with irqs_disabled. */
+static struct syscore_ops hv_synic_syscore_ops =3D {
+	.suspend =3D hv_synic_suspend,
+	.resume =3D hv_synic_resume,
+};
+
 static int __init hv_acpi_init(void)
 {
 	int ret, t;
@@ -2116,6 +2158,8 @@ static int __init hv_acpi_init(void)
 	hv_setup_kexec_handler(hv_kexec_handler);
 	hv_setup_crash_handler(hv_crash_handler);
=20
+	register_syscore_ops(&hv_synic_syscore_ops);
+
 	return 0;
=20
 cleanup:
@@ -2128,6 +2172,8 @@ static void __exit vmbus_exit(void)
 {
 	int cpu;
=20
+	unregister_syscore_ops(&hv_synic_syscore_ops);
+
 	hv_remove_kexec_handler();
 	hv_remove_crash_handler();
 	vmbus_connection.conn_state =3D DISCONNECTED;
--=20
1.8.3.1

