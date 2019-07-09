Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79B062FF1
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jul 2019 07:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfGIF3e (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Jul 2019 01:29:34 -0400
Received: from mail-eopbgr820117.outbound.protection.outlook.com ([40.107.82.117]:5824
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfGIF3d (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Jul 2019 01:29:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJD0g3u1pa8ssDawR329SAg6MwisUK7H9VRcs55oXWEvWYANzDSPw0Pa8HW1GM28j6fqRff/b3vGmrEil7JjEIqgHRM9FCS6yA95Jkvja4lgyTyK77ZAR7tc0Az9uSkyGb+usIwWucxwGyDKVwc4gCKkG5w7L8mtsFvZr/5viaB6lC1G7Mb3pqx2U/28sT0vP7jJSipD1efR0/aVgYpIJs1aGYJ9L6hxN/nTkL4aLoRC+xdFemnhJsSLg5F5S6dU6P9+JMJ23wpl3kfnDDfK8MmMWbLZ7FLKjIMdsrv832jaf1n+k/geDOkLUyemMabNz+KcGf2n9nx+4Ig0vvAOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5OLYrGpvrA/7I/0tA/29rl89bHXRPDwQY2mZkhIYf4=;
 b=bTyo6DcZ4WEqeVMGNXpJFYZ/Ofba9ToVtyKihcCwjtDKr7il78N43inwMc1EUjmDIPlV2s8pcs0IXGQ88LNkrUiaCcX+8FhC6GZeQ/Th70qQGuXxT6jaO7oI0TPmsCekJdTiIOOOXWCw4Bq9smzpL5Cx6T7yaAH8wXVbIvPyRRqGkWPRseP0wQHcuSJpAwK2r4yYBei/lRt/admMspxWxqNySqXhqrxTyKjGUFiedTDcho56eXwpAbObAqT2891fHwM1EzFBwDatAp3S4Doj2nxJFpLMqgMl7jzjvn9dKp181B8rxgDMypMOtEeqJHU6dl7cOLX/UBLNffpc+7wWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5OLYrGpvrA/7I/0tA/29rl89bHXRPDwQY2mZkhIYf4=;
 b=ly83KZ9F6M45wDqhnbwGAoxzV7KcG9cAz59wzK923W3zpsN9E30ZKiXoPMOGVum+5pDcDpAYdJ4b0k51S0TN0msrhiasumlko6isOPEnCBfm86fp5pWQqmprDYNqyEtU5Nf9z3DGYqApemmRoL6Gw/rJbO2UMCJUfta7i8xe+5k=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1040.namprd21.prod.outlook.com (52.132.115.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.3; Tue, 9 Jul 2019 05:29:25 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab%3]) with mapi id 15.20.2094.001; Tue, 9 Jul 2019
 05:29:25 +0000
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
Subject: [PATCH 1/7] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Thread-Topic: [PATCH 1/7] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Thread-Index: AQHVNhdFRRyFGQIwMEKlHd+qwwILmA==
Date:   Tue, 9 Jul 2019 05:29:25 +0000
Message-ID: <1562650084-99874-2-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 9e3203a0-5263-43e3-2bb9-08d7042e67bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1040;
x-ms-traffictypediagnostic: SN6PR2101MB1040:|SN6PR2101MB1040:
x-microsoft-antispam-prvs: <SN6PR2101MB1040B8C9F4517C4A642E0972BFF10@SN6PR2101MB1040.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(6436002)(10290500003)(43066004)(2906002)(2501003)(4720700003)(316002)(54906003)(110136005)(6486002)(22452003)(64756008)(1511001)(66556008)(256004)(66446008)(66476007)(478600001)(73956011)(14444005)(476003)(66946007)(52116002)(66066001)(305945005)(8676002)(81156014)(81166006)(5660300002)(76176011)(486006)(4326008)(36756003)(6116002)(3846002)(71190400001)(71200400001)(25786009)(99286004)(8936002)(50226002)(446003)(107886003)(10090500001)(2616005)(6512007)(14454004)(26005)(11346002)(53936002)(68736007)(186003)(3450700001)(7736002)(386003)(6506007)(15650500001)(102836004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1040;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3L+29WO5rs7XeBFHWZRjX+4c0+pFU1/EKQBX0kD0Ml5I1S4j9SWr0BwvBzzf2UdJsi6qrh+1p/hLVwGomKMMrN3cL2FoFrln/xqNMnXkoYLiPTh0VrV///SXc/sO4/DIixcLRIqXRmspo4RjUsSLIS8UjJtXuj94h/u3jsqeRsV4KxE+NS5kGm1hsSHNLSDLnU0C68a+JpYX1MTiW4wCeAyV8Tg7SKyciRdaDvc+zwCh8L70P+GhED0WBkhRe8dSBM+XtwN+qOfMGjNh/NdFiexgtzcZL9eYbXsIFtKLf2rZyQwmYf6H/+Goj8wHWrxYdjwhQAtWpaAMOSeCoz7LjD69JWdTOjQoFW5sy3UDBZH/Sju3EP0j6t4LeHs9BU/kXEsSJDyigA3KCVmMyMDYPy1nZ+ysE10Px/O44Sn3QiY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3203a0-5263-43e3-2bb9-08d7042e67bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 05:29:25.6803
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

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's hypercall page and then resume the old
kernel's.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0e033ef..3005871 100644
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
@@ -214,6 +215,34 @@ static int __init hv_pci_init(void)
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
@@ -294,6 +323,9 @@ void __init hyperv_init(void)
=20
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
+
+	register_syscore_ops(&hv_syscore_ops);
+
 	return;
=20
 remove_cpuhp_state:
@@ -313,6 +345,8 @@ void hyperv_cleanup(void)
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

