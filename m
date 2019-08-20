Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF17953D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfHTBwJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:09 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728992AbfHTBwG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZwIgj0Ku5C6qvlpbyVsHhAMFvprb3rLmvnIkz1s/EX2q7hmJqDVcJKDynI/KmtVK51/pYz4NK5imuLchV799D6QwoIzYnffH9gzmgG+MU6TjI+da1nwddxHX7M8yxTwmRuexidy1IA1nyaYM09Iy+d+N/C17PRlWs1AyQo2bnoA4M2jC7G+qkp6QDbl3wYcV8RH9bKlXnpmqi6l6KknE5xukre7GcK1002oIfh5qtRCL9dwK0ITD1nVTZ+QiV532/YWAlCSqx0o/PO1wIHqqR/6xTalfcqS2NyPDS4UcdRmXJ30WYOdrEFTK4hsNIaLBTBLCPgDSRwo+iBiwn0+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9WbU0OQPgQXFUFxw4BePAz1VpZSX9sufx/nLcR4vr8=;
 b=HRRoiXjoBKReRYpqxXOjB4j3v2gVpuuDYqXR0pFjOJ+axXxjrOcO8KmJQlqSmKvpj//g2a9ZFI40wW8W5BsNjBinKjiUAOCuD5k2npsj2wWOF4PnLBk63rARHbSTBFg4uIERKjvFdKq631VyO5hBj3tdbhPCddZhcPwCz4Fz0eaS5Am+1eK+261XPtAOmIo1QV9hjA77ZdQWT+QOIhKHP7C+dh7GQq4klcTaznQtka8upmDnSwW5HLywKKuzUj0Url02/VQiP6fMOW0sVGjpHoDPTT+BHJp5bnn/BlbDGU65ii/Cc3VicXOYnw+SFsNgitC8HUa4fe+YP3uRvOBR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9WbU0OQPgQXFUFxw4BePAz1VpZSX9sufx/nLcR4vr8=;
 b=e8MT7xz1mBj4e0krq0kGMMDGYqnuSJMlGyk9q3fUk/LwxQ8GBoku1NlHi7vSuDChKECWseb6MX5/DkNyOzfaJdbjxIsKI0yK1Zx5pi35mHgtyLvUaNDcXph3qX09EbBuC1Vo/YUI1BJRXPH15lX39geL9gL1qbwNJ4Iq+IUbkws=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:52:03 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:52:03 +0000
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
Subject: [PATCH v3 05/12] Drivers: hv: vmbus: Suspend/resume the synic for
 hibernation
Thread-Topic: [PATCH v3 05/12] Drivers: hv: vmbus: Suspend/resume the synic
 for hibernation
Thread-Index: AQHVVvncM3DK6lbFDE2xfhpLVjn7fw==
Date:   Tue, 20 Aug 2019 01:52:02 +0000
Message-ID: <1566265863-21252-6-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 3b884c1f-cb9c-46ca-f591-08d72510febf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1133523463766A0A33D6B685BFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(15650500001)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vc76Oeh3YNBmKXqimgbz8oZ/O1Q4aZCyLXnc3HoCyp+N1RzbwqWmcnfq7lxVLf5kM4lw06YPwfVmHX3AaUx+OiK3tlI9P9O04qyLV4JdRjK/iBOz2rjqWR9SoEwQ5Rb1QJ9FA0mAvCy5S1lhS1Ai7O+auw278qJ5DBaqUUJfAPfEDJ5GJWAqfEVmsuhY/espkjJMLPP26++XPX59Cr648gGBacJJ6Q9qEkrnNpoybxwdB12RXXkqCJw3AKG4ebSeUBjKbF5LEKXC7HntrI3n+SiLzD0I4+THVq0lPa2t0vcnVrkCHej+ikY2xUA2RF/tPqlLb8MfiBYdIsP0ISj8/5PGUxXZf1a27KK2vIsU0CBF+lv7gI6R9NbMfQBza9cdyrnS7iA8qTINuiZmKWi0XIAp0MDYnriHKFS9Ly46D64=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b884c1f-cb9c-46ca-f591-08d72510febf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:52:02.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCjpne9xpBHgBom468yK349LUP6ltIdDHqVcxHeWSHoe+NxG704Euz7NuA0Vj4D2VIJFKhAGU5EtEfTRkIEljA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
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

