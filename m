Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53D84C1CD
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jun 2019 21:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfFSTyp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Jun 2019 15:54:45 -0400
Received: from mail-eopbgr1310125.outbound.protection.outlook.com ([40.107.131.125]:17376
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfFSTyp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Jun 2019 15:54:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=WVh4iMEQaXtfN0tSAWVU7cBJziAMsdPmN8kurx5LFuPu8ocQt1oZfs/0eMpckRIFV9Oi2Y7BxZF5vMORz/FAU5iTEhSZfo4AyE4w8hEXYOMgL5hoxtXcKi2vhgTemLBoTQbwL82E4t0kyMgdf2MC2CLBNgyRIBJOj1O+iKmLTo0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJZ2jRmkEBa9G0PN9bXkHZLhIXLZstCX/9z1RPdu5zI=;
 b=jE7hFQTYH4o1ZCoAOhhmk7l1QbLTRdogPI9ricIjNiT7c/2S8eippfbm+F5yA+iJKlAy7oaZ2J8Pjs+TFe6RbyuTfoNh54aKXbHvXXjuDIfOO7cqFrbvr68gwxy9R/twxnJoLhW5JcRFqz1Z1ZUR/HMehaQCLu5wGxZxeu610oM=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJZ2jRmkEBa9G0PN9bXkHZLhIXLZstCX/9z1RPdu5zI=;
 b=cYwmBcDivmhEhpSllmN4UsHt7e5QAgcRVanAy5jIxQpvsom4cfelzxs7CTh9wgToR1zhzAMF6Z8Nb9kZbQXrN/t9TVXe08OUnnj41i/WJ5fKCg7LZk6gQjHcLo6LrKDVBdK5vlIpSsaHcovLbGSAZMY3B9CGUAHVeriOZtXD0mk=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0171.APCP153.PROD.OUTLOOK.COM (10.170.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.0; Wed, 19 Jun 2019 19:54:29 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04%4]) with mapi id 15.20.2008.007; Wed, 19 Jun 2019
 19:54:29 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Thread-Topic: [PATCH] ACPI: PM: Export the function
 acpi_sleep_state_supported()
Thread-Index: AQHVIt2lUviLbUjfZEmzRslUu7e03qabnRQggAAYmbCABFQwAIAALIpA
Date:   Wed, 19 Jun 2019 19:54:28 +0000
Message-ID: <PU1P153MB016902786ABA34BD01430F83BFE50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1560536224-35338-1-git-send-email-decui@microsoft.com>
 <BL0PR2101MB134895BADA1D8E0FA631D532D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
 <PU1P153MB01699020B5BC4287C58F5335BFEE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190617161454.GB27113@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190617161454.GB27113@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-19T19:54:25.3007226Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dd92b2e7-52d9-431a-bb8c-fbc7f468180f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:35b0:9107:ef50:5160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21b55b4e-a870-4179-1f79-08d6f4eff0b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0171;
