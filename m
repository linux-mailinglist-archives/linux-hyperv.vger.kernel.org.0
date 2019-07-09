Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A662FFF
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jul 2019 07:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfGIFb1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Jul 2019 01:31:27 -0400
Received: from mail-eopbgr820117.outbound.protection.outlook.com ([40.107.82.117]:5824
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727311AbfGIFb1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Jul 2019 01:31:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ryjatj8aDdBGA7uEDawYUpHg5t1u9oeEB49loFPFnJQ736Q9UYAplz2GR5T8CeKTthT3MdyG0Tgkw/mhrxpKJ9MVcgdJu7mU6aEo8SSfhlmaD0UvB6uPGDzDMt14/5yGDjiGRhytzrcDpjCIMn2eNRjA6t/nYyDjM4n8K5RmiWLvLUvyGPKXQm0R9P8sDU+3WjhTllW2crnNoqX3m9Xz3zSuSoxs/Wm8pG9CadRFjkHKcE4c8HCmiReg4+uDQBrXybCTtdWs3yoPLPHPyN2bJqReITEz5p/vtrayXIDYIRxBweXl7H6AVURoeY9rzEL/JkVRSuo3nFd0yR9XSYsNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+O3P1q1GNQyUZ6Moom7ipu8lndqLQcgedwqXhVXSdE=;
 b=fQY7/5C2w/O7rCaZ5rQJTGPP2SUStEzXEkKqbREKOfQIqgs5zW3gH+EZNURPWygUCWdk7GCTpORRBmX48B7NmTsyUQNS7t5hFEs/1RrmP5xMJhx/JL7YZDVE86DfkB2AZTHFaUar8Zl8r/zAQEN893mtm7CeCp+BOH2XCVcbTA7wSzgh1po/MzftqIUJDaDmhRuoWrjKV6r+XmgvlGBwgcWRjN3GXFvfKFQVn14c6p8GByAt8KldTJKQdObO3FBsaCSg3exv3W8qSzkrwYZxvyAr2hvAVw0jQjknjeFvGHtYshf7ALro1Tcx6D2Wpj5u7KmxDB5R14F9Ns++ZP1rkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+O3P1q1GNQyUZ6Moom7ipu8lndqLQcgedwqXhVXSdE=;
 b=j22ahYrE3gTHoaJSLflg4eshxd/0wCv4Ndq0BIMXYNX7MQdjIo7I82cJdATKPsalyGrm18GQkEdSnO9CL/RNNB/6oQUGEVHJKKX4BeOL4FDtHPREwEUncXtUAxeL0EBedMPqdnlWj0Wkm3lFPFWDVhNFSLwMMtx5bKRXCJnmIHs=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1040.namprd21.prod.outlook.com (52.132.115.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.3; Tue, 9 Jul 2019 05:29:27 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab%3]) with mapi id 15.20.2094.001; Tue, 9 Jul 2019
 05:29:27 +0000
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
Subject: [PATCH 3/7] Drivers: hv: vmbus: Split hv_synic_init/cleanup into regs
 and timer settings
Thread-Topic: [PATCH 3/7] Drivers: hv: vmbus: Split hv_synic_init/cleanup into
 regs and timer settings
