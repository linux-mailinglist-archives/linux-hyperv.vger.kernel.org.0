Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9B9953DC
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfHTBwl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:41 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728981AbfHTBwF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hcua9fvkdsWMhkTxHAZZgpmzMLQc3xI41ba2cCbBFO3yxb/qQ2RqEWZF8gm6rJt8ycpgaNrgcjejCRL2dH+akddpXd5CWXaftOVWeGEwl2R3EmWR0oGPtLEkFIDcLY/UZ9ho0UBslBv0LE+ruT2Mfls5Tg7qdcuiSteqidT9GkVSaPdcNXJq8nqnpGpl6pzxEt3yUpDka09lyJJhDwpErTuuWhxprvSDiBPcX4y6AYKLy3MTo04tuPLjX47sa8P4XOVt/pT7GkasKIDydy/KamE3PhcoHgmtghg+1gMshnCr8KZ0k//aMyY6vP0ofByVsR86/b2KSXz+SWqiECuBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2SopJ+juho072YN2Zrut1KNuEePiwLKCvRKAzclqbo=;
 b=NXRozsdoPHNXRXeaMOn+x4q+7SThYpALV0vifKGkhPsoxGKZEwxBYkR2jUluLeavovlQs0z0plxhf2/U94F0mFAuquHsWtEiEwFVcRSkHId6/dPHfUqjHDyg/wRux/sC5cbEiForvugogRbwQAy4NNFuZWOlsuLCtAZ5sei3P8eh86I4Nic+HUo3czSuRTLWai1Gwmt7HdtMt2Em4aifjnWnRpbbvaYVWNoXuZRBTNMJgDx0L8mEfaR8XsFCF8DL9TyGUxlTZnN7BhspluBLmMZv0iz6kMkdokfL/rkO9Z1QO+IdJcNTEVSrQjGRkQ93bwlEmZK5SOiHMa2IjE/htw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2SopJ+juho072YN2Zrut1KNuEePiwLKCvRKAzclqbo=;
 b=fBoLwmz++NmMyE51Z+k+3XnSIhgcHtSaEV0NR81X6bfpeIEeGyH0wfz+1tvpisuWjRIL11Velhi7Icj7XJnDHLR6A/eaal/WZBvwWV43ZaXTuYO4R2kEXxiawl6dk4oXPL69f/59icKtarIBkAEVN0EnPsi7KCYL+ETa4bTlw48=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:52:01 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:52:01 +0000
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
Subject: [PATCH v3 04/12] Drivers: hv: vmbus: Break out synic enable and
 disable operations
Thread-Topic: [PATCH v3 04/12] Drivers: hv: vmbus: Break out synic enable and
 disable operations
Thread-Index: AQHVVvnbv4AiqNtJB0SkNFyBzFF3VQ==
Date:   Tue, 20 Aug 2019 01:52:01 +0000
Message-ID: <1566265863-21252-5-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 9bf8d955-d91f-4624-cd9c-08d72510fe2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB11334A5C01C1D08F0E6071A1BFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MtxZCcIXsJKgZKhRDko6nwWU5faklZVJTNcosUDo1q9u4AmCnsvCP8gEUsQvsKxo9YoSq7bTuhiXZopySzsHtcuFD3GinjeHrB1NT1ROZfvEEim992yeyRBbR65+7jnRT01kM9u2hdYrV4B/tktCeHlXd9eZugpvA8T1Y8BwTu+NvY4L0ogZMr662UGZpbOr8zmq7ZqirA1flcEpF3G9vbO+K6b6mdMh0ddYC1uBQXQRXcMg7OK1oV2I5kvsg9HTyEHTSJfSqq2oq+y/F44WleDwl8G0Ss1oZnDCq5dAVCP4FevPNiLULDljwGoC7gAPHWXRYR4jqvKz8NKxKHhmIaT10s+X2dHu6TqWHfQTZbWih8TI4htigyR5i0ZpPY/WoINncqjBEutdXvsyapKFsp5LbuHGBnn836Y6LBQ2MlY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf8d955-d91f-4624-cd9c-08d72510fe2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:52:01.2595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RLV0BWarUDUD4+zNxxbGgQp0tf0Hhkon4iJOtaXvTVe+U68pt2EnwyFtYCHj+XXERvLS+FJ+4wgnDe6oQKuTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
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

