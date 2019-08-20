Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F569953DD
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfHTBwC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:02 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfHTBwB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fboi6BduZPbi2I4zi5jHEinbhtcHCviTsHKCdZUQGFeOarTvo81CLZS2wkOrWtxCP7litD+cMQW8Cz0R4su1UluLJNrRJS5DfedWaJkyMbHQvT9Fud5XW0wr3Aae/JFQpoexQjD1DaqW5XoDV5wFe8ZNX5X6X491QDMCvFUJrbJkZNmtCzg/XxipoI/7D7nW1EamtlJKIj0bLxj21g2qla8FyNEt5krG5rg8IDXhbpnHyEIM0dLs7JABBZ2Hedn+YQcHG8V7/URz5W9E0af1BiLEk1jg6OSpATGOpldEeCsTMrQUimf4XHWO8iDLYIHDIXrpEZozWag3NzPEmCgmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJU9/e0K7F8rxKQtg8grE4iRkr5No83lv/nfIPd1TVw=;
 b=chip/fJUr2L4AP9GS9Fy3MWVc8hKPKGUzMILuErZoMYHy/NEDJzHg1U9uv0Dq/5GWXjivjYHElXNGB3tpD7qsLnHTuK2XJbSUy72AL0mjLWZR0ma1UtxxGAZ19+DeVa5hGy/+qK3vFapW4DaCImROPrbkv3piF/mMKPgSAaE4SQ3iFYnQGYc6XP94l5Gd0hFXyv97h82WQh1kRRrksnxaLFXrwBkqSDeQbXcYkaGQaHt/j5TrUH14ex8PTyePA61oNIZQ+wC2c/ti2sFg2yuuG79jbqVY+KuZN47QUmqZfbl6NMLz/8MlPtk0cNnbHB0bAVXGsexJWnfSiTWkau81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJU9/e0K7F8rxKQtg8grE4iRkr5No83lv/nfIPd1TVw=;
 b=T+csn8cxKfJSd8kljkW+SVuMfVd7DHKGH16ziTBl9w2oljrZ+anaSwIv4IymRP/ue17nxa6JcDmieKmUZL4MaW+OAUiSV0Bzf1xDAB/Y+g9Z11zicfIslHOC/JlqXCqsicLv8LNybX+XsjmMIbvn7GjNQI6OsRCEE5bPukCH3aw=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:51:59 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:51:59 +0000
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
Subject: [PATCH v3 02/12] x86/hyper-v: Implement hv_is_hibernation_supported()
Thread-Topic: [PATCH v3 02/12] x86/hyper-v: Implement
 hv_is_hibernation_supported()
Thread-Index: AQHVVvnaauv4CVKCgkuC73ZaL/4H9w==
Date:   Tue, 20 Aug 2019 01:51:59 +0000
Message-ID: <1566265863-21252-3-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 665a234c-8539-4e78-71e9-08d72510fd0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB113377EA74F76D87BAF73CB5BFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UP61vQ99yTA852QAkeR47hGswY4tSgJk2XMpQVZiN8TyuydOgtU9/knZWoqJnidbC0+NCSh4XckxCPR3BIJOG7sFHdo1vvqqtMRPx+WT9oFWr3UysZg3L7a7UnnwHvmRjWLeL5cNMNV/bA93k+yFDzXYrXL/3vY4poJ93ZsAdHEN2Q4khdqNvowmWAUYAeguvqjmTDOOs+35/tqGdcS3bsKawo9a+Kw8MxiVXzhAmKo0TFmRo3Lm4WGd0CupDZiYj0J01XKOGbz/efKgNQvEzq2JVuHFAIr09fnacu57sXyvxO1kQyZRPLKvWh8JJI2dPsRhPLf9tj0A82UAzbVjIdpJ8wi3XBB10qNrEx3bHTztzbanTkO1vsQzsP6TB6dHoqUozoqFE2uz5uKTRR5L/jn71mbfRDRe1bf0lKX3IAQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665a234c-8539-4e78-71e9-08d72510fd0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:51:59.3745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOYz1ToXCHXqFIeNJ/OgEF1cF1PidUGmdtE2nEptUcEnt4md9gOICxZiPNDkEmvweKoQx8yWuFKQtXRCusvOdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When a Linux VM runs on Hyper-V and hibernates, it must disable the
memory hot-add/remove and balloon up/down capabilities in the hv_balloon
driver.

By default, Hyper-V does not enable the virtual ACPI S4 state for a VM;
on recent Hyper-V hosts, the administrator is able to enable the virtual
ACPI S4 state for a VM, so we hope to use the presence of the virtual ACPI
S4 state as a hint for hv_balloon to disable the aforementioned
capabilities.

The new API will be used by hv_balloon.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      | 7 +++++++
 include/asm-generic/mshyperv.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 78e53d9..6735e45 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -7,6 +7,7 @@
  * Author : K. Y. Srinivasan <kys@microsoft.com>
  */
=20
+#include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/types.h>
 #include <asm/apic.h>
@@ -453,3 +454,9 @@ bool hv_is_hyperv_initialized(void)
 	return hypercall_msr.enable;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+bool hv_is_hibernation_supported(void)
+{
+	return acpi_sleep_state_supported(ACPI_STATE_S4);
+}
+EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.=
h
index 0becb7d..1cb4001 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -166,9 +166,11 @@ static inline int cpumask_to_vpset(struct hv_vpset *vp=
set,
 void hyperv_report_panic(struct pt_regs *regs, long err);
 void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
+bool hv_is_hibernation_supported(void);
 void hyperv_cleanup(void);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
+static inline bool hv_is_hibernation_supported(void) { return false; }
 static inline void hyperv_cleanup(void) {}
 #endif /* CONFIG_HYPERV */
=20
--=20
1.8.3.1