Thread-Index: AQHVNhdG/NzuAifub0WMnyiBKyXMnw==
Date:   Tue, 9 Jul 2019 05:29:27 +0000
Message-ID: <1562650084-99874-4-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 8fb37e67-7826-421f-fe40-08d7042e6909
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1040;
x-ms-traffictypediagnostic: SN6PR2101MB1040:|SN6PR2101MB1040:
x-microsoft-antispam-prvs: <SN6PR2101MB1040F6B0C6026C7F32D4C70EBFF10@SN6PR2101MB1040.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(6436002)(10290500003)(43066004)(2906002)(2501003)(4720700003)(316002)(54906003)(110136005)(6486002)(22452003)(64756008)(1511001)(66556008)(256004)(66446008)(66476007)(478600001)(73956011)(476003)(66946007)(52116002)(66066001)(305945005)(8676002)(81156014)(81166006)(5660300002)(76176011)(486006)(4326008)(36756003)(6116002)(3846002)(71190400001)(71200400001)(25786009)(99286004)(8936002)(50226002)(446003)(107886003)(10090500001)(2616005)(6512007)(14454004)(26005)(11346002)(53936002)(68736007)(186003)(3450700001)(7736002)(386003)(6506007)(102836004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1040;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BoOypzu70Bod4E4DWcMDqDhHxu/o6RQg9X+7LWUpO22U+00DHHjIoYy+CaYPW4UumSm7FSALA6XKply44qyzVqnOpRQht7XGpOtt9Du3/xA9TP1IHv/qD+FBUkZBpICndN8Eb3mvdAAiwUWPe86XMbgnJGO9as/e4Qb17gYe5j0nWw4+IT0G1Ms/UEyMoPRht93mQYbuXNB6Mn4L5M6M5olPi2gs6zRjdzuCImhY+MeFId6950uWoYJqmDVNIow5xw2jgQA5KxOds8pKTt6vZLwj+7RhTpgwO56Z2QxigNtwvrb6HEictELlmZhwFcf+SX+uN3s9T+CG9r1qFYzPx39ggTzgso0kKQZDo0f9FCwbIHXy4+QaVo8TKFTNf7bquCvPCDN6a5bLBwJkh/fBPLyX17mUidjrx8rjc0oNkcQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb37e67-7826-421f-fe40-08d7042e6909
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 05:29:27.6711
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

There is only one functional change: the unnecessary check
"if (sctrl.enable !=3D 1) return -EFAULT;" is removed, because when we're i=
n
hv_synic_cleanup(), we're absolutely sure sctrl.enable must be 1.

The new functions hv_synic_disable/enable_regs() will be used by a later pa=
tch
to support hibernation.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hv.c           | 66 ++++++++++++++++++++++++++-----------------=
----
 drivers/hv/hyperv_vmbus.h |  2 ++
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 6188fb7..fcc5279 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -154,7 +154,7 @@ void hv_synic_free(void)
  * retrieve the initialized message and event pages.  Otherwise, we create=
 and
  * initialize the message and event pages.
  */
-int hv_synic_init(unsigned int cpu)
+void hv_synic_enable_regs(unsigned int cpu)
 {
 	struct hv_per_cpu_context *hv_cpu
 		=3D per_cpu_ptr(hv_context.cpu_context, cpu);
@@ -196,6 +196,11 @@ int hv_synic_init(unsigned int cpu)
 	sctrl.enable =3D 1;
=20
 	hv_set_synic_state(sctrl.as_uint64);
+}
+
+int hv_synic_init(unsigned int cpu)
+{
+	hv_synic_enable_regs(cpu);
=20
 	hv_stimer_init(cpu);
=20
@@ -205,20 +210,45 @@ int hv_synic_init(unsigned int cpu)
 /*
  * hv_synic_cleanup - Cleanup routine for hv_synic_init().
  */
-int hv_synic_cleanup(unsigned int cpu)
+void hv_synic_disable_regs(unsigned int cpu)
 {
 	union hv_synic_sint shared_sint;
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
 	union hv_synic_scontrol sctrl;
+
+	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+
+	shared_sint.masked =3D 1;
+
+	/* Need to correctly cleanup in the case of SMP!!! */
+	/* Disable the interrupt */
+	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+
+	hv_get_simp(simp.as_uint64);
+	simp.simp_enabled =3D 0;
+	simp.base_simp_gpa =3D 0;
+
+	hv_set_simp(simp.as_uint64);
+
+	hv_get_siefp(siefp.as_uint64);
+	siefp.siefp_enabled =3D 0;
+	siefp.base_siefp_gpa =3D 0;
+
+	hv_set_siefp(siefp.as_uint64);
+
+	/* Disable the global synic bit */
+	hv_get_synic_state(sctrl.as_uint64);
+	sctrl.enable =3D 0;
+	hv_set_synic_state(sctrl.as_uint64);
+}
+
+int hv_synic_cleanup(unsigned int cpu)
+{
 	struct vmbus_channel *channel, *sc;
 	bool channel_found =3D false;
 	unsigned long flags;
=20
-	hv_get_synic_state(sctrl.as_uint64);
-	if (sctrl.enable !=3D 1)
-		return -EFAULT;
-
 	/*
 	 * Search for channels which are bound to the CPU we're about to
 	 * cleanup. In case we find one and vmbus is still connected we need to
@@ -249,29 +279,7 @@ int hv_synic_cleanup(unsigned int cpu)
=20
 	hv_stimer_cleanup(cpu);
=20
-	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
-
-	shared_sint.masked =3D 1;
-
-	/* Need to correctly cleanup in the case of SMP!!! */
-	/* Disable the interrupt */
-	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
-
-	hv_get_simp(simp.as_uint64);
-	simp.simp_enabled =3D 0;
-	simp.base_simp_gpa =3D 0;
-
-	hv_set_simp(simp.as_uint64);
-
-	hv_get_siefp(siefp.as_uint64);
-	siefp.siefp_enabled =3D 0;
-	siefp.base_siefp_gpa =3D 0;
-
-	hv_set_siefp(siefp.as_uint64);
-
-	/* Disable the global synic bit */
-	sctrl.enable =3D 0;
-	hv_set_synic_state(sctrl.as_uint64);
+	hv_synic_disable_regs(cpu);
=20
 	return 0;
 }
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 362e70e..26ea161 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -171,8 +171,10 @@ extern int hv_post_message(union hv_connection_id conn=
ection_id,
=20
 extern void hv_synic_free(void);
=20
+extern void hv_synic_enable_regs(unsigned int cpu);
 extern int hv_synic_init(unsigned int cpu);
=20
+extern void hv_synic_disable_regs(unsigned int cpu);
 extern int hv_synic_cleanup(unsigned int cpu);
=20
 /* Interface */
--=20
1.8.3.1

