Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AF75F197
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jul 2019 04:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGDCnm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Jul 2019 22:43:42 -0400
Received: from mail-eopbgr1310091.outbound.protection.outlook.com ([40.107.131.91]:19388
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726964AbfGDCnm (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Jul 2019 22:43:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ7GQiao+nOKiveN04jeespWYjpWzmg/JkH92cgKOUr1imD+jk5jHp88Cjq5Du8WEYrZ84To30nh4JdcB+5IqYicY+qV3zYqAdR3AmNDpNR6xip8d6JersERcTWqNyesAra+mOWL0lwfCqT9eUPg+KgCcbZIxiJQCcKZEPTk0dUq92+V0AuTk+1MudJSlKSan+CdIVxOA3Jw6xEozcFYuTrYjnCY57E5aENCF0zDP1GZ+SOwyykgfG/wCE+F2PbYrpHzlYPro+Mvb31t3IC/gi2IgMKE/aHlD2tKkJvxUbCotPmho8zRyrT0Xn4bpXQ6wQBhjJkFfZc/riyjnTmNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx6NBnN0opfzdecRJ1qbbqBYOSWjnLft666acyjrrsM=;
 b=Hy553I8IVBsfjt2N8VgQllVph5ARoWGYRUmSGWRoOS04G+7q74fYaLHHUDEhG1uEAlEedbovRhFAbw5eo2bwPxOVP0QxN4yf47vwS++f2dg5S8m1ta0+itCqNKxdYEK4Oipgix7JTGps6BmbVo9YBxA0eV/t+kEkadvsGbN/SJmJyKh1Rb5SjccN19mPUJbWuEDWIkGOERCyrQD+MxbsHReq4FMIJU7u2qEtDo2kRJIQVq0v5/awnRNk3r8OwRNzkIHJLCYDMFffqqKwBYZIxpWx0AfS00L63Klq8oJzlvuQYjyvVVR68PozuInefOvgDd2NQjOvzeqZgkJvbAlWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx6NBnN0opfzdecRJ1qbbqBYOSWjnLft666acyjrrsM=;
 b=ogrUHJhOKP7AByFxNJr4EW1ZeGOYFguGpUX3K7J+vBa4xbVZaoypKeP1Eqzu583xCEgXIOT/hSWsnLWAAmCgAxHXD4rTUOgsqx2zUoifN7LRYL2Apdzwpv3dv/vF56ShIZQDPNZSSXKO+2tJR3d8MFrgCWQFuZFYIt/5pTsYWXo=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0140.APCP153.PROD.OUTLOOK.COM (10.170.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Thu, 4 Jul 2019 02:43:33 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b%9]) with mapi id 15.20.2073.004; Thu, 4 Jul 2019
 02:43:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Russ Dill <Russ.Dill@ti.com>,
        Sebastian Capella <sebastian.capella@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
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
Subject: [PATCH] ACPI: PM: Make acpi_sleep_state_supported() non-static
Thread-Topic: [PATCH] ACPI: PM: Make acpi_sleep_state_supported() non-static
Thread-Index: AdUyD/1jbxa9lbVkR4S4rtxqyMrQ3w==
Date:   Thu, 4 Jul 2019 02:43:32 +0000
Message-ID: <PU1P153MB0169A260911AACDA861F0029BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-04T02:43:30.0747531Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=59142a4a-ecc0-433a-bd18-ef91209dc589;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:418d:2241:ae9c:1f48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6761ab1-704f-45cf-d19c-08d7002967dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0140;
x-ms-traffictypediagnostic: PU1P153MB0140:|PU1P153MB0140:
x-ms-exchange-purlcount: 3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01401E7745A461E8AA0831BBBFFA0@PU1P153MB0140.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(86362001)(68736007)(74316002)(73956011)(66946007)(66446008)(64756008)(66556008)(76116006)(4326008)(66476007)(305945005)(2201001)(8676002)(6506007)(102836004)(52536014)(25786009)(110136005)(2501003)(7416002)(7736002)(14454004)(966005)(316002)(22452003)(54906003)(5660300002)(8990500004)(478600001)(55016002)(6116002)(71200400001)(71190400001)(81166006)(10090500001)(10290500003)(33656002)(6436002)(476003)(2906002)(46003)(486006)(99286004)(53936002)(9686003)(6306002)(8936002)(1511001)(81156014)(7696005)(14444005)(186003)(256004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0140;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hEEMZkwMMmNbHEZ/tnUsAw3cizasDVs1mHffcFIYr3hlNVj8/43awOCHXr7W5ejlB1t64le6yxZcoB3oCoSRrHw4SikDxWsisfcyetmij7DAD4myUsUxrMzlDpoCmMNFeVL9WzZL5T2Jn4GYyQDj5ju4V9phUE7zxdExQJcY2VV0FbV8HadvgDe2o8U1/M2KYrxcJw2RXp4z/r4YPQKl/hir8ILfWUf4vtMH9JcnHXUQx4EJImiBaFrL6T1JjS/IT0itZelQwcRtVW+CCHskKKqT0XUcrxQGfkIAxgxHKwQ9lPZ4PgBt4Y9ZUdWfWHPyl3kdOuQVUS1FiNF0XQjxi3HKpWtRPAPwlx+K+iOJVzZkM3ArxpOaUuorpc45OtgP1ZQk64kjlL14RteJmnedY8ONSoz4bYU4Y0StxDo+rV4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6761ab1-704f-45cf-d19c-08d7002967dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 02:43:32.6187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0140
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


With some upcoming patches to save/restore the Hyper-V drivers related
states, a Linux VM running on Hyper-V will be able to hibernate. When
a Linux VM hibernates, unluckily we must disable the memory hot-add/remove
and balloon up/down capabilities in the hv_balloon driver
(drivers/hv/hv_balloon.c), because these can not really work according to
the design of the related back-end driver on the host.

By default, Hyper-V does not enable the virtual ACPI S4 state for a VM;
on recent Hyper-V hosts, the administrator is able to enable the virtual
ACPI S4 state for a VM, so we hope to use the presence of the virtual ACPI
S4 state as a hint for hv_balloon to disable the aforementioned
capabilities. In this way, hibernation will work more reliably, from the
user's perspective.

By marking acpi_sleep_state_supported() non-static, we'll be able to
implement a hv_is_hibernation_supported() API in the always-built-in
module arch/x86/hyperv/hv_init.c, and the API will be called by hv_balloon.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Previously I posted a version that tries to export the function:
https://lkml.org/lkml/2019/6/14/1077, which may be an overkill.

So I proposed a second patch (which covers this patch and shows how this
patch will be used): https://lkml.org/lkml/2019/6/19/861

I explained the situation in detail here: https://lkml.org/lkml/2019/6/21/6=
3
(a correction: old Hyper-V hosts can support guest hibernation, but some
important functionalities in the host's management tool stack are missing).

There is no further reply in that discussion, so I'm sending this patch to
draw people's attention again. :-)

 drivers/acpi/sleep.c    | 2 +-
 include/acpi/acpi_bus.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 8ff08e531443..d1ff303a857a 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -77,7 +77,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
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
--=20
2.19.1