x-ms-traffictypediagnostic: PU1P153MB0171:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0171F039A06FE77F2163880ABFE50@PU1P153MB0171.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(305945005)(8990500004)(7736002)(52536014)(7696005)(11346002)(10090500001)(81156014)(446003)(76176011)(486006)(5660300002)(102836004)(186003)(71200400001)(71190400001)(8676002)(81166006)(6506007)(99286004)(46003)(25786009)(86362001)(4326008)(6436002)(2501003)(14454004)(66556008)(14444005)(256004)(66446008)(54906003)(7416002)(66946007)(66476007)(6116002)(55016002)(2201001)(9686003)(73956011)(76116006)(64756008)(110136005)(68736007)(22452003)(8936002)(33656002)(476003)(316002)(74316002)(10290500003)(478600001)(2906002)(53936002)(6246003)(229853002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0171;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q2QLcOrovBj7TbMjyyhL9ZjpW5h+lCmUuQB3hoPezE8Y+lJ6eFrYz0kdpPPBVEkHNxagQFFrUo5W5OFujL0cEAIQyF1fMqxLhVQnhdSLlWADLTWMwralWH6DMZ57Vmk70SRp9LTaQZs3YqCpBBTOpMD6fI/H7RtlV8HXN/IBqVJ4aXOEYKv5n2EikGG0zgaxlLHvCdtSWIcSzrjYJvMGalpZKEo8TaHMEJ6Ipj6xClu+K5hluPZxGG9v3+2J0K8qjTqVa2epICuG0OtJTvahsqf8P99p0hUt4dEVNVl2o0ZeKEKLgBXyu2lz3zeWxHaLcKkH9MK1DWBBdN+44qCyiMO/z2zL+gyKyo2+THbANyF/kKO/jXHXWIWiFaqPDGMRTLZ+Z1LAfCJxh6pKiCXpTCPMqTW55qNSYjLgy7qtyV0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b55b4e-a870-4179-1f79-08d6f4eff0b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 19:54:28.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0171
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Lorenzo Pieralisi
> Sent: Monday, June 17, 2019 9:15 AM
> > ...
> > + some ARM experts who worked on arch/arm/kernel/hibernate.c.
> >
> > drivers/acpi/sleep.c is only built if ACPI_SYSTEM_POWER_STATES_SUPPORT
> > is defined, but it looks this option is not defined on ARM.
> >
> > It looks ARM does not support the ACPI S4 state, then how do we know
> > if an ARM host supports hibernation or not?
>=20
> Maybe we should start from understanding why you need to know whether
> Hibernate is possible to answer your question ?
>=20
> On ARM64 platforms system states are entered through PSCI firmware
> interface that works for ACPI and device tree alike.
>=20
> Lorenzo

Hi Lorenzo,
It looks I may have confused you as I didn't realize the word "ARM" only me=
ans
32-bit ARM. It looks the "ARM" arch and the "ARM64" arch are very different=
.

As far as I know, Hyper-V only supports x86 and "ARM64", and it's unlikely =
to
support 32-bit ARM in the future, so actually I don't really need to know i=
f and
how a 32-bit ARM machine supports hibernation.

When a Linux guest runs on Hyper-V (x86_32, x86_64, or ARM64) , we have a
front-end balloon driver in the guest, which balloons up/down and
hot adds/removes the guest's memory when the host requests that. The proble=
m
is: the back-end driver on the host can not really save and restore the sta=
tes
related to the front-end balloon driver on guest hibernation, so we made th=
e
decision that balloon up/down and hot-add/remove are not supported when
we enable hibernation for a guest; BTW, we still want to load the front-end
driver in the guest, because the dirver has a functionality of reporting th=
e
guest's memory pressure to the host, which we think is useful.

On x86_32 and x86_64, we enable hibernation for a guest by enabling
the virtual ACPI S4 state for the guest; on ARM64, so far we don't have the
host side changes required to support guest hibernation, so the details are
still unclear.

After I discussed with Michael Kelley, it looks we don't really need to
export drivers/acpi/sleep.c: acpi_sleep_state_supported(), but I think we d=
o
need to make it non-static.

Now I propose the below changes. I plan to submit a patch first for the
changes made to drivers/acpi/sleep.c and include/acpi/acpi_bus.h in a few
days, if there is no objection.

Please let me know how you think of this. Thanks!

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index a34deccd7317..18d2e5922448 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -79,7 +79,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
 	return 0;
 }
=20
-static bool acpi_sleep_state_supported(u8 sleep_state)
+bool acpi_sleep_state_supported(u8 sleep_state)
 {
 	acpi_status status;
 	u8 type_a, type_b;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 31b6c87d6240..3e6563e1a2c0 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -651,6 +651,12 @@ static inline int acpi_pm_set_bridge_wakeup(struct dev=
ice *dev, bool enable)
 }
 #endif
=20
+#ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
+bool acpi_sleep_state_supported(u8 sleep_state);
+#else
+bool acpi_sleep_state_supported(u8 sleep_state) { return false; }
+#endif
+
 #ifdef CONFIG_ACPI_SLEEP
 u32 acpi_target_system_state(void);
 #else
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 79f626ab8306..197e8fa32871 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -17,6 +17,7 @@
  *
  */
=20
+#include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/types.h>
 #include <asm/apic.h>
@@ -420,3 +421,9 @@ bool hv_is_hyperv_initialized(void)
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
index 0becb7d9704d..1cb40016ee53 100644
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
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 111ea3599659..39fd4e4a8fd7 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -34,6 +34,8 @@
=20
 #include <linux/hyperv.h>
=20
+#include <asm/mshyperv.h>
+
 #define CREATE_TRACE_POINTS
 #include "hv_trace_balloon.h"
=20
@@ -1682,6 +1684,9 @@ static int balloon_probe(struct hv_device *dev,
 {
 	int ret;
=20
+	if (hv_is_hibernation_supported())
+		hot_add =3D false;
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 	do_hot_add =3D hot_add;
 #else


Thanks,
-- Dexuan
