Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC85A60C38
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jul 2019 22:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGEUSz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Jul 2019 16:18:55 -0400
Received: from mail-eopbgr1300108.outbound.protection.outlook.com ([40.107.130.108]:9839
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbfGEUSy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Jul 2019 16:18:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUNKAMgcOhxoL00Vg53yugy+ogJRXHM1hLbB6ViZQ7yY2we62BQFsVYinvcB8Be9pnLoj3ZHycKPJMgs2UP032tCd38rwkYWkcDSeGWkzyw2hKR8pY3Vqt1WrnHU2xoMKXcqmZPvmR8yg+OTqaEj2IN1pjAanXGtbq9nVsFD8yLA70SnM65siAKoeZCc2uTdyBMfYf8NDUanlv5I8Z+Ejm3kjbFpdRh5lz/BHwl3jb8D93/QSOGFbUR4gUDXF6lXN0JHAW6cp9AWtrBgyMbTFmU9KfMtpkRBGCiuTqVc+ViXFfbndyNXxdAW2HfDsJLOpjvlf5IJ66+VrmVm38UVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUUnPjDRIFgNYOKz+XOgJc8n6yxkDv3Y4ldBTjHj27M=;
 b=T8er6NWA7RLnVzHcu5VgNC83TU1Blgjk4v7/bw7X/Ywf0pSFxa4RQ7W3+DguB3D5RLgH/H/rOe3Bw6XJduQ1EFX7sOXWMI3gqZ04DW/DfEx3yw+mhCYEJOXIBEQ+QbNRDeiJpjwydWyOq40uwoI3jBz9ZUxLNhmjAqecmIeKTX3T2evTkOzGUI6PIPvgyTLrDQOkZ/ssQ31pebGJtguBXZd3eiFv8IVwvTbk0n2PJRiO9b+u804IWy1UZoFQcQSIvoAYg8PHhqpIpufonQlmQuqcNDd0djkZndamLlEmpM1RJRLFNmM6TwkodGz4q9gRbuZjVV94E3UR+NymsC/ZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUUnPjDRIFgNYOKz+XOgJc8n6yxkDv3Y4ldBTjHj27M=;
 b=J98QdbdP49lqGJJTMiAqpTAe1hrBgbpbHMih4VnaUGXxXJ01MKjl64iS0C4js0MJxFdvhakfae/b7djyWNwdDBEFMHobfTtap06TuPZ0cZ1DynEbg8XKptKe8D9LL5+DXu1GWVzpQWYMbnbXUGfW8bs661MxYWemgstrzmMemTc=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0139.APCP153.PROD.OUTLOOK.COM (10.170.188.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Fri, 5 Jul 2019 20:18:44 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b%9]) with mapi id 15.20.2073.007; Fri, 5 Jul 2019
 20:18:44 +0000
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
Subject: [PATCH] ACPI: PM: Fix "multiple definition of
 acpi_sleep_state_supported" for ARM64
Thread-Topic: [PATCH] ACPI: PM: Fix "multiple definition of
 acpi_sleep_state_supported" for ARM64
Thread-Index: AdUzbmM4XUj6neW+TFKprEoFjAWlBA==
Date:   Fri, 5 Jul 2019 20:18:43 +0000
Message-ID: <PU1P153MB0169731042EFE4D6B08F04A5BFF50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-05T20:18:41.4014074Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=42a7c061-4d29-4fcd-9ae8-d829837adbb9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:5896:cf8a:cefe:fd7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cccd131-22dc-445c-80b8-08d70185fa90
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0139;
x-ms-traffictypediagnostic: PU1P153MB0139:|PU1P153MB0139:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0139B7D25B696EAB9FF74F1DBFF50@PU1P153MB0139.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(189003)(199004)(110136005)(2501003)(9686003)(71190400001)(71200400001)(316002)(55016002)(8990500004)(86362001)(54906003)(4326008)(6116002)(22452003)(186003)(10290500003)(7736002)(305945005)(1511001)(10090500001)(99286004)(66446008)(25786009)(14454004)(6436002)(486006)(33656002)(68736007)(74316002)(478600001)(46003)(14444005)(256004)(8676002)(7416002)(81156014)(81166006)(6506007)(102836004)(7696005)(5660300002)(53936002)(476003)(52536014)(2906002)(76116006)(73956011)(66476007)(66556008)(8936002)(64756008)(66946007)(2201001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0139;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9lpp7EBoPVK4bZ0lsYsjOt7vhha0m2XMLgqGezTaE03D76b9/Ei1jIU7HhKjpL7WYpgfKM392v+dwrY+BmpcCgWsyCZuBJ3zY1nG8J6UZr2mKwRuVlFB+uTzJAHLKQ1xYXyi6+NfSlC4jIupwbppl7egnDYzSKQngfuFEs2BFZXIffMQwSdWAkesvMT2OFdBqLagRWKjrm6UDWGJgegKljKRu6qbKuI8g9vZE90K4ks1KWOwtdsplYJ23/FjYrwZu7fW3uy6ZkRNml45pfM2uBeqfhWWbZKMP0sSKLxQROewKK9BzCXWVIU0SzPS629pS2Cli4SxtfPQ5t2n9vh+yPLgiBq1AWJjxNHkjgSVTdqBPRoPo1/UaZqkRlPXhhJxDAtt5P5/seNCqA90yROCZum17O//NMRuHH5dXX7+zsk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cccd131-22dc-445c-80b8-08d70185fa90
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 20:18:43.6729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0139
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


If CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT is not set, the dummy version of
the function should be static.

Fixes: 1e2c3f0f1e93 ("ACPI: PM: Make acpi_sleep_state_supported() non-stati=
c")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reported-by: kbuild test robot <lkp@intel.com>
---

Sorry for not doing it right in the previous patch!

The patch fixes the build errors on ARM64:

   drivers/net/ethernet/qualcomm/emac/emac-phy.o: In function `acpi_sleep_s=
tate_supported':
>> emac-phy.c:(.text+0x1d8): multiple definition of `acpi_sleep_state_suppo=
rted'
   drivers/net/ethernet/qualcomm/emac/emac.o:emac.c:(.text+0xbf8): first de=
fined here
   drivers/net/ethernet/qualcomm/emac/emac-sgmii.o: In function `acpi_sleep=
_state_supported':
   emac-sgmii.c:(.text+0x548): multiple definition of `acpi_sleep_state_sup=
ported'
   drivers/net/ethernet/qualcomm/emac/emac.o:emac.c:(.text+0xbf8): first de=
fined here


 include/acpi/acpi_bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4ce59bdc852e..8ffc4acf2b56 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -657,7 +657,7 @@ static inline int acpi_pm_set_bridge_wakeup(struct devi=
ce *dev, bool enable)
 #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
 bool acpi_sleep_state_supported(u8 sleep_state);
 #else
-bool acpi_sleep_state_supported(u8 sleep_state) { return false; }
+static bool acpi_sleep_state_supported(u8 sleep_state) { return false; }
 #endif
=20
 #ifdef CONFIG_ACPI_SLEEP
--=20
2.17.1

