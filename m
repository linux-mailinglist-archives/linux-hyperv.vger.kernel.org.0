Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D16A5E8C
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfICAXt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:49 -0400
Received: from mail-eopbgr810129.outbound.protection.outlook.com ([40.107.81.129]:6162
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728212AbfICAXs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+k4DevnZNzGt2/SQsZfFyVTF0e6cLF4SrfD2GNGzujLEedAXJdMfme8AcRe0MsbvUE/dM1lEa3c5/Mj7KIcPX+lypD8dBXrJoWH4xDPpUdJlR7UnUap9079XIe01aufm/fckvxnqskNosJ+qmjqRXWlW13gUwZEfJyukecba9+k6RuioiuIeq245692k++jBMLkZNWMQ9MgOsaaF3eKYOZthWM1EnNPrfynhC96mIlobbiAkGRQDYw3Z8dEusAjpnuLcx/eYgxHt+t7wdIWHf3lB1Zn5F2eL1ePMLVzI+cJcDsmuxHd5j+OgSnXfonDfNQjxEFoW5K6ydXdx+sVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9WbU0OQPgQXFUFxw4BePAz1VpZSX9sufx/nLcR4vr8=;
 b=EhyFB+rjNuK3VCBjnCNX84SaK8LDLei0+QRPntOzgQ13tBzzaQj3b9rSfhafKkLwsw4sCuOa9T7GNidogkddYtVXNxdBwlG3Jwbhai54l2qZWViaqgld5tcVOpk9eU2hwAMZZcHNPSPFD0HijQdq2N8U/YDDh7aaZwnMHAuRMdD5JC7LVEQVrlCPKaQ45on+L5G7bwcvbfNUpVfS1RnL8JRXvIuez4QB69XZ4TGCldlYtQ4GY6NfCSwZfwgK3mJKs2E27h86zfm9gdSn+UU/XzPoFxtXV+QOO8e0vb2Vjt7bVWpn6AoXPaXJAU3LZhuGdTzisNA7i/xZReBeFKeTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9WbU0OQPgQXFUFxw4BePAz1VpZSX9sufx/nLcR4vr8=;
 b=ksVgY0eglONz83YKCQu3+LLrLckTKtkCc8sukSB0nZIlaeBRyG93nj07C18q/HAzCFpVDQ9qupGcM7VH+zhrnuG1Ln/7Y/UfzWsXCoMo52C7CyAFoK1owzwSiWDwbdV131o3piqhOQyvij5NQKExpiaH5y2Uvb3B4OcZMhMZvzk=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:20 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:20 +0000
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
Subject: [PATCH v4 05/12] Drivers: hv: vmbus: Suspend/resume the synic for
 hibernation
Thread-Topic: [PATCH v4 05/12] Drivers: hv: vmbus: Suspend/resume the synic
 for hibernation
Thread-Index: AQHVYe3KlFWZ7KIAhEeWO6gWPjlvgg==
Date:   Tue, 3 Sep 2019 00:23:20 +0000
Message-ID: <1567470139-119355-6-git-send-email-decui@microsoft.com>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567470139-119355-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:301:1::15) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48dec67f-4663-4f3f-d7c8-08d73004ec8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1054715E50739D318A30C394BFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(15650500001)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dhYDaSsoRP1nNxJL4wSnAOCvXgQYIThxcAWgNFo+hk/jJWWTUpK+uErUDQLd9mmH0vRCDf75LfjW80gm545paiBH5uKFvfllGIOR8JLQtq+OSQvU8o7zPubp4aanqLk9Rh5niY1hDujfeaxewDkiYpW5lXU3Kt/8Nnsj0BZDkCDrA4nm9uES2W7pwpExHXjmSKetUlS3gyyyrgum0tL3CaCJBlR7aWWu/MfcFdVEhvwcJFG6p536wNCyaC+tdu+57RqOVoOVUak46gte0yV2pSqPlPIelcNm8r6oOEgNATM/0JYWm3qluZcNAyYT3imy8oiJmO7VsBTovXhbc7OnzGoIMolUk16sz/w4bfA6NauViwyYfzDmNEZOwNqxr5RRzJ7uLxtE8E8b11LX46WUkpVUYfIwESAMrxkex1zDwAk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dec67f-4663-4f3f-d7c8-08d73004ec8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:20.4508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBT74aujRT9QKbaHCIoms4nyrO70ILEQSRhsWSskcRsM9Nfdn5Dv5PfpKBnc/qK4S1cvNXJQVH7sXXJ2kbuFug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
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

