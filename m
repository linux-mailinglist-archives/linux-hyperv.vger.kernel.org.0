Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10163A5E91
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfICAXX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:23 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727814AbfICAXV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XViiGeBzaRo4SDoX/AYAH94NWO/iAcdoIFa1Nyzv8GCXjyvVelO3H6d11PHKfM46TYScBICoB3qJ87uj8RZDHbocLY89XiWxROGXbLBV68V84z7fSLUJ7BJweiy7fGfoDiLDVXHeRYjVaBrPvD0lRVEQ7rJgDhIT5lEPCOQP3qjVqBHrebE8iAIcbtEY8ePt2rSwUeftZ4fkHlwfhdkqEcTwg/OpgJsC/eF3PEsT5hYePyVKrc3gOubwRs9eLaaCOFsHOg/Lm3kMeeX6Pcns+E/kgMdMxdxIew2y3WbHqECl9kLXbpqO75tJfXTneJ1aFqmuaaZox3qBV0ZR7vWYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aHE6vwd+ZTeDME1Mn6QUQYdpg+irr1EPlG47WC+jdM=;
 b=EV/OwkupSi9TILR+ZgikqQXB4TxhXuHFXRWe+Kiyeh8CJCD0hfxdiWU+qCw96lyKWd7FANi81Dcx2rExvhW74eR5snCzJfe0MZn+KkRXIzFSHtHt0h7kSVx/9dqNX1h+D4eGqO94lZy5L+yZLqFgimFwgJuRfGyewg0r8lvQ1vw9+iKy279trfmgrV//CR9wKhX/ZFCxoDpHzvTv7Lr9iwo07p1i2VzQ/SdPQf3orvGm4HK7YBjpqdtEmr1HcVjWv4R+fq9+ou/zwKNd4emvgM9HZayTS9S0+li8Yj5ad6HXam0SBH5vciFRlA95GG9UObM4UyBoIG/jReduamZWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aHE6vwd+ZTeDME1Mn6QUQYdpg+irr1EPlG47WC+jdM=;
 b=g7mVHu2eDAcvldwbi+7qbbuNWjD7RzX29POrVFu9TIR1LfQQsKaX6uYSvw+HDoNFdytCa+oR4RzDkMhhqMaT1IRy+xjtz1GVnH4QWRKx85FJnwPAqXzt68hLbLCHdaAasjxhcOz5DFrh62I52AXE6ywjlLa00tmBaAVECCk3PXQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:17 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:17 +0000
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
Subject: [PATCH v4 01/12] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Thread-Topic: [PATCH v4 01/12] x86/hyper-v: Suspend/resume the hypercall page
 for hibernation
Thread-Index: AQHVYe3IFusf8h3dV0+jJXegos1oNA==
Date:   Tue, 3 Sep 2019 00:23:16 +0000
Message-ID: <1567470139-119355-2-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: d4e9b0ce-7287-4feb-2322-08d73004ea5f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB10546448BB93AA603798DC02BFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(15650500001)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wqsJXZuk5O5KQVu8+dkEisv0pWMWQIHHfy6HgukYGssp5aEOzja+mzgqEuADFtNVn30wNF53kuQQtb9xRD0qH2sKBNvNh+q43Om5v5RdyQVTxdMXFHTG+w+ijSR9vrdwh6hrt5NS3bZmna0vO5vneUmsgkIDchAriLHOoJP9lP7n3bCwR9sj1bhcSGqrof4pOn86WYV1zlfB2SC95eH0wfDRDiqF5AqbGRjblH53X6NgKV6pBnnVboaKbgLpdx3Kz2rLfAIWPPy/Y0nInyoJetPCAaF/VVGytGvQT37hMTgRPT05GKRByx1Rx1erR5BjHpSghkHdH7/hzmLxpultB2mPmG0UFmMYUssyGspMjQdESdkugOO3+UZ5c8+uGnINw8AycHSfLULVFCEWJe3FXYcYJyQfYD2m7tbLqBi7IRE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e9b0ce-7287-4feb-2322-08d73004ea5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:16.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNqmhOKTmD8p0iVaXKQC+FSBGOWsRBfj5gvJrCsu4wBGjHM6p/P7nuHfluuPom6ihLaijs0/ub1iWTwszxSoCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's hypercall page and then resume the old
kernel's.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0d25868..78e53d9 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -20,6 +20,7 @@
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
+#include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
=20
 void *hv_hypercall_pg;
@@ -223,6 +224,34 @@ static int __init hv_pci_init(void)
 	return 1;
 }
=20
+static int hv_suspend(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/* Reset the hypercall page */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable =3D 0;
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+	return 0;
+}
+
+static void hv_resume(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/* Re-enable the hypercall page */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable =3D 1;
+	hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_pg);
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+}
+
+static struct syscore_ops hv_syscore_ops =3D {
+	.suspend =3D hv_suspend,
+	.resume =3D hv_resume,
+};
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -303,6 +332,9 @@ void __init hyperv_init(void)
=20
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
+
+	register_syscore_ops(&hv_syscore_ops);
+
 	return;
=20
 remove_cpuhp_state:
@@ -322,6 +354,8 @@ void hyperv_cleanup(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
=20
+	unregister_syscore_ops(&hv_syscore_ops);
+
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
=20
--=20
1.8.3.1

