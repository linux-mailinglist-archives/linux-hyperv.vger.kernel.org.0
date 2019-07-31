Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82D07CAF8
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 19:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfGaRwa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 Jul 2019 13:52:30 -0400
Received: from mail-eopbgr710125.outbound.protection.outlook.com ([40.107.71.125]:44032
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729476AbfGaRwH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 Jul 2019 13:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBMqAoTuj/o2lOgaTnKg7iOskpKZgNL36a/k3r7GYPKLNZ/DPnprX1y3O0lCsJRNcalewg0oN8gal95eynWR6oc1BoJJbqpOV2beRBiQ2K4fBp+mClPPLbeDnIUAkehHi0ZJQI5KNSnZ26qVlUlWbEIggsKkCd3eRO6h4TTjAcLRfnLswXnBlJTCSC/CaEKIFzi/erVltHncP2gmS9+qKarPcHYQLjpM5PRp1kR0HQGe88RPyfzWZpXw/4yZJ+JyTZ8r+fB2U/nG7BIKYYnLI0HjcmOh+1zsX+1M9A5AOr8HpUe1RyFN3rGkVAM3cVlejjXaxL0ge8foQsTcDHzIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxdFs5z+MZY4K2rne8fcNfqU0IKDavY5HGuQiTmLdNs=;
 b=klujcoP3rDDM6cT0LIPgcdZPgxy/RnJOD+0qmVQVN95KEI2VTH+8Sxpm4ukbPz9MycE/WSBy2xsDR9jMmhbg4c+iEjSNrAEAXUndVXMvqGW6cMG06ilvY/87xWUCiDTAmPzqA+lYvmWZnx8un4kg2ZxJaVrUYaPrr5zG+OLxYnIsMeiynkrvHKb/9h1STmmuuwfmk+cUaksjR3HWPYxcdA8pFeqKCk8AvS1vCmXj6H2iBz9SyRfiN5vxIrBxOTekzqhGXHV3iyzKXGcGaLLQ5hf+/aA7zEtOx/pE7jwQgPTVb3/gM6pP4ESKLRbCQDGadICL8o//BIqO4NhmceM/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxdFs5z+MZY4K2rne8fcNfqU0IKDavY5HGuQiTmLdNs=;
 b=JSWiVQtt1p3bUVatbMStWRH9ILWH8KLrh+SSV0RN2KA3Mn15r31XwSTEZ/mKDthkRNxMFE5AhXjnILbIBjMaS9KPLsHp+1q3OKvQLELWYQUe8gaGG14qmVouYrO/FB9jKPHNdFNZ3UNrFv6w82WYP5kkrA644ty2vgu+4JIA0dY=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 17:52:04 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9%7]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 17:52:04 +0000
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
Subject: [PATCH v2 3/7] Drivers: hv: vmbus: Break out synic enable and disable
 operations
Thread-Topic: [PATCH v2 3/7] Drivers: hv: vmbus: Break out synic enable and
 disable operations
Thread-Index: AQHVR8ip8baDygktDEW+MgiAj+nQyA==
Date:   Wed, 31 Jul 2019 17:52:03 +0000
Message-ID: <1564595464-56520-4-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 1fe9bdba-9af5-4f49-af0c-08d715dfcbc3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1120;
x-ms-traffictypediagnostic: SN6PR2101MB1120:|SN6PR2101MB1120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB11209BBA069D9833F50634DFBFDF0@SN6PR2101MB1120.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(68736007)(10090500001)(36756003)(76176011)(53936002)(6512007)(54906003)(3846002)(305945005)(52116002)(4720700003)(8676002)(3450700001)(14454004)(6436002)(6486002)(99286004)(8936002)(107886003)(25786009)(81156014)(71200400001)(81166006)(71190400001)(6116002)(446003)(66946007)(10290500003)(22452003)(486006)(7736002)(86362001)(11346002)(476003)(1511001)(50226002)(316002)(102836004)(478600001)(66446008)(66556008)(66476007)(64756008)(256004)(4326008)(2616005)(186003)(110136005)(66066001)(6506007)(43066004)(26005)(386003)(2501003)(5660300002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1120;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KfnPKsM7TwbfaJNdo0Cz8JJuUuSGrFgCvQS8FWkP3POZC7xyYpCx4b9cx3UR4TuPFlR9CUCVIzt/KgdQL58acDO+tWFz2WRT31skyBpu1t68qhhwfIrSFZyptP4Ij/LRm9e2sPuLLdbpqbLvlpe0nCAAQdi3mK8xhJxe/1m4Bfb1IWPQyElxww2V+h/+u0mn1f1sbmIDhZ8muH9vQcY+6OzvQtxYQx50A6fuwysVafBW0vYr16Lr6+wNdJhFlIqDMLKIY0gwZqd4uvA/PoEyMZmek9rR5YLwVe1NOdhI3+valtmxly51ju0hLfwtR/5rz441ryznZE/XKdzWLXkxNo8n8jdxxjMJfKeXyE++QKq/soCzBQtubUT/4wZ/mekoFUbJCLvfZUacakRUUEL91RDJsQ61yv733GaYLKzTsKk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe9bdba-9af5-4f49-af0c-08d715dfcbc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:52:03.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0L7sC6RdCIAatmuLbVzK7zU65PgewRi8KT0d2llgyKwZmX9IxkrLpV3URNAm1wyfjBdnKGcvl1o8awbmTU0paw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1120
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

