Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B347CAF2
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfGaRwK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 Jul 2019 13:52:10 -0400
Received: from mail-eopbgr710125.outbound.protection.outlook.com ([40.107.71.125]:44032
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729665AbfGaRwJ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 Jul 2019 13:52:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6GEH31b34td9oqM0jYsTbW44uqQtvd1pDDDDebWBG4/y7JH99MAl6YVLszM7otBWg6TUz/J+fO3cpMw80g+RGbpfW81GyyUZLLuOBUgxa6qgtbam548mZa7xtzdRWNuhg2iVxGMiy6eOtOT+6N5GvUyMmLFwG3ZKw4SVVSeOy81V2crwpVyuLotf+KzWsZnzkvR7OLhywuK84j8u9u7sNcL9Mgs7xjFrCguhkMcV7+uNNTK6rmhQxQSzBgcb9yoR8Vgo3dwe9X/1gBdJQPvJtC1RHkr5O4tsdhyXwOa5K5JSY/BMgjyrhsHobqvirvhFqbIR97j6t9A1G6PagG6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGEer2HOmgaTuT6Y+Jz6y2IrOfS1v/lOZqssTzCss4o=;
 b=ZmVnco4E+w97OodaTcivOWgZz5k5Uwuc9CdvTbaP3dFEDzCp0oAaUBzEgw0/qhqMbsdXPjVVEZdepWqz912GWfEbj2nO51YgPccS4XxBKuub63aznQlZAPaBKfNKLW4yIkRLMjFImCUEZHg7QqK4lnYoK6p4+IyThEfGVrCTk25UP89vImMXiY6ui/XvhmuPyEYVXeWTuP8U4s+pKZr1sgKvDgnJNUqEVmDjvlsZ1/m2hMTcHfLJuGbE0SdqYS3r788oGmgDdqkUU3/G1O+cukJqb6qCsZKtOmrPi5FRXcARxcJ1Ldq5A8qM+GzgrbBNrnk9zun1TcyBObI610TQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGEer2HOmgaTuT6Y+Jz6y2IrOfS1v/lOZqssTzCss4o=;
 b=BVaoJYt9fdku46GvDxL5bDSmyghdy29YpZXT2S5a4nS5KLVY/6wSUCYLCijnJFWzCsWePh2oTpUA2Da8CmB0oGiRWxYOD1+GAYV9MICwERsTrigi1SHJMr9JyLux3gKMmNNrJCXHtFBhV59JnicykucwsX8ZtUsXfXqE3un6hHI=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 17:52:05 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9%7]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 17:52:05 +0000
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
Subject: [PATCH v2 4/7] Drivers: hv: vmbus: Suspend/resume the synic for
 hibernation
Thread-Topic: [PATCH v2 4/7] Drivers: hv: vmbus: Suspend/resume the synic for
 hibernation
Thread-Index: AQHVR8ip5oBUYAEUwEyFxtnTysl6IQ==
Date:   Wed, 31 Jul 2019 17:52:04 +0000
Message-ID: <1564595464-56520-5-git-send-email-decui@microsoft.com>
References: <1564595464-56520-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1564595464-56520-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1301CA0011.namprd13.prod.outlook.com
 (2603:10b6:301:29::24) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fba9d974-961c-45b4-8674-08d715dfcc4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1120;
x-ms-traffictypediagnostic: SN6PR2101MB1120:|SN6PR2101MB1120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1120990E2490DAD3D5AB067BBFDF0@SN6PR2101MB1120.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(68736007)(10090500001)(36756003)(76176011)(53936002)(6512007)(54906003)(3846002)(305945005)(52116002)(4720700003)(8676002)(3450700001)(14454004)(6436002)(6486002)(99286004)(8936002)(107886003)(25786009)(81156014)(71200400001)(81166006)(71190400001)(6116002)(446003)(66946007)(10290500003)(22452003)(486006)(7736002)(86362001)(11346002)(476003)(1511001)(15650500001)(50226002)(316002)(102836004)(478600001)(66446008)(66556008)(66476007)(64756008)(256004)(4326008)(14444005)(2616005)(186003)(110136005)(66066001)(6506007)(43066004)(26005)(386003)(2501003)(5660300002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1120;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JriEb0H+ttBeLd+D95B3eDDr/2o+nDl2Hct2f8nLd2vRQHYcMiUcSng13dxmWf1Q7mMHqAbi2d/4gBvJO4xhpwl5ti0y1+r/A8IDrBdHFZNRQ7fXUA/VfkKnUtnK/MKla+6bv2n29+P6HDVO183N1rDVzhcPsFHLjOcbkWpsi6uz9UIihXfZAa+hDMh7LmO45L3w+XEbStND/WkG9pnjXEJ2u/ob+UryeWHQSn/OJb/486W42TNIj1uYqMO6ISB0/jIxbpq7qddT++SNA4GjP9KngJw1OcEqz1O1uzfDJSYQfGy7VJd/Jp/4Cnns1S/kaw0mZ3ZxJ/wfzIZwDy0wNJ7jcRxuPsjiyz8V4cLNgDHML7nUXOAYYNLQPunTwq7s/qclQ/c6+xuH0252iyOMJsu4HDoCMXrBHRIBE3mUutU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba9d974-961c-45b4-8674-08d715dfcc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:52:04.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uX9veQLfpLU+1HlOfQsmTjHr8gIBrOhdHuAL6OanAAzDQhgDfzwlIxyV28eGBOgWk8jxReii8wrPfU2/ISS5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1120
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is needed when we resume the old kernel from the "current" kernel.

Note: when hv_synic_suspend() and hv_synic_resume() run, all the
non-boot CPUs have been offlined, and interrupts are disabled on CPU0.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
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

