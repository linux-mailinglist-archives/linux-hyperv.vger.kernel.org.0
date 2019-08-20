Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B4D953C5
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfHTBwB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:01 -0400
Received: from mail-eopbgr820104.outbound.protection.outlook.com ([40.107.82.104]:41280
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728878AbfHTBwA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YssyCvrskletTYdezDOVbET/zEssovxBdZOy4sU4qpfzKHKpdr1DIG6+woVNVApVtCId32flIYcSUlmuq7oX4GJGs56GVlEmvm2ZcZQB5yl5FOAo3Es56VShtpEeLyEw3t1apk6X+DmXmXcluWJPW+wpzQFNLJenGeaAssckJU1RQEDNtdHghKu84/nCN5Z+OpcBldLhFyR5Yub8hICe48zn51XO2kxJ+gUY7tpGlGxlN8VriRmpWWDJ5yo2vkcBINKZ0Gg4nAe+YuawWTMEKh6DpcEQuhtGVFGxb6L4O5cg5ZK5+qqbp0m697iGY1K7mvOd3qz3sxhFYXsn8l5oLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aHE6vwd+ZTeDME1Mn6QUQYdpg+irr1EPlG47WC+jdM=;
 b=fn2WQdW+CWCxFVYNsE/Bt+OojXfQ99P6qtOJYNdo2L638bSVhRfja/aZijK/kKiuBw58TZrD+pF4s+QP8VsJKf769fPvK4AaqqcO+4H2lxmr1djGAcnWOfzZtG6XKj0CxU2WSSvgfpXOjbNqCpTZHDn0JSazhRtd/zz2zau8mQlkh19uwbA6qG+BNHC9eHPW3dkHlqpj3zEnzaVZDegzuOBaXrvgBEVKelwyvRtAdTS/4+5x4mtRRzNqmnL15g2TDACJLGqpYb0FjVBq/+xdmwlYmAvWywJi8Dnw1IT3cjR0YcI+Dk8luASTuftIj2rsepialJ1ZmxRF9e6Nlwkd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aHE6vwd+ZTeDME1Mn6QUQYdpg+irr1EPlG47WC+jdM=;
 b=Qs8PgB/egCJvy34MXGjoB/HHVCe73QKGRkz6iJPyR1llHso5EqtOtCneaiSg/vYGwAi9ggHHSYCeqzVfws4bDoOzPQgQHfEdfk+H9GoMLEUnvUFhGrDqtaYbiCq5awfJNsQRRXsHbGV5wj9kqsEjn9kBV5V6cPYVKaOuBMExneo=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:51:58 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:51:58 +0000
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
Subject: [PATCH v3 01/12] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Thread-Topic: [PATCH v3 01/12] x86/hyper-v: Suspend/resume the hypercall page
 for hibernation
Thread-Index: AQHVVvnaGjbf6aq/60OmlD2e/YcobQ==
Date:   Tue, 20 Aug 2019 01:51:58 +0000
Message-ID: <1566265863-21252-2-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: f189caa8-5b67-4484-8f3d-08d72510fc61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB11333A866B8022AC4369681ABFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(15650500001)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R3HZRpvZAwOmDQoX+5laajVieaNmmsydWjbt5VLLZ1McA+lS1wdZlaqRgt39RnwsjodDugwqtVJ6VNsXBm3M1v1onm0cHlqQSQbiIFd7pELQmO24GHI9ERPednZtYrfEa+sxMjicTbz32SnMGtJGnkchhkMC9tcjZH/LIOMaY3tMAdQU9hUl697Jd1oS3QbnffdcaxLFmokyjfmiaQq2TbaDh5yQucXeBj2N2IWUQ1I8BB28CVo427dQXqAbQbdWjfyGNDoM70WtKVM1ZZfbvDIirPrCvFNNWn8Z+luaTUXeY5TT2e54XezL2glRi6OJ+Ok4VM2UIfcLbZsAend6VuJM6KZ8e7L/Vs29tTSB7d46SbLFYvkpRX7z/8+di6egX4NeEQeJUlBd03Knm9eP75Ae1kXTwpkJbkO9mA6lYXQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f189caa8-5b67-4484-8f3d-08d72510fc61
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:51:58.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXkwaubQkXi5FurEFMLQdtUahQLkn+LgbVuL1pCClBQUgUbscosWFeNvIfgo0MlFwAkhpgqR+GOCH9AguArqFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
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

