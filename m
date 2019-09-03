Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7EA5E8E
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfICAX0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:26 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728004AbfICAXZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0fyTjd/aGuU8pL7MdrvQZbVRrfDmXD/X2nwLO8eb3m18ElOJWLzqEooJ2GKzU1ey7u0G1x4o6yRdecR3ksls4FTdNCPO1lV63IqRLJcthSC6m7GOO5d7PBuwugWUPm59bSx0wzn/XCRfNzYcXqwnDdx/ypvylA8amSGHFNhwSV7O1FZDcMRQN7RZfuqW3s2n3Y0aSNf1zO/bGyhceSE8e9lKgdozhrGsIwIHY4hXG40DiXU4s4EiV/NG6vJ15X2riYGYtErX2wLZj3c56w987Rgb7CHl+9vZfYxMFbaquk24SmA2o+TCiO6bT7dMy1cny1yAocrAt7c42XTR6WoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2SopJ+juho072YN2Zrut1KNuEePiwLKCvRKAzclqbo=;
 b=jvHB2YRvsJiMoBsgRmbsNz0knyyYP+72ZlMagf/H4+K8ttVXhnSRY8kgEIHk+xBIddfTZR0Q/fMvuLHoMBPKytM1Fu8IFyMZKHB0uyK6uqmuBX7xm21Qao4NutElA5lmBZR2TQeV6h0TerNkE+Xcg3NxQgcxSCrXMUpHBb5PGmmNODUcIy2KXyYwSluNQKF6P04FHvDJafp+Di/YrWE0YSrHC0l1o8W/hnCunTmqDK2WtqML67XZPhgq6cjXjZVMGRD/cW2QJVXWFU4W5QkjRthhLpgVHhxTn/lnBgwypr2L2Ah+nHOUQMpcsLzLlP3EDb7yAaYlpt4j1VcO/6wbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2SopJ+juho072YN2Zrut1KNuEePiwLKCvRKAzclqbo=;
 b=ka37iW0/0P5RhRxlmo/IC5VtiNZzk0bzrOXbM27smG0mPEAMQHsaYK/fHqzZaY3PFFBwWwi5uwCc7ch5I6HvL/BpwIO+hSHn+RLYJ+TaqjJN8gJZkDhXi3krJoCert4OD2C4nNlhzpZOH2o7s23KI1fo+MUFdDQ86XmNQcPWYtM=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:19 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:19 +0000
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
Subject: [PATCH v4 04/12] Drivers: hv: vmbus: Break out synic enable and
 disable operations
Thread-Topic: [PATCH v4 04/12] Drivers: hv: vmbus: Break out synic enable and
 disable operations
Thread-Index: AQHVYe3JTmxgjwV2mkWEY2ndexVZYA==
Date:   Tue, 3 Sep 2019 00:23:19 +0000
Message-ID: <1567470139-119355-5-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 38dfb511-b5a8-4652-a05c-08d73004ec06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB10549C0A12C80094EBB53D90BFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dEPTMQcvkgxCRS7bOqS1Omj2wMRhBapAfQ9AlO7zJ1WMMIfCNEcey3kKAYbLmeMwP9DRBXgtQdfFcqE6wjcvG7sa5MUFm8knDqosFVUT9MRFUqB8QZOw+9NBOw+IXsR5ch8TXwkGZZFkvtwalD/axlPIJMVc3gm7xq49LBshQvsmFagxQWgM+WFgJY9/pe96i61q6WIXlbDvmqqAk6OJW1/m/7X9hMqJdKN/8sFhyvMX2Q4qhCfuxZPZhGo2ZLZL/vgVx35kStr6HVCo2RUfo8BWIxZgdNTCC4F35gBLeR7+euc7KRGqX31k4EYhmKLIOoaIDJl4sNa068mnqh2qqUDmNKXr6PcXVcfXd8LZknqjMxAykjhlbw17ykPpyYinNZPHQKgbC1fSjkiYDrPPj6bY4B2wV7+ycGmbGWoro78=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dfb511-b5a8-4652-a05c-08d73004ec06
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:19.5853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1pNAhRcBJVHooXAADOoW42ddWL9ZkBC40/xfvL0jM3EFK6g8BP5mtS+w16qjKszpOKwhwqZ30kGkbcBuJA+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Break out synic enable and disable operations into separate
hv_synic_disable_regs() and hv_synic_enable_regs() functions for use by a
later patch to support hibernation.

There is no functional change except the unnecessary check
"if (sctrl.enable !=3D 1) return -EFAULT;" which is removed, because when
we're in hv_synic_cleanup(), we're absolutely sure sctrl.enable must be 1.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
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
index fb16a62..9f7fb6d 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -169,8 +169,10 @@ extern int hv_post_message(union hv_connection_id conn=
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

