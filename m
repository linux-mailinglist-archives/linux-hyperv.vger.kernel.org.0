Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA6A7CAEC
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 19:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfGaRwG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 Jul 2019 13:52:06 -0400
Received: from mail-eopbgr710125.outbound.protection.outlook.com ([40.107.71.125]:44032
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726300AbfGaRwG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 Jul 2019 13:52:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+FXhOYKii/YSUHYTtao4RtnisdRyKRxFL/HmSwJ+ChnvVIcgXomUEEafSWfRPOwQR20RM9+nZioAyvCXrgxPHtv6oKFuM4cu7fpBYrR5ZBH46+ZJXh/4kRCRe3ISiGu1xP1l+4LBmkVsz0nYXRoD8hjLXoJghcZh/aXVaSP2jzoCqfKOTzUcvwA7UTbhmNUJqksBLrOTepKbu+4Mt/CurqMmNxqz06HQS0YWH976pLxHlcoWNVPdvJZ9kMWU95ANZgdjF10mZ6hl7QTHkD4VC70E6mRVoHpTE1kwR8PG5+BSSw9tlvuL6aOEdhXzVXreMbWXGxfF/dy7Mjp9W3KFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aHE6vwd+ZTeDME1Mn6QUQYdpg+irr1EPlG47WC+jdM=;
 b=RkqWYVNlxUXy9w7rn1QE15ldXoF6ycTH8DdKmEQY9W9e5WDMtU/Hqm9CtSrWufzfGTngQ24bX8FvT/W+FXeiEYLV0LRS3CVeVzF+E5BjsCIisoq1yPgQvDdLi53dZVmkDlroDEmLI6IJPKBME27FMGDL/9bfwKsSDTHwLpN/kn48+EZPXM3bzLTLH4vVPtv+xA+nSQ1D2Gq0u6TPvytmGnF/KRQ9+2KCLD3sc5io/RW7wPfFjYYI66vmuE1cWzZ3Trib7xtYsZTHF+RhDKAPLaU5hfMPTUFAWoZWBu4HTE4X9uSA/Le0TEnqylxpyYYMZTCRU0Hq0p+NnplfC8acjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aHE6vwd+ZTeDME1Mn6QUQYdpg+irr1EPlG47WC+jdM=;
 b=htpC2XUygu8MtIUEAM6fkXv0I3DYLMFZGLWlnAnwbSrI1NSClAINlDta7VUiNn6qQK1b8El4TncCaVDom2xU8fld1ZDwCX0S8cJtPD+FEoe4OjAdvCEVWLyB4qbxOiaVRDu/vMlQkIcPS6pDwrJWJpjeb+qMGTckeoWYkGPio0c=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 17:52:02 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9%7]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 17:52:02 +0000
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
Subject: [PATCH v2 1/7] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Thread-Topic: [PATCH v2 1/7] x86/hyper-v: Suspend/resume the hypercall page
 for hibernation
Thread-Index: AQHVR8ioV+t7r+ryT0u58WMFMu1LMA==
Date:   Wed, 31 Jul 2019 17:52:01 +0000
Message-ID: <1564595464-56520-2-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 30351573-c60c-4264-4b35-08d715dfca9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1120;
x-ms-traffictypediagnostic: SN6PR2101MB1120:|SN6PR2101MB1120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB11201DABBC8EDE8940AEF863BFDF0@SN6PR2101MB1120.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(68736007)(10090500001)(36756003)(76176011)(53936002)(6512007)(54906003)(3846002)(305945005)(52116002)(4720700003)(8676002)(3450700001)(14454004)(6436002)(6486002)(99286004)(8936002)(107886003)(25786009)(81156014)(71200400001)(81166006)(71190400001)(6116002)(446003)(66946007)(10290500003)(22452003)(486006)(7736002)(86362001)(11346002)(476003)(1511001)(15650500001)(50226002)(316002)(102836004)(478600001)(66446008)(66556008)(66476007)(64756008)(256004)(4326008)(14444005)(2616005)(186003)(110136005)(66066001)(6506007)(43066004)(26005)(386003)(2501003)(5660300002)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1120;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j/ugIQb8ixJhr95VzsuA8zisOI3B2Jf4Y6h347XkIO/NO33cGm0DOUIuz3vgLxCJUL8yg+B4uWsTT0aARAon4q92YlM4pyjfg6WUleGOunaS/46hSEDV7IOBvUFZU4dTGMf64ONDOTQEuNb/v93mxF78LSptdLBZFjD/SzvURPh2BYj0j/uQdcyt+QdC3LdRy0N+AxdPQq2WH2Xx5DKulMqdIXnJCb4e0TBPOjiUvmvtrVqQmBtzqhUzTSwQIhwn8ZaBpaXru6XdPylWnIqfQRFp6MlWRYXvdstCUEceZDcy4KcvskfhJLSGztMskJhc7xtXWOCQlWYIqUMHfYqVrpZe1d1q/3TGb1ilX56TKcm1E1M9UZJ2kq41jtkjKYYppEcuDucb8vltiX0+ejzWHabEejjFGFbCW7fpDGgSGfI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30351573-c60c-4264-4b35-08d715dfca9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:52:02.0033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QlAe7j1c6nhsDGFuptxlF5n76eM/RhyN/eF+huRvgGOj/M5bGPmEOVWjd+5m0BTyLi8sGX0aO0aEyFDKJgTsOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1120
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

