Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392CAAAEE7
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbfIEXBS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:01:18 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:14272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388923AbfIEXBS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:01:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QecTOazGAaEdL34dC776ecK8ECDXAVzT/ER0Y0+CoW4Jod6+77TTX5sG86UGIDC9koliJLk3l2XJV4KHQW/atzvQxR1IXUGX74n/MeDjckkqxtNvVjoh6hoAtj2khvdTgT8tJWDMHxhDJzpCDrEtUhBVrxfttkBcPP+Zr4MUOOuk/2hQLNXbPlyjkkvuT4n626G5G7MFhjyEBZp2xB3skwYpKcpceaQl1U3eVk3dUuyIQXFVcwvPiKs/r7iFIwOVhxvvobLXinUB0D2u6bZcUcGVZOMw5UCqCNwUDRJp7jgLNg0lNdhS/siLFzCrEq1bOaTPqNmV8jTR3UdpumyAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxdFs5z+MZY4K2rne8fcNfqU0IKDavY5HGuQiTmLdNs=;
 b=VE+Fbh8vD9LygO8YZKZgy6bWeVBv/KtlKnmg6ZUDXasSorWYpo4t6ZRCu9MYgRXfhrHVKBQ7zq8y6X7G+p5fLwCg2YUtONOHJzqCWG5KYkdIyWfCmxfeOekEy/dJoacns0d7R/QtgaivF3CG1fATr8sT2cXgw+jBIsj42DsV0hGWTNSRYmhHKo99ifW/5g/RWoEdLBaCn5gIK/vDc1fPyDW+5cjQ0X7Zu05zYWd0fFUlzM+lpazUlWXDd3Q071wlpzoEz/c/o9GH6nzCoqmKTvezzxRLpk9FNXnO2xEg/E3j9udrahUThpOstDBIIvPW0Yh92lIq5EdjQ6x2VDUa2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxdFs5z+MZY4K2rne8fcNfqU0IKDavY5HGuQiTmLdNs=;
 b=TVzF/4SAy45YJouSKVrH7ilyAVdzhqa41LoXWPJKmmReYJAGewvRz7q6qxP21RAh0FYMh8VeGiJNw8BDZlRm8Mm2qCVT7qMQGjFCuJB1zO74MQxSIyb1Op1uKTUdBNj2CBBhtZRlDf423w8mg5z4F23eukgqCxz8dNbOZmoSbyQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Thu, 5 Sep 2019 23:01:15 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 23:01:15 +0000
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
Subject: [PATCH v5 1/9] Drivers: hv: vmbus: Break out synic enable and disable
 operations
Thread-Topic: [PATCH v5 1/9] Drivers: hv: vmbus: Break out synic enable and
 disable operations
Thread-Index: AQHVZD3RkdA75qoo7UKKomiH85t+Sg==
Date:   Thu, 5 Sep 2019 23:01:15 +0000
Message-ID: <1567724446-30990-2-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: b40b0700-8708-47ab-e680-08d73254f419
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:|SN6PR2101MB1038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1038CB7F1C1D41123CD1FB33BFBB0@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(66446008)(256004)(10290500003)(478600001)(476003)(102836004)(186003)(36756003)(52116002)(64756008)(71200400001)(26005)(11346002)(3450700001)(6512007)(71190400001)(305945005)(107886003)(4326008)(446003)(66946007)(316002)(76176011)(7736002)(6436002)(66556008)(386003)(22452003)(66476007)(6486002)(486006)(53936002)(2616005)(25786009)(14454004)(54906003)(110136005)(5660300002)(2501003)(3846002)(2906002)(6116002)(81156014)(8676002)(81166006)(86362001)(50226002)(4720700003)(66066001)(10090500001)(1511001)(99286004)(8936002)(43066004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xhBDHrzjCz1qCzf48T2TKjdTZNbCWnZOFjiWWWkhmCrBZnkE6zoYXlH1SPqA4vtcYyHwE3CnD6H2geBnW+fZsMcuTlRg2BY8oE//VM0nUwy4OFzn2sy9+tL0U9MihNAhYWuHGjCWFp1OvTVjE8E6cWH2FS+CoD6rWDzSOqjET+AvcxGTFXeYM3OFJn2rI26NgTjUvMS3KLpjwwYFtG7bz31MjjjOszgzm2BJ1JhLGjvX9f4tFDeydC+aWlhPOJYKJEPHvrQgP38EW+DFZ7hUHBdkBoU9ta5kzSEa9RF2xGXVny16nJXB25TQiPDoGGrRQB2xARxobLRNSVoeOVXMWrgASTmjfiarpYy0dpWxJmWhuyLgin8y8UEDk0C0Z+q5LWoQzPRhiLLyMbKZagCX+DzP97AZaXQPtLFVTVQDV+U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40b0700-8708-47ab-e680-08d73254f419
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:01:15.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lb1B9MHe5nONObODPY3ISEIuU3K5AUYkKal0srm/v8tu1dJkr0ATIs671bKJBGiGdcDdp4NzojQdkHkKu3SrhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
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

