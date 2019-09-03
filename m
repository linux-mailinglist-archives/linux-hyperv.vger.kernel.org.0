Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FAFA5E92
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfICAXY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:24 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfICAXX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ergLJf0hme0m8NlRwnZxj1xrWtpI3ePsI8UKavfAL3ONWqIG0WbUAWAQVSlY8B75GQcOKpljonIpT2V4pPI5lylVCSpttKJBs+z/ivXcdLdg97y9xBTa9mjszeggxhUH9C48kX1ZCD3HhzQSAmoTI+ryIyb89DVycyLkZIdTeNQzXdg0XXF8YeWsTp2HTw3Dx6nwpPOMqX+U3qOWyOf81gC+RT4o6KqkTI+kh9hLXMuOTV85sk9nn/l5E7fEbjx7KiQm+r4Gtm0/WuSE3DLzPgpxAoVuaMX4i587FJSwIMGkBkHtDDku04cRK3pTR2EMRVZkG/LhIavPJBPpu9191w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C5W9ygPQoEU4MtAuzybxYT/aiDyAnK9mS0LRsthdZk=;
 b=icH737tK2hHmZjPWiQ/z6syIkuqy8WJFrL7+bWOfSAI+bZU/p9Ke25wJ86f1h+OKwNHmWd2a39raRkkl658VnHhxDlJc87yo/07gYPxy4XyirB0Uajy9eaxsh2gD6p6o2PGkStiW2bDZv+F+n5qaCFFBu7dcXo8pUg5N04VslHBzQbx0GNmSZgT3LM9i/JEqlzUvfBCSukNYLh5zXWH2QMhnMvEJ60xWb8V/kJQ9JXiSbqiFzwPyNqBnknqIll3aSHdrwGk25mz7d1f9rGXM0YMh6HRsd4A20eOcuIBmlXVBiKSjZTVagCDyeLMOrgNDhObrJ54abUXuznIZHlzZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C5W9ygPQoEU4MtAuzybxYT/aiDyAnK9mS0LRsthdZk=;
 b=VvKqjCPn6+hLf0l/r3bxjqV8m6aHJaRzx29jpHXbmZIxY9U8jlUd7rqMkEKSVU/pXsDZMDrGVXLQ9tA7hRNHlA+dSxeE5/Nd5RWCmHt8zffretxttIJMgpVoKvn4S7UDVWFJGVMiIv3TZeP0xlJZKg6xtdRJlCmJPPeqCuNaG5c=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:18 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:18 +0000
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
Subject: [PATCH v4 02/12] x86/hyper-v: Implement hv_is_hibernation_supported()
Thread-Topic: [PATCH v4 02/12] x86/hyper-v: Implement
 hv_is_hibernation_supported()
Thread-Index: AQHVYe3IqTcRHQtSOE6NiLz/07UAAA==
Date:   Tue, 3 Sep 2019 00:23:17 +0000
Message-ID: <1567470139-119355-3-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 665bccc0-b941-473b-ce55-08d73004eaf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1054ADA8F90DF83438EACE7BBFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 55dww75RniUkcvgFwV3e5bkD9ASQ9vEnb+SI7yiMBpiFPXvBrtN945hqdEpS9eI47e13LDRkZEXUZX6CCbMrmtDwfqWn9vxRu97somPO9jEYKW/D6HHZ48DLmweKoYxjE39uwOPpbuC2BY4kIA9XRElXTdLmbqkDhpLTyoezLi2DYM6Yzc5yk6YkueACKRQZZwEI5SvsdKoK6x7UCtfdwP7iy1GoxvMFFt8mpGzUrIP9hZ3nH+moJiOnQ2Yg+veImENFPXmmpOffNhXMiLURd5VRBMFTyW5L6q9/Y0wRJuqmwUYt/8zfaTbOW5pxLIFrKxSSR8hGJYRtkHDV3YvHj+YrcV5EvOslRbFFCpul07ypBmqEeGA4BDV9BIvA52U4n49BroFQPfadKWGC2V4vXA+376CFOtPuva56fhieYuw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665bccc0-b941-473b-ce55-08d73004eaf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:17.8403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNQkx3WYi2RTk1F+mZZ4RM2TzcHEk6SMinXM60gDboEOq+OEwvZLjgq3sJCDM45ASyfbkVqvRYHdhYcL8B5yIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The API will be used by the hv_balloon and hv_vmbus drivers.

Balloon up/down and hot-add of memory must not be active if the user
wants the Linux VM to support hibernation, because they are incompatible
with hibernation according to Hyper-V team, e.g. upon suspend the
balloon VSP doesn't save any info about the ballooned-out pages (if any);
so, after Linux resumes, Linux balloon VSC expects that the VSP will
return the pages if Linux is under memory pressure, but the VSP will
never do that, since the VSP thinks it never stole the pages from the VM.

So, if the user wants Linux VM to support hibernation, Linux must forbid
balloon up/down and hot-add, and the only functionality of the balloon VSC
driver is reporting the VM's memory pressure to the host.

Ideally, when Linux detects that the user wants it to support hibernation,
the balloon VSC should tell the VSP that it does not support ballooning
and hot-add. However, the current version of the VSP requires the VSC
should support these capabilities, otherwise the capability negotiation
fails and the VSC can not load at all, so with the later changes to the
VSC driver, Linux VM still reports to the VSP that the VSC supports these
capabilities, but the VSC ignores the VSP's requests of balloon up/down
and hot add, and reports an error to the VSP, when applicable. BTW, in
the future the balloon VSP driver will allow the VSC to not support the
capabilities of balloon up/down and hot add.

The ACPI S4 state is not a must for hibernation to work, because Linux is
able to hibernate as long as the system can shut down. However in practice
we decide to artificially use the presence of the virtual ACPI S4 state as
an indicator of the user's intent of using hibernation, because Linux VM
must find a way to know if the user wants to use the hibernation feature
or not.

By default, Hyper-V does not enable the virtual ACPI S4 state; on recent
Hyper-V hosts (e.g. RS5, 19H1), the administrator is able to enable the
state for a VM by WMI commands.

Once all the vmbus and VSC patches for the hibernation feature are
accepted, an extra patch will be submitted to forbid hibernation if the
virtual ACPI S4 state is absent, i.e. hv_is_hibernation_supported() is
false.

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

