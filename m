Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B35C62FFD
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jul 2019 07:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfGIFaH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Jul 2019 01:30:07 -0400
Received: from mail-eopbgr810121.outbound.protection.outlook.com ([40.107.81.121]:9192
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfGIFaH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Jul 2019 01:30:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP+nmO8KqkPlsSpvkk43BB5yRfojDS+mFjy7fHskR/IrWqbknkA3ZMb2skW02FFgnhRXrhUB3Iw+dwl/JUkazRmAMXVMGwpkTqbbhiR/06WMQIgXkYrAtmkSvpb1CtKfMCofaq/Kb9YFuH3AU84AvakPij//TQ1qIVwKtkekXETZzue7g7REUJMQb4igmqvdhyRCwlky2b49cdS4AIN/fMQ+hWSKLjyg8qhQugQFlDCjWR6amCLkTfWGgP3L7nevKbBic+ImFJmT5CCZ6ZnpJ86eenw0Jn1vjQgEx3FoJMnZlD+HbdEai0KEP/WzY/+r5om3rgoYu35qCd2TQBoWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr17+lWf5H0N5B0x29WS7E9Zm1LionacF9LpQib/R7M=;
 b=i7hAe3cQXFkTbuSeqWsav1a29UwJowAesBDhbOCtp5xtJHI47FhKUH0FyhideAq4U+hfieop7rEHN1Vwi8KL9sE7wAvfbhlVpMvccAv9kvgP38fVIs0HJg/0ZwDwJ8t1+OXe4/tSMZVj/h+9EuiG1brq7Sv5wRtz+V+6pPpGy6aAB1DD/whU7PkgJ2Z0S2mRACABGdjAH9Tt8fFqwOkToXyeyBJ2wsv9nLISJrw5NoboX79gyDRtGZ2p/nsEjOR0UpkyPVvsGtvTEFUgT62EpdFZ4wnmrpgc0KhgM0xvFhdngbq+V6k0+Wq9vZnvzTfgYavtAwJQX6Fh4ScdQTdXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr17+lWf5H0N5B0x29WS7E9Zm1LionacF9LpQib/R7M=;
 b=GZSV/OsPhu8pCuDdr57TJVARaT72C0y9xW2eTcIkNw9h3KJXrFykqFO1giIDyfK9pE1HieScke+RtsaSr/s57WEwxxRZ5+NoZXGO8dYrOfDwT9JLBVIqYT2AgIo4RIOBH5IBwPD3jZ2JKuNR4OhWRegoXLKg3pIdg4mdkMvx5aU=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1040.namprd21.prod.outlook.com (52.132.115.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.3; Tue, 9 Jul 2019 05:29:28 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab%3]) with mapi id 15.20.2094.001; Tue, 9 Jul 2019
 05:29:28 +0000
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
Subject: [PATCH 4/7] Drivers: hv: vmbus: Suspend/resume the synic for
 hibernation
Thread-Topic: [PATCH 4/7] Drivers: hv: vmbus: Suspend/resume the synic for
 hibernation
Thread-Index: AQHVNhdHAZrxEDUncEGWO0fIfq/1aw==
Date:   Tue, 9 Jul 2019 05:29:28 +0000
Message-ID: <1562650084-99874-5-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: edcab254-e035-400f-3baa-08d7042e69b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1040;
x-ms-traffictypediagnostic: SN6PR2101MB1040:|SN6PR2101MB1040:
x-microsoft-antispam-prvs: <SN6PR2101MB104089DD92F78DB52697863CBFF10@SN6PR2101MB1040.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(6436002)(10290500003)(43066004)(2906002)(2501003)(4720700003)(316002)(54906003)(110136005)(6486002)(22452003)(64756008)(1511001)(66556008)(256004)(66446008)(66476007)(478600001)(73956011)(14444005)(476003)(66946007)(52116002)(66066001)(305945005)(8676002)(81156014)(81166006)(5660300002)(76176011)(486006)(4326008)(36756003)(6116002)(3846002)(71190400001)(71200400001)(25786009)(99286004)(8936002)(50226002)(446003)(107886003)(10090500001)(2616005)(6512007)(14454004)(26005)(11346002)(53936002)(68736007)(186003)(3450700001)(7736002)(386003)(6506007)(15650500001)(102836004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1040;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aiMBmToB3VvGkh/Pz3RN8tgqtcsxcwJ6JjktqHl7XcHHQnuZ/hJekkwp4KlLoSCrumIKOWp9Odj9+3GshIEMJaDEmrR/MiWnIx8d3hF7ha84uVIHZFzJQXG3oaXcUdaKnDbre48HzjfsPtPgZxRqDWq/tmYbDzZSGcvCyIm4umJMoAP4hLart/QHYSJBJPuGzrtYECqC6v1DyJIyRwCqg9BPwwDxMCC1ewmYdZqCuhE7yHh5Ld+Byn/+INx515D1QrmLiQG7/eUH6uxpQwelJi5pTuatH88p3rFDzcEvLCb48levHWJoaQmLBY4JkQYfwMjfdjBl7HFYb6GEfU7g4Jnsx0xW7fIHz0pIVSUTbFgjfaPTSWbnG3dY7Un+Nr4N3vhcra93zLTCsSjU+K6etIg6SW1yVVOBq3plY9D+ANI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcab254-e035-400f-3baa-08d7042e69b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 05:29:28.6726
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

This is needed when we resume the old kernel from the "current" kernel.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 72d5a7c..1c2d935 100644
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
@@ -2088,6 +2089,41 @@ static void hv_crash_handler(struct pt_regs *regs)
 	hyperv_cleanup();
 };
=20
+static int hv_synic_suspend(void)
+{
+	/*
+	 * Here we only need to care about CPU0: when the other CPUs are
+	 * offlined, hv_synic_cleanup() has been called for them, and the
+	 * timers on them have been automatically disabled and deleted in
+	 * tick_cleanup_dead_cpu().
+	 */
+	hv_stimer_cleanup(0);
+
+	hv_synic_disable_regs(0);
+
+	return 0;
+}
+
+static void hv_synic_resume(void)
+{
+	/*
+	 * Here we only need to care about CPU0: when the other CPUs are
+	 * onlined, hv_synic_init() has been called, and the timers are
+	 * added there.
+	 *
+	 * Note: we don't need to call hv_stimer_init() for stimer0, because
+	 * it is not deleted before hibernation and it's resumed in
+	 * timekeeping_resume().
+	 */
+	hv_synic_enable_regs(0);
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
@@ -2118,6 +2154,8 @@ static int __init hv_acpi_init(void)
 	hv_setup_kexec_handler(hv_kexec_handler);
 	hv_setup_crash_handler(hv_crash_handler);
=20
+	register_syscore_ops(&hv_synic_syscore_ops);
+
 	return 0;
=20
 cleanup:
@@ -2130,6 +2168,8 @@ static void __exit vmbus_exit(void)
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

